-- chunkname: @IQIGame\\Config\\CfgQuestionnaireTable.lua

local CfgQuestionnaireTable = {
	[31120001] = {
		Url = "https://www.wjx.cn/vm/wscF61N.aspx#",
		Activity = "298749929",
		RefActivityId = 60004012,
		Type = 1,
		Id = 31120001,
		MailId = 31000202
	}
}

setmetatable(CfgQuestionnaireTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgQuestionnaireTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Url = "",
		Activity = "",
		RefActivityId = 0,
		Type = 0,
		Icon = "",
		MailId = 0
	}
}

for i, data in pairs(CfgQuestionnaireTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgQuestionnaireTable
