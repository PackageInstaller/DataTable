ConfigBackPackMgr = {}

local canGetReward = {}

ConfigBackPackMgr.RareType = {
	R = 2,
	SR = 3,
	SSR = 4,
	UR = 5,
}

local AddReward = function(reward)
	for i = 1, #canGetReward do
		if canGetReward[i]["ID"] == reward["ID"] then
			canGetReward[i]["Count"] = canGetReward[i]["Count"] + reward["Count"]
			return
		end
	end
	table.insert(canGetReward,reward)
end

function ConfigBackPackMgr.ConfirmSplitEquipEX(needSplitEquip, sendSplitCB, cancelSplitCB, characterId)
	local newNeedSplitEquip = {}
	for i = 0, needSplitEquip.Count - 1 do
		table.insert(newNeedSplitEquip, needSplitEquip[i])
	end
	ConfigBackPackMgr.ConfirmSplitEquip(newNeedSplitEquip, sendSplitCB, cancelSplitCB, characterId)
end
function ConfigBackPackMgr.ConfirmSplitEquip(needSplitEquip, sendSplitCB, cancelSplitCB, characterId)
	if #needSplitEquip == 0 then
		local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2034"].NameLan)
		LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
		return
	end
	local equipData
	local equipConfig
	local rExp = 0
	local srExp = 0
	local ssrExp = 0
	local urExp = 0
	canGetReward = {}
	for i = 1, #needSplitEquip do
		equipData = DataMgr.Player.equipments[needSplitEquip[i]]
		equipConfig = ConfigMgr.Config.equipments[equipData.equipmentId]
		ConfigBackPackMgr.ReturnGradeMaterial(equipData.grade,equipConfig.rare)
		ConfigBackPackMgr.ReturnStarMaterial(equipData.star,equipConfig.rare)

		if equipConfig.rare == ConfigBackPackMgr.RareType.R then
			rExp = rExp + equipData.exp
		elseif equipConfig.rare == ConfigBackPackMgr.RareType.SR then
			srExp = srExp + equipData.exp
		elseif equipConfig.rare == ConfigBackPackMgr.RareType.SSR then
			ssrExp = ssrExp + equipData.exp
		elseif equipConfig.rare == ConfigBackPackMgr.RareType.UR then
			urExp = urExp + equipData.exp
		end
	end
	rExp = math.floor(rExp * (ConfigMgr.Config.constants.levelUpExpToItemR / 100))
	srExp = math.floor(srExp * (ConfigMgr.Config.constants.levelUpExpToItemSR / 100))
	ssrExp = math.floor(ssrExp * (ConfigMgr.Config.constants.levelUpExpToItemSSR / 100))
	urExp = math.floor(urExp * (ConfigMgr.Config.constants.levelUpExpToItemUR / 100))
	ConfigBackPackMgr.ReturnLevelExp(rExp + srExp + ssrExp + urExp)
	local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2045"].NameLan)
	local itemList = json.encode(canGetReward)
	LuaMgr.ShowConfirmConsumeViewModel(tipStr,itemList, sendSplitCB, cancelSplitCB, characterId)
end


function ConfigBackPackMgr.ReturnLevelExp(totalExp)
	if totalExp == 0 then return end
	ConfigHelper.ExpGoodsDes()
	local count = 0
	local goods = {}
	for i = 1, #ConfigHelper.ExpDes do
		goods = {}
		if totalExp >= ConfigHelper.ExpDes[i].value then
			count = math.floor(totalExp / ConfigHelper.ExpDes[i].value)
			goods["ID"] = tostring(ConfigHelper.ExpDes[i].ID)
			goods["Count"] = count
			totalExp = totalExp - count * ConfigHelper.ExpDes[i].value
			AddReward(goods)
		end
	end
end


function ConfigBackPackMgr.ReturnGradeMaterial(gradeLevel,rare)
	local goods = {}
	local equipGradeUp = {}
	if rare == ConfigBackPackMgr.RareType.R then
		equipGradeUp = ConfigMgr.Config.constants.REquipGradeUp
	elseif rare == ConfigBackPackMgr.RareType.SR then
		equipGradeUp = ConfigMgr.Config.constants.SREquipGradeUp
	elseif rare == ConfigBackPackMgr.RareType.SSR then
		equipGradeUp = ConfigMgr.Config.constants.SSREquipGradeUp
	elseif rare == ConfigBackPackMgr.RareType.UR then
		equipGradeUp = ConfigMgr.Config.constants.UREquipGradeUp
	end
	for i = 1, #equipGradeUp do
		if equipGradeUp[i][1] == gradeLevel then
			goods["ID"] = tostring(equipGradeUp[i][2])
			goods["Count"] = equipGradeUp[i][3]
			AddReward(goods)
			break
		end
	end
end

function ConfigBackPackMgr.ReturnStarMaterial(starLevel,rare)
	local goods = {}
	local equipStarUp = {}
	if rare == ConfigBackPackMgr.RareType.R then
		equipStarUp = ConfigMgr.Config.constants.REquipStarUp
	elseif rare  == ConfigBackPackMgr.RareType.SR then
		equipStarUp = ConfigMgr.Config.constants.SREquipStarUp
	elseif rare  == ConfigBackPackMgr.RareType.SSR then
		equipStarUp = ConfigMgr.Config.constants.SSREquipStarUp
	elseif rare == ConfigBackPackMgr.RareType.UR then
		equipStarUp = ConfigMgr.Config.constants.UREquipStarUp
	end
	for i = 1, #equipStarUp do
		if equipStarUp[i][1] == starLevel then
			goods["ID"] = tostring(equipStarUp[i][2])
			goods["Count"] = equipStarUp[i][3]
			AddReward(goods)
			break
		end
	end
end