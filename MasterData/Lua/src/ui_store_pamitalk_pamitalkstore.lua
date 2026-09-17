local this = class("pamiTalkStore", G_BaseStore)
this:importPartialClass(require(L_R.store .. "pamiTalk.pamiTalkState"))
this:importPartialClass(require(L_R.store .. "pamiTalk.pamiTalkAction"))
this.event = {
  refreshLetter = "pamiTalk_refreshLetter",
  refreshReadStatus = "pamiTalk_refreshReadStatus",
  refreshRewardStatus = "pamiTalk_refreshRewardStatus",
  refreshLetterRedDot = "pamiTalk_refreshLetterRedDot",
  refreshLettersData = "pamiTalk_refreshLettersData"
}

function this:getPamiTalkData()
  return self.data.pamiTalkData
end

function this:getPamiParsedLetters()
  return self.data.parsedLetters
end

function this:getPamiLetterMap()
  return self.data.letterMap
end

return this
