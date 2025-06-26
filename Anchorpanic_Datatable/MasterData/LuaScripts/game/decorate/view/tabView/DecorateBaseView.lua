module('decorate.DecorateBaseView', Class.impl(TabSubView))

--构造函数
function ctor(self)
	super.ctor(self)
end

-- 初始化数据
function initData(self)
	super.initData(self)
	-- 是否正在查找喜欢状态
	self.m_isFindingLike = false
end

function configUI(self)
	super.configUI(self)

	self.m_btnControl = self:getChildGO("BtnControl")
	self.m_imgControl = self.m_btnControl:GetComponent(ty.AutoRefImage)

	self.m_btnSetLike = self:getChildGO("BtnSetLike")
	self.m_goLike = self:getChildGO("ImgSetLikeSelect")

	self.m_btnFindLike = self:getChildGO("BtnFindLike")
	self.m_goFindLike = self:getChildGO("ImgFindLikeSelect")

	self.m_btnFindAll = self:getChildGO("BtnFindAll")
	self.m_goFindAll = self:getChildGO("ImgFindAllSelect")
	
	self.m_showNode = self:getChildTrans("BigShowNode")
	self.mTxtName = self:getChildTrans("TextName"):GetComponent(ty.Text)
	self.m_textTip = self:getChildTrans("TextTip"):GetComponent(ty.Text)
	self.m_textTimeTip = self:getChildTrans("TextTimeTip"):GetComponent(ty.Text)
	
    self.m_scroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
	self.m_scroller:SetItemRender(self:getLyScrollerItem())
end

function active(self, args)
	super.active(self, args)
	GameDispatcher:addEventListener(EventName.DECORATE_ITEM_SELECT, self.__onSelectItemUpdateHandler, self)
	role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_AVATAR, self.__onRoleDataUpdateHandler, self)
	role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_AVATAR_FRAME, self.__onRoleDataUpdateHandler, self)
	role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_TITLE, self.__onRoleDataUpdateHandler, self)
	decorate.DecorateManager:addEventListener(decorate.DecorateManager.UPDATE_NEW_BUBBLE, self.__onDecorateBubbleUpdateHandler, self)
	decorate.DecorateManager:addEventListener(decorate.DecorateManager.UPDATE_DECORATE_LIST, self.__onDecorateListUpdateHandler, self)
	self:__updateFindStateHandler(false)
	self:__setData(args)
end

function deActive(self)
	super.deActive(self)
	GameDispatcher:removeEventListener(EventName.DECORATE_ITEM_SELECT, self.__onSelectItemUpdateHandler, self)
	role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_AVATAR, self.__onRoleDataUpdateHandler, self)
	role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_AVATAR_FRAME, self.__onRoleDataUpdateHandler, self)
	role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_TITLE, self.__onRoleDataUpdateHandler, self)
	decorate.DecorateManager:removeEventListener(decorate.DecorateManager.UPDATE_NEW_BUBBLE, self.__onDecorateBubbleUpdateHandler, self)
	decorate.DecorateManager:removeEventListener(decorate.DecorateManager.UPDATE_DECORATE_LIST, self.__onDecorateListUpdateHandler, self)
	self:initData()
end

function initViewText(self)
	super.initViewText(self)
	self:setBtnLabel(self.m_btnFindLike, 25195, "喜爱")
	self:setBtnLabel(self.m_btnFindAll, 25196, "全部")
end

function addAllUIEvent(self)
	super.addAllUIEvent(self)
	self:addUIEvent(self.m_btnSetLike, self.__onClickSetLikeHandler)
	self:addUIEvent(self.m_btnFindLike, self.__onClickFindLikeHandler)
	self:addUIEvent(self.m_btnFindAll, self.__onClickFindAllHandler)
	self:addUIEvent(self.m_btnControl, self.__onClickControlHandler)
end

function __onClickSetLikeHandler(self)
end

function __onClickFindLikeHandler(self)
	self:__updateFindStateHandler(true)
end

function __onClickFindAllHandler(self)
	self:__updateFindStateHandler(false)
end

function __updateFindStateHandler(self, isFindLike)
	self.m_isFindingLike = isFindLike
	self.m_goFindLike:SetActive(self.m_isFindingLike)
	self.m_goFindAll:SetActive(not self.m_isFindingLike)
	self:__setData()
end

function __onClickControlHandler(self)
end

function __onSelectItemUpdateHandler(self, args)
	local tabType = decorate.getModuleTypeByTabType(args.tabType)
	local id = args.id
	if(decorate.DecorateManager:getIsNew(tabType, id))then
		GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, {type = decorate.getReadTypeByModuleType(tabType), id = id})
	end
	self:onSelectItemUpdateHandler(args)
end

function onSelectItemUpdateHandler(self,args)
end

function __onRoleDataUpdateHandler(self)
	self:__setData()
end

function __onDecorateBubbleUpdateHandler(self, args)
	self:__setData()
end

function __onDecorateListUpdateHandler(self, args)
	-- local moduleType = args.moduleType
end

function getLyScrollerItem(self)
	return decorate.DecorateBaseItem
end

function getIsFindingLike(self)
	return self.m_isFindingLike
end

function __setData(self, args)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
