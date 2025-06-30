module('gm.GuideTabView', Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("gm/GuideTabView.prefab")

function configUI(self)
	super.configUI(self)
	
	local function _call()
		GameDispatcher:dispatchEvent(EventName.OPEN_GUIDE_TOOLS_PANEL)
		GameDispatcher:dispatchEvent(EventName.OPEN_GM_PANEL)
	end
	self:addOnClick(self:getChildGO("OpenBtn"), _call)

	local function _toggleCall(bval)
		guide.GuideManager.m_gmOpenRepeat = bval
	end
	self:getChildGO("OpenRepeat"):GetComponent(ty.Toggle).onValueChanged:AddListener(_toggleCall)
	
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
