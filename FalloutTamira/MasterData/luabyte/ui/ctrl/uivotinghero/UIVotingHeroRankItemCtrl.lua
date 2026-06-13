local UIVotingHeroRankItemCtrl = BaseClass("UIVotingHeroRankItemCtrl")
local M = UIVotingHeroRankItemCtrl
local sfmt = string.format

function M:__init(view)
    self._view = view
    self._view.btnTips:SetOnClick(self, self.OnTipsClick)
    self.tabColor = {{r=252, g=200, b=64}, {r=64, g=157, b=252}, {r=229, g=177, b=115}}
    self.bgPath = "UI/SpritePics/common/ui_voting_hx_img_0"
    local tabParam = ConfigHelper.GetSystemParams(211)
    local state = VotingDataMgr:GetInstance():GetNowState()
    self.showTipsNum = ConfigHelper.GetSystemParam(227)
    if tabParam.Length >= state then
        self.tipsState = tabParam[state - 1] == 1 and true or false
    else
        self.tipsState = false
    end
end

function M:UpdateItem(data)
    self:SetIndex(data.index)
    self:SetItemData(data)
end

function M:SetIndex(index)
    if index > 3 then
        self._view.textIndex:SetText(sfmt("%d.", index))
        self._view.tfBg.gameObject:SetActive(false)
        return
    end

    self._view.textIndex:SetText("")
    self._view.tfBg.gameObject:SetActive(true)
    self._view.imageNum:SetPic(self.bgPath .. tostring(index))
    local tabColor = self.tabColor[index]
    self._view.imageBg:SetColor(tabColor.r, tabColor.g, tabColor.b)
end

function M:SetItemData(data)
    self._view.textNum:SetText(tostring(data.VoteCnt))
    self._view.textName:SetText(data.BaseInfo.Nick)
    self._view.tfBg1.gameObject:SetActive(data.index % 2 == 0 and true or false)
    self._view.tfBg2.gameObject:SetActive(data.index % 2 == 1 and true or false)
    self._view.btnTips:SetActive(self.tipsState and data.index <= self.showTipsNum)
end

function M:OnTipsClick()
    local tips = ConfigHelper.GetCfgPropByLua("activityGirl", VotingDataMgr:GetInstance():GetActivityGirlId(), "desc")
    tips = ConfigHelper.GetLocalString(tips)
    UIContextMgr:GetInstance():Show(UIDefine.UIVotingTips, tips)
end

function M:OnDispose()
    self.tabColor = nil
    self.bgPath = nil
    self.tipsState = nil
    self._view.btnTips:RemoveOnClick()
    if self._view then
        self._view:OnDispose()
    end
    self._view = nil
end

return UIVotingHeroRankItemCtrl
