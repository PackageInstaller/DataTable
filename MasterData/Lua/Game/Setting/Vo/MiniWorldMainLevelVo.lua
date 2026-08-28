local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

-- 微缩世界主线关卡表

---@class MiniWorldMainLevelVo
local MiniWorldMainLevelVo = Class("MiniWorldMainLevelVo", SettingRefBase)

function MiniWorldMainLevelVo:__init()
    self.id = nil               -- 关卡id
    self.activityId = nil            -- 活动id
    self.ifParkour = nil              -- 是否为跑酷关卡
    self.trapId = nil               -- 陷阱id（显示顺序从左至右）
    self.gainId = nil               -- 增益id（显示顺序从左至右）
    self.picture = nil               -- 关卡图片
    self.prefabId = nil               -- 对应地图资源
    self.title = nil               -- "02." 这种
    self.name = nil               -- 名称
    self.desc = nil               -- 描述
    self.type = nil               -- 剧情类型（ 2剧情+战斗 1纯剧情  0仅战斗）
    self.unlockLevel = nil               -- 解锁条件值（填充为0，固定为前置关卡解锁）
    self.date = nil               -- 开放时间（按照活动开启当天计算，单位为秒，0为默认解锁）
    self.exp = nil               -- 主角经验
    self.cardExp = nil               -- 卡牌经验
    self.battleRules = nil               -- 战斗规则字段
    self.proposalLevel = nil               -- 推荐战斗力
    self.costItem = nil               -- 消耗道具ID
    self.costNum = nil               -- 成功时消耗的数量
    self.costNumLose = nil               -- 进入时扣除的数量
    self.sceneId = nil               -- 场景ID
    self.rounds = nil               -- 回合限制(超出后直接失败)
    self.petLineup = nil               -- 机器人阵容ID（填0为不需要机器人阵容）
    self.roleNun = nil               -- 最多上阵人数（1为下限 4为上限）
    self.repeatButton = nil               -- 重复挑战关卡按钮显示（0不1是）
    self.powerRatioTeamID = nil               -- 战力碾压组别
    self.status = nil               --状态
end

---FillVo
---@param row TableML.TableFileRow
function MiniWorldMainLevelVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")
    self.activityId = parse_number(row, "activityId")
    self.ifParkour = parse_number(row, "ifParkour")
    self.trapId = parse_string(row, "trapId")
    self.gainId = parse_string(row, "gainId")
    self.picture = ParseUtils.ParsePathName(row, "picture")
    self.prefabId = parse_string(row, "prefabId")
    self.title = ParseUtils.ParseLocalizeText(row, "title") 
    self.name = ParseUtils.ParseLocalizeText(row, "name")   
    self.desc = ParseUtils.ParseLocalizeText(row, "desc")
    self.type = parse_number(row, "type")
    self.unlockLevel = parse_string(row, "unlockLevel")
    self.date = parse_number(row, "date")
    self.exp = parse_number(row, "exp")
    self.cardExp = parse_number(row, "cardExp")
    self.battleRules = parse_string(row, "battleRules")
    self.proposalLevel = parse_number(row, "proposalLevel")
    self.costItem = parse_number(row, "costItem")
    self.costNum = parse_number(row, "costNum")
    self.costNumLose = parse_number(row, "costNumLose")
    self.sceneId = parse_number(row, "sceneId")
    self.rounds = parse_number(row, "rounds")
    self.petLineup = parse_number(row, "petLineup")
    self.roleNun = parse_string(row, "roleNun")
    self.repeatButton = parse_number(row, "repeatButton")
    self.powerRatioTeamID = parse_number(row, "powerRatioTeamID")           
    self.status = parse_number(row, "status")
end

function MiniWorldMainLevelVo:__delete()
    self.id = nil               -- 关卡id
    self.activityId = nil            -- 活动id
    self.ifParkour = nil              -- 是否为跑酷关卡
    self.trapId = nil               -- 陷阱id（显示顺序从左至右）
    self.gainId = nil               -- 增益id（显示顺序从左至右）
    self.picture = nil               -- 关卡图片
    self.prefabId = nil               -- 对应地图资源
    self.title = nil               -- "02." 这种
    self.name = nil               -- 名称
    self.desc = nil               -- 描述
    self.type = nil               -- 剧情类型（ 2剧情+战斗 1纯剧情  0仅战斗）
    self.unlockLevel = nil               -- 解锁条件值（填充为0，固定为前置关卡解锁）
    self.date = nil               -- 开放时间（按照活动开启当天计算，单位为秒，0为默认解锁）
    self.exp = nil               -- 主角经验
    self.cardExp = nil               -- 卡牌经验
    self.battleRules = nil               -- 战斗规则字段
    self.proposalLevel = nil               -- 推荐战斗力
    self.costItem = nil               -- 消耗道具ID
    self.costNum = nil               -- 成功时消耗的数量
    self.costNumLose = nil               -- 进入时扣除的数量
    self.sceneId = nil               -- 场景ID
    self.rounds = nil               -- 回合限制(超出后直接失败)
    self.petLineup = nil               -- 机器人阵容ID（填0为不需要机器人阵容）
    self.roleNun = nil               -- 最多上阵人数（1为下限 4为上限）
    self.repeatButton = nil               -- 重复挑战关卡按钮显示（0不1是）
    self.powerRatioTeamID = nil               -- 战力碾压组别
    self.status = nil               --状态
end

return MiniWorldMainLevelVo
