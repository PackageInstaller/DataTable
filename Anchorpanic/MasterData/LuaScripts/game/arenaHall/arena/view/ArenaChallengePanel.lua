module("arena.ArenaChallengePanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("arenaHall/arena/ArenaChallengePanel.prefab")
destroyTime = -1 -- 自动销毁时间-1默认

--构造函数
function ctor(self)
	super.ctor(self)
	self:setSize(0, 0)
	self:setTxtTitle("")
	-- self:setBg("hero_formation_bg.jpg", false)
end

-- 初始化数据
function initData(self)
end

function configUI(self)
	super.configUI(self)
end

function active(self)
	super.active(self)
	-- self:addOnClick(self.m_btnAward, self.__onClickAwardHandler)

	self:__updateView(true)
end

function deActive(self)
	super.deActive(self)
	-- self:removeOnClick(self.m_btnAward)
end

function __onClickAwardHandler(self)
end

function __updateView(self, cusIsInit)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
