local var_0_0 = {
	get_all_version = 2,
	send_test = 0,
	keep_alive = 999,
	get_battle_report = 6,
	export_csv = 5,
	get_battle_result = 4,
	get_battle_team = 1,
	get_all_battle = 3,
	progressEnum = {
		winCount = "越战胜场",
		fightValue = "战力比值",
		round = "平均回合数"
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
	fightValueGap = "越战百分比",
	victimName = "受击者名",
	attackName = "攻击者名",
	winCount = "越战胜场",
	winRate = "越战战胜率",
	averageRound = "平均轮次",
	maxRound = "最大轮次",
	attackFightValue = "攻击者战力",
	attack = "攻击方",
	victim = "受击方",
	victimFightValue = "受击者战力"
}
var_0_0.CsvBaseHead = {
	attack = true,
	victim = true
}

return var_0_0
