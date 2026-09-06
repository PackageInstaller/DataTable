-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/lmvc/view/ViewComponent.lua

module("frameworkext.lmvc.view.ViewComponent", package.seeall)

local ViewComponent = class("ViewComponent")

function ViewComponent:ctor()
	self.mainGO = nil
	self._viewPresentor = nil
end

function ViewComponent:setViewPresentor(presentor)
	self._viewPresentor = presentor
end

function ViewComponent:bindEvents()
	return
end

function ViewComponent:unbindEvents()
	return
end

function ViewComponent:buildUI()
	return
end

function ViewComponent:destroyUI()
	return
end

function ViewComponent:onEnter()
	return
end

function ViewComponent:onEnterFinished()
	return
end

function ViewComponent:onExit()
	return
end

function ViewComponent:onExitFinished()
	return
end

function ViewComponent:getGo(goPath)
	return goutil.findChild(self.mainGO, goPath)
end

function ViewComponent:getBtn(goPath)
	return Framework.ButtonAdapter.GetFrom(self.mainGO, goPath)
end

function ViewComponent:getInput(goPath)
	return Framework.InputFieldAdapter.GetFrom(self.mainGO, goPath)
end

function ViewComponent:getSlider(goPath)
	return Framework.SliderAdapter.GetFrom(self.mainGO, goPath)
end

function ViewComponent:getToggle(goPath)
	return Framework.ToggleAdapter.GetFrom(self.mainGO, goPath)
end

function ViewComponent:getTabGroup(goPath)
	return Framework.UITabGroup.GetFrom(self.mainGO, goPath)
end

function ViewComponent:getSwith(goPath)
	return Framework.UISwitch.GetFrom(self.mainGO, goPath)
end

function ViewComponent:getProgressBar(goPath)
	return Framework.UIMaskProgressBar.GetFrom(self.mainGO, goPath)
end

function ViewComponent:getTimerProgressBar(goPath)
	return Framework.UITimerProgressBar.GetFrom(self.mainGO, goPath)
end

function ViewComponent:getBigBg(goPath)
	return Framework.ImageBigBG.GetFrom(self.mainGO, goPath)
end

function ViewComponent:getScrollRect(goPath)
	return Framework.ScrollRectAdapter.GetFrom(self.mainGO, goPath)
end

function ViewComponent:registerNotify(name, handler, handlerObj, priority)
	GlobalDispatcher:addListener(name, handler, handlerObj)
end

function ViewComponent:unregisterNotify(name, handler, handlerObj)
	GlobalDispatcher:removeListener(name, handler, handlerObj)
end

function ViewComponent:notify(name, message)
	GlobalDispatcher:dispatch(name, message)
end

function ViewComponent:registerLocalNotify(name, handler, handlerObj, priority)
	self._viewPresentor.localDispatcher:addListener(name, handler, handlerObj)
end

function ViewComponent:unregisterLocalNotify(name, handler, handlerObj)
	self._viewPresentor.localDispatcher:removeListener(name, handler, handlerObj)
end

function ViewComponent:localNotify(name, message)
	self._viewPresentor.localDispatcher:dispatch(name, message)
end

function ViewComponent:getRes(path)
	return self._viewPresentor:getRes(path)
end

function ViewComponent:getPrefab(path)
	return self._viewPresentor:getPrefab(path)
end

function ViewComponent:getResInstance(path)
	return self._viewPresentor:getResInstance(path)
end

function ViewComponent:getOpenParam()
	return self._viewPresentor:getOpenParam()
end

function ViewComponent:getFirstParam()
	return self._viewPresentor:getFirstParam()
end

function ViewComponent:close()
	ViewMgr.instance:close(self._viewPresentor.viewName)
end

function ViewComponent:back()
	ViewMgr.instance:close(self._viewPresentor.viewName, true)
end

return ViewComponent
