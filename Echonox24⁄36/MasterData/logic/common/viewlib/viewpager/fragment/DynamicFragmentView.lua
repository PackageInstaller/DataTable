-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/viewpager/fragment/DynamicFragmentView.lua

module("logic.common.viewlib.viewpager.fragment.DynamicFragmentView", package.seeall)

local M = class("DynamicFragmentView", FragmentView)

local function kCreateRootMatchParent(name)
	local root = goutil.create(name, true)
	local transform = root.transform

	RectTransformUtils.SetAnchorMin(transform, 0, 0)
	RectTransformUtils.SetAnchorMax(transform, 1, 1)
	RectTransformUtils.SetOffset(transform, 0, 0, 0, 0)

	return root
end

local kViewState = {
	Entered = 2,
	Exited = 3,
	Loading = 1,
	None = 0
}

function M:buildUI()
	return
end

function M:destroyUI()
	return
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:ctor()
	self.mainGO = kCreateRootMatchParent("DynFragment")
	self._resLoader = PrefabLoader.Get(self.mainGO)
	self._viewState = kViewState.None
	self._registry = false
	self._viewPager = false
	self._subViews = {}
end

function M:destroy()
	self:unbindEvents()
	self:_notifySubViews(FunctionName.unbindEvents)
	self:destroyUI()
	self:_notifySubViews(FunctionName.destroyUI)

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = false
	end

	self._viewPager = false

	self._resLoader:clear()

	self._resLoader = false

	goutil.destroy(self.mainGO)

	self.mainGO = false
end

function M:isLoaded()
	return self._resLoader:getInst()
end

function M:active(url)
	if self:isLoaded() then
		self._viewState = kViewState.Entered

		self:onEnter()
		self:_notifySubViews(FunctionName.onEnter)
	else
		self._viewState = kViewState.Loading

		self._resLoader:load(url, self._onResourceLoaded, self)
	end
end

function M:inactive()
	if self._viewState == kViewState.Entered then
		self._viewState = kViewState.Exited

		self:onExit()
		self:_notifySubViews(FunctionName.onExit)
	end
end

function M:_onResourceLoaded(resource)
	if not self._registry then
		self._registry = ViewElementsRegistry.New(resource:getInst())
	else
		self._registry:cleanRegistry()
		self._registry:setMainGO(resource:getInst())
	end

	self:buildUI()
	self:setupSubViews()
	self:_notifySubViews(FunctionName.buildUI)
	self:bindEvents()
	self:_notifySubViews(FunctionName.bindEvents)

	if self._viewState == kViewState.Loading then
		self._viewState = kViewState.Entered

		self:onEnter()
		self:_notifySubViews(FunctionName.onEnter)
	end
end

function M:setViewPager(viewPager)
	self._viewPager = viewPager
end

function M:getViewPage()
	return self._viewPager
end

function M:_notifySubViews(functionName)
	for _, subView in ipairs(self._subViews) do
		subView[functionName](subView)
	end
end

function M:setupSubViews()
	for _, subView in ipairs(self._subViews) do
		subView.mainGO = self.mainGO

		subView:setViewPresentor(self._viewPager:getViewPresentor())
	end
end

function M:addSubView(viewComponent)
	table.insert(self._subViews, viewComponent)
end

function M:getSubView(index)
	return self._subViews[index]
end

return M
