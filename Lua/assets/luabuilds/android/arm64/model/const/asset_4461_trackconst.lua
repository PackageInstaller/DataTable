local TrackConst = class("TrackConst")

function TrackConst:GetTrackData(arg_1_1, ...)
	return {
		system = self,
		id = arg_1_1,
		desc = TrackConst.GetDesc(self, arg_1_1, ...)
	}
end

function TrackConst:GetDesc(arg_2_1, ...)
	return TrackConst["Build" .. self .. "Action" .. arg_2_1 .. "Desc"](unpack({
		...
	}))
end

TrackConst.SYSTEM_SHOP = 1
TrackConst.ACTION_ENTER_MAIN = 1
TrackConst.ACTION_ENTER_GIFT = 2
TrackConst.ACTION_BUY_RECOMMEND = 3
TrackConst.ACTION_LOOKUP_RECOMMEND = 4

function TrackConst:Build1Action1Desc()
	return self and "1" or "0"
end

function TrackConst:Build1Action2Desc()
	return self and "1" or "0"
end

function TrackConst:Build1Action3Desc()
	return self .. ""
end

function TrackConst:Build1Action4Desc()
	return self .. ""
end

return TrackConst
