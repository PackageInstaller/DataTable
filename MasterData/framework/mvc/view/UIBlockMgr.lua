-- chunkname: @framework/mvc/view/UIBlockMgr.lua

module("framework.mvc.view.UIBlockMgr", package.seeall)

local UIBlockMgr = class("UIBlockMgr")

UIBlockMgr.DefaultKey = "default"

function UIBlockMgr:ctor()
	self._blockKeyDict = {}
	self._goBlock = nil
	self._clickCounter = 0
end

function UIBlockMgr:startBlock(blockKey)
	blockKey = blockKey or UIBlockMgr.DefaultKey
	self._blockKeyDict[blockKey] = true

	self:_checkFirstCreateMask()
	gohelper.setActive(self._goBlock, true)
end

function UIBlockMgr:endBlock(blockKey)
	blockKey = blockKey or UIBlockMgr.DefaultKey
	self._blockKeyDict[blockKey] = nil

	for _, _ in pairs(self._blockKeyDict) do
		return
	end

	gohelper.setActive(self._goBlock, false)

	self._clickCounter = 0
end

function UIBlockMgr:endAll()
	if self:isBlock() then
		self._blockKeyDict = {}

		gohelper.setActive(self._goBlock, false)

		self._clickCounter = 0
	end
end

function UIBlockMgr:isBlock()
	for _, _ in pairs(self._blockKeyDict) do
		return true
	end
end

function UIBlockMgr:isKeyBlock(blockKey)
	return self._blockKeyDict[blockKey]
end

function UIBlockMgr:getBlockGO()
	self:_checkFirstCreateMask()

	return self._goBlock
end

function UIBlockMgr:_checkFirstCreateMask()
	if not self._goBlock then
		self._goBlock = gohelper.find("UIRoot/TOP/UIBlock")

		SLFramework.UGUI.UIClickListener.Get(self._goBlock):AddClickListener(self._onClickBlock, self)
	end
end

function UIBlockMgr:_onClickBlock()
	self._clickCounter = self._clickCounter + 1

	if self._clickCounter == 5 then
		local keyList = {}

		for key, _ in pairs(self._blockKeyDict) do
			table.insert(keyList, key)
		end

		logNormal("BlockKeys: " .. table.concat(keyList, ","))
	end
end

UIBlockMgr.instance = UIBlockMgr.New()

return UIBlockMgr
