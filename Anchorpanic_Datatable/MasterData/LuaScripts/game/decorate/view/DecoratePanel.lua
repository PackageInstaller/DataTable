module('decorate.DecoratePanel', Class.impl(TabView))

UIRes = UrlManager:getUIPrefabPath('decorate/DecoratePanel.prefab')
destroyTime = -1 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
	super.ctor(self)
end

-- 初始化数据
function initData(self)
	super.initData(self)
end


function initTabBar(self)
end

function configUI(self)
	super.configUI(self)
	self.mContent = self:getChildTrans("Content")
	self.m_btnClose = self:getChildGO("BtnClose")
end

function updateTab(self)
	self.tabDataList = {}
	self.list = self:getTabDatas()

	self.tabBar = CustomTabBar:create(self:getChildGO("GroupTabItem"),self.mContent,self.setType, self)
	self.tabBar:setData(self.tabDataList)
	self.tabBar:setPage(decorate.TabType.HEAD)
end

function setType(self, cusTabType, cusArgs)
    if (self.curPage == cusTabType) then
        self:subActive()
        return
    end



    self:setPage(cusTabType)
    local instance = self:getClassInsByType(cusTabType)
    for type, classIns in pairs(self.m_classInsDic) do
        if (type ~= cusTabType) then
            if (not classIns:getIsCache()) then
                classIns:setUICache(false)
                classIns:__deActive()
            end
        end
    end
    if cusArgs then
        self.args[self.curPage] = cusArgs
    elseif not self.args[self.curPage] then
        self.args[self.curPage] = self:getActiveArgs()
    end
    instance:setUICache(true)
    instance:__active(self.args[self.curPage])
end



function active(self, args)
	super.active(self, args)
	self:updateTab()
	decorate.DecorateManager:addEventListener(decorate.DecorateManager.UPDATE_NEW_BUBBLE, self.__onDecorateBubbleUpdateHandler, self)
	self:__onDecorateBubbleUpdateHandler()
end

function deActive(self)
	super.deActive(self)
	decorate.DecorateManager:removeEventListener(decorate.DecorateManager.UPDATE_NEW_BUBBLE, self.__onDecorateBubbleUpdateHandler, self)
	self.tabBar:reset()
end

function initViewText(self)
	super.initViewText(self)
end

function addAllUIEvent(self)
	super.addAllUIEvent(self)
	self:addUIEvent(self.m_btnClose, self.close, self:getCloseSoundPath())
end

function isHorizon(self)
	return false
end

function getTabDatas(self)
	self.tabDataList = {}

	if(funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HOME_HEAD, false))then
		self.tabDataList[decorate.TabType.HEAD] ={page = decorate.TabType.HEAD,nomalLan = decorate.getNameByTabType(decorate.TabType.HEAD), nomalLanEn = ""}
	end
	if(funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HOME_HEAD_FRAME, false))then
		self.tabDataList[decorate.TabType.HEAD_FRAME] ={page = decorate.TabType.HEAD_FRAME,nomalLan = decorate.getNameByTabType(decorate.TabType.HEAD_FRAME), nomalLanEn = ""}
	end
	if(funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HOME_TITLE, false))then
		self.tabDataList[decorate.TabType.TITLE] ={page = decorate.TabType.TITLE,nomalLan = decorate.getNameByTabType(decorate.TabType.TITLE), nomalLanEn = ""}
	end
	return self.tabDataList
end

function getTabClass(self)
	self.tabClassDic[decorate.TabType.HEAD] = decorate.DecorateHeadView
	self.tabClassDic[decorate.TabType.HEAD_FRAME] = decorate.DecorateHeadFrameView
	self.tabClassDic[decorate.TabType.TITLE] = decorate.DecorateTitleView
	return self.tabClassDic
end

function __onDecorateBubbleUpdateHandler(self, args)
	local tabDataList = self:getTabDatas()

	for id,data in pairs(tabDataList) do
		local isBubble = decorate.DecorateManager:isModuleTypeBubble(decorate.getModuleTypeByTabType(id))
		if(isBubble)then
			self:addBubble(id)
		else
			self:removeBubble(id)
		end
	end
end

function addBubble(self, tabType)
    self.tabBar:addBubble(tabType, 66, 28)
end

function removeBubble(self, tabType)
    self.tabBar:removeBubble(tabType)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
