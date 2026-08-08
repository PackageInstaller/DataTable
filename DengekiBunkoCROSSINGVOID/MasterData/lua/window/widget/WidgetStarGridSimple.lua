local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_singleWidth, m_intervalX

function SetStar(count, darkCount, leftAlign, intervalX)
  if m_singleWidth == nil then
    m_singleWidth = REF.Bright.UISprite.width
    m_intervalX = intervalX or REF.Bright.UISprite.intervalX
  end
  count = count or 0
  darkCount = darkCount or 0
  WU.SetActive(REF.Bright, 0 < count)
  if 0 < count or 0 < darkCount then
    if leftAlign then
      REF.Bright.transform.localPosition = CS.UnityEngine.Vector3(0, 0, 0)
    else
      local maxCount = count + darkCount
      REF.Bright.transform.localPosition = CS.UnityEngine.Vector3(-(maxCount * m_singleWidth + (maxCount - 1) * m_intervalX) / 2 + math.floor(m_singleWidth * -0.5), 0, 0)
    end
  end
  REF.Bright.UISprite.width = m_singleWidth * count + m_intervalX * (count - 1)
  WU.SetActive(REF.Dark, 0 < darkCount)
  if 0 < darkCount then
    REF.Dark.UISprite.width = m_singleWidth * darkCount + m_intervalX * (darkCount - 1)
    REF.Dark.transform.localPosition = CS.UnityEngine.Vector3(REF.Bright.transform.localPosition.x + REF.Bright.UISprite.width + m_intervalX, 0, 0)
  end
end

function PlayTween(forward)
  if REF["$UIPlayTween"] then
    REF["$UIPlayTween"].Play(forward)
  end
end
