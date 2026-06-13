local UIVotingSelItemCtrl = BaseClass("UIVotingSelItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))
local M = UIVotingSelItemCtrl
--  海选英雄界面
--  对应view UIVotingSelItemView
--  213 X 386
function M:Init()
    self.tabColor = {
        {r=252, g=200, b=64}, 
        {r=64, g=157, b=252}, 
        {r=229, g=177, b=115}
    }
    self.heroIconPath = "UI/SpritePics/formation/"
    self.bgPath = "UI/SpritePics/common/ui_voting_hx_img_0"
    self._view.btn:SetOnClick(self, self.OnBtnHeroClick) -- 点击投票
    self._view.imageIcon:SetOnClick(self, self.OnBtnClick) -- 点击英雄
end

function M:UpdateItem(data)
    self.data = data
    local heroId = data.heroId
    self._view.textName:SetAvatarName(heroId, RoleType.ERT_Hero)
    self._view.textNum:SetText(tostring(data.Ticket))

    self._view.imageIcon:SetPic(self.heroIconPath..heroId)

    self:SetIndex(data.index)
end

function M:SetIndex(index)
    if index > 3 then
        self._view.textIndex:SetText(tostring(index) .. ".")
        self._view.goBg.gameObject:SetActive(false)
        return
    end

    self._view.textIndex:SetText("")
    self._view.goBg.gameObject:SetActive(true)
    self._view.imageIndex:SetPic(self.bgPath .. tostring(index))
    local tabColor = self.tabColor[index]
    self._view.imageIndexBg:SetColor(tabColor.r, tabColor.g, tabColor.b)
end

function M:OnBtnClick()
    if self.data == nil then
        return
    end

    EventMgr:Broadcast(UIMessageNames.VOTING_CLICKHERO, self.data.heroId)
end

function M:OnBtnHeroClick()
    UIContextMgr:GetInstance():Show(UIDefine.UIVotingVote, self.data.heroId, self.data.Ticket)
end

-- 关闭时回调，无参
function M:OnClose()
    self.tabColor = nil
    self.bgPath = nil
    self.data = nil
end

return UIVotingSelItemCtrl
