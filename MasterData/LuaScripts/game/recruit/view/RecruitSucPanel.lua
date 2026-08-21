module('recruit.RecruitSucPanel', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath('recruit/RecruitSucPanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
	super.ctor(self)
	self:setSize(0, 0)
	self:setTxtTitle('')
end

-- 初始化数据
function initData(self)
    self.m_scroller = nil
	self.m_times = nil
	self.m_heroTidList = nil
end

function configUI(self)	
	self.m_scroller = self:getChildGO('LyScroller'):GetComponent(ty.LyScroller)
	self.m_scroller:SetItemRender(recruit.RecruitSucItem)
end

function active(self, args)
	super.active(self, args)

	self:setData(args.times, args.heroTidList)
end

function deActive(self)
	super.deActive(self)
end

function setData(self, cusTimes, cusHeroTidList)
	self.m_times = cusTimes
	self.m_heroTidList = cusHeroTidList
	self:__updateView(true)
end

function __updateView(self, cusIsInit)	
	if(cusIsInit)then
		self.m_scroller.DataProvider = self.m_heroTidList
	else
		self.m_scroller:ReplaceAllDataProvider(self.m_heroTidList)
	end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
