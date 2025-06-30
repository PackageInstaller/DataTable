module("RefMgr", Class.impl())

function ctor(self)
    -- 普通引用数据路径
    self.m_basePath = ""
    -- 已加载的普通引用数据
    self.m_loadMap = {}

    -- 多语言的引用数据路径
    self.m_lanPath = ""
    -- 已加载的多语言引用数据
    self.m_loadLanMap = {}
end

-- 设置基础路径
function setBasePath(self, path)
    self.m_basePath = path
end
-- 设置多语言的数据路径
function setLanPath(self, path)
    self.m_lanPath = path
end

-- 获取整个引用数据 文件名 是否一直使用最新的(编辑器下使用)
function getData(self, fileName, allowByNew)
    local refData = self.m_loadMap[fileName]
    if not refData or allowByNew == true then
        refData = self.m_loadLanMap[fileName]

        if not refData or allowByNew == true then
            local function _tryLanRequire()
                refData = require(self.m_lanPath .. fileName)
                self.m_loadLanMap[fileName] = refData
            end
            if not pcall(_tryLanRequire) then
                local function _tryRequire()
                    refData = require(self.m_basePath .. fileName)
                    self.m_loadMap[fileName] = refData
                end
                if not pcall(_tryRequire) then
                    Debug:log_warn("RefMgr", "no [%s] ref data !!!", fileName)
                end
            end

            -- local function _tryRequire()
            -- 	print(self.m_basePath..fileName)
            -- 	refData = require(self.m_basePath..fileName)
            -- end
            -- if pcall(_tryRequire) and refData then	
            -- 	self.m_loadMap[fileName] = refData
            -- else
            -- 	local function _tryLanRequire()
            -- 		print(self.m_lanPath..fileName)
            -- 		refData = require(self.m_lanPath..fileName)
            -- 	end
            -- 	if pcall(_tryLanRequire) and refData then	
            -- 		self.m_loadLanMap[fileName] = refData
            -- 	else
            -- 		Debug:log_warn("RefMgr", "no [%s] ref data !!!", fileName)
            -- 	end
            -- end
        end
        -- self:clearData(fileName)
    end
    return refData
end
-- 获取一条引用数据
function getRefData(self, fileName, refID)
    local refs = self:getData(fileName, refID)
    if refs then
        return refs[refID]
    end
    Debug:log_warn("RefMgr", "[%s] ref no [%d] data !!!", fileName, refID)
end

function clearData(self, fileName)
    if self.m_loadMap[fileName] then
        self.m_loadMap[fileName] = nil
        package.loaded[self.m_basePath .. fileName] = nil
        return
    end
    if self.m_loadLanMap[fileName] then
        self.m_loadLanMap[fileName] = nil
        package.loaded[self.m_lanPath .. fileName] = nil
        return
    end
end

function clearAllBaseData(self)
    for k, _ in pairs(self.m_loadMap) do
        package.loaded[self.m_basePath .. k] = nil
    end
    self.m_loadMap = {}
end

function clearAllLanData(self)
    for k, _ in pairs(self.m_loadLanMap) do
        package.loaded[self.m_lanPath .. k] = nil
    end
    self.m_loadLanMap = {}
end

-- 特殊资源配置
function getSpecialConfig(self)
    if GameManager:getIsInCommiting() then
        return {}
    end
    if gs.File.Exists(gs.PathUtil.GetPersistentAssetsWPath("LuaScripts/resconfig/re_config.lua")) then
        local refData = require("resconfig/re_config")
        return refData
    end
    return nil
end

function clearAllData(self)
    self:clearAllBaseData()
    self:clearAllLanData()
end

return _M