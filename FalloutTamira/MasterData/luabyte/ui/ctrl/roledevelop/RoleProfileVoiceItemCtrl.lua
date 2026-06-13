--语音ITEM
local RoleProfileVoiceItemCtrl = BaseClass("RoleProfileVoiceItemCtrl", UIBaseComponent)
local M = RoleProfileVoiceItemCtrl
local numPath = "UI/SpritePics/common/RomanNum/ui_develop_text_"

function M:__init()
    self._heroCfg = nil
    self._index = 0
    self._clickCallback = nil
    self._view.playBtn:SetOnClick(self, self._OnClickItem)
    --self._view.stopBtn:onClick(Bind(self,self._OnClickItem))
    self._curAudioId = 0
    self._finishCallback = nil
    self._words = 0
    self._voice = 0
end

--设置ITEM
function M:SetVoice(heroCfg, id, favorLevel, clickCallback, index)
    self._heroCfg = heroCfg
    self._clickCallback = clickCallback
    self.isLocked = favorLevel < heroCfg.voiceLimit[id]
    self._view.voiceName.text = ConfigHelper.GetLocalString(heroCfg.voiceName[id])

    self._view.UIState:SetState(self.isLocked and 2 or 1)
    self._view.voiceName:SetText(heroCfg.voiceName[id])

    if self._view.voiceName2 then
        self._view.voiceName2:SetText(heroCfg.voiceName[id])
    end

    local str = ConfigHelper.GetLocalString(1244)
    self._view.lockDesc:SetText(string.format(str, heroCfg.voiceLimit[id]))
    self._view.wave:SetActive(false)
    self._view.triangle:SetActive(true)
    self._view.bar.gameObject:SetActive(false) --进度条
    self._words = self._heroCfg.voiceWords[id]
    self._voice = self._heroCfg.voiceId[id]

    self._view.labNum:SetText(tostring(index))
    local line = math.modf(index / 10) -- 取整数
    local mod = math.fmod(index, 10) -- 取余数
    self._view.imgNum2:SetPic(numPath .. line)
    self._view.imgNum1:SetPic(numPath .. mod)
end

function M:GetWord()
    return self._words
end

--播放声音
function M:PlayVoice(finishCallback)
    local soundData = ConfigHelper.GetCfg("sound", self._voice)

    if soundData then
        self._curAudioId = GameHelper.PlaySoundReturnObjId(soundData.eventID, 1, Bind(self, self._AudioEndCallBack))
    end

    self._finishCallback = finishCallback
    self._view.UIState:SetState(3)
end

--停止声音
function M:StopVoice()
    self._view.anim:SetActive(false)
    self._view.wave:SetActive(false)
    self._view.UIState:SetState(self.isLocked and 2 or 1)
    GameHelper.PlayAudioById(1317)
end

--声音完成
function M:_AudioEndCallBack(audioId)
    if self._finishCallback then
        self._finishCallback(self._curAudioId)
    end

    self._view.UIState:SetState(self.isLocked and 2 or 1)
end

function M:_OnClickItem(go)
    if self._clickCallback then
        self._clickCallback(self)
    end
end

function M:ClearCallBack()
    self._view.UIState:SetState(1)
    self._finishCallback = nil
end

function M:OnDestroy()
    self._finishCallback = nil
    self._clickCallback = nil
    M.super.OnDestroy(self)
end

return RoleProfileVoiceItemCtrl
