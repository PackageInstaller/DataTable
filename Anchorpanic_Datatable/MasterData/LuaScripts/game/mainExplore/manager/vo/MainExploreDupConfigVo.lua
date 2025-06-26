--[[ 
-----------------------------------------------------
@filename       : MainExploreDupConfigVo
@Description    : 主线探索副本配置
@date           : 2022-3-29 
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreDupConfigVo", Class.impl())

function parseConfig(self, dupId, cusData)
	-- 副本id
    self.dupId = dupId
	-- 进入副本消耗
    self.cost = {cusData.need_tid, cusData.need_num}
	-- 敌人配置
    self.mMonsterIdList = cusData.dup_guard
	-- 通关展示将礼包（展示）
    self.showAwardId = cusData.show_drop
	-- 背景音乐id
    self.mMusicId = cusData.music_id
	-- 场景id
    self.mSceneId = cusData.scene_id
	-- 失败效果
	self.mFailEffect = cusData.fail_effect
end

function getMonsterIdList(self)
    return self.mMonsterIdList
end

function getMusicId(self)
	return self.mMusicId
end

function getSceneId(self)
	return self.mSceneId
end

function getFailEffect(self)
	return self.mFailEffect
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
