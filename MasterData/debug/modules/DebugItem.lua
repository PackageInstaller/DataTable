-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\Modules\\DebugItem.lua

local DebugConst = require("Debug/DebugConst")
local ResHero = require("ClientData/ResHero")
local ResItemHeroSkin = require("ClientData/ResItemHeroSkin")
local ResHandBookArtifact = require("ClientData/ResHandBookArtifact")
local ResEquip = require("ClientData/ResEquip")
local ResRelic = require("ClientData/ResRelic")
local ResTimeValidConfig = require("ClientData/ResTimeValidConfig")
local ResItem = require("ClientData/ResItem")
local DebugModule = {}

DebugModule.ENTRY_NAME = "道具"

function DebugModule.getItem(sender, menu, value)
	if value == "" then
		MsgManager.notice("请输入道具resid 空格 数量")
	else
		RPC.executeGM("//item " .. value)
	end
end

function DebugModule.timeVaild(sender, menu, strDateArgs)
	local strDate = strDateArgs
	local timeVaild_id

	if not string.find(strDateArgs, ",") then
		MsgManager.notice("输入控制id和开启时间")

		return
	else
		local args = utils.splitString(strDateArgs, ",")

		timeVaild_id = tonumber(args[1])
		strDate = args[2]
	end

	if ResTimeValidConfig[timeVaild_id] then
		ResTimeValidConfig[timeVaild_id].valid_tick = strDate

		RPC.executeGM("//time_config set " .. timeVaild_id .. " " .. strDate)
	else
		MsgManager.notice("id不正确")
	end
end

function DebugModule.getItems(sender, menu, value)
	RPC.executeGM("//item 530001 500")
	RPC.executeGM("//item 530002 500")
	RPC.executeGM("//item 530003 500")
	RPC.executeGM("//item 530004 500")
	RPC.executeGM("//item 530005 500")
	RPC.executeGM("//item 530006 500")
	RPC.executeGM("//item 530007 500")
	RPC.executeGM("//item 530008 500")
	RPC.executeGM("//item 530009 500")
	RPC.executeGM("//item 530010 500")
	RPC.executeGM("//item 530011 500")
	RPC.executeGM("//item 530012 500")
	RPC.executeGM("//item 530013 500")
	RPC.executeGM("//item 530014 500")
	RPC.executeGM("//item 530015 500")
	RPC.executeGM("//item 530016 500")
	RPC.executeGM("//item 530017 500")
	RPC.executeGM("//item 530018 500")
	RPC.executeGM("//item 530019 500")
	RPC.executeGM("//item 530020 500")
	RPC.executeGM("//item 530021 500")
	RPC.executeGM("//item 530022 500")
	RPC.executeGM("//item 530023 500")
	RPC.executeGM("//item 530024 500")
	RPC.executeGM("//item 530025 500")
	RPC.executeGM("//item 530026 500")
	RPC.executeGM("//item 530027 500")
	RPC.executeGM("//item 530028 500")
	RPC.executeGM("//item 530029 500")
	RPC.executeGM("//item 530030 500")
	RPC.executeGM("//item 530031 500")
	RPC.executeGM("//item 530032 500")
	RPC.executeGM("//item 530033 500")
	RPC.executeGM("//item 530034 500")
	RPC.executeGM("//item 530035 500")
	RPC.executeGM("//item 530036 500")
	RPC.executeGM("//item 530037 500")
	RPC.executeGM("//item 530038 500")
	RPC.executeGM("//item 530039 500")
	RPC.executeGM("//item 530040 500")
	RPC.executeGM("//item 530041 500")
	RPC.executeGM("//item 530042 500")
	RPC.executeGM("//item 530043 500")
	RPC.executeGM("//item 530044 500")
	RPC.executeGM("//item 530045 500")
	RPC.executeGM("//item 530046 500")
	RPC.executeGM("//item 530047 500")
	RPC.executeGM("//item 530048 500")
	RPC.executeGM("//item 530049 500")
	RPC.executeGM("//item 530050 500")
	RPC.executeGM("//item 100017 500")
	RPC.executeGM("//item 500000 900000000")
	RPC.executeGM("//item 500001 900000000")
end

function DebugModule.getequip(sender, menu, value)
	local equipnumber = {
		"361001",
		"361002",
		"361003",
		"361004",
		"361005",
		"361006",
		"361011",
		"361012",
		"361013",
		"361014",
		"361015",
		"361016",
		"361021",
		"361022",
		"361023",
		"361024",
		"361025",
		"361026"
	}

	for i = 1, 5 do
		for i, v in pairs(equipnumber) do
			RPC.executeGM("//item " .. v .. " 1")
		end
	end

	RPC.executeGM("//item 520061 99999999")
	RPC.executeGM("//item 520062 99999999")
	RPC.executeGM("//item 520063 99999999")
	RPC.executeGM("//item 520064 99999999")
	RPC.executeGM("//item 520065 99999999")
	RPC.executeGM("//item 520066 99999999")
	RPC.executeGM("//item 520033 99999999")
	RPC.executeGM("//item 500001 99999999")
	RPC.executeGM("//attr 1 10000000")
	RPC.executeGM("//attr 2 1000000")
	RPC.executeGM("//item 510170 100000")

	for k in pairs(ResItem) do
		if ResItem[k].subtype == 112 and k ~= 510169 then
			RPC.executeGM("//item " .. k .. " 200")
		end
	end
