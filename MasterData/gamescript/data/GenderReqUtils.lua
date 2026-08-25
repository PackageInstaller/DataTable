local GenderReqUtils = {}

function GenderReqUtils.ReqChangeGender(targetGender, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnChangePlayerGender", function(data)
    data = data or {}
    Logger.Info("OnChangePlayerGender Successful ", table.tostring(data))
    PlayerDataUtils.SetGenderChangeTimes(data.genderChangeTimes)
    PlayerDataUtils.SetGender(data.gender)
    PlayerDataUtils.SetUsingEmojiList(data.useEmojiList)
    PlayerDataUtils.SetIcon(data.icon)
    EventMgr.Instance.OnGenderChange:Dispatch()
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("OnChangePlayerGender failed ", table.tostring(data))
  end, targetGender)
end

return GenderReqUtils
