module("arenaEntrance.ArenaHellRobotDataRo", Class.impl())

function parseData(self, refID, refData)
    self.m_refID = refID

    self.m_points = refData.points
    -- self.m_power = refData.power
    self.m_formationId = refData.formation_id
    self.m_headIcon = refData.head_icon
    self.m_battleArray1 = refData.battle_array1
    self.m_battleArray2 = refData.battle_array2
    self.m_battleArray3 = refData.battle_array3

    self.m_sceneId = refData.scene_id
    self.m_musicId = refData.music_id
    self.m_name = refData.name
    -- self.m_level = refData.level
end

function getRefID(self)
    return self.m_refID
end

function getPoints(self)
    return self.m_points
end

-- function getPower(self)
-- 	return self.m_power
-- end

function getFormationId(self)
    return self.m_formationId
end

function getHeadIcon(self)
    return self.m_headIcon
end

function getBattleArray(self, id)
    if id == 1 then
        return self.m_battleArray1
    elseif id == 2 then
        return self.m_battleArray2
    else
        return self.m_battleArray3
    end
end

function getSceneId(self)
    return self.m_sceneId
end

function getMusicId(self)
    return self.m_musicId
end

function getName(self)
    return self.m_name
end

function getLevel(self)
    return self.m_level
end

return _M
