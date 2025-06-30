--[[ 
-----------------------------------------------------
@filename       : GMFightReplayItem
@Description    : GM
@date           : 2022-2-22 20:22:07
@Author         : lyx
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("gm.GmFightReplayItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
	self.mTypeTxt = self:getChildGO("TypeTxt"):GetComponent(ty.Text)
    self.mSceneIDTxt = self:getChildGO("SceneIDTxt"):GetComponent(ty.Text)
    self.mReplayIDTxt = self:getChildGO("ReplayIDTxt"):GetComponent(ty.Text)

    
    self:addOnClick(self:getChildGO("ReplayBtn"), self._replayCall)
end

function _replayCall(self)
    if self.mReplayData then
        fight.FightManager:reqReplay(self.mReplayData.type, self.mReplayData.id)
    end
end

function setData(self, param)
    super.setData(self, param)
    self.mReplayData = param
    self.mTypeTxt.text = ""..param.type
    self.mSceneIDTxt.text = ""..param.field_id
    self.mReplayIDTxt.text = ""..param.id
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
