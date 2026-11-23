require("ViewModel/Rogue/Rogue_TalentNodeItem")

local this = {
    vm = nil,
    nodeId = nil,
    nodeItemMap = {},
    LineImgMap = {},
    nodeDataMap = {},
    nodeUnlockMap = {
status = 0,
        parentId = "",
    },
    isEnough = false,
    curShowPage = 1,
};
local lockColor = UnityEngine.Color(95 / 255, 95 / 255, 99 / 255, 1);

local data = {
    showTotalBuffBtn = false,
    showResetBtn = false,
    showNodeInfo = false,
    showNodeIcon = false,
    showNodeIconSuo = false,
    showTotalBuff = false,
    nodeIcon = DefaultSprite,
    nodeIconColor = UnityEngine.Color.white,
    nodeName = "",
    nodeDesc = "",
    nodeDescList = { { desc = "" } },
    showConfirmBtn = false,
    showUnlockBtn = false,
    lockTipsStr = "",
    showUnlockConsume = false,
    unlockConsumeIcon = DefaultTexture,
    unlockConsumeCount = "",

    showSwitchPageBtn = false,
    showPage1 = false,
    showPage2 = false,
}

local command = {
    resetCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local consumeItem = ConfigMgr.Config.RogueConstants.RogueTechReset
            LuaMgr.ShowLuaPanel(UIName.RogueConfirmViewModel, LuaMgr.GetLangText("RogueTalentViewModel_0"), ConfigMgr.Config.RogueConstants.RogueTechReset, function()
                local cost = consumeItem[1];
                local costCount = tonumber(consumeItem[2]);
                local item = DataMgr.Player.items[cost];
                local itemCount = item ~= nil and item.count0 or 0;
                if itemCount < costCount then
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("26230"))
                    return
                end
                RogueMgr.OnAskResetTech(this.curShowPage, function(result)
                    this.ParseData()
                end)
            end, function()
            end)
        end
    },
    buffPreviewCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.ShowNodeInfo("")
        end
    },
    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.HideNodeInfo()
        end
    },
    unlockCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickUnlockTech()
        end
    },
    nodeInfoMaskCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.HideNodeInfo()
        end
    },
    switchCommand_1 = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.curShowPage == 1 then
                return
            end
            this.curShowPage = 1
            this.ParseData()
        end
    },
    switchCommand_2 = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.curShowPage == 2 then
                return
            end
            this.curShowPage = 2
            this.ParseData()
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.nodeItemMap = {}
        local rogueTechCfgs = ConfigMgr.Config.RogueTechs
        local page1NodeCount = 0
        for i, v in ipairs(rogueTechCfgs) do
            if v.Version == 1 then
                page1NodeCount = page1NodeCount + 1
            end
        end
        for i, v in ipairs(rogueTechCfgs) do
            local tr = nil
            if v.Version == 1 then
                tr = vm.behaviour.transform:Find("root/TalentTree_1/ScrollView/Viewport/Content/NodeList/RogueTechNode_" .. v.Id)
            elseif v.Version == 2 then
                local newIndex = tonumber(v.Id) - page1NodeCount
                tr = vm.behaviour.transform:Find("root/TalentTree_2/ScrollView/Viewport/Content/NodeList/RogueTechNode2_" .. newIndex)
            end

            if tr ~= nil then
                local temp = Rogue_TalentNodeItem.New()
                temp.gameObject = tr.gameObject
                temp.transform = tr
                temp.type = v.Version
                temp:Init()
                this.nodeItemMap[v.Id] = temp
            end
        end

        this.LineImgMap = {}
        local lineConnectTr1 = vm.behaviour.transform:Find("root/TalentTree_1/ScrollView/Viewport/Content/LineList")
        local count = lineConnectTr1.childCount
        for i = 1, count do
            local lineTr = lineConnectTr1:GetChild(i - 1)
            local strs = NumTool.split(lineTr.gameObject.name, "-")
            local item = {
                canvasGroup = lineTr:GetComponent("CanvasGroup"),
                leftNodeId = strs[1],
                rightNodeId = strs[2],
            }
            table.insert(this.LineImgMap, item)
        end
        local lineConnectTr2 = vm.behaviour.transform:Find("root/TalentTree_2/ScrollView/Viewport/Content/LineList")
        local count = lineConnectTr2.childCount
        for i = 1, count do
            local lineTr = lineConnectTr2:GetChild(i - 1)
            local strs = NumTool.split(lineTr.gameObject.name, "-")
            local item = {
                canvasGroup = lineTr:GetComponent("CanvasGroup"),
                leftNodeId = strs[1],
                rightNodeId = strs[2],
            }
            table.insert(this.LineImgMap, item)
        end
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.curShowPage = RogueMgr.CurShowPage
            this.ParseData()
        end
    end,
    before_deactive = function(vm)
        for k, v in pairs(this.nodeItemMap) do
            v:Clear()
        end
    end,
    before_destroy = function()
        for k, v in pairs(this.nodeItemMap) do
            v:Destroy()
        end
        this.nodeItemMap = {}
    end
}