end

function DebugModule.getItems1(sender, menu, value)
	RPC.executeGM("//item 100001 9000000000")
	RPC.executeGM("//item 100002 900000")
end

function DebugModule.getItems2(sender, menu, value)
	for k, v in pairs(ResHandBookArtifact) do
		if k > 405000 then
			RPC.executeGM("//item " .. k .. " 1")
		end
	end

	for k1, v in pairs(ResEquip) do
		if ResEquip[k1].强化模板ID == 6 then
			RPC.executeGM("//item " .. k1 .. " 1")
		end
	end

	RPC.executeGM("//item 520051 1000")
	RPC.executeGM("//item 520045 10000")
end

function DebugModule.getItems15(sender, menu, value)
	for i = 510041, 510150 do
		RPC.executeGM("//item " .. i .. " 1000")
	end

	for i = 500030, 500050 do
		RPC.executeGM("//item " .. i .. " 1000")
	end
end

function DebugModule.getItems16(sender, menu, value)
	for i = 1020001, 1020012 do
		RPC.executeGM("//item " .. i .. " 3")
	end

	for i = 1010001, 1010004 do
		RPC.executeGM("//item " .. i .. " 3")
	end

	for i = 1100000, 1100011 do
		RPC.executeGM("//item " .. i .. " 3")
	end
end

function DebugModule.getItems3(sender, menu, value)
	for k, v in pairs(ResHero) do
		RPC.executeGM("//hero " .. k)
	end

	for k, v in pairs(ResItemHeroSkin) do
		for k1, v1 in pairs(ResItemHeroSkin[k]) do
			RPC.executeGM("//item " .. ResItemHeroSkin[k][k1].itemId .. " 1")
		end
	end
end

