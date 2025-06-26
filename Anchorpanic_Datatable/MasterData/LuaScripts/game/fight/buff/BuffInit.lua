Buff = {}
BuffDef = require('game/fight/buff/def/BuffDef')
-- 数据类
Buff.BuffDataRo = require('rodata/BuffDataRo')
Buff.EleReactionDataRo = require('rodata/EleReactionDataRo')

Buff.BuffPerformDataRo = require('rodata/BuffPerformDataRo')
Buff.BuffOverlyingRo = require('rodata/BuffOverlyingRo')
Buff.BuffRoMgr = require('game/fight/buff/BuffRoMgr').new()
-- 基础类
Buff.BuffAttrVo  = require('game/fight/buff/vo/BuffAttrVo')
Buff.BuffVo = require('game/fight/buff/vo/BuffVo')
Buff.BuffInfluenceVo = require('game/fight/buff/vo/BuffInfluenceVo')
Buff.BuffIntervalVo = require('game/fight/buff/vo/BuffIntervalVo')
-- 单一类
Buff.BuffFixedVo = require('game/fight/buff/vo/BuffFixedVo')
Buff.BuffPercentVo = require('game/fight/buff/vo/BuffPercentVo')
-- 连续类
Buff.BuffIntervalFixedVo = require('game/fight/buff/vo/BuffIntervalFixedVo')
Buff.BuffIntervalPercentVo = require('game/fight/buff/vo/BuffIntervalPercentVo')

-- 干扰类
Buff.BuffInfluFixedVo = require('game/fight/buff/vo/BuffInfluFixedVo')
Buff.BuffInfluPercentVo = require('game/fight/buff/vo/BuffInfluPercentVo')
Buff.BuffInfluGainInvalidVo = require('game/fight/buff/vo/BuffInfluGainInvalidVo')
Buff.BuffInfluInvalidVo = require('game/fight/buff/vo/BuffInfluInvalidVo')
Buff.BuffInfluExcludeVo = require('game/fight/buff/vo/BuffInfluExcludeVo')

Buff.BuffEntity = require('game/fight/buff/BuffEntity')
BuffHandler = require('game/fight/buff/BuffHandler').new()

-- Buff特效的处理 (服务器时 不用加载些类)
BuffEftHandler = require('game/fight/buff/BuffEftHandler').new()

return Buff
 
--[[ 替换语言包自动生成，请勿修改！
]]