this.ParseData = function()
    this.InitNodeUnlockMap()
    this.nodeDataMap = {}
    local rogueTechCfgs = ConfigMgr.Config.RogueTechs
    local unlockTechMap = DataMgr.Player.RogueTech
    for i, v in ipairs(rogueTechCfgs) do
        if v.Version == this.curShowPage then
            local nodeData = {
                id = v.Id,
                index = i,
                icon = LuaMgr.GetSprite("Rogue", v.BuffIcon);
                status = this.nodeUnlockMap[v.Id].status,
                select = false,
                cfg = v,
                callback = this.OnClickNode,
            }
            this.nodeDataMap[v.Id] = nodeData
        end
    end

    for k, v in pairs(this.nodeDataMap) do
        this.nodeItemMap[k]:SetData(v)
    end

    for i, v in ipairs(this.LineImgMap) do
        if this.nodeUnlockMap[v.leftNodeId] ~= nil and this.nodeUnlockMap[v.rightNodeId] ~= nil then
            if this.nodeUnlockMap[v.leftNodeId].status == 1 and this.nodeUnlockMap[v.rightNodeId].status == 1 then
                v.canvasGroup.alpha = 1
            else
                v.canvasGroup.alpha = 0.5
            end
        end
    end
    
    this.vm.data.showSwitchPageBtn = RogueMgr.CheckRogueLike2IsOpen()
    this.vm.data.showPage1 = this.curShowPage == 1
    this.vm.data.showPage2 = this.curShowPage == 2
    
    this.HideNodeInfo()
end

this.InitNodeUnlockMap = function()
    this.nodeUnlockMap = {}
    local rogueTechCfgs = ConfigMgr.Config.RogueTechs
    local unlockTechMap = DataMgr.Player.RogueTech
    for i, v in ipairs(rogueTechCfgs) do
        if v.Version == this.curShowPage then
            local techId = v.Id
            local data = {
                parentId = "",
                status = 0
            }
            if tonumber(v.Unlock[1]) == 0 then
                data.status = 2
            elseif tonumber(v.Unlock[1]) == 1 then
                data.parentId = v.Unlock[2]
                data.status = 0
            elseif tonumber(v.Unlock[1]) == 2 then
                data.status = 1
            end
            if unlockTechMap[techId] ~= nil then
                data.status = 1
            elseif not IsNullOrEmpty(data.parentId) and unlockTechMap[data.parentId] ~= nil then
                data.status = 2
            end
            this.nodeUnlockMap[techId] = data
        end
    end

    for k, v in pairs(this.nodeUnlockMap) do
        if v.status ~= 1 and v.status ~= 2 then
            v.status = 0
            if not IsNullOrEmpty(v.parentId) and not IsNullOrEmpty(v.parentId) then
                local parentNodeUnlockData = this.nodeUnlockMap[v.parentId]
                if not TableIsNull(parentNodeUnlockData) and not IsNullOrEmpty(parentNodeUnlockData.parentId)
                        and unlockTechMap[parentNodeUnlockData.parentId] ~= nil then
                    v.status = 3
                end
            end
        end
    end
end

this.OnClickNode = function(nodeId)
    if this.nodeId == nodeId then
        return
    end
    this.ShowNodeInfo(nodeId)
end