function DebugModule.getItems4(sender, menu, value)
	RPC.executeGM("//hero 211001")
	RPC.executeGM("//hero 211003")
	RPC.executeGM("//hero 211004")
	RPC.executeGM("//hero 211005")
	RPC.executeGM("//hero 211008")
	RPC.executeGM("//hero 211101")
	RPC.executeGM("//hero 212001")
	RPC.executeGM("//hero 212002")
	RPC.executeGM("//hero 212003")
	RPC.executeGM("//hero 212004")
	RPC.executeGM("//hero 212005")
	RPC.executeGM("//hero 212006")
	RPC.executeGM("//hero 212008")
	RPC.executeGM("//hero 212009")
	RPC.executeGM("//hero 212010")
	RPC.executeGM("//hero 212101")
	RPC.executeGM("//hero 213001")
	RPC.executeGM("//hero 213002")
	RPC.executeGM("//hero 213003")
	RPC.executeGM("//hero 213004")
	RPC.executeGM("//hero 213008")
	RPC.executeGM("//hero 213009")
	RPC.executeGM("//hero 213010")
	RPC.executeGM("//hero 213011")
	RPC.executeGM("//hero 213101")
	RPC.executeGM("//hero 214001")
	RPC.executeGM("//hero 214003")
	RPC.executeGM("//hero 214004")
	RPC.executeGM("//hero 214005")
	RPC.executeGM("//hero 214006")
	RPC.executeGM("//hero 214007")
	RPC.executeGM("//hero 214008")
	RPC.executeGM("//hero 214101")
	RPC.executeGM("//hero 215001")
	RPC.executeGM("//hero 215002")
	RPC.executeGM("//hero 215003")
	RPC.executeGM("//hero 215004")
	RPC.executeGM("//hero 215005")
	RPC.executeGM("//hero 215006")
	RPC.executeGM("//hero 215007")
	RPC.executeGM("//hero 215008")
	RPC.executeGM("//hero 215009")
	RPC.executeGM("//hero 215101")
	RPC.executeGM("//hero 211006")
	RPC.executeGM("//hero 212007")
	RPC.executeGM("//hero 213006")
	RPC.executeGM("//hero 211007")
	RPC.executeGM("//hero 213007")
	RPC.executeGM("//hero 214002")
	RPC.executeGM("//hero 213201")
	RPC.executeGM("//hero 212201")
	RPC.executeGM("//hero 214010")
	RPC.executeGM("//hero 213201")
	RPC.executeGM("//hero 213201")
	RPC.executeGM("//hero 214201")
	RPC.executeGM("//hero 211201")
	RPC.executeGM("//hero 213005")
	RPC.executeGM("//hero 212202")
	RPC.executeGM("//hero 211202")
	RPC.executeGM("//hero 211002")
	RPC.executeGM("//hero 215201")
	RPC.executeGM("//hero 213202")
	RPC.executeGM("//hero 214012")
	RPC.executeGM("//hero 213102")
	RPC.executeGM("//hero 212203")
	RPC.executeGM("//hero 214011")
	RPC.executeGM("//hero 211010")
	RPC.executeGM("//hero 213203")
	RPC.executeGM("//item 375007 1")
	RPC.executeGM("//item 375008 1")
	RPC.executeGM("//item 375009 1")
	RPC.executeGM("//item 375010 1")
	RPC.executeGM("//item 375011 1")
	RPC.executeGM("//item 375012 1")
	RPC.executeGM("//heroall 220 10 15")
	RPC.executeGM("//item 520033 50000")
	RPC.executeGM("//item 520045 50000")
	RPC.executeGM("//item 375007 1")
	RPC.executeGM("//item 375008 1")
	RPC.executeGM("//item 375009 1")
	RPC.executeGM("//item 375010 1")
	RPC.executeGM("//item 375011 1")
	RPC.executeGM("//item 375012 1")
	RPC.executeGM("//item 100001 500000000")
	RPC.executeGM("//item 500001 500000000")
	RPC.executeGM("//item 500000 500000000")
	RPC.executeGM("//item 375007 1")
	RPC.executeGM("//item 375008 1")
	RPC.executeGM("//item 375009 1")
	RPC.executeGM("//item 375010 1")
	RPC.executeGM("//item 375011 1")
	RPC.executeGM("//item 375012 1")
	RPC.executeGM("//item 700001 1")
	RPC.executeGM("//item 700002 1")
	RPC.executeGM("//item 700003 1")
	RPC.executeGM("//item 700004 1")
	RPC.executeGM("//item 700005 1")
	RPC.executeGM("//item 375007 1")
	RPC.executeGM("//item 375008 1")
	RPC.executeGM("//item 375009 1")
	RPC.executeGM("//item 375010 1")
	RPC.executeGM("//item 375011 1")
	RPC.executeGM("//item 375012 1")
	RPC.executeGM("//item 436001 4")
	RPC.executeGM("//item 445001 4")
	RPC.executeGM("//item 456001 4")
	RPC.executeGM("//item 406001 4")
	RPC.executeGM("//item 406002 4")
end

