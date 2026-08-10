return {
	INQUERY = 8,
	CD_KEY = 1,
	ACTIVITY = 13,
	OFFICIAL_WEBSITE = 4,
	QUESTIONNAIRE = 2,
	MANUAL_WORD_VERIFY = 16,
	SHOP_TAOBAO = 14,
	SUGGEST = 6,
	CHANGE_NICK = 9,
	ATTENTION = 3,
	USER_CENTER = 5,
	SHARE_FLAG = 11,
	FORUM = 7,
	CHANGE_SIGN = 10,
	INFOMATION = 15,
	PLATFORM = {
		BILIBILI = 3,
		WEIBO = 1,
		WECHAT = 2,
		FACEBOOK = 5,
		DISCORD = 6,
		YOUTUBE = 7,
		TWITTER = 4
	},
	SURVEY_TYPE = {
		NORMAL = 1,
		REGRESSION = 2
	},
	OPERATION_STOP = {
		DAMAGE_TEST = 902,
		JOIN_CLUB = 201,
		CHANGE_CLUB_SIGN = 203,
		CHANGE_CLUB_NICK = 202
	},
	URL_OPEN_WAY = {
		NORMAL = 1,
		INTERNAL = 2
	},
	SCREEN_ORIENTATION = {
		FORCE_HORIZONTAL = 0,
		FORCE_VERTICAL = 1,
		FREE = -1
	},
	URL_PARAM_MARK = {
		userId = {
			getFunc = function(arg_1_0)
				return PlayerData:GetPlayerInfo().userID
			end
		},
		signUserId = {
			getFunc = function(arg_2_0)
				return PlayerData:GetPlayerInfo().signUserId
			end
		},
		gameAppId = {
			getFunc = function(arg_3_0)
				return _G.ChannelLoginInfo.channelAppId
			end
		},
		token = {
			getFunc = function(arg_4_0)
				return _G.ChannelLoginInfo.channelToken
			end
		},
		heroName = {
			getFunc = function(arg_5_0)
				return arg_5_0.heroName
			end
		},
		timestamp = {
			getFunc = function(arg_6_0)
				return _G.SERVER_TIMESTAMP
			end
		},
		sign = {
			getFunc = function(arg_7_0)
				return _G.SERVER_TIMESTAMP_SIGN
			end
		},
		channelId = {
			getFunc = function(arg_8_0)
				return _G.TMP_CHANNELID
			end
		},
		mixUserToken = {
			getFunc = function(arg_9_0)
				return GetSDKLoginToken()
			end
		},
		region = {
			getFunc = function(arg_10_0)
				return GameToSDK.CURRENT_SERVER
			end
		},
		serverId = {
			getFunc = function(arg_11_0)
				return _G.SELECT_REGION_SEVER_ID
			end
		},
		partnerid = {
			getFunc = function(arg_12_0)
				return PlayerData:GetPlayerInfo().userID
			end
		}
	}
}
