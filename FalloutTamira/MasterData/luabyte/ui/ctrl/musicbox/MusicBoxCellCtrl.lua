local M = BaseClass("MusicBoxCellCtrl",UIBaseComponent)
local numPath = "UI/SpritePics/common/RomanNum/ui_develop_text_"

function M:__init()
    self._view.playBtn:SetOnClick(self, self._OnClickItem)
end

function M:OnEnter()

end

function M:OnClose()
    
end

--设置ITEM
function M:SetVoice(Cfg,clickCallback, index)
    self._Cfg = Cfg
    self._clickCallback = clickCallback
    self._view.titleTf:SetText(ConfigHelper.GetLocalString(Cfg.languageID))

    self._view.state:SetState(1)
    self._view.wave:SetActive(false)
    self._view.triangle:SetActive(true)
    self._view.bar.gameObject:SetActive(false) --进度条

    self._view.numberTxt:SetText(tostring(index))
    local line = math.modf(index / 10) -- 取整数
    local mod = math.fmod(index, 10) -- 取余数
    self._view.imgNum2:SetPic(numPath .. line)
    self._view.imgNum1:SetPic(numPath .. mod)
end

function M:_OnClickItem(go)
    if self._clickCallback then
        self._clickCallback(self)
    end
end

--播放声音
function M:PlayVoice(finishCallback)
    local soundData = ConfigHelper.GetCfg("sound", self._Cfg.soundID)

    if soundData then
        self._curAudioId = GameHelper.PlaySoundReturnObjId(soundData.eventID, 1, Bind(self, self.CallBack))
    end

    self._finishCallback = finishCallback
    self._view.state:SetState(3)
end

--停止声音
function M:StopVoice()
    self._view.anim:SetActive(false)
    self._view.wave:SetActive(false)
    self._view.state:SetState(1)
    GameHelper.PlayAudioById(1317)
end

--声音完成
function M:_AudioEndCallBack(audioId)
    if self._finishCallback then
        self._finishCallback(self._curAudioId)
    end

    self._view.state:SetState(1)
end

function M:CallBack(audioId)

end

function M:_OnClickItem(go)
    if self._clickCallback then
        self._clickCallback(self)
    end
end

function M:ClearCallBack()
    self._view.state:SetState(1)
    self._finishCallback = nil
end

function M:OnDestroy()
    self._finishCallback = nil
    self._clickCallback = nil
    M.super.OnDestroy(self)
end

function M:OnDestroy()
    self._clickCallback = nil
    M.super.OnDestroy(self)
end

return M