function DebugModule.getItems5(sender, menu, value)
	RPC.executeGM("//item 100001 900000000")
	RPC.executeGM("//item 100002 900000")
	RPC.executeGM("//item 100003 500")
	RPC.executeGM("//item 500000 9000000")
	RPC.executeGM("//item 100011 9000")
	RPC.executeGM("//item 100012 9000")
	RPC.executeGM("//item 100013 9000")
	RPC.executeGM("//item 500001 500000")
	RPC.executeGM("//item 510001 5000")
	RPC.executeGM("//item 510002 10000")
	RPC.executeGM("//item 510003 60")
	RPC.executeGM("//item 510004 10000")
	RPC.executeGM("//item 510005 100000")
	RPC.executeGM("//item 510006 5000")
	RPC.executeGM("//item 510007 1000")
	RPC.executeGM("//item 530001 1000")
	RPC.executeGM("//item 530013 100")
	RPC.executeGM("//item 530014 100")
	RPC.executeGM("//item 530011 100")
	RPC.executeGM("//item 530015 100")
	RPC.executeGM("//item 530016 100")
	RPC.executeGM("//item 530017 100")
	RPC.executeGM("//item 530019 100")
	RPC.executeGM("//item 530021 100")
	RPC.executeGM("//item 530025 100")
	RPC.executeGM("//item 530029 100")
	RPC.executeGM("//stage 1 23 2")
	RPC.executeGM("//hero 211001")
	RPC.executeGM("//hero 211003")
	RPC.executeGM("//hero 211004")
	RPC.executeGM("//hero 211005")
	RPC.executeGM("//hero 211008")
	RPC.executeGM("//hero 211101")
	RPC.executeGM("//hero 212001")
	RPC.executeGM("//hero 212002")
	RPC.executeGM("//hero 212003")
	RPC.executeGM("//hero 212004")
	RPC.executeGM("//hero 212005")
	RPC.executeGM("//hero 212006")
	RPC.executeGM("//hero 212008")
	RPC.executeGM("//hero 212009")
	RPC.executeGM("//hero 212010")
	RPC.executeGM("//hero 212101")
	RPC.executeGM("//hero 213001")
	RPC.executeGM("//hero 213002")
	RPC.executeGM("//hero 213003")
	RPC.executeGM("//hero 213004")
	RPC.executeGM("//hero 213008")
	RPC.executeGM("//hero 213009")
	RPC.executeGM("//hero 213010")
	RPC.executeGM("//hero 213011")
	RPC.executeGM("//hero 213101")
	RPC.executeGM("//hero 214001")
	RPC.executeGM("//hero 214003")
	RPC.executeGM("//hero 214004")
	RPC.executeGM("//hero 214005")
	RPC.executeGM("//hero 214006")
	RPC.executeGM("//hero 214007")
	RPC.executeGM("//hero 214008")
	RPC.executeGM("//hero 214101")
	RPC.executeGM("//hero 215001")
	RPC.executeGM("//hero 215002")
	RPC.executeGM("//hero 215003")
	RPC.executeGM("//hero 215004")
	RPC.executeGM("//hero 215005")
	RPC.executeGM("//hero 215006")
	RPC.executeGM("//hero 215007")
	RPC.executeGM("//hero 215008")
	RPC.executeGM("//hero 215009")
	RPC.executeGM("//hero 215101")
	RPC.executeGM("//hero 211006")
	RPC.executeGM("//hero 212007")
	RPC.executeGM("//hero 213006")
	RPC.executeGM("//hero 211007")
	RPC.executeGM("//hero 213007")
	RPC.executeGM("//hero 214002")
	RPC.executeGM("//hero 213201")
	RPC.executeGM("//hero 212201")
	RPC.executeGM("//hero 214010")
	RPC.executeGM("//hero 214201")
	RPC.executeGM("//hero 211201")
	RPC.executeGM("//hero 213005")
	RPC.executeGM("//hero 212202")
	RPC.executeGM("//hero 211202")
	RPC.executeGM("//hero 211002")
	RPC.executeGM("//hero 215201")
	RPC.executeGM("//hero 213202")
	RPC.executeGM("//hero 214012")
	RPC.executeGM("//hero 213102")
	RPC.executeGM("//hero 212203")
	RPC.executeGM("//hero 214011")
	RPC.executeGM("//hero 212012")
	RPC.executeGM("//hero 211010")
	RPC.executeGM("//hero 213203")
	RPC.executeGM("//item 330001 1")
	RPC.executeGM("//item 330002 1")
	RPC.executeGM("//item 330003 1")
	RPC.executeGM("//item 330004 1")
	RPC.executeGM("//item 330005 1")
	RPC.executeGM("//item 330006 1")
	RPC.executeGM("//item 330031 1")
	RPC.executeGM("//item 330032 1")
	RPC.executeGM("//item 330033 1")
	RPC.executeGM("//item 330034 1")
	RPC.executeGM("//item 330035 1")
	RPC.executeGM("//item 330036 1")
	RPC.executeGM("//item 404001 1")
	RPC.executeGM("//item 404002 1")
	RPC.executeGM("//item 404003 1")
	RPC.executeGM("//item 404004 1")
	RPC.executeGM("//item 405001 1")
	RPC.executeGM("//item 405002 1")
	RPC.executeGM("//item 405003 1")
	RPC.executeGM("//item 405004 1")
	RPC.executeGM("//mail 10005 210")
	RPC.executeGM("//mail 10005 215")
	RPC.executeGM("//mail 10005 21000")
	RPC.executeGM("//mail 10005 50011")
	RPC.executeGM("//mail 10005 217")
	RPC.executeGM("//mail 10005 50027")
	RPC.executeGM("//heroall 200 9 14")
	RPC.executeGM("//item 530049 1000000")
	RPC.executeGM("//item 530050 1000000")
	RPC.executeGM("//item 531001 1000")
	RPC.executeGM("//item 531001 1000")
	RPC.executeGM("//item 531002 1000")
	RPC.executeGM("//item 531003 1000")
	RPC.executeGM("//item 531005 1000")
	RPC.executeGM("//item 531006 1000")
	RPC.executeGM("//item 531201 1000")
	RPC.executeGM("//item 532001 1000")
	RPC.executeGM("//item 532002 1000")
	RPC.executeGM("//item 532003 1000")
	RPC.executeGM("//item 532004 1000")
	RPC.executeGM("//item 532005 1000")
	RPC.executeGM("//item 532007 1000")
	RPC.executeGM("//item 532012 1000")
	RPC.executeGM("//item 532201 1000")
	RPC.executeGM("//item 532203 1000")
	RPC.executeGM("//item 533001 1000")
	RPC.executeGM("//item 533002 1000")
	RPC.executeGM("//item 533003 1000")
	RPC.executeGM("//item 533004 1000")
	RPC.executeGM("//item 533005 1000")
	RPC.executeGM("//item 533006 1000")
	RPC.executeGM("//item 533201 1000")
	RPC.executeGM("//item 533202 1000")
	RPC.executeGM("//item 531001 1000")
	RPC.executeGM("//item 534002 1000")
	RPC.executeGM("//item 534003 1000")
	RPC.executeGM("//item 534004 1000")
	RPC.executeGM("//item 534005 1000")
	RPC.executeGM("//item 534006 1000")
	RPC.executeGM("//item 534011 1000")
	RPC.executeGM("//item 534012 1000")
	RPC.executeGM("//item 534201 1000")
	RPC.executeGM("//item 535001 1000")
	RPC.executeGM("//item 535002 1000")
	RPC.executeGM("//item 535003 1000")
	RPC.executeGM("//item 535004 1000")
	RPC.executeGM("//item 535006 1000")
	RPC.executeGM("//item 535008 1000")
	RPC.executeGM("//item 535201 1000")
	RPC.executeGM("//item 800001 1")
	RPC.executeGM("//item 800002 1")
	RPC.executeGM("//item 800003 1")
	RPC.executeGM("//item 800004 1")
	RPC.executeGM("//item 800005 1")
	RPC.executeGM("//item 800006 1")
	RPC.executeGM("//item 800007 1")
	RPC.executeGM("//item 800008 1")
	RPC.executeGM("//item 800009 1")
	RPC.executeGM("//item 800010 1")
	RPC.executeGM("//item 800011 1")
	RPC.executeGM("//item 800012 1")
	RPC.executeGM("//item 800013 1")
	RPC.executeGM("//item 800014 1")
	RPC.executeGM("//item 800015 1")
	RPC.executeGM("//item 800016 1")
	RPC.executeGM("//item 800017 1")
	RPC.executeGM("//item 800018 1")
	RPC.executeGM("//item 800019 1")
	RPC.executeGM("//item 800020 1")
	RPC.executeGM("//item 800021 1")
	RPC.executeGM("//item 800022 1")
	RPC.executeGM("//item 800023 1")
	RPC.executeGM("//item 800024 1")
	RPC.executeGM("//item 800025 1")
	RPC.executeGM("//item 800026 1")
	RPC.executeGM("//item 800027 1")
	RPC.executeGM("//item 800028 1")
