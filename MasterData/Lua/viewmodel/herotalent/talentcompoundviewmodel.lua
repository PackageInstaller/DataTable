require("ViewModel/HeroTalent/TalentCompoundItemGroup")

local this = {
    scrollView = nil,
    requireItemList = nil,
    formulaList = nil,
    interaction = nil,
    callCompoudAll = true
}

local objs = {
    itemGroup = { path = "template/ItemGroup", type = "GameObject" },
    bg = { path = "root/Middle/Bg", type = "RectTransform" },
    scrollViewGO = { path = "root/Middle/Bg/ScrollView", type = "GameObject" },
    closeBtn = { path = "root/Middle/Bg/cancel", type = "Button" },
    comfirmBtn = { path = "root/Middle/Bg/comfirm", type = "Button" }
}

this.InitFormulaList = function()
    this.formulaList = {}
    this.interaction = ConfigFoundationMgr.GetInteractionById("201")
    if (this.interaction == nil) then
        this.interaction = PlayerFoundationMgr.GetBuildingConfigByGroup("201")
    end
    if (this.interaction == nil) then
        return
    end
    this.callCompoudAll = true
    for i, v in ipairs(this.requireItemList) do
        local yieldsItem = this.interaction.YieldsItem
        local formulaMap = ConfigMgr.Config.FormulaMap
        local hasCount = DataHelper.GetItemCountById(v.id)
        local needCount = v.count - hasCount
        if (needCount > 0) then
            for key, value in pairs(formulaMap) do
                if ((value.CostRequire == nil or value.CostRequire <= 0) and value.RecipeGroup == yieldsItem and value.Produce[1].id == v.id and value.Unlock) then
                    local tb = {}
                    tb[4] = {}
                    tb[4].id = v.id
                    tb[4].count = needCount
                    tb[4].formulaId = value.Id
                    tb[4].cantCompound = false
                    if (not IsNull(value.Cost)) then
                        local canCompoundNum = 0
                        for key2, value2 in ipairs(value.Cost) do
                            tb[key2] = {}
                            tb[key2].id = value2.id
                            tb[key2].count = value2.count * needCount
                            tb[key2].hasCount = DataHelper.GetItemCountById(value2.id)
                            local num = tb[key2].hasCount / value2.count
                            if (canCompoundNum == 0 or num < canCompoundNum) then
                                canCompoundNum = num
                            end
                            if (this.callCompoudAll and tb[key2].hasCount < tb[key2].count) then
                                LuaDebug.error("54===============" .. table.tostring(tb[key2]))
                                this.callCompoudAll = false
                            end
                            if (tb[key2].hasCount < value2.count) then
                                tb[4].cantCompound = true
                            end
                        end
                        if (canCompoundNum > needCount) then
                            canCompoundNum = needCount
                        end
                        tb[4].hasCount = math.floor(tonumber(canCompoundNum))
                    end
                    table.insert(this.formulaList, tb)
                end
            end
        end
    end
end


this.SetData = function()
    this.InitFormulaList()
    this.scrollView:Clear(false)
    local scrollData
    local scrollDatas = {}
    local len = #this.formulaList
    for i = 1, len do
        scrollData = UIScrollData.GetData(this.itemGroup, "TalentCompoundItemGroup", 620, 110,
            { config = this.formulaList[i], num = i })
        table.insert(scrollDatas, scrollData)
    end
    if (len > 3) then
        len = 3.5
    elseif (len < 1) then
        len = 1
    end
    this.bg.sizeDelta = Vector2(652, 276 + 110 * (len - 1) + 5)
    this.scrollView:SetParams(620, 110 * len + 5)
    this.scrollView:SetData(scrollDatas, true)
end


this.OnClickClose = function()
    LuaMgr.HidePanel(UIName.TalentCompoundViewModel)
end

this.OnClickComfirm = function()
    local cache = {}
    local totalNum = #this.formulaList
    local cantCompoundNum = 0
    for k, v in pairs(this.formulaList) do
        local config = v[4]
        if (config.cantCompound) then
            cantCompoundNum = cantCompoundNum + 1
        end
        cache[config.formulaId] = config.count
    end
    if (totalNum == cantCompoundNum) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ErrCodeLan_ErrCode_messagelan_7"));
        return
    end
    if (not this.callCompoudAll) then
        LuaMgr.ShowPanel(
            UIName.ConfirmSmallViewModel,
            LuaMgr.GetLangText(ConfigMgr.LangGlobal("29671")),
            function()
                PlayerFoundationMgr.MulCompose(this.interaction.Id, cache, this.ComposeResponse)
            end,
            function()
                LuaMgr.HidePanel(UIName.ConfirmSmallViewModel)
            end
        )
        return
    end
    PlayerFoundationMgr.MulCompose(this.interaction.Id, cache, this.ComposeResponse)
end


this.ComposeResponse = function(result)
    local data = json.decode(result)
    if (data ~= nil and data.result ~= nil) then
        if (not IsNull(data.result.Rewards)) then
            local resultRewards = json.encode(data.result.Rewards)
            LuaMgr.ShowItemRewared(resultRewards)
        end
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/compose_light.mp3")
        LuaMgr.HidePanel(UIName.TalentCompoundViewModel)
        LuaMgr.InvokeUIEventListeners(UIEventConst.PropUse);
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.scrollView = UIScrollView.New(this.scrollViewGO)
        LuaMgr.AddClick(this.closeBtn, this.OnClickClose)
        LuaMgr.AddClick(this.comfirmBtn, this.OnClickComfirm)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        if (vm.behaviour.Params.Length > 0) then
            this.requireItemList = vm.behaviour.Params[0]
        end
        this.SetData()
    end,
    before_deactive = function(vm)
        this.scrollView:Clear(true)
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickClose)
        LuaMgr.RemoveClick(this.comfirmBtn, this.OnClickComfirm)
        UIScrollView.ClearItem("TalentCompoundItemGroup")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)