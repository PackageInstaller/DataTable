







local this = {

    oldBrandTypeData = nil,

    newBrandTypeData = nil,

    brandItems = nil
}
local objs = {
    brandItem = {path = "template/BrandItem", type = BalatroUtil.GameObject},
    confirmBtn = {path = "root/Middle/Bottom/ConfirmBtn", type = BalatroUtil.Button},
    brandParent = {path = "root/Middle/Top/BrandParent", type = BalatroUtil.Transform},
    des = {path = "root/Middle/Top/Des", type = BalatroUtil.Text},
    name = {path = "root/Middle/Top/Name", type = BalatroUtil.Text},
    upBeforeLevelBig = {path = "root/Middle/Bottom/UpBefore/LevelText1", type = BalatroUtil.Text},
    upBeforeLevelSmall = {path = "root/Middle/Bottom/UpBefore/LevelText2", type = BalatroUtil.Text},
    upBeforeScore = {path = "root/Middle/Bottom/UpBefore/ScoreText", type = BalatroUtil.Text},
    upBeforeRate = {path = "root/Middle/Bottom/UpBefore/RateText", type = BalatroUtil.Text},
    upAfterLevelBig = {path = "root/Middle/Bottom/UpAfter/LevelText1", type = BalatroUtil.Text},
    upAfterLevelSmall = {path = "root/Middle/Bottom/UpAfter/LevelText2", type = BalatroUtil.Text},
    upAfterScore = {path = "root/Middle/Bottom/UpAfter/ScoreText", type = BalatroUtil.Text},
    upAfterRate = {path = "root/Middle/Bottom/UpAfter/RateText", type = BalatroUtil.Text}
}

this.before_awake = function()
end

this.before_active = function()
    if this.oldBrandTypeData then
        this.upBeforeLevelBig.text = this.oldBrandTypeData:GetLevel(true)
        this.upBeforeLevelSmall.text = this.oldBrandTypeData:GetLevel(true)
        this.upBeforeScore.text = this.oldBrandTypeData:GetTotalScore(true)
        this.upBeforeRate.text = this.oldBrandTypeData:GetTotalRate(true)
    end
    if this.newBrandTypeData then
        this.upAfterLevelBig.text = this.newBrandTypeData:GetLevel(true)
        this.upAfterLevelSmall.text = this.newBrandTypeData:GetLevel(true)
        this.upAfterScore.text = this.newBrandTypeData:GetTotalScore(true)
        this.upAfterRate.text = this.newBrandTypeData:GetTotalRate(true)

        this.name.text = this.newBrandTypeData:GetName()
        this.des.text = this.newBrandTypeData:GetDes()

        local modeBrandLen = #this.newBrandTypeData:GetModelIDs()
        if not this.brandItems or #this.brandItems == 0 then
            this.brandItems = {}
            for i = 1, modeBrandLen do
                local obj = BalatroBrandItem.New(this.brandItem, this.brandParent, false, i)
                table.insert(this.brandItems, obj)
            end
        end
        for i = 1, modeBrandLen do
            local item = this.brandItems[i]
            if not item then
                return
            end
            local brandID = this.newBrandTypeData:GetModelIDs()[i]
            local brandConfig = BalatroDataMgr.GetGeneralBrandConfig(brandID)
            SetActive(item.gameObject, true)
            item:SetData(BalatroBrandItem.SizeType.Small, brandConfig.ResID)
        end
    end
end

this.ParseParam = function(params)
    if params.Length > 1 then
        this.oldBrandTypeData = params[0]
        this.newBrandTypeData = params[1]
    end
end

this.OnClickBack = function()
    LuaMgr.HidePanel(UIName.BalatroBrandTypeUpFeedPopup)
    LuaMgr.ShowLuaPanel(UIName.BalatroPhasePreviewPopup)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.confirmBtn, this.OnClickBack)
        this.before_awake()
    end,
    before_active = function(vm)
        if vm.behaviour.Params then
            this.ParseParam(vm.behaviour.Params)
            vm.behaviour:PopupBack(this.OnClickBack)
        end
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.confirmBtn, this.OnClickBack)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)