end

function DebugModule.getItems6(sender, menu, value)
	for k, v in pairs(ResItemHeroSkin) do
		for k1, v1 in pairs(ResItemHeroSkin[k]) do
			RPC.executeGM("//item " .. ResItemHeroSkin[k][k1].itemId .. " 1")
		end
	end
end

function DebugModule.getItems7(sender, menu, value)
	for k, v in pairs(ResHero) do
		RPC.executeGM("//hero " .. k)
	end

	RPC.executeGM("//heroall 220 10 " .. value)
	RPC.executeGM("//stage 1 31 30")
	RPC.executeGM("//attr 2 10000")
end

function DebugModule.getItems8(sender, menu, value)
	for k2, v in pairs(ResRelic) do
		RPC.executeGM("//item " .. k2 .. " 1")
	end
end

function DebugModule.getItems9(sender, menu, value)
	RPC.executeGM("//hero 211001")
	RPC.executeGM("//hero 211002")
	RPC.executeGM("//hero 211003")
	RPC.executeGM("//hero 211004")
	RPC.executeGM("//hero 211005")
	RPC.executeGM("//hero 211008")
	RPC.executeGM("//hero 211010")
	RPC.executeGM("//hero 211101")
	RPC.executeGM("//hero 211201")
	RPC.executeGM("//hero 212001")
	RPC.executeGM("//hero 212002")
	RPC.executeGM("//hero 212003")
	RPC.executeGM("//hero 212004")
	RPC.executeGM("//hero 212005")
	RPC.executeGM("//hero 212006")
	RPC.executeGM("//hero 212007")
	RPC.executeGM("//hero 212012")
	RPC.executeGM("//hero 212101")
	RPC.executeGM("//hero 212201")
	RPC.executeGM("//hero 212203")
	RPC.executeGM("//hero 213001")
	RPC.executeGM("//hero 213002")
	RPC.executeGM("//hero 213003")
	RPC.executeGM("//hero 213004")
	RPC.executeGM("//hero 213005")
	RPC.executeGM("//hero 213006")
	RPC.executeGM("//hero 213008")
	RPC.executeGM("//hero 213009")
	RPC.executeGM("//hero 213010")
	RPC.executeGM("//hero 213012")
	RPC.executeGM("//hero 213101")
	RPC.executeGM("//hero 213103")
	RPC.executeGM("//hero 213201")
	RPC.executeGM("//hero 213202")
	RPC.executeGM("//hero 213203")
	RPC.executeGM("//hero 214002")
	RPC.executeGM("//hero 214003")
	RPC.executeGM("//hero 214004")
	RPC.executeGM("//hero 214005")
	RPC.executeGM("//hero 214006")
	RPC.executeGM("//hero 214010")
	RPC.executeGM("//hero 214011")
	RPC.executeGM("//hero 214012")
	RPC.executeGM("//hero 214101")
	RPC.executeGM("//hero 214201")
	RPC.executeGM("//hero 214202")
	RPC.executeGM("//hero 215001")
	RPC.executeGM("//hero 215002")
	RPC.executeGM("//hero 215003")
	RPC.executeGM("//hero 215004")
	RPC.executeGM("//hero 215006")
	RPC.executeGM("//hero 215008")
	RPC.executeGM("//hero 215101")
	RPC.executeGM("//hero 215201")
	RPC.executeGM("//heroall 220 10 8")
	RPC.executeGM("//stage 1 31 30")
	RPC.executeGM("//attr 2 10000")
