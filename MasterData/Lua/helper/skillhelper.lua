SkillHelper = {}

function SkillHelper.SetData(skillItem, type, targetId, isClick, showType, scale, typeBool)
    skillItem.type = type;
    skillItem.targetId = targetId;
    skillItem.isClick = isClick;
    skillItem.showType = showType;
    skillItem.typeBool = typeBool;
    if scale == nil then
        scale = 0.64
    end
    skillItem.scale = Vector3(scale, scale, 1);
end

function SkillHelper.SetSkill(skillItem, id, level, type, color, isLevel, isLock, isName)
    skillItem.id = id
    skillItem.icon = LuaMgr.GetTexture(LuaMgr.GetSkillIcon(string.gsub(id, "ex", "")))
    skillItem.iconColor = color
    skillItem.level = tostring(level)
    skillItem.isLevel = isLevel
    skillItem.isLock = isLock
    skillItem.isName = isName
    skillItem.order = 100
    if string.match(id, "%a%a", -2) == "ex" then
        skillItem.isEx = true
    else
        skillItem.isEx = false
    end

    if type == 1 then
        local skill = ConfigSkillMgr.GetCharacterSkill(id .. level)
        if skill ~= nil then
            skillItem.typeSp = LuaMgr.GetSprite("HeroRes", "skillType_" .. skill.Type)
            if skillItem.isName then
                skillItem.sname = LuaMgr.GetLangText(skill.NameLan)
                skillItem.isName = true
            end

            if skill.Type == 1 then
                skillItem.order = 1
            elseif skill.Type == 2 then
                skillItem.order = 3
            elseif skill.Type == 11 then
                skillItem.order = 2
            end
        end
    elseif type == 2 then
        local skill = ConfigSkillMgr.GetCharacterPassiveSkill(id .. level)
        if skill ~= nil then
            skillItem.typeSp = LuaMgr.GetSprite("HeroRes", "skillType_" .. skill.Type)
            if skillItem.isName then
                skillItem.sname = LuaMgr.GetLangText(skill.NameLan)
                skillItem.isName = true
            end
        end
    elseif type == 3 then
        local skill = ConfigSkillMgr.GetEquipmentSkill(id, tostring(level))
        if skill ~= nil then
            skillItem.typeSp = LuaMgr.GetSprite("HeroRes", "skillType_" .. skill.Type)
        end
    end
    skillItem.isType = true
end 