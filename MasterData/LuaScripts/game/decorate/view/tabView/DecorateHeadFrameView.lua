module('decorate.DecorateHeadFrameView', Class.impl("game.decorate.view.tabView.DecorateBaseView"))

UIRes = UrlManager:getUIPrefabPath('decorate/tab/DecorateHeadFrameView.prefab')

--构造函数
function ctor(self)
	super.ctor(self)
end

-- 初始化数据
function initData(self)
	super.initData(self)
end

function configUI(self)
	super.configUI(self)
end

function active(self, args)
	super.active(self, args)
end

function deActive(self)
	super.deActive(self)
	self:setSelectId(nil)
end

function initViewText(self)
	super.initViewText(self)
end

function addAllUIEvent(self)
	super.addAllUIEvent(self)
end

function __onClickSetLikeHandler(self)
	local moduleType = decorate.getModuleTypeByTabType(self:__getTabType())
	local isActive = decorate.DecorateManager:getIsActive(moduleType, self:getSelectId())
	if(isActive)then
		local isSetLike = not decorate.DecorateManager:getIsLike(moduleType, self:getSelectId())
		if(isSetLike)then
			GameDispatcher:dispatchEvent(EventName.REQ_SET_LIKE_DECORATE, {moduleType = moduleType, id = self:getSelectId()})
		else
			GameDispatcher:dispatchEvent(EventName.REQ_CANCEL_LIKE_DECORATE, {moduleType = moduleType, id = self:getSelectId()})
		end
	else
		gs.Message.Show(_TT(25204))
	end
end

function __onClickControlHandler(self)
	local moduleType = decorate.getModuleTypeByTabType(self:__getTabType())
	local isActive = decorate.DecorateManager:getIsActive(moduleType, self:getSelectId())
	if(isActive)then
		if(self:getSelectId() == role.RoleManager:getRoleVo():getAvatarFrameId())then
			gs.Message.Show(_TT(25197))
		else
			local moduleType = decorate.getModuleTypeByTabType(self:__getTabType())
			GameDispatcher:dispatchEvent(EventName.REQ_SET_DECORATE, {moduleType = moduleType, id = self:getSelectId()})
		end
	else
		gs.Message.Show(_TT(25204))
	end
end

function getLyScrollerItem(self)
	return decorate.DecorateHeadFrameItem
end

function getCurId(self)
	local roleVo = role.RoleManager:getRoleVo()
	return roleVo:getAvatarFrameId()
end

function getSelectId(self)
	if(not self.m_selectId)then
		self.m_selectId = self:getCurId()
	end
	return self.m_selectId
end

function setSelectId(self, id)
	self.m_selectId = id
end

function __getTabType(self)
	return decorate.TabType.HEAD_FRAME
end

-- 装饰item选择变化
function onSelectItemUpdateHandler(self, args)
	local tabType = args.tabType
	local id = args.id
	if(tabType == self:__getTabType())then
		self:setSelectId(id)
		self:__setData()
	end
end

-- 装饰列表变化
function __onDecorateListUpdateHandler(self, args)
	local moduleType = args.moduleType
	if(moduleType == decorate.getModuleTypeByTabType(self:__getTabType()))then
		self:__setData()
	end
end

function __setData(self, args)
	self:__updateFindList()
	self:__updateLikeState()
	self:__updateShow()
	self:__updateBtnTip()
end

