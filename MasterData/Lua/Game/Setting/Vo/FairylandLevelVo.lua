---
--- 乱流幻境关卡表
--- Author: dawanfan
--- Date: 2024-1-18 11:39:42
---

local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

---@class FairylandLevelVo
local FairylandLevelVo = Class("FairylandLevelVo", SettingRefBase)

---__int
function FairylandLevelVo:__init()
    self.id = nil              --关卡ID
    self.copyId = nil           -- 对应副本Id
    self.name = nil              --名称
    self.difficulty = nil              --对应副本难度
    self.monsterShow = nil              --怪物显示（皮肤表ID）
    self.scale = nil                -- 单关镜像进度
    self.costNum = nil              --成功时消耗的数量
    self.costNumLose = nil              --进入时扣除的数量
    self.exp = nil              --主角经验
    self.cardExp = nil              --卡牌经验
    self.battleRules = nil              --战斗规则字段
    self.proposalLevel = nil              --推荐战斗力
    self.costItem = nil              --消耗道具ID
    self.SceneId = nil              --场景ID
    self.rounds = nil              --回合限制(超出后直接失败)
    self.roleNun = nil              --最多上阵人数（1为下限 4为上限）
    self.status = nil              --状态
end

---FillVo
---@param row TableML.TableFileRow
function FairylandLevelVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")
    self.copyId = parse_number(row, "copyId")
    self.name = ParseUtils.ParseLocalizeText(row, "name")
    self.difficulty = parse_number(row, "difficulty")
    self.monsterShow = parse_number(row, "monsterShow")
    self.scale = parse_number(row, "scale")
    self.costNum = parse_number(row, "costNum")
    self.costNumLose = parse_number(row, "costNumLose")
    self.exp = parse_number(row, "exp")
    self.cardExp = parse_number(row, "cardExp")
    self.battleRules = parse_string(row, "battleRules")
    self.proposalLevel = parse_number(row, "proposalLevel")
    self.costItem = parse_number(row, "costItem")
    self.SceneId = parse_number(row, "SceneId")
    self.rounds = parse_number(row, "rounds")
    self.roleNun = parse_number(row, "roleNun")
    self.status = parse_number(row, "status")
end

function FairylandLevelVo:__delete()
    self.id = nil
    self.copyId = nil
    self.name = nil
    self.difficulty = nil
    self.monsterShow = nil
    self.scale = nil
    self.costNum = nil
    self.costNumLose = nil
    self.exp = nil
    self.cardExp = nil
    self.battleRules = nil
    self.proposalLevel = nil
    self.costItem = nil
    self.SceneId = nil
    self.rounds = nil
    self.roleNun = nil
    self.status = nil
end

return FairylandLevelVo
