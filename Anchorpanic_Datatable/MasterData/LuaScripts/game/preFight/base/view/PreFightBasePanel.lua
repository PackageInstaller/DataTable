module('preFight.BasePanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('preFight/PreFightBasePanel.prefab')

panelType = 1
destroyTime = -1 -- 自动销毁时间-1默认

--构造函数
function ctor(self)
	super.ctor(self)
	self:setSize(0, 0)
	self:setTxtTitle('')
end

function initData(self)
	self.m_attModelGoDic = {}
	self.m_defModelGoDic = {}
end

function configUI(self)
	local gBtnClose = self:getChildGO('m_btnClose')
	self:addOnClick(gBtnClose, __onClosehHandler)
	local gBtnStart = self:getChildGO('m_btnStart')
	self:addOnClick(gBtnStart, __onStarthHandler)
	local gBtnRefresh = self:getChildGO('m_btnRefresh')
	self:addOnClick(gBtnRefresh, __onRefreshHandler)
	self.m_btnSetting = self:getChildGO('m_btnSetAttacker')
	self:addOnClick(self.m_btnSetting, __onSettingHandler)
	self.m_textSetting = self:getChildGO('m_textSetAttacker'):GetComponent(ty.Text)
	
	local mScrollerGo = self:getChildGO('m_scroller')
	self.mScroller = mScrollerGo:GetComponent(ty.LyScroller)
	-- self.mScroller:SetMask()
	-- 这个itemGo看看虚拟列表那边要怎么处理
	local itemGoName = self:getItemGoName()
	if(not itemGoName) then
		local itemGo = AssetLoader.GetGO(itemGoName)
		self.mScroller:SetItemGameObject(itemGo)
	end
	self.mScroller:SetItemRender(self:getItemName())
end

function active(self)
	self:getShowManager():dispatchEvent(self:getShowManager().START_INIT, {manager = self:getManager()})
	self:getManager():addEventListener(self:getManager().PREP_FIGHT_SELECT_TEMP_CHANGE, self.__onSelectChangeHandler, self)
	self:__updateView()
end

function deActive(self)
	self:getShowManager():dispatchEvent(self:getShowManager().START_RECOVERY)
	self:getManager():removeEventListener(self:getManager().PREP_FIGHT_SELECT_TEMP_CHANGE, self.__onSelectChangeHandler, self)
end

-- 项选择改变
function __onSelectChangeHandler(self, args)
	local isSelect = args.isSelect
	local tempShowVo = args.tempShowVo
	local changeHeroVo = args.changeHeroVo
	if(isSelect) then
		self:getShowManager():dispatchEvent(self:getShowManager().ADD_SHOW_ITEM, {showVo = tempShowVo, heroVo = changeHeroVo})
	else
		self:getShowManager():dispatchEvent(self:getShowManager().REMOVE_SHOW_ITEM, {showVo = tempShowVo, heroVo = changeHeroVo})
	end
	
	self:getManager():dispatchEvent(self:getManager().UPDATE_LIST_ITEM, {heroVo = changeHeroVo})
end

function __updateView(self)
	local isAttacker = self:getManager():getIsAttackerSetting()
	local heroList = hero.HeroManager:getHeroList(isAttacker)
	self.mScroller.DataProvider = heroList
	self:__updateModel()
	self:__updateSettingBtnView()
end

function __updateSettingBtnView(self)
	local isAttackerSetting = self:getManager():getIsAttackerSetting()
	if(isAttackerSetting) then
		self.m_textSetting.text = "攻方设置"
	else
		self.m_textSetting.text = "守方设置"
	end
end

-- 更新指定模型
function __updateModel(self)
	local showList = self:getManager():getTempShowList()
	for _, showVo in pairs(showList) do
		if(showVo.heroVo ~= nil) then
			self:getShowManager():dispatchEvent(self:getShowManager().ADD_SHOW_ITEM, {showVo = showVo, heroVo = showVo.heroVo})
		end
	end
end

-- 重置
function __onRefreshHandler(self)
	local isAttackerSetting = self:getManager():getIsAttackerSetting()
	if(isAttackerSetting) then
		self:getShowManager():dispatchEvent(self:getShowManager().REMOVE_ATT_SHOW_ITEMS)
	else
		self:getShowManager():dispatchEvent(self:getShowManager().REMOVE_DEF_SHOW_ITEMS)
	end
	self:getManager():resetTempShowList(isAttackerSetting)
	self:__updateView()
end

-- 排阵设置攻防方
function __onSettingHandler(self)
	local isAttackerSetting = self:getManager():getIsAttackerSetting()
	self:getManager():setIsAttackerSetting(not isAttackerSetting)
	self:__updateView()
end

-- 关闭
function __onClosehHandler(self)
	self:close()
	self:getManager():resetTempShowList()
	self:getManager():setIsAttackerSetting(true)
end

-- 开始
function __onStarthHandler(self)
	if(self:getManager():isEnoughHero()) then
		self:close()
		self:getManager():updateShowList()
		self:getManager():setIsAttackerSetting(true)
		-- GameDispatcher:dispatchEvent(EventName.BEGIN_FIGHT, {battleType = self:getManager():getBattleType()})
		self:getManager():dispatchEvent(self:getManager().REQ_START_BATTLE)
	end
end

function getShowManager(self)
	return preFight.ShowManager
end

function getItemGoName(self)
	return "HeroGrid.prefab"
end

------------------------------------------------------子类必须实现方法------------------------------------------------------
function getManager(self)
	return nil
end

function getItemName(self)
	return nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
