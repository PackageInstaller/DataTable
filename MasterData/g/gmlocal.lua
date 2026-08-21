--模拟GM本地执行的执行

local GMLocal = {}

function GMLocal.opitem()
    UIMgr:popUI("ItemPanel")
    return true
end

function GMLocal.reloadcfg()

	Config.Reload()
    ReloadModule("ClientConfig")
	ReloadModule("ClientConstant")
	---@type LocalStrEnum
    LocalStrEnum = Config.table.LocalStrEnum_ChineseSimplified
    UILanguageKey = Config.table.UILanguageKey_ChineseTraditional
    -- 单机的服务端跟客户端用一个Config，但服务端不会reload客户端配置
    if Standalone then
        return true
    end

	return false
end

return GMLocal