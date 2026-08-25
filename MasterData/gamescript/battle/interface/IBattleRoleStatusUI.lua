local IBattleRoleStatusUI = System.NewInterface("IBattleRoleStatusUI")

function IBattleRoleStatusUI:UpdateRootHpAndRootIntentionPosition()
end

function IBattleRoleStatusUI:SetActiveWithIntention(isActive)
end

function IBattleRoleStatusUI:SetActive(isActive)
end

function IBattleRoleStatusUI:CreateFloadTextUI()
end

function IBattleRoleStatusUI:SetBloodActive(isActive)
end

function IBattleRoleStatusUI:SetIntentionActive(isActive)
end

return IBattleRoleStatusUI
