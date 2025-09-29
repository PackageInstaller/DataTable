-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/StoryLoader.lua

module("logic.extensions.story.core.StoryLoader", package.seeall)

local M = class("StoryLoader")

M.LoadState = {
	Success = 2,
	Loading = 1,
	None = 0
}

function M:ctor()
	self._multiLoader = MultiResLoader.New()
	self._loadState = M.LoadState.None
	self._callback = {}
	self._seqCallback = {}
	self._allCompleteCallback = nil
	self._allCompleteCallbackTarget = nil

	StoryModel.instance:cacheLoader(self)
end

function M:dispose()
	self:clear()

	self._multiLoader = nil
	self._callback = nil
	self._seqCallback = nil
end

function M:clear()
	self._loadState = M.LoadState.None

	if self._multiLoader then
		self._multiLoader:clear()
	end

	self._callback = {}
	self._seqCallback = {}
	self._allCompleteCallback = nil
	self._allCompleteCallbackTarget = nil
end

function M:GetRes(url)
	if self._multiLoader then
		return self._multiLoader:getResource(url)
	end

	return nil
end

function M:addUrl(url, callback, callbackTarget, param1, param2, param3)
	if self._loadState == M.LoadState.Success then
		printError("loader 已持有资源")

		return
	end

	if string.nilorempty(url) then
		printError("url不能为空")

		return
	end

	if self._callback[url] ~= nil then
		return
	end

	self._multiLoader:addResPath(url)

	if callback then
		self._callback[url] = {
			callback = callback,
			target = callbackTarget,
			p1 = param1,
			p2 = param2,
			p3 = param3
		}
	end
end

function M:addSeqUrl(url, callback, callbackTarget, param1, param2, param3)
	if self._loadState == M.LoadState.Success then
		printError("loader 已持有资源")

		return
	end

	if string.nilorempty(url) then
		printError("url不能为空")

		return
	end

	self._multiLoader:addResPath(url)

	if callback then
		self._seqCallback[#self._seqCallback + 1] = {
			url = url,
			callback = callback,
			target = callbackTarget,
			p1 = param1,
			p2 = param2,
			p3 = param3
		}
	end
end

function M:startLoad(allCompleteCallback, allCompleteCallbackTarget)
	if self._loadState ~= M.LoadState.None then
		printWarn("loader已经持有资源")

		return
	end

	self._allCompleteCallback = allCompleteCallback
	self._allCompleteCallbackTarget = allCompleteCallbackTarget
	self._loadState = M.LoadState.Loading

	self._multiLoader:load(self._onAllResLoaded, self._onSingleResLoaded, self)
end

function M:_onAllResLoaded()
	self._loadState = M.LoadState.Success

	for index, value in ipairs(self._seqCallback) do
		if value and value.callback then
			local _target = value.target
			local _res = self._multiLoader:getResource(value.url)

			if _res then
				local p1, p2, p3 = value.p1, value.p2, value.p3

				if _target then
					value.callback(_target, _res, p1, p2, p3)
				else
					value.callback(_res, p1, p2, p3)
				end
			end
		end
	end

	if self._allCompleteCallback then
		self._allCompleteCallback(self._allCompleteCallbackTarget)
	end
end

function M:_onSingleResLoaded(res, loadedCount, totalCount)
	local _path = res.ResPath

	print(string.format("storyLoader progress：（%s/%s）,path=%s", loadedCount, totalCount, tostring(_path)))

	if not self._callback[_path] then
		return
	end

	local _st = self._callback[_path]
	local _callback = _st.callback
	local _target = _st.target

	if _callback then
		local p1, p2, p3 = _st.p1, _st.p2, _st.p3

		if _target then
			_callback(_target, res, p1, p2, p3)
		else
			_callback(res, p1, p2, p3)
		end
	end
end

return M
