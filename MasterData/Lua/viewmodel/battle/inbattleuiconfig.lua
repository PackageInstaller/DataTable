
InBattleUIConfig = {}

InBattleUIConfig.UIType = {
    InBattle = 1,
    EndBattle = 2
}
InBattleUIConfig.Config = {

    ["team_relay"] = {
        [InBattleUIConfig.UIType.InBattle] = "SCNJBattleInUI",
        [InBattleUIConfig.UIType.EndBattle] = "SCNJBattleEndUI"
    }
}