this.ShowNodeInfo = function(nodeId)
    this.nodeId = nodeId
    if nodeId == "" then

        this.vm.data.showTotalBuff = true
        this.vm.data.showNodeIcon = false
        this.vm.data.showConfirmBtn = true
        this.vm.data.showUnlockBtn = false
        this.vm.data.lockTipsStr = ""
        local rogueTechCfgs = ConfigMgr.Config.RogueTechs
        local unlockTechMap = DataMgr.Player.RogueTech
        local attrList = {}
        for i, v in ipairs(rogueTechCfgs) do
            if unlockTechMap[v.Id] ~= nil then
                table.insert(attrList, { desc = LuaMgr.GetLangText(v.BuffDesLan), sort = v.Order })
            end
        end
        table.sort(attrList, function(a, b)
            return a.sort > b.sort
        end)
        if #attrList == 0 then
            table.insert(attrList, { desc = ConfigMgr.LangGlobal("26509"), sort = 1 })
        end
        this.vm.data.nodeDescList = attrList
    else
        this.vm.data.showTotalBuff = false
        this.vm.data.showNodeIcon = true
        local nodeData = this.nodeDataMap[nodeId]
        local nodeCfg = nodeData.cfg
        this.vm.data.nodeIcon = nodeData.icon
        this.vm.data.nodeName = LuaMgr.GetLangText(nodeCfg.BuffNameLan)
        this.vm.data.nodeDesc = LuaMgr.GetLangText(nodeCfg.BuffDesLan)
        this.vm.data.nodeDescList = {}

        local isUnlock = nodeData.status == 1
        this.vm.data.showNodeIconSuo = not isUnlock
        this.vm.data.nodeIconColor = isUnlock and UnityEngine.Color.white or lockColor
        this.vm.data.showConfirmBtn = isUnlock
        this.vm.data.showUnlockBtn = nodeData.status == 2
        if nodeData.status == 2 then
            this.vm.data.showUnlockConsume = not TableIsNull(nodeCfg.Consume)
            if this.vm.data.showUnlockConsume then
                local cost = nodeCfg.Consume[1];
                local costCount = tonumber(nodeCfg.Consume[2]);
                local item = DataMgr.Player.items[cost];
                local itemCount = item ~= nil and item.count0 or 0;
                this.vm.data.unlockConsumeIcon = GetItemHomeIcon(cost);
                this.isEnough = itemCount >= costCount
                this.vm.data.unlockConsumeCount = string.format("<color=%s>%d</color>", this.isEnough and "#c2b49d" or "#c31f36", costCount);
            else
                this.isEnough = true
            end
        else
            this.vm.data.showUnlockBtn = false
        end
        local lockTips = ""
        if nodeData.status == 0 or nodeData.status == 3 then
            lockTips = ConfigMgr.LangGlobal(nodeCfg.UnlockDesc[1])
        end
        this.vm.data.lockTipsStr = lockTips
    end
    this.vm.data.showTotalBuffBtn = false
    this.vm.data.showResetBtn = false
    this.vm.data.showNodeInfo = true

    for k, v in pairs(this.nodeItemMap) do
        v:CheckSelect(this.nodeId)
    end
end

this.HideNodeInfo = function()
    this.nodeId = nil
    this.vm.data.showTotalBuffBtn = true
    this.vm.data.showResetBtn = false
    this.vm.data.showNodeInfo = false
    local rogueTechCfgs = ConfigMgr.Config.RogueTechs
    local unlockTechMap = DataMgr.Player.RogueTech
    for i, v in ipairs(rogueTechCfgs) do
        if v.Version == this.curShowPage and tonumber(v.Unlock[1]) ~= 2 and unlockTechMap[v.Id] ~= nil then
            this.vm.data.showResetBtn = true
            break
        end
    end
end

this.OnClickUnlockTech = function()
    if not this.isEnough then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("26229"))
        return
    end
    if not IsNullOrEmpty(this.nodeId) then
        RogueMgr.OnAskUnlockTech(this.nodeId, function(re)
            local nodeId = this.nodeId
            this.ParseData()
            this.nodeItemMap[nodeId]:ShowUnlockEffect()
        end)
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})