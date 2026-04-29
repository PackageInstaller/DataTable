_class("UIHomeVisitInfo", Object)
UIHomeVisitInfo = UIHomeVisitInfo

function UIHomeVisitInfo:Constructor(data)
  self._data = data
end

function UIHomeVisitInfo:Data()
  return self._data
end

function UIHomeVisitInfo:HasGift()
  local gifts = self._data.item_list
  if next(gifts) then
    for key, gift in pairs(gifts) do
      if gift.count > 0 then
        return true
      end
    end
  end
  return false
end
