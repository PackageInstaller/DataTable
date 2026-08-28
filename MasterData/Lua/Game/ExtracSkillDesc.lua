-- 使用前要先把CardProgressionSkillUtils里面两处处理\\n的代码去掉

--- @type CardProgressionSkillDesc
local CardProgressionSkillDesc = import('Game.CardProgression.Common.CardProgressionSkillDesc')
---@type CardConfMgr
local cardConfMgr      = CardConfMgr:GetInstance()
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionSkillUtils
local CardProgressionSkillUtils     = import("Game.CardProgression.CardProgressionSkillUtils")

local ExtracSkillDesc = {}

function ExtracSkillDesc:Show()
    CardProgressionSkillUtils.SkillExtraMode = true
    xTry(function()
        local Normal = CardProgressionConstants.SkillGroupType.Normal
        local Final = CardProgressionConstants.SkillGroupType.Final

        --- @type CardProgressionSkillDesc
        local generator = CardProgressionSkillDesc.New()

        for voIndex, cardVo in ipairs(CfUtils.GetWholeVo(AutoIds.IdSetting28, 'CardVo')) do
            print(cardVo.name)
            generator._cardVo = cardVo
            local skillCardId = cardVo.skillNode.generalSkill
            ---@type SkillCardVo | TalentVo
            local vo = CardProgressionSkillUtils.GetSkillVoBySkillGroupType(skillCardId, Normal)
            generator:InitSkillLevel2Star(Normal)
            for i = 1, 3, 1 do
                xTry(function()
                    local desc = generator:GetDesc(vo, i, Normal, cardVo.roleId)
                    print(vo.id, vo.skillName, desc)
                end, function()
                    print(vo.id, vo.skillName, "error desc")
                end)
            end
            local skillCardId = cardVo.skillNode.advancedSkill
            ---@type SkillCardVo | TalentVo
            local vo = CardProgressionSkillUtils.GetSkillVoBySkillGroupType(skillCardId, Normal)
            generator:InitSkillLevel2Star(Normal)
            for i = 1, 3, 1 do
                xTry(function()
                    local desc = generator:GetDesc(vo, i, Normal, cardVo.roleId)
                    print(vo.id, vo.skillName, desc)
                end, function()
                    print(vo.id, vo.skillName, "error desc")
                end)
            end
            local skillCardId = cardVo.skillNode.finalSkill
            ---@type SkillCardVo | TalentVo
            local vo = CardProgressionSkillUtils.GetSkillVoBySkillGroupType(skillCardId, Final)
            generator:InitSkillLevel2Star(Final)
            xTry(function()
                local desc, skillOtherDescInfo, starUnlockDescInfo = generator:GetDesc(vo, 12, Final, cardVo.roleId)
                print(vo.id, vo.skillName, desc)
                for i, d in ipairs(starUnlockDescInfo) do
                    print(vo.id, vo.skillName, d.desc)
                end
            end, function()
                print(vo.id, vo.skillName, "error desc")
            end)
        end
    end)
    CardProgressionSkillUtils.SkillExtraMode = false
end

function ExtracSkillDesc:ShowPassive()
    CardProgressionSkillUtils.SkillExtraMode = true
    xTry(function()
        local Buff = CardProgressionConstants.SkillGroupType.Buff

        --- @type CardProgressionSkillDesc
        local generator = CardProgressionSkillDesc.New()

        for voIndex, cardVo in ipairs(CfUtils.GetWholeVo(AutoIds.IdSetting28, 'CardVo')) do
            local vo = CardProgressionSkillUtils.GetTalentVo(cardVo.roleId, 4)
            xTry(function()
                print(cardVo.name, vo.name)
            end, function()
                print(cardVo.name, "error name")
            end)
            generator._cardVo = cardVo
            generator:InitSkillLevel2Star(Buff)
            xTry(function()
                local desc, _, starUnlockDescInfo = generator:GetDesc(nil, 4, Buff, cardVo.roleId)
                print(desc)
                for i, info in ipairs(starUnlockDescInfo) do
                    print(info.desc)
                end
            end, function()
                print("error desc")
            end)
        end
    end)
    CardProgressionSkillUtils.SkillExtraMode = false
end

function ExtracSkillDesc:WriteAll()
    CardProgressionSkillUtils.SkillExtraMode = true

    xTry(function()
        -- local AppEngine = CS.Engine.Lib.AppEngine
        -- local languages =  AppEngine.GetConfig("Engine.I18N", "Languages")
        -- languages = string.split(languages, ',')
        local languages = CfUtils.GetConfigLang()
        for i, language in ipairs(languages) do
            -- if language == "ja_JP" then
            --     goto continue
            -- end
            CS.Engine.Lib.I18NManager.Instance.CurrentLanguage = language
            CS.Engine.Modules.LuaModule.Instance:ClearAllCache()
            CS.Engine.Modules.SettingModule.AllSettingsReload()
            SettingMgr:GetInstance():ReloadSettings()
            self:Write(language)
            self:WritePassive(language)
    
            ::continue::
        end
    end)
    
    CardProgressionSkillUtils.SkillExtraMode = false
end

