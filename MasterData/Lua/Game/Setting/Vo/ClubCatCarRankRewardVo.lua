--id,upperLimit,lowerLimit,#name,reward,rewardNum,mail,status
--编号,排名上限,排名下限,档位文本显示,奖励道具,奖励数量,邮件ID,状态
--int,int,int,string,int[],int[],int,int
local SettingRefBase = require('Game.Setting.SettingRefBase')
local ParseUtils = CS.ParseUtils

---@class ClubCatCarRankRewardVo : SettingRefBase
local ClubCatCarRankRewardVo = Class('ClubCatCarRankRewardVo', SettingRefBase)


function ClubCatCarRankRewardVo:__init()
    self.id = nil                      --编号
    self.upperLimit = nil              --排名上限
    self.lowerLimit = nil              --排名下限
    self.name = nil                    --档位文本显示
    self.reward = nil                  --奖励道具
    self.rewardNum = nil               --奖励数量
    self.rewards = nil
    self.mail = nil                    --邮件ID
end


function ClubCatCarRankRewardVo:__delete()
end


---@param row TableML.TableFileRow
function ClubCatCarRankRewardVo:FillVo(row)
    SettingRefBase.FillVo(self, row)
    
    self.id = parse_number(row, 'id')
    self.upperLimit = parse_number(row, 'upperLimit')
    self.lowerLimit = parse_number(row, 'lowerLimit')
    self.name = ParseUtils.ParseLocalizeText(row, 'name')
    self.reward = parse_string(row, 'reward')
    self.rewardNum = parse_string(row, 'rewardNum')
    self.rewards = parse_rewards(self.reward,self.rewardNum)
    self.mail = parse_number(row, 'mail')
end


return ClubCatCarRankRewardVo