end

function DebugModule.getItems10(sender, menu, value)
	RPC.executeGM("//hero 211001")
	RPC.executeGM("//hero 211002")
	RPC.executeGM("//hero 211003")
	RPC.executeGM("//hero 211004")
	RPC.executeGM("//hero 211005")
	RPC.executeGM("//hero 211008")
	RPC.executeGM("//hero 211010")
	RPC.executeGM("//hero 211101")
	RPC.executeGM("//hero 211201")
	RPC.executeGM("//hero 212001")
	RPC.executeGM("//hero 212002")
	RPC.executeGM("//hero 212003")
	RPC.executeGM("//hero 212004")
	RPC.executeGM("//hero 212005")
	RPC.executeGM("//hero 212006")
	RPC.executeGM("//hero 212007")
	RPC.executeGM("//hero 212012")
	RPC.executeGM("//hero 212101")
	RPC.executeGM("//hero 212201")
	RPC.executeGM("//hero 212203")
	RPC.executeGM("//hero 213001")
	RPC.executeGM("//hero 213002")
	RPC.executeGM("//hero 213003")
	RPC.executeGM("//hero 213004")
	RPC.executeGM("//hero 213005")
	RPC.executeGM("//hero 213006")
	RPC.executeGM("//hero 213008")
	RPC.executeGM("//hero 213009")
	RPC.executeGM("//hero 213010")
	RPC.executeGM("//hero 213012")
	RPC.executeGM("//hero 213101")
	RPC.executeGM("//hero 213103")
	RPC.executeGM("//hero 213201")
	RPC.executeGM("//hero 213202")
	RPC.executeGM("//hero 213203")
	RPC.executeGM("//hero 214002")
	RPC.executeGM("//hero 214003")
	RPC.executeGM("//hero 214004")
	RPC.executeGM("//hero 214005")
	RPC.executeGM("//hero 214006")
	RPC.executeGM("//hero 214010")
	RPC.executeGM("//hero 214011")
	RPC.executeGM("//hero 214012")
	RPC.executeGM("//hero 214101")
	RPC.executeGM("//hero 214201")
	RPC.executeGM("//hero 214202")
	RPC.executeGM("//hero 215001")
	RPC.executeGM("//hero 215002")
	RPC.executeGM("//hero 215003")
	RPC.executeGM("//hero 215004")
	RPC.executeGM("//hero 215006")
	RPC.executeGM("//hero 215008")
	RPC.executeGM("//hero 215101")
	RPC.executeGM("//hero 215201")
	RPC.executeGM("//heroall 220 10 10")
	RPC.executeGM("//stage 1 31 30")
	RPC.executeGM("//attr 2 10000")
end

function DebugModule.getItems11(sender, menu, value)
	RPC.executeGM("//hero 211001")
	RPC.executeGM("//hero 211002")
	RPC.executeGM("//hero 211003")
	RPC.executeGM("//hero 211004")
	RPC.executeGM("//hero 211005")
	RPC.executeGM("//hero 211008")
	RPC.executeGM("//hero 211010")
	RPC.executeGM("//hero 211101")
	RPC.executeGM("//hero 211201")
	RPC.executeGM("//hero 212001")
	RPC.executeGM("//hero 212002")
	RPC.executeGM("//hero 212003")
	RPC.executeGM("//hero 212004")
	RPC.executeGM("//hero 212005")
	RPC.executeGM("//hero 212006")
	RPC.executeGM("//hero 212007")
	RPC.executeGM("//hero 212012")
	RPC.executeGM("//hero 212101")
	RPC.executeGM("//hero 212201")
	RPC.executeGM("//hero 212203")
	RPC.executeGM("//hero 213001")
	RPC.executeGM("//hero 213002")
	RPC.executeGM("//hero 213003")
	RPC.executeGM("//hero 213004")
	RPC.executeGM("//hero 213005")
	RPC.executeGM("//hero 213006")
	RPC.executeGM("//hero 213008")
	RPC.executeGM("//hero 213009")
	RPC.executeGM("//hero 213010")
	RPC.executeGM("//hero 213012")
	RPC.executeGM("//hero 213101")
	RPC.executeGM("//hero 213103")
	RPC.executeGM("//hero 213201")
	RPC.executeGM("//hero 213202")
	RPC.executeGM("//hero 213203")
	RPC.executeGM("//hero 214002")
	RPC.executeGM("//hero 214003")
	RPC.executeGM("//hero 214004")
	RPC.executeGM("//hero 214005")
	RPC.executeGM("//hero 214006")
	RPC.executeGM("//hero 214010")
	RPC.executeGM("//hero 214011")
	RPC.executeGM("//hero 214012")
	RPC.executeGM("//hero 214101")
	RPC.executeGM("//hero 214201")
	RPC.executeGM("//hero 214202")
	RPC.executeGM("//hero 215001")
	RPC.executeGM("//hero 215002")
	RPC.executeGM("//hero 215003")
	RPC.executeGM("//hero 215004")
	RPC.executeGM("//hero 215006")
	RPC.executeGM("//hero 215008")
	RPC.executeGM("//hero 215101")
	RPC.executeGM("//hero 215201")
	RPC.executeGM("//heroall 220 10 15")
	RPC.executeGM("//stage 1 31 30")
	RPC.executeGM("//attr 2 10000")