function __updateFindList(self)
	local cusIsInit = true
    local scrollList = {}
	local configList = decorate.DecorateManager:getPlayerHeadFrameConfigList()
	if(cusIsInit)then
		table.sort(configList, decorate.DecorateManager.sortList)
	end

	local isFindLike = self:getIsFindingLike()
	local moduleType = decorate.getModuleTypeByTabType(self:__getTabType())
	local firstScrollVo = nil
	local isHasSelect = false
	for i = 1, #configList do
		if(not isFindLike or (isFindLike and decorate.DecorateManager:getIsLike(moduleType, configList[i]:getRefID())))then
			local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
			scrollVo:setDataVo({tabType = self:__getTabType(), configVo = configList[i]})
			if(not firstScrollVo)then
				firstScrollVo = scrollVo
			end
			table.insert(scrollList, scrollVo)
	
			if (not isHasSelect and self:getSelectId() == configList[i]:getRefID()) then
				scrollVo:setSelect(true)
				isHasSelect = true
			end
		end
	end
	if(not isHasSelect and firstScrollVo)then
		self:setSelectId(firstScrollVo:getDataVo().configVo:getRefID())
		firstScrollVo:setSelect(true)
	end

    self:recoverListData(self.m_scroller.DataProvider)
    if (self.m_scroller.Count <= 0) then
        self.m_scroller.DataProvider = scrollList
    else
        self.m_scroller:ReplaceAllDataProvider(scrollList)
	end
end

function recoverListData(self, list)
    if(list and #list > 0)then
        for i, v in ipairs(list) do
            LuaPoolMgr:poolRecover(v)
        end
    end
end

-- 更新喜欢状态
function __updateLikeState(self)
	local moduleType = decorate.getModuleTypeByTabType(self:__getTabType())
	local isLike = decorate.DecorateManager:getIsLike(moduleType, self:getSelectId())
	self.m_goLike:SetActive(isLike)
end

-- 更新展示的
function __updateShow(self)
    local roleVo = role.RoleManager:getRoleVo()
    if (not self.m_playerHeadGrid) then
        self.m_playerHeadGrid = PlayerHeadGrid:poolGet()
    end
    self.m_playerHeadGrid:setData(roleVo:getAvatarId())
    self.m_playerHeadGrid:setHeadFrame(self:getSelectId())
    self.m_playerHeadGrid:setParent(self.m_showNode)
    self.m_playerHeadGrid:setScale(1)
    self.m_playerHeadGrid:setLvl(nil)
    self.m_playerHeadGrid:setClickEnable(false)
    self.m_playerHeadGrid:setCallBack(nil, nil)
end

function __updateBtnTip(self)
	self.mTxtName.text = _TT(decorate.DecorateManager:getPlayerHeadFrameConfigVo(self:getSelectId()):getResName())
	local moduleType = decorate.getModuleTypeByTabType(self:__getTabType())
	local isActive = decorate.DecorateManager:getIsActive(moduleType, self:getSelectId())
	if(isActive)then
		self.m_textTip.text = ""
		if(self:getSelectId() == role.RoleManager:getRoleVo():getAvatarFrameId())then
			self.m_textTip.text = ""
			self:setBtnLabel(self.m_btnControl, 25197, "使用中")
			self.m_imgControl:SetImg(UrlManager:getCommonPath("common_3005.png"), false)
		else
			self:setBtnLabel(self.m_btnControl, 25198, "更换")
			self.m_imgControl:SetImg(UrlManager:getCommonPath("common_3003.png"), false)
		end
		local decorateVo = decorate.DecorateManager:getDecorateVo(moduleType, self:getSelectId())
		if(decorateVo.expiredTime <= 0)then
			self.m_textTimeTip.text = ""
		else
			local time = decorateVo.expiredTime - GameManager:getClientTime()
			self.m_textTimeTip.text = _TT(25199,TimeUtil.getFormatTimeBySeconds_2(time))
		end
	else
		self.m_textTip.text = _TT(decorate.DecorateManager:getPlayerHeadFrameConfigVo(self:getSelectId()):getGetDescription())
		self:setBtnLabel(self.m_btnControl, 25204, "未解锁")
		self.m_imgControl:SetImg(UrlManager:getCommonPath("common_3005.png"), false)
		self.m_textTimeTip.text = ""
	end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(25204):	"未解锁"
	语言包: _TT(25197):	"使用中"
	语言包: _TT(25204):	"未解锁"
]]
