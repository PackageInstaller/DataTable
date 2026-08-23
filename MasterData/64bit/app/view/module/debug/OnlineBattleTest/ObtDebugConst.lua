local var_0_0 = {
	get_battle_result = 4,
	get_all_battle = 3,
	get_all_version = 2,
	get_battle_team = 1,
	send_test = 0,
	keep_alive = 999,
	get_battle_report = 6,
	export_csv = 5,
	progressEnum = {
		round = "平均回合数",
		winCount = "越战胜场",
		fightValue = "战力比值"
	}
}

var_0_0.DEFAULT_IP = "172.20.120.63"
var_0_0.DEFAULT_PORT = "9969"
var_0_0.progressList = {
	var_0_0.progressEnum.fightValue,
	var_0_0.progressEnum.winCount,
	var_0_0.progressEnum.round
}
var_0_0.CsvHead = {
	victimName = "受击者名",
	winRate = "越战战胜率",
	averageRound = "平均轮次",
	fightValueGap = "越战百分比",
	maxRound = "最大轮次",
	victimFightValue = "受击者战力",
	attackFightValue = "攻击者战力",
	winCount = "越战胜场",
	victim = "受击方",
	attackName = "攻击者名",
	attack = "攻击方"
}
var_0_0.CsvBaseHead = {
	victim = true,
	attack = true
}

return var_0_0
