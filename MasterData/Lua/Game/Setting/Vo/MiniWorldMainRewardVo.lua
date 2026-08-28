local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

-- 微缩世界主线奖励表

---@class MiniWorldMainRewardVo
local MiniWorldMainRewardVo = Class("MiniWorldMainRewardVo", SettingRefBase)

function MiniWorldMainRewardVo:__init()
    self.id = nil
    self.regularReward = nil        --必定掉落
    self.regularRewardNum = nil --必定掉落数量
    self.fristRewards = nil     --首次通关掉落
    self.fristRewardsNum = nil  --首次通关掉落数量
    self.showItem = nil         --编队UI展示奖励道具
    self.showItemNum = nil      --编队UI展示奖励道具数量
    self.showItemTag = nil      --编队UI展示奖励道具标签，1必定掉落、2概率掉落、3首次通关掉落、4三星奖励
    self.status = nil               --状态
end

---FillVo
---@param row TableML.TableFileRow
function MiniWorldMainRewardVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")
    self.regularReward = parse_string(row, "regularReward")
    self.regularRewardNum = parse_string(row, "regularRewardNum")
    self.fristRewards = parse_string(row, "fristRewards")
    self.fristRewardsNum = parse_string(row, "fristRewardsNum")
    self.showItem = parse_string(row, "showItem")
    self.showItemNum = parse_string(row, "showItemNum")
    self.showItemTag = parse_string(row, "showItemTag")           
    self.status = parse_number(row, "status")
end

function MiniWorldMainRewardVo:__delete()
    self.id = nil
    self.regularReward = nil        --必定掉落
    self.regularRewardNum = nil --必定掉落数量
    self.fristRewards = nil     --首次通关掉落
    self.fristRewardsNum = nil  --首次通关掉落数量
    self.showItem = nil         --编队UI展示奖励道具
    self.showItemNum = nil      --编队UI展示奖励道具数量
    self.showItemTag = nil      --编队UI展示奖励道具标签，1必定掉落、2概率掉落、3首次通关掉落、4三星奖励
    self.status = nil               --状态
end

return MiniWorldMainRewardVo
