module('recruit.RecruitTmpPanel', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath('recruit/RecruitTmpPanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认
panelType = -1 -- 窗口类型 1 全屏 2 弹窗
isBlur = 0
isScreensave = 0 --是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)
isAdapta = 0 --是否开启适配刘海
--构造函数
function ctor(self)
	super.ctor(self)
	self:setSize(0, 0)
	self:setTxtTitle('')
end
function setMask(self)
end
function __playOpenAction(self)
end
function configUI(self)	
	local function _click()
		self:close()
		local tids = recruit.RecruitManager:getRecruitHeroResultList()
		if not table.empty(tids) then
			if #tids==10 then
				GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_SHOW_ALL_VIEW, tids)
			else
				GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_SHOW_ONE_VIEW, { tid = tids[1],propsList = tids[1].propsList})
			end
			return
		end
		GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
		-- GameDispatcher:dispatchEvent(EventName.SHOW_MAIN_UI)
		GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_PANEL)
	end
	self:addOnClick(self:getChildGO('CloseBtn'), _click)
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
