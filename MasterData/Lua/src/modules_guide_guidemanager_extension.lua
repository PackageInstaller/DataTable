local this = {}

function this:skipPrelude()
  if L_ExternalGMManager ~= nil then
    local guideList = L_GameConstTpl:getData("SKIP_FIRST_TASKID_GUIDE", L_Const.GameTplType.list_int)
    for _, v in pairs(guideList) do
      L_GuideStore:updateGuideData(v, 0)
    end
    L_ExternalGMManager:SendGMCommand("SKIPPRELUDE")
  end
  L_UI:open("pageMOD")
  C_LoginMovieHelper.StopLoginMovie()
end

return this
