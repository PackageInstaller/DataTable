if not GV.IsServer then
    return
end

if GF.isInitHotfixModule("ConfigReload") then
    return
end

local function reLoad()

    -- local tableList = 
    -- {
    --    "OpenBetaTest01Table",
    --    "QuestionnaireTable",
    -- }
    -- Config.reloadTableList(tableList)

    --更新全部表和方法
    Config.reloadAll()
end

reLoad()

