---@class CustomBackPanel : CustomBackPanel_Generate
---##################### 【CustomBackPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【CustomBackPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local CustomBackPanel = require "CustomBackPanel_Generate"

function CustomBackPanel:InitLogic(data)
    -- self.msgEventHandler = {
    --     {GameMsgType.RefreshTopResource, self.RefreshTopResource},
    -- }
    self._overrideBackFunc = nil
    self._overrideMainBackFunc = nil
    self._specificResList = nil  --具体资源列表 用于商店、卡池等需要动态更换资源栏使用
    self._InstructionsOpenFunc = nil  --帮助按钮点击回调
    self._InstructionsCloseFunc = nil  --帮助界面关闭回调
    self._useLoadPanelList = {
        GE.NavigationType.GenRoleFrag,
        GE.NavigationType.RaffleMainPanel,
    }
end

--function CustomBackPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--初始化   传入导航栏表id
--资源栏默认通过id读配置表关联
---@param id FunctionTabTable.id 导航栏表id
function CustomBackPanel:Bind(id)
    -- LuaLogger.ds("id", id)
    self._id = id
    self:RefreshPage()
end

--设置特殊资源列表
function CustomBackPanel:OverrideSpecificRes(resList)
    -- LuaLogger.ds("resList", tablex.dump(resList))
    self._specificResList = resList
    self:RefreshTopResource()
end

--返回方法特殊处理
function CustomBackPanel:OverrideBackFunc(func)
    self._overrideBackFunc = func
end

function CustomBackPanel:OverrideMainBackFunc(func)
    self._overrideMainBackFunc = func
end

--清空返回方法
function CustomBackPanel:ClearBackFunc()
    self._overrideBackFunc = nil
end

function CustomBackPanel:OverrideInstructionsOpenFunc(func)
    self._InstructionsOpenFunc = func
end

function CustomBackPanel:ClearInstructionsOpenFunc()
    self._InstructionsOpenFunc = nil
end

function CustomBackPanel:OverrideInstructionsCloseFunc(func)
    self._InstructionsCloseFunc = func
end

function CustomBackPanel:ClearInstructionsCloseFunc()
    self._InstructionsCloseFunc = nil
end

--- func 刷新界面
function CustomBackPanel:RefreshPage()
    self:RefreshTopResource()
    self:RefreshBackPart()
    self:RefreshTipsPart()
end

--- func 刷新顶部资源栏
function CustomBackPanel:RefreshTopResource()
    --LuaLogger.ds("刷新顶部资源栏")
    --获取资源列表
    local targetRes
    --优先使用特殊资源列表
    if self._specificResList and tablex.size(self._specificResList) > 0 then
        targetRes = self._specificResList
    else
        targetRes = Config.GetFunctionTabInfo(self._id).Resources or {}
    end
    --复用格子
    self:FillTemplateContent(self.resBox, self.resource, tablex.size(targetRes), function(index, box)
        local itemId = targetRes[index]
        local itemInfo = Config.GetItemInfo(itemId)
        --资源icon
        ResMgr:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPathSmall, itemInfo.icon), box.gameObject, function (s)
            box.resIcon.image.sprite = s
        end)
        box.resIcon.scaleButton.onClick:RemoveAllListeners()
        box.resIcon.scaleButton.onClick:AddListener(function()
            Me:ShowItemTips({
                id =  itemId,
                type = GE.RewardType.ItemProp,
                navType = self._id,
                tipsPassEventState = false,
                isResources = true,
                --ownerPanelName = data.ownerPanelName,
            })
        end)
        --拥有数量
        --钻石走付费资源
        if itemId == GE.ResourceType.PayDiamond then
            LuaLogger.ds("CustomBackPanel 100001")
            box.resNumTxt.text.text = Me:getItemCountById(itemId)
        elseif itemInfo.type == GE.ItemTypeIndex.ticket then--体力
            box.resNumTxt.text.text = UICommonUtils.SetResourceFormatByType(GE.ResourceType.Strength)--.."/"..Config.GetConfigInfo("LimitNormalTicketNum")
        else
            box.resNumTxt.text.text = Me:getItemCountById(itemId)
        end
        --加号按钮
        box.addBtn.scaleButton.onClick:RemoveAllListeners()
        
        box.addBtn.scaleButton.onClick:AddListener(function()
            GameMsgMgr:sendEvent(GameMsgType.CommonBackPanelAddClick)
            box.addBtn.scaleButton.interactable = false
            DLuaTimer:DoAfter(2, function()
                box.addBtn.scaleButton.interactable = true
            end)
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            --体力特殊判断
            if itemInfo.type == GE.ItemTypeIndex.ticket then
                UIMgr:popUICover("BuyTicketPanel", {})
            else
                local turnto = itemInfo.turnTo
                local canTurnTo = UICommonUtils.CanUseSkipJudge(turnto[1], true)
                if canTurnTo then
                    UICommonUtils.CommonTurnTo(turnto[1])
                end
            end
        end)    
        --显隐
        --体力特殊判断
        if itemInfo.type == GE.ItemTypeIndex.ticket then
            box.addBtn:SetActive(true)
        else
            box.addBtn:SetActive(tablex.size(itemInfo.turnTo) > 0)
        end
    end)
end

--- func 刷新左上角返回提示
function CustomBackPanel:RefreshBackPart()
    local functionTabInfo = Config.GetFunctionTabInfo(self._id)
    self.titleTxt.text.text = LocalStrEnum[functionTabInfo.TabName] or functionTabInfo.TabName    --界面名称
end

--- func 刷新提示部分
function CustomBackPanel:RefreshTipsPart()
    --判断是否需要显示帮助按钮
    local functionTabInfo = Config.GetFunctionTabInfo(self._id)
    self.helpBtn:SetActive(functionTabInfo.IsfunctionDes ~= 0)
end

--[[
/Back/BackBg/BackBtn onClick 通用返回
--]]
function CustomBackPanel:backBtn_ScaleButton_onClick(backBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Back)
    GameMsgMgr:sendEvent(GameMsgType.CustomBackPanelBackClick)
    if self._overrideBackFunc then
        self._overrideBackFunc()
        LuaLogger.ds("通用返回override")
    else
        LuaLogger.ds("通用返回default UIMgr closeCurrentUI")
        UIMgr:closeCurrentUI()
    end
end

--[[
/Back/BackMainlBtn onClick 返回主界面
--]]
function CustomBackPanel:backMainlBtn_ScaleButton_onClick(backMainlBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Back)
    GameMsgMgr:sendEvent(GameMsgType.CustomBackPanelMainClick)
    --清空跳转记录
    ClientData:RecordActivityPanelLastSelectId(nil)
    if self._overrideMainBackFunc then
        self._overrideMainBackFunc()
        return
    end
    -- UIMgr:switchUIDataGroup(UIGroup.Main)
    
    local isQuick = true
    if self._id and tablex.find(self._useLoadPanelList, self._id) then
        isQuick = false
    end
    LoadingMgr:SetUISwitchStart(function()
        UIMgr:clearAllUI()
        CoveManager.instance():SetGameSceneInfoShowOrHide(true)
        SeaMapMgr:resetLastMode()
        local seaMapRoot = GameObject.Find("SeaMapRoot")
        if seaMapRoot then
            GameObject.Destroy(seaMapRoot)
        end
        UIMgr:popUIBase("MainPanel", {}, function()
            LoadingMgr:SetUISwitchOver(nil, isQuick)
        end)
    end, isQuick)
end

--[[
/Back/HelpBtn onClick tips 提示
--]]
function CustomBackPanel:helpBtn_ScaleButton_onClick(helpBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local functionTabInfo = Config.GetFunctionTabInfo(self._id)

    if functionTabInfo.functionDes == nil or next(functionTabInfo.functionDes) == nil then
        return
    end

    if self._InstructionsOpenFunc then
        self._InstructionsOpenFunc()
    end
    GameMsgMgr:sendEvent(GameMsgType.CustomBackPanelHelpClick)
    UIMgr:popUICover("InstructionsPanel", {tabId = self._id, closeFunc = self._InstructionsCloseFunc})
end

function CustomBackPanel:highLight(order)
    local canvas = self.back.gameObject:GetOrAddComponent(TypeInfo.Canvas)
    canvas.overrideSorting = true
    canvas.sortingLayerName = "UI"
    canvas.sortingOrder = order
    canvas = self.resource.gameObject:GetOrAddComponent(TypeInfo.Canvas)
    canvas.overrideSorting = true
    canvas.sortingLayerName = "UI"
    canvas.sortingOrder = order
    self.back.gameObject:GetOrAddComponent(TypeInfo.GraphicRaycaster)
    self.resource.gameObject:GetOrAddComponent(TypeInfo.GraphicRaycaster)
end

function CustomBackPanel:unHighLight()
    GameObject.Destroy(self.back.gameObject:GetComponent(TypeInfo.GraphicRaycaster))
    GameObject.Destroy(self.back.gameObject:GetComponent(TypeInfo.Canvas))
    GameObject.Destroy(self.resource.gameObject:GetComponent(TypeInfo.GraphicRaycaster))
    GameObject.Destroy(self.resource.gameObject:GetComponent(TypeInfo.Canvas))
end

--[[
/Resource/ResBox/ResIcon onClick 
--]]
function CustomBackPanel:resIcon_ScaleButton_onClick(resIcon)

end

return CustomBackPanel
