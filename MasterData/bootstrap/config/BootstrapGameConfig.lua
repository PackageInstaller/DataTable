module("bootstrap.config.BootstrapGameConfig", package.seeall)

ServerType = {
	LOGIN_INTERNET_EXAMINE = 14,
	LOGIN_INTERNET_DEV = 10,
	LOGIN_INTRANET_WEEK = 2,
	LOGIN_INTRANET_DEV = 0,
	LOGIN_INTERNET_FORMAL = 13,
	LOGIN_INTRANET_FORMAL = 4,
	LOGIN_INTERNET_MONTH = 11,
	LOGIN_INTRANET_REVIEW = 3,
	LOGIN_INTRANET_MONTH = 1,
	LOGIN_INTERNET_REVIEW = 12,
	LOGIN_INTERNET_PRE_FORMAL = 15
}

local var_0_0 = GameRequestUrl

return {
	urlInfo = {
		cn = {
			default = {
				hotUpdateAppCode = "spacexcn",
				httpLoginUrl = var_0_0.LOGIN_ZH_FORMAL_INTERNET,
				reviewHttpLoginUrl = var_0_0.LOGIN_ZH_IOS_REVIEW,
				backupHttpLoginUrl = var_0_0.LOGIN_ZH_BACKUP_INTERNET,
				hotUpdateInfoUrl = var_0_0.HOTUPDATE_ZH_FORMAL_INTERNET,
				backupHotUpdateInfoUrl = var_0_0.HOTUPDATE_ZH_BACKUP,
				noticeUrl = var_0_0.NOTICE_ZH_FORMAL,
				feedbackUrl = var_0_0.FEEDBACK_ZH_FORMAL,
				fileServerUrl = var_0_0.FILE_SERVER_URL
			},
			[ServerType.LOGIN_INTRANET_DEV] = {
				httpLoginUrl = var_0_0.LOGIN_INTRANET_DEV,
				backupHttpLoginUrl = var_0_0.LOGIN_INTRANET_DEV,
				hotUpdateInfoUrl = var_0_0.HOTUPDATE_ZH_TEST_INTRANET,
				reviewHttpLoginUrl = var_0_0.LOGIN_INTRANET_DEV,
				noticeUrl = var_0_0.NOTICE_ZH_TEST,
				feedbackUrl = var_0_0.FEEDBACK_ZH_TEST
			},
			[ServerType.LOGIN_INTRANET_MONTH] = {
				httpLoginUrl = var_0_0.LOGIN_INTRANET_MONTH,
				hotUpdateInfoUrl = var_0_0.HOTUPDATE_ZH_TEST_INTERNET,
				noticeUrl = var_0_0.NOTICE_ZH_TEST
			},
			[ServerType.LOGIN_INTRANET_WEEK] = {
				httpLoginUrl = var_0_0.LOGIN_INTRANET_WEEK,
				hotUpdateInfoUrl = var_0_0.HOTUPDATE_ZH_TEST_INTERNET,
				noticeUrl = var_0_0.NOTICE_ZH_TEST
			},
			[ServerType.LOGIN_INTRANET_REVIEW] = {
				httpLoginUrl = var_0_0.LOGIN_INTRANET_REVIEW
			},
			[ServerType.LOGIN_INTRANET_FORMAL] = {
				httpLoginUrl = var_0_0.LOGIN_INTRANET_FORMAL,
				hotUpdateInfoUrl = var_0_0.HOTUPDATE_ZH_TEST_INTERNET
			},
			[ServerType.LOGIN_INTERNET_DEV] = {
				httpLoginUrl = var_0_0.LOGIN_INTERNET_DEV,
				hotUpdateInfoUrl = var_0_0.HOTUPDATE_ZH_TEST_INTERNET,
				noticeUrl = var_0_0.NOTICE_ZH_TEST
			},
			[ServerType.LOGIN_INTERNET_MONTH] = {
				httpLoginUrl = var_0_0.LOGIN_INTERNET_MONTH,
				hotUpdateInfoUrl = var_0_0.HOTUPDATE_ZH_TEST_INTERNET,
				noticeUrl = var_0_0.NOTICE_ZH_TEST
			},
			[ServerType.LOGIN_INTERNET_FORMAL] = {
				httpLoginUrl = var_0_0.LOGIN_ZH_FORMAL_INTERNET,
				fileServerUrl = var_0_0.FILE_SERVER_URL_CN
			},
			[ServerType.LOGIN_INTERNET_REVIEW] = {
				httpLoginUrl = var_0_0.LOGIN_ZH_REVIEW
			},
			[ServerType.LOGIN_INTERNET_EXAMINE] = {
				httpLoginUrl = var_0_0.LOGIN_ZH_IOS_REVIEW
			},
			[ServerType.LOGIN_INTERNET_PRE_FORMAL] = {
				httpLoginUrl = var_0_0.LOGIN_ZH_FORMAL_PRE_INTERNET,
				backupHttpLoginUrl = var_0_0.LOGIN_ZH_PRE_BACKUP_INTERNET,
				fileServerUrl = var_0_0.FILE_SERVER_URL_CN
			}
		},
		xm = {
			default = {
				hotUpdateAppCode = "sxcx-gp-sm",
				httpLoginUrl = var_0_0.LOGIN_XM_FORMAL_INTERNET,
				reviewHttpLoginUrl = var_0_0.LOGIN_XM_FORMAL_INTERNET,
				backupHttpLoginUrl = var_0_0.LOGIN_XM_BACKUP_INTERNET,
				hotUpdateInfoUrl = var_0_0.HOTUPDATE_XM_FORMAL_INTERNET,
				noticeUrl = var_0_0.NOTICE_XM_FORMAL,
				feedbackUrl = var_0_0.FEEDBACK_XM_FORMAL,
				fileServerUrl = var_0_0.FILE_SERVER_URL
			},
			[ServerType.LOGIN_INTRANET_DEV] = {
				httpLoginUrl = var_0_0.LOGIN_INTRANET_XM,
				reviewHttpLoginUrl = var_0_0.LOGIN_INTRANET_XM,
				backupHttpLoginUrl = var_0_0.LOGIN_INTRANET_XM,
				hotUpdateInfoUrl = var_0_0.HOTUPDATE_XM_TEST_INTERNET,
				noticeUrl = var_0_0.NOTICE_ZH_TEST,
				feedbackUrl = var_0_0.FEEDBACK_XM_TEST
			},
			[ServerType.LOGIN_INTERNET_FORMAL] = {
				httpLoginUrl = var_0_0.LOGIN_XM_FORMAL_INTERNET
			}
		}
	}
}