end

function DebugModule.getItems12(sender, menu, value)
	RPC.executeGM("//hero 211001")
	RPC.executeGM("//hero 211002")
	RPC.executeGM("//hero 211003")
	RPC.executeGM("//hero 211004")
	RPC.executeGM("//hero 211005")
	RPC.executeGM("//hero 211008")
	RPC.executeGM("//hero 211010")
	RPC.executeGM("//hero 211101")
	RPC.executeGM("//hero 211201")
	RPC.executeGM("//hero 212001")
	RPC.executeGM("//hero 212002")
	RPC.executeGM("//hero 212003")
	RPC.executeGM("//hero 212004")
	RPC.executeGM("//hero 212005")
	RPC.executeGM("//hero 212006")
	RPC.executeGM("//hero 212007")
	RPC.executeGM("//hero 212012")
	RPC.executeGM("//hero 212101")
	RPC.executeGM("//hero 212201")
	RPC.executeGM("//hero 212203")
	RPC.executeGM("//hero 213001")
	RPC.executeGM("//hero 213002")
	RPC.executeGM("//hero 213003")
	RPC.executeGM("//hero 213004")
	RPC.executeGM("//hero 213005")
	RPC.executeGM("//hero 213006")
	RPC.executeGM("//hero 213008")
	RPC.executeGM("//hero 213009")
	RPC.executeGM("//hero 213010")
	RPC.executeGM("//hero 213012")
	RPC.executeGM("//hero 213101")
	RPC.executeGM("//hero 213103")
	RPC.executeGM("//hero 213201")
	RPC.executeGM("//hero 213202")
	RPC.executeGM("//hero 213203")
	RPC.executeGM("//hero 214002")
	RPC.executeGM("//hero 214003")
	RPC.executeGM("//hero 214004")
	RPC.executeGM("//hero 214005")
	RPC.executeGM("//hero 214006")
	RPC.executeGM("//hero 214010")
	RPC.executeGM("//hero 214011")
	RPC.executeGM("//hero 214012")
	RPC.executeGM("//hero 214101")
	RPC.executeGM("//hero 214201")
	RPC.executeGM("//hero 214202")
	RPC.executeGM("//hero 215001")
	RPC.executeGM("//hero 215002")
	RPC.executeGM("//hero 215003")
	RPC.executeGM("//hero 215004")
	RPC.executeGM("//hero 215006")
	RPC.executeGM("//hero 215008")
	RPC.executeGM("//hero 215101")
	RPC.executeGM("//hero 215201")
	RPC.executeGM("//heroall 220 10 15")
	RPC.executeGM("//stage 1 31 30")
	RPC.executeGM("//item 700006 1")
	RPC.executeGM("//item 700007 1")
	RPC.executeGM("//item 700008 1")
	RPC.executeGM("//item 700009 1")
	RPC.executeGM("//item 700010 1")
	RPC.executeGM("//item 700011 1")
	RPC.executeGM("//item 700012 1")
	RPC.executeGM("//item 700013 1")
	RPC.executeGM("//item 700014 1")
	RPC.executeGM("//item 700015 1")
	RPC.executeGM("//item 700016 1")
	RPC.executeGM("//item 700017 1")
	RPC.executeGM("//item 700018 1")
	RPC.executeGM("//item 700019 1")
	RPC.executeGM("//item 700020 1")
	RPC.executeGM("//item 700021 1")
	RPC.executeGM("//item 700022 1")
	RPC.executeGM("//item 700023 1")
	RPC.executeGM("//item 700024 1")
	RPC.executeGM("//item 700025 1")
	RPC.executeGM("//item 700026 1")
	RPC.executeGM("//item 700027 1")
	RPC.executeGM("//item 700028 1")
	RPC.executeGM("//item 700029 1")
	RPC.executeGM("//item 700030 1")
	RPC.executeGM("//item 700032 1")
	RPC.executeGM("//item 700034 1")
	RPC.executeGM("//item 560006 10")
	RPC.executeGM("//item 560007 10")
	RPC.executeGM("//item 560008 10")
	RPC.executeGM("//item 560009 10")
	RPC.executeGM("//item 560010 10")
	RPC.executeGM("//item 560011 10")
	RPC.executeGM("//item 560012 10")
	RPC.executeGM("//item 560013 10")
	RPC.executeGM("//item 560014 10")
	RPC.executeGM("//item 560015 10")
	RPC.executeGM("//item 560016 10")
	RPC.executeGM("//item 560017 10")
	RPC.executeGM("//item 560018 10")
	RPC.executeGM("//item 560019 10")
	RPC.executeGM("//item 560020 10")
	RPC.executeGM("//item 560021 10")
	RPC.executeGM("//item 560022 10")
	RPC.executeGM("//item 560023 10")
	RPC.executeGM("//item 560024 10")
	RPC.executeGM("//item 560025 10")
	RPC.executeGM("//item 560026 10")
	RPC.executeGM("//item 560027 10")
	RPC.executeGM("//item 560028 10")
	RPC.executeGM("//item 560029 10")
	RPC.executeGM("//item 560030 10")
	RPC.executeGM("//item 560032 10")
	RPC.executeGM("//item 560034 10")
	RPC.executeGM("//attr 2 10000")
	RPC.executeGM("//attr 1 1000000")
