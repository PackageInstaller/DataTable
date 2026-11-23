







BalatroVictoryPopup = {}
BalatroVictoryPopup.OperateType = {
BrandTypeUpLevel = 1,
GetPropsBrand = 2,
ChangeBalatro = 3
}

local this = {}
local objs = {
    skipBtn = {path = "root/Middle/SkipBtn", type = BalatroUtil.Button},
    upBrandTypeBtn = {path = "root/Middle/UpgradeBtn", type = BalatroUtil.Button},
    getPropBtn = {path = "root/Middle/GetPropBtn", type = BalatroUtil.Button},
    changeBalatroBtn = {path = "root/Middle/ChangeBalatroBtn", type = BalatroUtil.Button},
    propsBrandIcon = {path = "root/Middle/GetPropBtn/Icon", type = BalatroUtil.Image},
    leftPlaycardTimes = {path = "root/Middle/RemainPlaycardCountText", type = BalatroUtil.Text},
    leftPlaycardScore = {path = "root/Middle/RemainPlaycardScoreImage/RemainPlaycardScoreText", type = BalatroUtil.Text},
    leftPlaycardScore1 = {path = "root/Middle/RemainPlaycardScoreImage/RemainPlaycardScoreText/RemainPlaycardScoreText1", type = BalatroUtil.Text},
    leftDiscardTimes = {path = "root/Middle/RemainDiscardCountText", type = BalatroUtil.Text},
    leftDiscardScore = {path = "root/Middle/RemainDiscardScoreImage/RemainDiscardScoreText", type = BalatroUtil.Text},
    leftDiscardScore1 = {path = "root/Middle/RemainDiscardScoreImage/RemainDiscardScoreText/RemainDiscardScoreText1", type = BalatroUtil.Text}
}

this.before_awake = function()
    LuaMgr.AddClick(this.skipBtn, this.OnClickSkip)
    LuaMgr.AddClick(this.upBrandTypeBtn, this.OnClickUpBrandType)
    LuaMgr.AddClick(this.getPropBtn, this.OnClickGetProp)
    LuaMgr.AddClick(this.changeBalatroBtn, this.OnChangeBalatro)
end

this.before_active = function()

    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroIntoCalView)
    local leftPlaycardTimes = BalatroStepMgr.GetPlaycardTimes()
    local leftDiscardTimes = BalatroStepMgr.GetDiscardTimes()
    local playcardTimesScore = BalatroStepMgr.GetPlaycardTimesScore()
    local discardTimesScore = BalatroStepMgr.GetDiscardTimesScore()
    this.leftPlaycardTimes.text = tostring(leftPlaycardTimes)
    this.leftDiscardTimes.text = tostring(leftDiscardTimes)
    this.leftPlaycardScore.text = tostring(playcardTimesScore)
    this.leftPlaycardScore1.text = tostring(playcardTimesScore)
    this.leftDiscardScore.text = tostring(discardTimesScore)
    this.leftDiscardScore1.text = tostring(discardTimesScore)
    local curRoundData = BalatroStepMgr.GetCurRoundData()
    if curRoundData ~= nil then
        local propsBrandCfg = BalatroDataMgr.GetRandomProps(curRoundData:GetRoundID())
        this.propsBrandIcon.sprite = LuaMgr.GetSprite(BalatroUtil.AlataOther, propsBrandCfg.ResID)
    end
end

this.OnClickSkip = function()
    this.OnClosePage()
    LuaMgr.HidePanel(UIName.BalatroVictoryPopup)
    LuaMgr.ShowLuaPanel(UIName.BalatroPhasePreviewPopup)
end

this.OnClickUpBrandType = function()
    local data = {}
    data.operateType = BalatroVictoryPopup.OperateType.BrandTypeUpLevel
    data.callback = this.OperateCallback
    LuaMgr.ShowLuaPanel(UIName.BalatroBrandTypeUpgradePopup, data)
end

this.OnClickGetProp = function()
    local propsDatas = BalatroDataMgr.GetPropsBrandDatas()
    if NumTool.GetLen(propsDatas) >= BalatroConstVal.MaxPropsBrandCount then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20020")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    local curRoundData = BalatroStepMgr.GetCurRoundData()
    if not curRoundData then
        return
    end
    local data = {}
    data.propsConfig = BalatroDataMgr.GetRandomProps(curRoundData:GetRoundID())
    data.operateType = BalatroVictoryPopup.OperateType.GetPropsBrand
    data.callback = this.OperateCallback
    LuaMgr.ShowLuaPanel(UIName.BalatroGetBrandPopup, data)
end

this.OnChangeBalatro = function()
    local data = {}
    data.operateType = BalatroVictoryPopup.OperateType.ChangeBalatro
    data.type = BalatroChangeForeverPopup.ChangeForverType.Change
    data.callback = this.OperateCallback
    LuaMgr.ShowLuaPanel(UIName.BalatroChangeForeverPopup, data)
end

this.OperateCallback = function(data)
    if not data then
        LuaDebug.error("this.OperateCallback 回调参数错误")
        return
    end
    if data.isCancel then
        return
    end
    this.OnClosePage()
    if data.operateType == BalatroVictoryPopup.OperateType.BrandTypeUpLevel then
        local oldData = table.Copy(BalatroDataMgr.GetBrandTypeDataByID(data.selectID))
        BalatroDataMgr.BrandTypeUpgrade(data.selectID)
        local newData = BalatroDataMgr.GetBrandTypeDataByID(data.selectID)

        LuaMgr.ShowLuaPanel(UIName.BalatroBrandTypeUpFeedPopup, oldData, newData)
    elseif data.operateType == BalatroVictoryPopup.OperateType.GetPropsBrand then
        local propsBrand = BalatroDataMgr.AddPropsBrandData(data.propsConfig.ID)
        if propsBrand then
            LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroGetPropsBrand, {propsBrandData = propsBrand})
            local data = {
                AtlaName = BalatroUtil.AlataOther,
                SpriteName = propsBrand:GetResName(),
                Name = propsBrand:GetName(),
                Des = propsBrand:GetDes(),
                Func = function()
                    LuaMgr.ShowLuaPanel(UIName.BalatroPhasePreviewPopup)
                end
            }
            LuaMgr.ShowLuaPanel(UIName.BalatroBrandInfoPopup, data)
        end
    elseif data.operateType == BalatroVictoryPopup.OperateType.ChangeBalatro then
        LuaMgr.ShowLuaPanel(UIName.BalatroPhasePreviewPopup)
    end
    LuaMgr.HidePanel(UIName.BalatroVictoryPopup)
end


this.OnClosePage = function()
    BalatroStepMgr.SetNextRound()
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
    end,
    before_active = function(vm)
        vm.behaviour:PopupBack(this.OnClickSkip)
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.skipBtn, this.OnClickSkip)
        LuaMgr.RemoveClick(this.upBrandTypeBtn, this.OnClickUpBrandType)
        LuaMgr.RemoveClick(this.getPropBtn, this.OnClickGetProp)
        LuaMgr.RemoveClick(this.changeBalatroBtn, this.OnChangeBalatro)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)