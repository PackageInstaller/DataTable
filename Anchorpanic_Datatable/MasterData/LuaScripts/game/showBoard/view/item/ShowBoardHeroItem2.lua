module('showBoard.ShowBoardHeroItem2', Class.impl('lib.component.BaseItemRender'))

function onInit(self, go)
    super.onInit(self, go)
    self.mGroup = self:getChildGO("mGroup")
    self.mImgHead = self:getChildGO("mImgHead"):GetComponent(ty.AutoRefImage)
    self.mImgHeadBg = self:getChildGO("mImgHeadBg"):GetComponent(ty.AutoRefImage)
    self.mImgSelect = self:getChildGO("mImgSelect")
    self.mImgNow = self:getChildGO("mImgNow")
    self.mTxtNow = self:getChildGO("mTxtNow"):GetComponent(ty.Text)
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mGroup, self.onClickItemHandler)
end

function setData(self, param)
    super.setData(self, param)
    showBoard.ShowBoardManager:addEventListener(showBoard.ShowBoardManager.SHOW_HERO_SELECT, self.onSelectHandler, self)

    self:onSelectHandler({ id = role.RoleManager:getRoleVo():getShowBoardHeroId() })

    if self.data then
        --  self.mImgHeadBg:SetImg(UrlManager:getHeroColorIconUrl_1(self.data.color), true)
        self.mImgHead:SetImg(UrlManager:getHeroHeadUrlByModel(self.data:getHeroModel()), true)
    end
end

function onClickItemHandler(self)
    showBoard.ShowBoardManager:dispatchEvent(showBoard.ShowBoardManager.SHOW_HERO_SELECT, { id = self.data.id })
end

function onSelectHandler(self, args)
    self.mImgSelect:SetActive(args.id == self.data.id)
end

function deActive(self)
    super.deActive(self)

    showBoard.ShowBoardManager:removeEventListener(showBoard.ShowBoardManager.SHOW_HERO_SELECT, self.onSelectHandler, self)
end

function onDelete(self)
    super.onDelete(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]