end

function DebugModule.getItems13(sender, menu, value)
	RPC.executeGM("//item 530049 1000000")
	RPC.executeGM("//item 530050 100000")

	for i, v in pairs(ResItem) do
		if v.subtype == 20 and ResHero[v.extend_args1].star_limit == 15 and ResHero[v.extend_args1] ~= 212103 then
			RPC.executeGM("//item " .. i .. " 100")
		end
	end
end

function DebugModule.getItems14(sender, menu, value)
	for k, v in pairs(ResHero) do
		if ResHero[k].valid_time_id then
			if ResHero[k].valid_time_id <= tonumber(value) then
				RPC.executeGM("//hero " .. k)
			end
		else
			RPC.executeGM("//hero " .. k)
		end
	end
end

function DebugModule.getItems17(sender, menu, value)
	RPC.executeGM("//item 510019 10")
	RPC.executeGM("//item 510020 10")
	RPC.executeGM("//item 510021 10")
	RPC.executeGM("//item 510038 10")
	RPC.executeGM("//item 500015 10")
	RPC.executeGM("//item 510037 10")
	RPC.executeGM("//item 568000 10")
	RPC.executeGM("//item 100011 10")
	RPC.executeGM("//item 100017 10")
	RPC.executeGM("//item 100018 10")
	RPC.executeGM("//item 100021 10")
	RPC.executeGM("//item 100026 10")
	RPC.executeGM("//item 501001 10")
	RPC.executeGM("//item 501011 10")
	RPC.executeGM("//item 501012 10")
	RPC.executeGM("//item 501013 10")
	RPC.executeGM("//item 510001 10")
	RPC.executeGM("//item 510004 10")
	RPC.executeGM("//item 510005 10")
	RPC.executeGM("//item 567018 10")
	RPC.executeGM("//item 568001 10")
	RPC.executeGM("//item 510025 10")
end

DebugModule.FUNC_MENU = {
	{
		name = "获得道具",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.getItem
	},
	{
		name = "外放控制",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.timeVaild
	},
	{
		name = "获取升阶装备",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.getItems
	},
	{
		name = "获取金币和钻石",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.getItems1
	},
	{
		name = "获取全神器",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.getItems2
	},
	{
		name = "获取全英雄，平均X星",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.getItems7
	},
	{
		name = "战力up",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.getItems4
	},
	{
		name = "兼容测试道具",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.getItems5
	},
	{
		name = "获取所有皮肤",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.getItems6
	},
	{
		name = "获取全手办和皮肤",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.getItems3
	},
	{
		name = "获取全布景",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.getItems8
	},
	{
		name = "平均15星+布景",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.getItems12
	},
	{
		name = "满涂装材料",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.getItems13
	},
	{
		name = "获取全手办",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.getItems14
	},
	{
		name = "获取羁绊道具",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.getItems15
	},
	{
		name = "获取宠物道具",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.getItems16
	},
	{
		name = "随机90件粉装",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.getequip
	},
	{
		name = "道具测试跳转",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.getItems17
	}
}

return DebugModule
