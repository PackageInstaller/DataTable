-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/StoryGameObjectPool.lua

module("logic.extensions.story.core.StoryGameObjectPool", package.seeall)

local m_pool = {}
local m_root
local m_isInit = false

function Get(key, source)
	if not m_isInit then
		printError("StoryGameObjectPool Error:not init the pool")

		return nil
	end

	if string.nilorempty(key) then
		printError("StoryGameObjectPool Error:key is empty")

		return nil
	end

	if m_pool[key] and #m_pool > 0 then
		local go = table.remove(m_pool, #m_pool)

		if not goutil.isNil(go) then
			goutil.setActive(go, true)

			return go
		end
	end

	if not goutil.isNil(source) then
		local temp = goutil.clone(source, source.name)

		return temp
	end

	printError("StoryGameObjectPool Error:", key, source)

	return nil
end

function Release(key, targetGameObject)
	if goutil.isNil(targetGameObject) then
		return
	end

	if not m_isInit then
		goutil.destroy(targetGameObject)

		return
	end

	local stack

	if m_pool[key] then
		stack = m_pool[key]
	else
		stack = {}
		m_pool[key] = stack
	end

	table.insert(stack, targetGameObject)
	goutil.addChildToParent(targetGameObject, RootGameObject())
	goutil.setActive(targetGameObject, false)
end

function RootGameObject()
	if not m_isInit then
		return nil
	end

	if goutil.isNil(m_root) then
		m_root = UnityEngine.GameObject.Find("StoryGameObjectPools")

		if goutil.isNil(m_root) then
			m_root = goutil.create("StoryGameObjectPools", false)

			UnityEngine.GameObject.DontDestroyOnLoad(m_root)
			goutil.setActive(m_root, false)
		end
	end

	return m_root
end

function Dispose()
	for _, list in pairs(m_pool) do
		for k, v in pairs(list) do
			goutil.destroy(v)
		end
	end

	m_pool = {}

	goutil.destroy(m_root)

	m_root = nil
	m_isInit = false
end

function Init()
	m_isInit = true
end