function ExtracSkillDesc:Write()
    local language = CS.Engine.Lib.I18NManager.Instance.CurrentLanguage

    local filePath = ""
    local isEditor = CS.UnityEngine.Application.isEditor
    local dataPath = CS.UnityEngine.Application.dataPath
    local persistentDataPath = CS.UnityEngine.Application.persistentDataPath
    local fileName = string.format("skillDesc_%s.csv", language)
    if isEditor then
        local ts = string.reverse(dataPath)
        local _, i = string.find(ts, "/")
        local m = string.len(ts) - i + 1
        local dirPath = string.sub(dataPath, 1, m)
        filePath = dirPath.."Product/"..fileName
    else
        filePath = persistentDataPath.."/"..fileName
    end

    -- 打开文件，如果文件不存在则创建，如果存在则覆盖
    local file = io.open(filePath, "w")

    -- 写入CSV文件的标题行
    file:write("id\tskillName\tskillDesc1\tskillDesc2\tskillDesc3\tskillDesc4\n")
    file:write("编号\t技能卡的名称\t1星描述\t2星描述\t3星描述\t4星描述\n")

    local Normal = CardProgressionConstants.SkillGroupType.Normal
    local Final = CardProgressionConstants.SkillGroupType.Final

    --- @type CardProgressionSkillDesc
    local generator = CardProgressionSkillDesc.New()
    for voIndex, cardVo in ipairs(CfUtils.GetWholeVo(AutoIds.IdSetting28, 'CardVo')) do
        generator._cardVo = cardVo

        local skillCardId = cardVo.skillNode.generalSkill
        ---@type SkillCardVo | TalentVo
        local vo = CardProgressionSkillUtils.GetSkillVoBySkillGroupType(skillCardId, Normal)
        generator:InitSkillLevel2Star(Normal)

        local row = vo.id .. "\t" .. vo.skillName
        for i = 1, 3, 1 do
            xTry(function()
                local desc = generator:GetDesc(vo, i, Normal, cardVo.roleId)
                row = row .. "\t" .. desc
            end, function() 
                row = row .. "\t" .. "错误的描述"
            end)
        end
        row = row .. "\n"
        file:write(row)

        local skillCardId = cardVo.skillNode.advancedSkill
        ---@type SkillCardVo | TalentVo
        local vo = CardProgressionSkillUtils.GetSkillVoBySkillGroupType(skillCardId, Normal)
        generator:InitSkillLevel2Star(Normal)

        local row = vo.id .. "\t" .. vo.skillName
        for i = 1, 3, 1 do
            xTry(function()
                local desc = generator:GetDesc(vo, i, Normal, cardVo.roleId)
                row = row .. "\t" .. desc
            end, function()
                row = row .. "\t" .. "错误的描述"
            end)
        end
        row = row .. "\n"
        file:write(row)

        local skillCardId = cardVo.skillNode.finalSkill
        ---@type SkillCardVo | TalentVo
        local vo = CardProgressionSkillUtils.GetSkillVoBySkillGroupType(skillCardId, Final)
        generator:InitSkillLevel2Star(Final)

        local row = vo.id .. "\t" .. vo.skillName
        xTry(function()
            local desc, skillOtherDescInfo, starUnlockDescInfo = generator:GetDesc(vo, 12, Final, cardVo.roleId)
            row = row .. "\t" .. desc
            for i, d in ipairs(starUnlockDescInfo) do
                row = row .. "\t" .. d.desc
            end
        end, function()
            row = row .. "\t" .. "错误的描述"
        end)
        row = row .. "\n"
        file:write(row)
    end
    
    -- 关闭文件
    file:close()
end

function ExtracSkillDesc:WritePassive()
    local language = CS.Engine.Lib.I18NManager.Instance.CurrentLanguage

    local filePath = ""
    local isEditor = CS.UnityEngine.Application.isEditor
    local dataPath = CS.UnityEngine.Application.dataPath
    local persistentDataPath = CS.UnityEngine.Application.persistentDataPath
    local fileName = string.format("passiveSkillDesc_%s.csv", language)
    if isEditor then
        local ts = string.reverse(dataPath)
        local _, i = string.find(ts, "/")
        local m = string.len(ts) - i + 1
        local dirPath = string.sub(dataPath, 1, m)
        filePath = dirPath.."Product/"..fileName
    else
        filePath = persistentDataPath.."/"..fileName
    end

    -- 打开文件，如果文件不存在则创建，如果存在则覆盖
    local file = io.open(filePath, "w")

    -- 写入CSV文件的标题行
    file:write("id\tname\tdesc\tstar2\tstar4\tstar6\n")
    file:write("编号\t天赋名称\t天赋描述\t2星描述\t4星描述\t6星描述\n")

    local Buff = CardProgressionConstants.SkillGroupType.Buff

    --- @type CardProgressionSkillDesc
    local generator = CardProgressionSkillDesc.New()

    for voIndex, cardVo in ipairs(CfUtils.GetWholeVo(AutoIds.IdSetting28, 'CardVo')) do
        local vo = CardProgressionSkillUtils.GetTalentVo(cardVo.roleId, 4)

        generator._cardVo = cardVo
        generator:InitSkillLevel2Star(Buff)

        local row = tostring(cardVo.roleId)

        xTry(function()
            row = row .. "\t" .. vo.name
        end, function()
            row = row .. "\t" .. "error name"
        end)

        xTry(function()
            local desc, _, starUnlockDescInfo = generator:GetDesc(nil, 4, Buff, cardVo.roleId)
            row = row .. "\t" .. desc
            for i, info in ipairs(starUnlockDescInfo) do
                row = row .. "\t" .. info.desc
            end
        end, function()
            row = row .. "\t" .. "错误的描述"
        end)
        row = row .. "\n"
        file:write(row)
    end

    -- 关闭文件
    file:close()
end

return ExtracSkillDesc