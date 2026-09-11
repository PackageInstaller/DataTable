return {
	Play100011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 100011001
		arg_1_1.duration_ = 4.95

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play100011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v0_prologue", "bgm_story_v0_prologue", "bgm_story_v0_prologue")

				local var_4_2 = manager.audio:GetAudioName("bgm_story_v0_prologue", "bgm_story_v0_prologue")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_2 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_2

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_2
						arg_1_1.bgmTxt2_.text = var_4_2
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_4_3 = "STblack"

			if arg_1_1.bgs_.STblack == nil then
				local var_4_4 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_3)
				var_4_4.name = var_4_3
				var_4_4.transform.parent = arg_1_1.stage_.transform
				var_4_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_3] = var_4_4
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_5 = arg_1_1.bgs_.STblack

				arg_1_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = 2 * (var_4_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_5.transform.localScale = Vector3.New(var_4_7 / var_4_6.sprite.bounds.size.y < var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x and var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x or var_4_7 / var_4_6.sprite.bounds.size.y, var_4_7 / var_4_6.sprite.bounds.size.y < var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x and var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x or var_4_7 / var_4_6.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_8 = "S0018"

			if arg_1_1.bgs_.S0018 == nil then
				local var_4_9 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_9:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_8)
				var_4_9.name = var_4_8
				var_4_9.transform.parent = arg_1_1.stage_.transform
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_8] = var_4_9
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_10 = arg_1_1.bgs_.S0018:GetComponent("SpriteRenderer")

				if var_4_10 then
					arg_1_1.var_.alphaOldValueS0018 = var_4_10.color.a
					arg_1_1.var_.alphaMatValueS0018 = var_4_10
				end

				arg_1_1.var_.alphaOldValueS0018 = 0
			end

			local var_4_11 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_11 then
				if arg_1_1.var_.alphaMatValueS0018 then
					arg_1_1.var_.alphaMatValueS0018.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueS0018, 1, (arg_1_1.time_ - 0) / var_4_11)
					arg_1_1.var_.alphaMatValueS0018.color = arg_1_1.var_.alphaMatValueS0018.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_11 and arg_1_1.time_ < 0 + var_4_11 + arg_4_0 and arg_1_1.var_.alphaMatValueS0018 then
				arg_1_1.var_.alphaMatValueS0018.color.a = 1
				arg_1_1.var_.alphaMatValueS0018.color = arg_1_1.var_.alphaMatValueS0018.color
			end

			local var_4_12 = 0
			local var_4_13 = manager.audio:GetVoiceLength("story_v_out_100011", "100011001", "story_v_out_100011.awb") / 1000

			if var_4_13 > 0 and 4.95 < var_4_13 and var_4_13 + var_4_12 > arg_1_1.duration_ then
				arg_1_1.duration_ = var_4_13 + var_4_12
			end

			if var_4_12 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				arg_1_1:AudioAction("play", "voice", "story_v_out_100011", "100011001", "story_v_out_100011.awb")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_15 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_16 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_17 = var_4_15:GetComponent("RectTransform")

				var_4_15:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleLeft
				var_4_17.offsetMin = Vector2.New(400, 105)
				var_4_17.offsetMax = Vector2.New(-400, -200)
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0
				arg_1_1.fswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(100011001).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_18 = 0.100000001490116

			if 0.100000001490116 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_19 = 28
			local var_4_20 = 1.86666666666667
			local var_4_21, var_4_22 = arg_1_1:GetPercentByPara(arg_1_1:FormatText(arg_1_1:GetWordFromCfg(100011001).content), 1)

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_23 = var_4_19 <= 0 and var_4_20 or var_4_20 * ((var_4_22 - arg_1_1.typewritterCharCountI18N) / var_4_19)

				if (var_4_19 <= 0 and var_4_20 or var_4_20 * ((var_4_22 - arg_1_1.typewritterCharCountI18N) / var_4_19)) > 0 and var_4_20 < var_4_23 then
					arg_1_1.talkMaxDuration = var_4_23

					if var_4_23 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_18
					end
				end
			end

			local var_4_24 = math.max(1.86666666666667, arg_1_1.talkMaxDuration)

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_24 then
				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_21, (arg_1_1.time_ - var_4_18) / var_4_24)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_18 + var_4_24 and arg_1_1.time_ < var_4_18 + var_4_24 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_21

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_22
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play100011002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 100011002
		arg_6_1.duration_ = 21.17

		local var_6_0 = {
			ja = 21.166,
			ko = 14.766,
			zh = 16.166,
			en = 17.4
		}
		local var_6_1 = manager.audio:GetLocalizationFlag()

		if var_6_0[var_6_1] ~= nil then
			arg_6_1.duration_ = var_6_0[var_6_1]
		end

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play100011003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			if arg_6_1.bgs_.S0015 == nil then
				local var_9_0 = Object.Instantiate(arg_6_1.paintGo_)

				var_9_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0015")
				var_9_0.name = "S0015"
				var_9_0.transform.parent = arg_6_1.stage_.transform
				var_9_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_6_1.bgs_.S0015 = var_9_0
			end

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				local var_9_1 = arg_6_1.bgs_.S0015

				arg_6_1.bgs_.S0015.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_9_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_9_2 = var_9_1:GetComponent("SpriteRenderer")

				if var_9_2 and var_9_2.sprite then
					local var_9_3 = 2 * (var_9_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_9_1.transform.localScale = Vector3.New(var_9_3 / var_9_2.sprite.bounds.size.y < var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x and var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x or var_9_3 / var_9_2.sprite.bounds.size.y, var_9_3 / var_9_2.sprite.bounds.size.y < var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x and var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x or var_9_3 / var_9_2.sprite.bounds.size.y, 0)
				end

				for iter_9_0, iter_9_1 in pairs(arg_6_1.bgs_) do
					if iter_9_0 ~= "S0015" then
						iter_9_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				arg_6_1.fswbg_:SetActive(false)
				arg_6_1.dialog_:SetActive(true)
				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				local var_9_4 = arg_6_1.bgs_.S0015:GetComponent("SpriteRenderer")

				if var_9_4 then
					arg_6_1.var_.alphaOldValueS0015 = var_9_4.color.a
					arg_6_1.var_.alphaMatValueS0015 = var_9_4
				end

				arg_6_1.var_.alphaOldValueS0015 = 0
			end

			local var_9_5 = 1.5

			if 0 <= arg_6_1.time_ and arg_6_1.time_ < 0 + var_9_5 then
				if arg_6_1.var_.alphaMatValueS0015 then
					arg_6_1.var_.alphaMatValueS0015.color.a = Mathf.Lerp(arg_6_1.var_.alphaOldValueS0015, 1, (arg_6_1.time_ - 0) / var_9_5)
					arg_6_1.var_.alphaMatValueS0015.color = arg_6_1.var_.alphaMatValueS0015.color
				end
			end

			if arg_6_1.time_ >= 0 + var_9_5 and arg_6_1.time_ < 0 + var_9_5 + arg_9_0 and arg_6_1.var_.alphaMatValueS0015 then
				arg_6_1.var_.alphaMatValueS0015.color.a = 1
				arg_6_1.var_.alphaMatValueS0015.color = arg_6_1.var_.alphaMatValueS0015.color
			end

			local var_9_6 = arg_6_1.bgs_.S0015.transform

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				arg_6_1.var_.moveOldPosS0015 = var_9_6.localPosition
			end

			local var_9_7 = 3

			if 0 <= arg_6_1.time_ and arg_6_1.time_ < 0 + var_9_7 then
				var_9_6.localPosition = Vector3.Lerp(arg_6_1.var_.moveOldPosS0015, Vector3.New(0, 1, 8), (arg_6_1.time_ - 0) / var_9_7)
			end

			if arg_6_1.time_ >= 0 + var_9_7 and arg_6_1.time_ < 0 + var_9_7 + arg_9_0 then
				var_9_6.localPosition = Vector3.New(0, 1, 8)
			end

			local var_9_8 = 0

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_8 + arg_9_0 then
				arg_6_1.allBtn_.enabled = false
			end

			if arg_6_1.time_ >= var_9_8 + 1.5 and arg_6_1.time_ < var_9_8 + 1.5 + arg_9_0 then
				arg_6_1.allBtn_.enabled = true
			end

			if arg_6_1.frameCnt_ <= 1 then
				arg_6_1.dialog_:SetActive(false)
			end

			local var_9_9 = 1.5
			local var_9_10 = 1.5

			if 1.5 < arg_6_1.time_ and arg_6_1.time_ <= var_9_9 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				arg_6_1.dialog_:SetActive(true)

				arg_6_1.dialogCg_.alpha = 0

				local var_9_11 = LeanTween.value(arg_6_1.dialog_, 0, 1, 0.3)

				var_9_11:setOnUpdate(LuaHelper.FloatAction(function(arg_10_0)
					arg_6_1.dialogCg_.alpha = arg_10_0
				end))
				var_9_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_6_1.dialog_)
					var_9_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_6_1.duration_ = arg_6_1.duration_ + 0.3

				SetActive(arg_6_1.leftNameGo_, false)

				arg_6_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_6_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_6_1:RecordName(arg_6_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_6_1.iconTrs_.gameObject, false)
				arg_6_1.callingController_:SetSelectedState("normal")

				local var_9_12 = arg_6_1:GetWordFromCfg(100011002)
				local var_9_13 = arg_6_1:FormatText(var_9_12.content)

				arg_6_1.text_.text = var_9_13

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.text_)

				local var_9_15 = 60 <= 0 and var_9_10 or var_9_10 * (utf8.len(var_9_13) / 60)

				if (60 <= 0 and var_9_10 or var_9_10 * (utf8.len(var_9_13) / 60)) > 0 and var_9_10 < var_9_15 then
					arg_6_1.talkMaxDuration = var_9_15
					var_9_9 = var_9_9 + 0.3

					if var_9_15 + var_9_9 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_15 + var_9_9
					end
				end

				arg_6_1.text_.text = var_9_13
				arg_6_1.typewritter.percent = 0

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011002", "story_v_out_100011.awb") ~= 0 then
					local var_9_16 = manager.audio:GetVoiceLength("story_v_out_100011", "100011002", "story_v_out_100011.awb") / 1000

					if var_9_16 + var_9_9 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_16 + var_9_9
					end

					if var_9_12.prefab_name ~= "" and arg_6_1.actors_[var_9_12.prefab_name] ~= nil then
						local var_9_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_6_1.actors_[var_9_12.prefab_name].transform, "story_v_out_100011", "100011002", "story_v_out_100011.awb")

						arg_6_1:RecordAudio("100011002", var_9_17)
						arg_6_1:RecordAudio("100011002", var_9_17)
					else
						arg_6_1:AudioAction("play", "voice", "story_v_out_100011", "100011002", "story_v_out_100011.awb")
					end

					arg_6_1:RecordHistoryTalkVoice("story_v_out_100011", "100011002", "story_v_out_100011.awb")
				end

				arg_6_1:RecordContent((string.gsub(var_9_13, "「盖亚」", "「盖亚」(Geyser宇宙)")))
			end

			local var_9_18 = var_9_9 + 0.3
			local var_9_19 = math.max(var_9_10, arg_6_1.talkMaxDuration)

			if var_9_9 + 0.3 <= arg_6_1.time_ and arg_6_1.time_ < var_9_18 + var_9_19 then
				arg_6_1.typewritter.percent = (arg_6_1.time_ - var_9_18) / var_9_19

				arg_6_1.typewritter:SetDirty()
			end

			if arg_6_1.time_ >= var_9_18 + var_9_19 and arg_6_1.time_ < var_9_18 + var_9_19 + arg_9_0 then
				arg_6_1.typewritter.percent = 1

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(true)
			end
		end

		arg_6_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_6_1:InitPlayNodeList()
	end,
	Play100011003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 100011003
		arg_12_1.duration_ = 23.33

		local var_12_0 = {
			ja = 23.333,
			ko = 16.7,
			zh = 15.066,
			en = 19.766
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play100011004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0.967 < arg_12_1.time_ and arg_12_1.time_ <= 0.967 + arg_15_0 then
				arg_12_1.var_.moveOldPosS0015 = arg_12_1.bgs_.S0015.transform.localPosition
			end

			local var_15_0 = 0.001

			if 0.967 <= arg_12_1.time_ and arg_12_1.time_ < 0.967 + var_15_0 then
				arg_12_1.bgs_.S0015.transform.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPosS0015, Vector3.New(0, -100, 10), (arg_12_1.time_ - 0.967) / var_15_0)
			end

			if arg_12_1.time_ >= 0.967 + var_15_0 and arg_12_1.time_ < 0.967 + var_15_0 + arg_15_0 then
				arg_12_1.bgs_.S0015.transform.localPosition = Vector3.New(0, -100, 10)
			end

			local var_15_1 = "S0011"

			if arg_12_1.bgs_.S0011 == nil then
				local var_15_2 = Object.Instantiate(arg_12_1.paintGo_)

				var_15_2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_15_1)
				var_15_2.name = var_15_1
				var_15_2.transform.parent = arg_12_1.stage_.transform
				var_15_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.bgs_[var_15_1] = var_15_2
			end

			if 1 < arg_12_1.time_ and arg_12_1.time_ <= 1 + arg_15_0 then
				local var_15_3 = arg_12_1.bgs_.S0011

				arg_12_1.bgs_.S0011.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_15_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_15_4 = var_15_3:GetComponent("SpriteRenderer")

				if var_15_4 and var_15_4.sprite then
					local var_15_5 = 2 * (var_15_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_15_3.transform.localScale = Vector3.New(var_15_5 / var_15_4.sprite.bounds.size.y < var_15_5 * manager.ui.mainCameraCom_.aspect / var_15_4.sprite.bounds.size.x and var_15_5 * manager.ui.mainCameraCom_.aspect / var_15_4.sprite.bounds.size.x or var_15_5 / var_15_4.sprite.bounds.size.y, var_15_5 / var_15_4.sprite.bounds.size.y < var_15_5 * manager.ui.mainCameraCom_.aspect / var_15_4.sprite.bounds.size.x and var_15_5 * manager.ui.mainCameraCom_.aspect / var_15_4.sprite.bounds.size.x or var_15_5 / var_15_4.sprite.bounds.size.y, 0)
				end

				for iter_15_0, iter_15_1 in pairs(arg_12_1.bgs_) do
					if iter_15_0 ~= "S0011" then
						iter_15_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				local var_15_6 = arg_12_1.bgs_.S0015:GetComponent("SpriteRenderer")

				if var_15_6 then
					arg_12_1.var_.alphaOldValueS0015 = var_15_6.color.a
					arg_12_1.var_.alphaMatValueS0015 = var_15_6
				end

				arg_12_1.var_.alphaOldValueS0015 = 1
			end

			local var_15_7 = 1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 then
				if arg_12_1.var_.alphaMatValueS0015 then
					arg_12_1.var_.alphaMatValueS0015.color.a = Mathf.Lerp(arg_12_1.var_.alphaOldValueS0015, 0, (arg_12_1.time_ - 0) / var_15_7)
					arg_12_1.var_.alphaMatValueS0015.color = arg_12_1.var_.alphaMatValueS0015.color
				end
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 and arg_12_1.var_.alphaMatValueS0015 then
				arg_12_1.var_.alphaMatValueS0015.color.a = 0
				arg_12_1.var_.alphaMatValueS0015.color = arg_12_1.var_.alphaMatValueS0015.color
			end

			if 1 < arg_12_1.time_ and arg_12_1.time_ <= 1 + arg_15_0 then
				local var_15_8 = arg_12_1.bgs_.S0011:GetComponent("SpriteRenderer")

				if var_15_8 then
					arg_12_1.var_.alphaOldValueS0011 = var_15_8.color.a
					arg_12_1.var_.alphaMatValueS0011 = var_15_8
				end

				arg_12_1.var_.alphaOldValueS0011 = 0
			end

			local var_15_9 = 1.5

			if 1 <= arg_12_1.time_ and arg_12_1.time_ < 1 + var_15_9 then
				if arg_12_1.var_.alphaMatValueS0011 then
					arg_12_1.var_.alphaMatValueS0011.color.a = Mathf.Lerp(arg_12_1.var_.alphaOldValueS0011, 1, (arg_12_1.time_ - 1) / var_15_9)
					arg_12_1.var_.alphaMatValueS0011.color = arg_12_1.var_.alphaMatValueS0011.color
				end
			end

			if arg_12_1.time_ >= 1 + var_15_9 and arg_12_1.time_ < 1 + var_15_9 + arg_15_0 and arg_12_1.var_.alphaMatValueS0011 then
				arg_12_1.var_.alphaMatValueS0011.color.a = 1
				arg_12_1.var_.alphaMatValueS0011.color = arg_12_1.var_.alphaMatValueS0011.color
			end

			local var_15_10 = arg_12_1.bgs_.S0011.transform

			if 1 < arg_12_1.time_ and arg_12_1.time_ <= 1 + arg_15_0 then
				arg_12_1.var_.moveOldPosS0011 = var_15_10.localPosition
			end

			local var_15_11 = 3.075

			if 1 <= arg_12_1.time_ and arg_12_1.time_ < 1 + var_15_11 then
				var_15_10.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPosS0011, Vector3.New(0, 1, 9), (arg_12_1.time_ - 1) / var_15_11)
			end

			if arg_12_1.time_ >= 1 + var_15_11 and arg_12_1.time_ < 1 + var_15_11 + arg_15_0 then
				var_15_10.localPosition = Vector3.New(0, 1, 9)
			end

			local var_15_12 = 0

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_12 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			if arg_12_1.time_ >= var_15_12 + 2.5 and arg_12_1.time_ < var_15_12 + 2.5 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end

			if arg_12_1.frameCnt_ <= 1 then
				arg_12_1.dialog_:SetActive(false)
			end

			local var_15_13 = 2.5
			local var_15_14 = 1.575

			if 2.5 < arg_12_1.time_ and arg_12_1.time_ <= var_15_13 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				arg_12_1.dialog_:SetActive(true)

				arg_12_1.dialogCg_.alpha = 0

				local var_15_15 = LeanTween.value(arg_12_1.dialog_, 0, 1, 0.3)

				var_15_15:setOnUpdate(LuaHelper.FloatAction(function(arg_16_0)
					arg_12_1.dialogCg_.alpha = arg_16_0
				end))
				var_15_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_12_1.dialog_)
					var_15_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_12_1.duration_ = arg_12_1.duration_ + 0.3

				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_16 = arg_12_1:GetWordFromCfg(100011003)
				local var_15_17 = arg_12_1:FormatText(var_15_16.content)

				arg_12_1.text_.text = var_15_17

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_19 = 64 <= 0 and var_15_14 or var_15_14 * (utf8.len(var_15_17) / 64)

				if (64 <= 0 and var_15_14 or var_15_14 * (utf8.len(var_15_17) / 64)) > 0 and var_15_14 < var_15_19 then
					arg_12_1.talkMaxDuration = var_15_19
					var_15_13 = var_15_13 + 0.3

					if var_15_19 + var_15_13 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_19 + var_15_13
					end
				end

				arg_12_1.text_.text = var_15_17
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011003", "story_v_out_100011.awb") ~= 0 then
					local var_15_20 = manager.audio:GetVoiceLength("story_v_out_100011", "100011003", "story_v_out_100011.awb") / 1000

					if var_15_20 + var_15_13 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_20 + var_15_13
					end

					if var_15_16.prefab_name ~= "" and arg_12_1.actors_[var_15_16.prefab_name] ~= nil then
						local var_15_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_16.prefab_name].transform, "story_v_out_100011", "100011003", "story_v_out_100011.awb")

						arg_12_1:RecordAudio("100011003", var_15_21)
						arg_12_1:RecordAudio("100011003", var_15_21)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_100011", "100011003", "story_v_out_100011.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_100011", "100011003", "story_v_out_100011.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_22 = var_15_13 + 0.3
			local var_15_23 = math.max(var_15_14, arg_12_1.talkMaxDuration)

			if var_15_13 + 0.3 <= arg_12_1.time_ and arg_12_1.time_ < var_15_22 + var_15_23 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_22) / var_15_23

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_22 + var_15_23 and arg_12_1.time_ < var_15_22 + var_15_23 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0.967,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0011",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.075,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play100011004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 100011004
		arg_18_1.duration_ = 21.1

		local var_18_0 = {
			ja = 21.1,
			ko = 14.933,
			zh = 16.366,
			en = 18.233
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play100011005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 1 < arg_18_1.time_ and arg_18_1.time_ <= 1 + arg_21_0 then
				arg_18_1.var_.moveOldPosS0011 = arg_18_1.bgs_.S0011.transform.localPosition
			end

			local var_21_0 = 0.001

			if 1 <= arg_18_1.time_ and arg_18_1.time_ < 1 + var_21_0 then
				arg_18_1.bgs_.S0011.transform.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPosS0011, Vector3.New(0, -100, 10), (arg_18_1.time_ - 1) / var_21_0)
			end

			if arg_18_1.time_ >= 1 + var_21_0 and arg_18_1.time_ < 1 + var_21_0 + arg_21_0 then
				arg_18_1.bgs_.S0011.transform.localPosition = Vector3.New(0, -100, 10)
			end

			local var_21_1 = "S0012"

			if arg_18_1.bgs_.S0012 == nil then
				local var_21_2 = Object.Instantiate(arg_18_1.paintGo_)

				var_21_2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_21_1)
				var_21_2.name = var_21_1
				var_21_2.transform.parent = arg_18_1.stage_.transform
				var_21_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_18_1.bgs_[var_21_1] = var_21_2
			end

			if 1 < arg_18_1.time_ and arg_18_1.time_ <= 1 + arg_21_0 then
				local var_21_3 = arg_18_1.bgs_.S0012

				arg_18_1.bgs_.S0012.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_21_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_21_4 = var_21_3:GetComponent("SpriteRenderer")

				if var_21_4 and var_21_4.sprite then
					local var_21_5 = 2 * (var_21_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_21_3.transform.localScale = Vector3.New(var_21_5 / var_21_4.sprite.bounds.size.y < var_21_5 * manager.ui.mainCameraCom_.aspect / var_21_4.sprite.bounds.size.x and var_21_5 * manager.ui.mainCameraCom_.aspect / var_21_4.sprite.bounds.size.x or var_21_5 / var_21_4.sprite.bounds.size.y, var_21_5 / var_21_4.sprite.bounds.size.y < var_21_5 * manager.ui.mainCameraCom_.aspect / var_21_4.sprite.bounds.size.x and var_21_5 * manager.ui.mainCameraCom_.aspect / var_21_4.sprite.bounds.size.x or var_21_5 / var_21_4.sprite.bounds.size.y, 0)
				end

				for iter_21_0, iter_21_1 in pairs(arg_18_1.bgs_) do
					if iter_21_0 ~= "S0012" then
						iter_21_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				local var_21_6 = arg_18_1.bgs_.S0011:GetComponent("SpriteRenderer")

				if var_21_6 then
					arg_18_1.var_.alphaOldValueS0011 = var_21_6.color.a
					arg_18_1.var_.alphaMatValueS0011 = var_21_6
				end

				arg_18_1.var_.alphaOldValueS0011 = 1
			end

			local var_21_7 = 1

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_7 then
				if arg_18_1.var_.alphaMatValueS0011 then
					arg_18_1.var_.alphaMatValueS0011.color.a = Mathf.Lerp(arg_18_1.var_.alphaOldValueS0011, 0, (arg_18_1.time_ - 0) / var_21_7)
					arg_18_1.var_.alphaMatValueS0011.color = arg_18_1.var_.alphaMatValueS0011.color
				end
			end

			if arg_18_1.time_ >= 0 + var_21_7 and arg_18_1.time_ < 0 + var_21_7 + arg_21_0 and arg_18_1.var_.alphaMatValueS0011 then
				arg_18_1.var_.alphaMatValueS0011.color.a = 0
				arg_18_1.var_.alphaMatValueS0011.color = arg_18_1.var_.alphaMatValueS0011.color
			end

			if 1 < arg_18_1.time_ and arg_18_1.time_ <= 1 + arg_21_0 then
				local var_21_8 = arg_18_1.bgs_.S0012:GetComponent("SpriteRenderer")

				if var_21_8 then
					arg_18_1.var_.alphaOldValueS0012 = var_21_8.color.a
					arg_18_1.var_.alphaMatValueS0012 = var_21_8
				end

				arg_18_1.var_.alphaOldValueS0012 = 0
			end

			local var_21_9 = 1.5

			if 1 <= arg_18_1.time_ and arg_18_1.time_ < 1 + var_21_9 then
				if arg_18_1.var_.alphaMatValueS0012 then
					arg_18_1.var_.alphaMatValueS0012.color.a = Mathf.Lerp(arg_18_1.var_.alphaOldValueS0012, 1, (arg_18_1.time_ - 1) / var_21_9)
					arg_18_1.var_.alphaMatValueS0012.color = arg_18_1.var_.alphaMatValueS0012.color
				end
			end

			if arg_18_1.time_ >= 1 + var_21_9 and arg_18_1.time_ < 1 + var_21_9 + arg_21_0 and arg_18_1.var_.alphaMatValueS0012 then
				arg_18_1.var_.alphaMatValueS0012.color.a = 1
				arg_18_1.var_.alphaMatValueS0012.color = arg_18_1.var_.alphaMatValueS0012.color
			end

			local var_21_10 = arg_18_1.bgs_.S0012.transform

			if 1 < arg_18_1.time_ and arg_18_1.time_ <= 1 + arg_21_0 then
				arg_18_1.var_.moveOldPosS0012 = var_21_10.localPosition
			end

			local var_21_11 = 3.65

			if 1 <= arg_18_1.time_ and arg_18_1.time_ < 1 + var_21_11 then
				var_21_10.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPosS0012, Vector3.New(0, 1, 8), (arg_18_1.time_ - 1) / var_21_11)
			end

			if arg_18_1.time_ >= 1 + var_21_11 and arg_18_1.time_ < 1 + var_21_11 + arg_21_0 then
				var_21_10.localPosition = Vector3.New(0, 1, 8)
			end

			local var_21_12 = 0

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_12 + arg_21_0 then
				arg_18_1.allBtn_.enabled = false
			end

			if arg_18_1.time_ >= var_21_12 + 2.5 and arg_18_1.time_ < var_21_12 + 2.5 + arg_21_0 then
				arg_18_1.allBtn_.enabled = true
			end

			if arg_18_1.frameCnt_ <= 1 then
				arg_18_1.dialog_:SetActive(false)
			end

			local var_21_13 = 2.5
			local var_21_14 = 2.15

			if 2.5 < arg_18_1.time_ and arg_18_1.time_ <= var_21_13 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0

				arg_18_1.dialog_:SetActive(true)

				arg_18_1.dialogCg_.alpha = 0

				local var_21_15 = LeanTween.value(arg_18_1.dialog_, 0, 1, 0.3)

				var_21_15:setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
					arg_18_1.dialogCg_.alpha = arg_22_0
				end))
				var_21_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_18_1.dialog_)
					var_21_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_18_1.duration_ = arg_18_1.duration_ + 0.3

				SetActive(arg_18_1.leftNameGo_, false)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_16 = arg_18_1:GetWordFromCfg(100011004)
				local var_21_17 = arg_18_1:FormatText(var_21_16.content)

				arg_18_1.text_.text = var_21_17

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_19 = 61 <= 0 and var_21_14 or var_21_14 * (utf8.len(var_21_17) / 61)

				if (61 <= 0 and var_21_14 or var_21_14 * (utf8.len(var_21_17) / 61)) > 0 and var_21_14 < var_21_19 then
					arg_18_1.talkMaxDuration = var_21_19
					var_21_13 = var_21_13 + 0.3

					if var_21_19 + var_21_13 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_19 + var_21_13
					end
				end

				arg_18_1.text_.text = var_21_17
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011004", "story_v_out_100011.awb") ~= 0 then
					local var_21_20 = manager.audio:GetVoiceLength("story_v_out_100011", "100011004", "story_v_out_100011.awb") / 1000

					if var_21_20 + var_21_13 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_20 + var_21_13
					end

					if var_21_16.prefab_name ~= "" and arg_18_1.actors_[var_21_16.prefab_name] ~= nil then
						local var_21_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_16.prefab_name].transform, "story_v_out_100011", "100011004", "story_v_out_100011.awb")

						arg_18_1:RecordAudio("100011004", var_21_21)
						arg_18_1:RecordAudio("100011004", var_21_21)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_100011", "100011004", "story_v_out_100011.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_100011", "100011004", "story_v_out_100011.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_22 = var_21_13 + 0.3
			local var_21_23 = math.max(var_21_14, arg_18_1.talkMaxDuration)

			if var_21_13 + 0.3 <= arg_18_1.time_ and arg_18_1.time_ < var_21_22 + var_21_23 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_22) / var_21_23

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_22 + var_21_23 and arg_18_1.time_ < var_21_22 + var_21_23 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0011",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.65,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play100011005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 100011005
		arg_24_1.duration_ = 6.43

		local var_24_0 = {
			ja = 6.433,
			ko = 4.233,
			zh = 4.666,
			en = 3.766
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play100011006(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 1.075

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0

				arg_24_1.dialog_:SetActive(true)

				arg_24_1.dialogCg_.alpha = 0

				local var_27_2 = LeanTween.value(arg_24_1.dialog_, 0, 1, 0.3)

				var_27_2:setOnUpdate(LuaHelper.FloatAction(function(arg_28_0)
					arg_24_1.dialogCg_.alpha = arg_28_0
				end))
				var_27_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_24_1.dialog_)
					var_27_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_24_1.duration_ = arg_24_1.duration_ + 0.3

				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_3 = arg_24_1:GetWordFromCfg(100011005)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_6 = 19 <= 0 and var_27_1 or var_27_1 * (utf8.len(var_27_4) / 19)

				if (19 <= 0 and var_27_1 or var_27_1 * (utf8.len(var_27_4) / 19)) > 0 and var_27_1 < var_27_6 then
					arg_24_1.talkMaxDuration = var_27_6
					var_27_0 = var_27_0 + 0.3

					if var_27_6 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011005", "story_v_out_100011.awb") ~= 0 then
					local var_27_7 = manager.audio:GetVoiceLength("story_v_out_100011", "100011005", "story_v_out_100011.awb") / 1000

					if var_27_7 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_0
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_100011", "100011005", "story_v_out_100011.awb")

						arg_24_1:RecordAudio("100011005", var_27_8)
						arg_24_1:RecordAudio("100011005", var_27_8)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_100011", "100011005", "story_v_out_100011.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_100011", "100011005", "story_v_out_100011.awb")
				end

				arg_24_1:RecordContent((string.gsub(var_27_4, "「视骸」", "「视骸」(BUG)")))
			end

			local var_27_9 = var_27_0 + 0.3
			local var_27_10 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 + 0.3 <= arg_24_1.time_ and arg_24_1.time_ < var_27_9 + var_27_10 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_9) / var_27_10

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_9 + var_27_10 and arg_24_1.time_ < var_27_9 + var_27_10 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play100011006 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 100011006
		arg_30_1.duration_ = 16.47

		local var_30_0 = {
			ja = 16.466,
			ko = 13.766,
			zh = 10.833,
			en = 14.533
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play100011007(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 1 < arg_30_1.time_ and arg_30_1.time_ <= 1 + arg_33_0 then
				arg_30_1.var_.moveOldPosS0012 = arg_30_1.bgs_.S0012.transform.localPosition
			end

			local var_33_0 = 0.001

			if 1 <= arg_30_1.time_ and arg_30_1.time_ < 1 + var_33_0 then
				arg_30_1.bgs_.S0012.transform.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPosS0012, Vector3.New(0, -100, 10), (arg_30_1.time_ - 1) / var_33_0)
			end

			if arg_30_1.time_ >= 1 + var_33_0 and arg_30_1.time_ < 1 + var_33_0 + arg_33_0 then
				arg_30_1.bgs_.S0012.transform.localPosition = Vector3.New(0, -100, 10)
			end

			local var_33_1 = "S0016"

			if arg_30_1.bgs_.S0016 == nil then
				local var_33_2 = Object.Instantiate(arg_30_1.paintGo_)

				var_33_2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_33_1)
				var_33_2.name = var_33_1
				var_33_2.transform.parent = arg_30_1.stage_.transform
				var_33_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_30_1.bgs_[var_33_1] = var_33_2
			end

			if 1 < arg_30_1.time_ and arg_30_1.time_ <= 1 + arg_33_0 then
				local var_33_3 = arg_30_1.bgs_.S0016

				arg_30_1.bgs_.S0016.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_33_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_33_4 = var_33_3:GetComponent("SpriteRenderer")

				if var_33_4 and var_33_4.sprite then
					local var_33_5 = 2 * (var_33_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_33_3.transform.localScale = Vector3.New(var_33_5 / var_33_4.sprite.bounds.size.y < var_33_5 * manager.ui.mainCameraCom_.aspect / var_33_4.sprite.bounds.size.x and var_33_5 * manager.ui.mainCameraCom_.aspect / var_33_4.sprite.bounds.size.x or var_33_5 / var_33_4.sprite.bounds.size.y, var_33_5 / var_33_4.sprite.bounds.size.y < var_33_5 * manager.ui.mainCameraCom_.aspect / var_33_4.sprite.bounds.size.x and var_33_5 * manager.ui.mainCameraCom_.aspect / var_33_4.sprite.bounds.size.x or var_33_5 / var_33_4.sprite.bounds.size.y, 0)
				end

				for iter_33_0, iter_33_1 in pairs(arg_30_1.bgs_) do
					if iter_33_0 ~= "S0016" then
						iter_33_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				local var_33_6 = arg_30_1.bgs_.S0012:GetComponent("SpriteRenderer")

				if var_33_6 then
					arg_30_1.var_.alphaOldValueS0012 = var_33_6.color.a
					arg_30_1.var_.alphaMatValueS0012 = var_33_6
				end

				arg_30_1.var_.alphaOldValueS0012 = 1
			end

			local var_33_7 = 1

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_7 then
				if arg_30_1.var_.alphaMatValueS0012 then
					arg_30_1.var_.alphaMatValueS0012.color.a = Mathf.Lerp(arg_30_1.var_.alphaOldValueS0012, 0, (arg_30_1.time_ - 0) / var_33_7)
					arg_30_1.var_.alphaMatValueS0012.color = arg_30_1.var_.alphaMatValueS0012.color
				end
			end

			if arg_30_1.time_ >= 0 + var_33_7 and arg_30_1.time_ < 0 + var_33_7 + arg_33_0 and arg_30_1.var_.alphaMatValueS0012 then
				arg_30_1.var_.alphaMatValueS0012.color.a = 0
				arg_30_1.var_.alphaMatValueS0012.color = arg_30_1.var_.alphaMatValueS0012.color
			end

			if 1 < arg_30_1.time_ and arg_30_1.time_ <= 1 + arg_33_0 then
				local var_33_8 = arg_30_1.bgs_.S0016:GetComponent("SpriteRenderer")

				if var_33_8 then
					arg_30_1.var_.alphaOldValueS0016 = var_33_8.color.a
					arg_30_1.var_.alphaMatValueS0016 = var_33_8
				end

				arg_30_1.var_.alphaOldValueS0016 = 0
			end

			local var_33_9 = 1.5

			if 1 <= arg_30_1.time_ and arg_30_1.time_ < 1 + var_33_9 then
				if arg_30_1.var_.alphaMatValueS0016 then
					arg_30_1.var_.alphaMatValueS0016.color.a = Mathf.Lerp(arg_30_1.var_.alphaOldValueS0016, 1, (arg_30_1.time_ - 1) / var_33_9)
					arg_30_1.var_.alphaMatValueS0016.color = arg_30_1.var_.alphaMatValueS0016.color
				end
			end

			if arg_30_1.time_ >= 1 + var_33_9 and arg_30_1.time_ < 1 + var_33_9 + arg_33_0 and arg_30_1.var_.alphaMatValueS0016 then
				arg_30_1.var_.alphaMatValueS0016.color.a = 1
				arg_30_1.var_.alphaMatValueS0016.color = arg_30_1.var_.alphaMatValueS0016.color
			end

			local var_33_10 = arg_30_1.bgs_.S0016.transform

			if 1.73333333333333 < arg_30_1.time_ and arg_30_1.time_ <= 1.73333333333333 + arg_33_0 then
				arg_30_1.var_.moveOldPosS0016 = var_33_10.localPosition
			end

			local var_33_11 = 3.3

			if 1.73333333333333 <= arg_30_1.time_ and arg_30_1.time_ < 1.73333333333333 + var_33_11 then
				var_33_10.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPosS0016, Vector3.New(0, 1, 9), (arg_30_1.time_ - 1.73333333333333) / var_33_11)
			end

			if arg_30_1.time_ >= 1.73333333333333 + var_33_11 and arg_30_1.time_ < 1.73333333333333 + var_33_11 + arg_33_0 then
				var_33_10.localPosition = Vector3.New(0, 1, 9)
			end

			local var_33_12 = 0

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_12 + arg_33_0 then
				arg_30_1.allBtn_.enabled = false
			end

			if arg_30_1.time_ >= var_33_12 + 2.5 and arg_30_1.time_ < var_33_12 + 2.5 + arg_33_0 then
				arg_30_1.allBtn_.enabled = true
			end

			if arg_30_1.frameCnt_ <= 1 then
				arg_30_1.dialog_:SetActive(false)
			end

			local var_33_13 = 2.5
			local var_33_14 = 0.975

			if 2.5 < arg_30_1.time_ and arg_30_1.time_ <= var_33_13 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0

				arg_30_1.dialog_:SetActive(true)

				arg_30_1.dialogCg_.alpha = 0

				local var_33_15 = LeanTween.value(arg_30_1.dialog_, 0, 1, 0.3)

				var_33_15:setOnUpdate(LuaHelper.FloatAction(function(arg_34_0)
					arg_30_1.dialogCg_.alpha = arg_34_0
				end))
				var_33_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_30_1.dialog_)
					var_33_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_30_1.duration_ = arg_30_1.duration_ + 0.3

				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_16 = arg_30_1:GetWordFromCfg(100011006)
				local var_33_17 = arg_30_1:FormatText(var_33_16.content)

				arg_30_1.text_.text = var_33_17

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_19 = 43 <= 0 and var_33_14 or var_33_14 * (utf8.len(var_33_17) / 43)

				if (43 <= 0 and var_33_14 or var_33_14 * (utf8.len(var_33_17) / 43)) > 0 and var_33_14 < var_33_19 then
					arg_30_1.talkMaxDuration = var_33_19
					var_33_13 = var_33_13 + 0.3

					if var_33_19 + var_33_13 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_19 + var_33_13
					end
				end

				arg_30_1.text_.text = var_33_17
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011006", "story_v_out_100011.awb") ~= 0 then
					local var_33_20 = manager.audio:GetVoiceLength("story_v_out_100011", "100011006", "story_v_out_100011.awb") / 1000

					if var_33_20 + var_33_13 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_20 + var_33_13
					end

					if var_33_16.prefab_name ~= "" and arg_30_1.actors_[var_33_16.prefab_name] ~= nil then
						local var_33_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_16.prefab_name].transform, "story_v_out_100011", "100011006", "story_v_out_100011.awb")

						arg_30_1:RecordAudio("100011006", var_33_21)
						arg_30_1:RecordAudio("100011006", var_33_21)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_100011", "100011006", "story_v_out_100011.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_100011", "100011006", "story_v_out_100011.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_22 = var_33_13 + 0.3
			local var_33_23 = math.max(var_33_14, arg_30_1.talkMaxDuration)

			if var_33_13 + 0.3 <= arg_30_1.time_ and arg_30_1.time_ < var_33_22 + var_33_23 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_22) / var_33_23

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_22 + var_33_23 and arg_30_1.time_ < var_33_22 + var_33_23 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0016",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.3,
				className = "StoryMoveNode",
				startTime = 1.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_30_1:InitPlayNodeList()
	end,
	Play100011007 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 100011007
		arg_36_1.duration_ = 13.93

		local var_36_0 = {
			ja = 13.933,
			ko = 12.2,
			zh = 10.7,
			en = 12.733
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play100011008(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 1 < arg_36_1.time_ and arg_36_1.time_ <= 1 + arg_39_0 then
				arg_36_1.var_.moveOldPosS0016 = arg_36_1.bgs_.S0016.transform.localPosition
			end

			local var_39_0 = 0.001

			if 1 <= arg_36_1.time_ and arg_36_1.time_ < 1 + var_39_0 then
				arg_36_1.bgs_.S0016.transform.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPosS0016, Vector3.New(0, -100, 10), (arg_36_1.time_ - 1) / var_39_0)
			end

			if arg_36_1.time_ >= 1 + var_39_0 and arg_36_1.time_ < 1 + var_39_0 + arg_39_0 then
				arg_36_1.bgs_.S0016.transform.localPosition = Vector3.New(0, -100, 10)
			end

			local var_39_1 = "S0017"

			if arg_36_1.bgs_.S0017 == nil then
				local var_39_2 = Object.Instantiate(arg_36_1.paintGo_)

				var_39_2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_39_1)
				var_39_2.name = var_39_1
				var_39_2.transform.parent = arg_36_1.stage_.transform
				var_39_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.bgs_[var_39_1] = var_39_2
			end

			if 1 < arg_36_1.time_ and arg_36_1.time_ <= 1 + arg_39_0 then
				local var_39_3 = arg_36_1.bgs_.S0017

				arg_36_1.bgs_.S0017.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_39_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_39_4 = var_39_3:GetComponent("SpriteRenderer")

				if var_39_4 and var_39_4.sprite then
					local var_39_5 = 2 * (var_39_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_39_3.transform.localScale = Vector3.New(var_39_5 / var_39_4.sprite.bounds.size.y < var_39_5 * manager.ui.mainCameraCom_.aspect / var_39_4.sprite.bounds.size.x and var_39_5 * manager.ui.mainCameraCom_.aspect / var_39_4.sprite.bounds.size.x or var_39_5 / var_39_4.sprite.bounds.size.y, var_39_5 / var_39_4.sprite.bounds.size.y < var_39_5 * manager.ui.mainCameraCom_.aspect / var_39_4.sprite.bounds.size.x and var_39_5 * manager.ui.mainCameraCom_.aspect / var_39_4.sprite.bounds.size.x or var_39_5 / var_39_4.sprite.bounds.size.y, 0)
				end

				for iter_39_0, iter_39_1 in pairs(arg_36_1.bgs_) do
					if iter_39_0 ~= "S0017" then
						iter_39_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				local var_39_6 = arg_36_1.bgs_.S0017:GetComponent("SpriteRenderer")

				if var_39_6 then
					arg_36_1.var_.alphaOldValueS0017 = var_39_6.color.a
					arg_36_1.var_.alphaMatValueS0017 = var_39_6
				end

				arg_36_1.var_.alphaOldValueS0017 = 1
			end

			local var_39_7 = 1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_7 then
				if arg_36_1.var_.alphaMatValueS0017 then
					arg_36_1.var_.alphaMatValueS0017.color.a = Mathf.Lerp(arg_36_1.var_.alphaOldValueS0017, 0, (arg_36_1.time_ - 0) / var_39_7)
					arg_36_1.var_.alphaMatValueS0017.color = arg_36_1.var_.alphaMatValueS0017.color
				end
			end

			if arg_36_1.time_ >= 0 + var_39_7 and arg_36_1.time_ < 0 + var_39_7 + arg_39_0 and arg_36_1.var_.alphaMatValueS0017 then
				arg_36_1.var_.alphaMatValueS0017.color.a = 0
				arg_36_1.var_.alphaMatValueS0017.color = arg_36_1.var_.alphaMatValueS0017.color
			end

			if 1 < arg_36_1.time_ and arg_36_1.time_ <= 1 + arg_39_0 then
				local var_39_8 = arg_36_1.bgs_.S0017:GetComponent("SpriteRenderer")

				if var_39_8 then
					arg_36_1.var_.alphaOldValueS0017 = var_39_8.color.a
					arg_36_1.var_.alphaMatValueS0017 = var_39_8
				end

				arg_36_1.var_.alphaOldValueS0017 = 0
			end

			local var_39_9 = 1

			if 1 <= arg_36_1.time_ and arg_36_1.time_ < 1 + var_39_9 then
				if arg_36_1.var_.alphaMatValueS0017 then
					arg_36_1.var_.alphaMatValueS0017.color.a = Mathf.Lerp(arg_36_1.var_.alphaOldValueS0017, 1, (arg_36_1.time_ - 1) / var_39_9)
					arg_36_1.var_.alphaMatValueS0017.color = arg_36_1.var_.alphaMatValueS0017.color
				end
			end

			if arg_36_1.time_ >= 1 + var_39_9 and arg_36_1.time_ < 1 + var_39_9 + arg_39_0 and arg_36_1.var_.alphaMatValueS0017 then
				arg_36_1.var_.alphaMatValueS0017.color.a = 1
				arg_36_1.var_.alphaMatValueS0017.color = arg_36_1.var_.alphaMatValueS0017.color
			end

			local var_39_10 = arg_36_1.bgs_.S0017.transform

			if 1.5 < arg_36_1.time_ and arg_36_1.time_ <= 1.5 + arg_39_0 then
				arg_36_1.var_.moveOldPosS0017 = var_39_10.localPosition
			end

			local var_39_11 = 1.8

			if 1.5 <= arg_36_1.time_ and arg_36_1.time_ < 1.5 + var_39_11 then
				var_39_10.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPosS0017, Vector3.New(0, 1, 9), (arg_36_1.time_ - 1.5) / var_39_11)
			end

			if arg_36_1.time_ >= 1.5 + var_39_11 and arg_36_1.time_ < 1.5 + var_39_11 + arg_39_0 then
				var_39_10.localPosition = Vector3.New(0, 1, 9)
			end

			local var_39_12 = 0

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 then
				arg_36_1.allBtn_.enabled = false
			end

			if arg_36_1.time_ >= var_39_12 + 2 and arg_36_1.time_ < var_39_12 + 2 + arg_39_0 then
				arg_36_1.allBtn_.enabled = true
			end

			if arg_36_1.frameCnt_ <= 1 then
				arg_36_1.dialog_:SetActive(false)
			end

			local var_39_13 = 2
			local var_39_14 = 1.65

			if 2 < arg_36_1.time_ and arg_36_1.time_ <= var_39_13 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0

				arg_36_1.dialog_:SetActive(true)

				arg_36_1.dialogCg_.alpha = 0

				local var_39_15 = LeanTween.value(arg_36_1.dialog_, 0, 1, 0.3)

				var_39_15:setOnUpdate(LuaHelper.FloatAction(function(arg_40_0)
					arg_36_1.dialogCg_.alpha = arg_40_0
				end))
				var_39_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_36_1.dialog_)
					var_39_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_36_1.duration_ = arg_36_1.duration_ + 0.3

				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_16 = arg_36_1:GetWordFromCfg(100011007)
				local var_39_17 = arg_36_1:FormatText(var_39_16.content)

				arg_36_1.text_.text = var_39_17

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_19 = 39 <= 0 and var_39_14 or var_39_14 * (utf8.len(var_39_17) / 39)

				if (39 <= 0 and var_39_14 or var_39_14 * (utf8.len(var_39_17) / 39)) > 0 and var_39_14 < var_39_19 then
					arg_36_1.talkMaxDuration = var_39_19
					var_39_13 = var_39_13 + 0.3

					if var_39_19 + var_39_13 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_19 + var_39_13
					end
				end

				arg_36_1.text_.text = var_39_17
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011007", "story_v_out_100011.awb") ~= 0 then
					local var_39_20 = manager.audio:GetVoiceLength("story_v_out_100011", "100011007", "story_v_out_100011.awb") / 1000

					if var_39_20 + var_39_13 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_20 + var_39_13
					end

					if var_39_16.prefab_name ~= "" and arg_36_1.actors_[var_39_16.prefab_name] ~= nil then
						local var_39_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_16.prefab_name].transform, "story_v_out_100011", "100011007", "story_v_out_100011.awb")

						arg_36_1:RecordAudio("100011007", var_39_21)
						arg_36_1:RecordAudio("100011007", var_39_21)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_100011", "100011007", "story_v_out_100011.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_100011", "100011007", "story_v_out_100011.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_22 = var_39_13 + 0.3
			local var_39_23 = math.max(var_39_14, arg_36_1.talkMaxDuration)

			if var_39_13 + 0.3 <= arg_36_1.time_ and arg_36_1.time_ < var_39_22 + var_39_23 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_22) / var_39_23

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_22 + var_39_23 and arg_36_1.time_ < var_39_22 + var_39_23 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0016",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0017",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.8,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play100011008 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 100011008
		arg_42_1.duration_ = 14.3

		local var_42_0 = {
			ja = 14.3,
			ko = 10.466,
			zh = 10.266,
			en = 11.4
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play100011009(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 1 < arg_42_1.time_ and arg_42_1.time_ <= 1 + arg_45_0 then
				arg_42_1.var_.moveOldPosS0017 = arg_42_1.bgs_.S0017.transform.localPosition
			end

			local var_45_0 = 0.001

			if 1 <= arg_42_1.time_ and arg_42_1.time_ < 1 + var_45_0 then
				arg_42_1.bgs_.S0017.transform.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPosS0017, Vector3.New(0, -100, 10), (arg_42_1.time_ - 1) / var_45_0)
			end

			if arg_42_1.time_ >= 1 + var_45_0 and arg_42_1.time_ < 1 + var_45_0 + arg_45_0 then
				arg_42_1.bgs_.S0017.transform.localPosition = Vector3.New(0, -100, 10)
			end

			local var_45_1 = "S0013"

			if arg_42_1.bgs_.S0013 == nil then
				local var_45_2 = Object.Instantiate(arg_42_1.paintGo_)

				var_45_2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_45_1)
				var_45_2.name = var_45_1
				var_45_2.transform.parent = arg_42_1.stage_.transform
				var_45_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_42_1.bgs_[var_45_1] = var_45_2
			end

			if 1 < arg_42_1.time_ and arg_42_1.time_ <= 1 + arg_45_0 then
				local var_45_3 = arg_42_1.bgs_.S0013

				arg_42_1.bgs_.S0013.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_45_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_45_4 = var_45_3:GetComponent("SpriteRenderer")

				if var_45_4 and var_45_4.sprite then
					local var_45_5 = 2 * (var_45_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_45_3.transform.localScale = Vector3.New(var_45_5 / var_45_4.sprite.bounds.size.y < var_45_5 * manager.ui.mainCameraCom_.aspect / var_45_4.sprite.bounds.size.x and var_45_5 * manager.ui.mainCameraCom_.aspect / var_45_4.sprite.bounds.size.x or var_45_5 / var_45_4.sprite.bounds.size.y, var_45_5 / var_45_4.sprite.bounds.size.y < var_45_5 * manager.ui.mainCameraCom_.aspect / var_45_4.sprite.bounds.size.x and var_45_5 * manager.ui.mainCameraCom_.aspect / var_45_4.sprite.bounds.size.x or var_45_5 / var_45_4.sprite.bounds.size.y, 0)
				end

				for iter_45_0, iter_45_1 in pairs(arg_42_1.bgs_) do
					if iter_45_0 ~= "S0013" then
						iter_45_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				local var_45_6 = arg_42_1.bgs_.S0017:GetComponent("SpriteRenderer")

				if var_45_6 then
					arg_42_1.var_.alphaOldValueS0017 = var_45_6.color.a
					arg_42_1.var_.alphaMatValueS0017 = var_45_6
				end

				arg_42_1.var_.alphaOldValueS0017 = 1
			end

			local var_45_7 = 1

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_7 then
				if arg_42_1.var_.alphaMatValueS0017 then
					arg_42_1.var_.alphaMatValueS0017.color.a = Mathf.Lerp(arg_42_1.var_.alphaOldValueS0017, 0, (arg_42_1.time_ - 0) / var_45_7)
					arg_42_1.var_.alphaMatValueS0017.color = arg_42_1.var_.alphaMatValueS0017.color
				end
			end

			if arg_42_1.time_ >= 0 + var_45_7 and arg_42_1.time_ < 0 + var_45_7 + arg_45_0 and arg_42_1.var_.alphaMatValueS0017 then
				arg_42_1.var_.alphaMatValueS0017.color.a = 0
				arg_42_1.var_.alphaMatValueS0017.color = arg_42_1.var_.alphaMatValueS0017.color
			end

			if 1 < arg_42_1.time_ and arg_42_1.time_ <= 1 + arg_45_0 then
				local var_45_8 = arg_42_1.bgs_.S0013:GetComponent("SpriteRenderer")

				if var_45_8 then
					arg_42_1.var_.alphaOldValueS0013 = var_45_8.color.a
					arg_42_1.var_.alphaMatValueS0013 = var_45_8
				end

				arg_42_1.var_.alphaOldValueS0013 = 0
			end

			local var_45_9 = 1

			if 1 <= arg_42_1.time_ and arg_42_1.time_ < 1 + var_45_9 then
				if arg_42_1.var_.alphaMatValueS0013 then
					arg_42_1.var_.alphaMatValueS0013.color.a = Mathf.Lerp(arg_42_1.var_.alphaOldValueS0013, 1, (arg_42_1.time_ - 1) / var_45_9)
					arg_42_1.var_.alphaMatValueS0013.color = arg_42_1.var_.alphaMatValueS0013.color
				end
			end

			if arg_42_1.time_ >= 1 + var_45_9 and arg_42_1.time_ < 1 + var_45_9 + arg_45_0 and arg_42_1.var_.alphaMatValueS0013 then
				arg_42_1.var_.alphaMatValueS0013.color.a = 1
				arg_42_1.var_.alphaMatValueS0013.color = arg_42_1.var_.alphaMatValueS0013.color
			end

			local var_45_10 = arg_42_1.bgs_.S0013.transform

			if 1.76666666666667 < arg_42_1.time_ and arg_42_1.time_ <= 1.76666666666667 + arg_45_0 then
				arg_42_1.var_.moveOldPosS0013 = var_45_10.localPosition
			end

			local var_45_11 = 1.7

			if 1.76666666666667 <= arg_42_1.time_ and arg_42_1.time_ < 1.76666666666667 + var_45_11 then
				var_45_10.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPosS0013, Vector3.New(0, 1, 9), (arg_42_1.time_ - 1.76666666666667) / var_45_11)
			end

			if arg_42_1.time_ >= 1.76666666666667 + var_45_11 and arg_42_1.time_ < 1.76666666666667 + var_45_11 + arg_45_0 then
				var_45_10.localPosition = Vector3.New(0, 1, 9)
			end

			local var_45_12 = 0

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_12 + arg_45_0 then
				arg_42_1.allBtn_.enabled = false
			end

			if arg_42_1.time_ >= var_45_12 + 2 and arg_42_1.time_ < var_45_12 + 2 + arg_45_0 then
				arg_42_1.allBtn_.enabled = true
			end

			if arg_42_1.frameCnt_ <= 1 then
				arg_42_1.dialog_:SetActive(false)
			end

			local var_45_13 = 2
			local var_45_14 = 1.025

			if 2 < arg_42_1.time_ and arg_42_1.time_ <= var_45_13 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0

				arg_42_1.dialog_:SetActive(true)

				arg_42_1.dialogCg_.alpha = 0

				local var_45_15 = LeanTween.value(arg_42_1.dialog_, 0, 1, 0.3)

				var_45_15:setOnUpdate(LuaHelper.FloatAction(function(arg_46_0)
					arg_42_1.dialogCg_.alpha = arg_46_0
				end))
				var_45_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_42_1.dialog_)
					var_45_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_42_1.duration_ = arg_42_1.duration_ + 0.3

				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_16 = arg_42_1:GetWordFromCfg(100011008)
				local var_45_17 = arg_42_1:FormatText(var_45_16.content)

				arg_42_1.text_.text = var_45_17

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_19 = 41 <= 0 and var_45_14 or var_45_14 * (utf8.len(var_45_17) / 41)

				if (41 <= 0 and var_45_14 or var_45_14 * (utf8.len(var_45_17) / 41)) > 0 and var_45_14 < var_45_19 then
					arg_42_1.talkMaxDuration = var_45_19
					var_45_13 = var_45_13 + 0.3

					if var_45_19 + var_45_13 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_19 + var_45_13
					end
				end

				arg_42_1.text_.text = var_45_17
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011008", "story_v_out_100011.awb") ~= 0 then
					local var_45_20 = manager.audio:GetVoiceLength("story_v_out_100011", "100011008", "story_v_out_100011.awb") / 1000

					if var_45_20 + var_45_13 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_20 + var_45_13
					end

					if var_45_16.prefab_name ~= "" and arg_42_1.actors_[var_45_16.prefab_name] ~= nil then
						local var_45_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_16.prefab_name].transform, "story_v_out_100011", "100011008", "story_v_out_100011.awb")

						arg_42_1:RecordAudio("100011008", var_45_21)
						arg_42_1:RecordAudio("100011008", var_45_21)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_100011", "100011008", "story_v_out_100011.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_100011", "100011008", "story_v_out_100011.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_22 = var_45_13 + 0.3
			local var_45_23 = math.max(var_45_14, arg_42_1.talkMaxDuration)

			if var_45_13 + 0.3 <= arg_42_1.time_ and arg_42_1.time_ < var_45_22 + var_45_23 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_22) / var_45_23

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_22 + var_45_23 and arg_42_1.time_ < var_45_22 + var_45_23 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0017",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0013",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.7,
				className = "StoryMoveNode",
				startTime = 1.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play100011009 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 100011009
		arg_48_1.duration_ = 6.73

		local var_48_0 = {
			ja = 5.8,
			ko = 4.933,
			zh = 5.033,
			en = 6.733
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play100011010(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPosS0013 = arg_48_1.bgs_.S0013.transform.localPosition
			end

			local var_51_0 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 then
				arg_48_1.bgs_.S0013.transform.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPosS0013, Vector3.New(0, 1, 9), (arg_48_1.time_ - 0) / var_51_0)
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 then
				arg_48_1.bgs_.S0013.transform.localPosition = Vector3.New(0, 1, 9)
			end

			local var_51_1 = arg_48_1.bgs_.S0013.transform

			if 0.0166666666666667 < arg_48_1.time_ and arg_48_1.time_ <= 0.0166666666666667 + arg_51_0 then
				arg_48_1.var_.moveOldPosS0013 = var_51_1.localPosition
			end

			local var_51_2 = 1.7

			if 0.0166666666666667 <= arg_48_1.time_ and arg_48_1.time_ < 0.0166666666666667 + var_51_2 then
				var_51_1.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPosS0013, Vector3.New(0.32, 0.72, 8), (arg_48_1.time_ - 0.0166666666666667) / var_51_2)
			end

			if arg_48_1.time_ >= 0.0166666666666667 + var_51_2 and arg_48_1.time_ < 0.0166666666666667 + var_51_2 + arg_51_0 then
				var_51_1.localPosition = Vector3.New(0.32, 0.72, 8)
			end

			local var_51_3 = 0
			local var_51_4 = 0.8

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_3 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_5 = arg_48_1:GetWordFromCfg(100011009)
				local var_51_6 = arg_48_1:FormatText(var_51_5.content)

				arg_48_1.text_.text = var_51_6

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_8 = 21 <= 0 and var_51_4 or var_51_4 * (utf8.len(var_51_6) / 21)

				if (21 <= 0 and var_51_4 or var_51_4 * (utf8.len(var_51_6) / 21)) > 0 and var_51_4 < var_51_8 then
					arg_48_1.talkMaxDuration = var_51_8

					if var_51_8 + var_51_3 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_3
					end
				end

				arg_48_1.text_.text = var_51_6
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011009", "story_v_out_100011.awb") ~= 0 then
					local var_51_9 = manager.audio:GetVoiceLength("story_v_out_100011", "100011009", "story_v_out_100011.awb") / 1000

					if var_51_9 + var_51_3 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_3
					end

					if var_51_5.prefab_name ~= "" and arg_48_1.actors_[var_51_5.prefab_name] ~= nil then
						local var_51_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_5.prefab_name].transform, "story_v_out_100011", "100011009", "story_v_out_100011.awb")

						arg_48_1:RecordAudio("100011009", var_51_10)
						arg_48_1:RecordAudio("100011009", var_51_10)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_100011", "100011009", "story_v_out_100011.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_100011", "100011009", "story_v_out_100011.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_11 = math.max(var_51_4, arg_48_1.talkMaxDuration)

			if var_51_3 <= arg_48_1.time_ and arg_48_1.time_ < var_51_3 + var_51_11 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_3) / var_51_11

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_3 + var_51_11 and arg_48_1.time_ < var_51_3 + var_51_11 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0013",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0013",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.7,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play100011010 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 100011010
		arg_52_1.duration_ = 13.43

		local var_52_0 = {
			ja = 13.4,
			ko = 11.4,
			zh = 9.933,
			en = 13.433
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play100011011(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 1 < arg_52_1.time_ and arg_52_1.time_ <= 1 + arg_55_0 then
				arg_52_1.var_.moveOldPosS0013 = arg_52_1.bgs_.S0013.transform.localPosition
			end

			local var_55_0 = 0.001

			if 1 <= arg_52_1.time_ and arg_52_1.time_ < 1 + var_55_0 then
				arg_52_1.bgs_.S0013.transform.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPosS0013, Vector3.New(0, -100, 10), (arg_52_1.time_ - 1) / var_55_0)
			end

			if arg_52_1.time_ >= 1 + var_55_0 and arg_52_1.time_ < 1 + var_55_0 + arg_55_0 then
				arg_52_1.bgs_.S0013.transform.localPosition = Vector3.New(0, -100, 10)
			end

			local var_55_1 = "S0014"

			if arg_52_1.bgs_.S0014 == nil then
				local var_55_2 = Object.Instantiate(arg_52_1.paintGo_)

				var_55_2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_55_1)
				var_55_2.name = var_55_1
				var_55_2.transform.parent = arg_52_1.stage_.transform
				var_55_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.bgs_[var_55_1] = var_55_2
			end

			if 1 < arg_52_1.time_ and arg_52_1.time_ <= 1 + arg_55_0 then
				local var_55_3 = arg_52_1.bgs_.S0014

				arg_52_1.bgs_.S0014.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_55_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_55_4 = var_55_3:GetComponent("SpriteRenderer")

				if var_55_4 and var_55_4.sprite then
					local var_55_5 = 2 * (var_55_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_55_3.transform.localScale = Vector3.New(var_55_5 / var_55_4.sprite.bounds.size.y < var_55_5 * manager.ui.mainCameraCom_.aspect / var_55_4.sprite.bounds.size.x and var_55_5 * manager.ui.mainCameraCom_.aspect / var_55_4.sprite.bounds.size.x or var_55_5 / var_55_4.sprite.bounds.size.y, var_55_5 / var_55_4.sprite.bounds.size.y < var_55_5 * manager.ui.mainCameraCom_.aspect / var_55_4.sprite.bounds.size.x and var_55_5 * manager.ui.mainCameraCom_.aspect / var_55_4.sprite.bounds.size.x or var_55_5 / var_55_4.sprite.bounds.size.y, 0)
				end

				for iter_55_0, iter_55_1 in pairs(arg_52_1.bgs_) do
					if iter_55_0 ~= "S0014" then
						iter_55_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_55_6 = 0

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_7 = 1

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_7 then
				local var_55_8 = Color.New(1, 1, 1)

				var_55_8.a = Mathf.Lerp(0, 1, (arg_52_1.time_ - var_55_6) / var_55_7)
				arg_52_1.mask_.color = var_55_8
			end

			if arg_52_1.time_ >= var_55_6 + var_55_7 and arg_52_1.time_ < var_55_6 + var_55_7 + arg_55_0 then
				local var_55_9 = Color.New(1, 1, 1)

				var_55_9.a = 1
				arg_52_1.mask_.color = var_55_9
			end

			local var_55_10 = 1

			if 1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_11 = 1

			if var_55_10 <= arg_52_1.time_ and arg_52_1.time_ < var_55_10 + var_55_11 then
				local var_55_12 = Color.New(1, 1, 1)

				var_55_12.a = Mathf.Lerp(1, 0, (arg_52_1.time_ - var_55_10) / var_55_11)
				arg_52_1.mask_.color = var_55_12
			end

			if arg_52_1.time_ >= var_55_10 + var_55_11 and arg_52_1.time_ < var_55_10 + var_55_11 + arg_55_0 then
				local var_55_13 = Color.New(1, 1, 1)

				arg_52_1.mask_.enabled = false
				var_55_13.a = 0
				arg_52_1.mask_.color = var_55_13
			end

			local var_55_14 = arg_52_1.bgs_.S0014.transform

			if 1 < arg_52_1.time_ and arg_52_1.time_ <= 1 + arg_55_0 then
				arg_52_1.var_.moveOldPosS0014 = var_55_14.localPosition
			end

			local var_55_15 = 0.001

			if 1 <= arg_52_1.time_ and arg_52_1.time_ < 1 + var_55_15 then
				var_55_14.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPosS0014, Vector3.New(0, 1, 7), (arg_52_1.time_ - 1) / var_55_15)
			end

			if arg_52_1.time_ >= 1 + var_55_15 and arg_52_1.time_ < 1 + var_55_15 + arg_55_0 then
				var_55_14.localPosition = Vector3.New(0, 1, 7)
			end

			local var_55_16 = 0

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_16 + arg_55_0 then
				arg_52_1.allBtn_.enabled = false
			end

			if arg_52_1.time_ >= var_55_16 + 2 and arg_52_1.time_ < var_55_16 + 2 + arg_55_0 then
				arg_52_1.allBtn_.enabled = true
			end

			if arg_52_1.frameCnt_ <= 1 then
				arg_52_1.dialog_:SetActive(false)
			end

			local var_55_17 = 2
			local var_55_18 = 1.025

			if 2 < arg_52_1.time_ and arg_52_1.time_ <= var_55_17 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0

				arg_52_1.dialog_:SetActive(true)

				arg_52_1.dialogCg_.alpha = 0

				local var_55_19 = LeanTween.value(arg_52_1.dialog_, 0, 1, 0.3)

				var_55_19:setOnUpdate(LuaHelper.FloatAction(function(arg_56_0)
					arg_52_1.dialogCg_.alpha = arg_56_0
				end))
				var_55_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_52_1.dialog_)
					var_55_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_52_1.duration_ = arg_52_1.duration_ + 0.3

				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_20 = arg_52_1:GetWordFromCfg(100011010)
				local var_55_21 = arg_52_1:FormatText(var_55_20.content)

				arg_52_1.text_.text = var_55_21

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_23 = 41 <= 0 and var_55_18 or var_55_18 * (utf8.len(var_55_21) / 41)

				if (41 <= 0 and var_55_18 or var_55_18 * (utf8.len(var_55_21) / 41)) > 0 and var_55_18 < var_55_23 then
					arg_52_1.talkMaxDuration = var_55_23
					var_55_17 = var_55_17 + 0.3

					if var_55_23 + var_55_17 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_23 + var_55_17
					end
				end

				arg_52_1.text_.text = var_55_21
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011010", "story_v_out_100011.awb") ~= 0 then
					local var_55_24 = manager.audio:GetVoiceLength("story_v_out_100011", "100011010", "story_v_out_100011.awb") / 1000

					if var_55_24 + var_55_17 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_24 + var_55_17
					end

					if var_55_20.prefab_name ~= "" and arg_52_1.actors_[var_55_20.prefab_name] ~= nil then
						local var_55_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_20.prefab_name].transform, "story_v_out_100011", "100011010", "story_v_out_100011.awb")

						arg_52_1:RecordAudio("100011010", var_55_25)
						arg_52_1:RecordAudio("100011010", var_55_25)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_100011", "100011010", "story_v_out_100011.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_100011", "100011010", "story_v_out_100011.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_26 = var_55_17 + 0.3
			local var_55_27 = math.max(var_55_18, arg_52_1.talkMaxDuration)

			if var_55_17 + 0.3 <= arg_52_1.time_ and arg_52_1.time_ < var_55_26 + var_55_27 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_26) / var_55_27

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_26 + var_55_27 and arg_52_1.time_ < var_55_26 + var_55_27 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0013",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0014",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play100011011 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 100011011
		arg_58_1.duration_ = 10.43

		local var_58_0 = {
			ja = 10.433,
			ko = 7.233,
			zh = 6.833,
			en = 9.266
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play100011012(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPosS0014 = arg_58_1.bgs_.S0014.transform.localPosition
			end

			local var_61_0 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 then
				arg_58_1.bgs_.S0014.transform.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPosS0014, Vector3.New(0, 1, 7), (arg_58_1.time_ - 0) / var_61_0)
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 then
				arg_58_1.bgs_.S0014.transform.localPosition = Vector3.New(0, 1, 7)
			end

			local var_61_1 = arg_58_1.bgs_.S0014.transform

			if 0.0166666666666667 < arg_58_1.time_ and arg_58_1.time_ <= 0.0166666666666667 + arg_61_0 then
				arg_58_1.var_.moveOldPosS0014 = var_61_1.localPosition
			end

			local var_61_2 = 3

			if 0.0166666666666667 <= arg_58_1.time_ and arg_58_1.time_ < 0.0166666666666667 + var_61_2 then
				var_61_1.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPosS0014, Vector3.New(0, 1, 10), (arg_58_1.time_ - 0.0166666666666667) / var_61_2)
			end

			if arg_58_1.time_ >= 0.0166666666666667 + var_61_2 and arg_58_1.time_ < 0.0166666666666667 + var_61_2 + arg_61_0 then
				var_61_1.localPosition = Vector3.New(0, 1, 10)
			end

			local var_61_3 = 0
			local var_61_4 = 0.8

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_3 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, false)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_5 = arg_58_1:GetWordFromCfg(100011011)
				local var_61_6 = arg_58_1:FormatText(var_61_5.content)

				arg_58_1.text_.text = var_61_6

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_8 = 32 <= 0 and var_61_4 or var_61_4 * (utf8.len(var_61_6) / 32)

				if (32 <= 0 and var_61_4 or var_61_4 * (utf8.len(var_61_6) / 32)) > 0 and var_61_4 < var_61_8 then
					arg_58_1.talkMaxDuration = var_61_8

					if var_61_8 + var_61_3 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_3
					end
				end

				arg_58_1.text_.text = var_61_6
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011011", "story_v_out_100011.awb") ~= 0 then
					local var_61_9 = manager.audio:GetVoiceLength("story_v_out_100011", "100011011", "story_v_out_100011.awb") / 1000

					if var_61_9 + var_61_3 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_9 + var_61_3
					end

					if var_61_5.prefab_name ~= "" and arg_58_1.actors_[var_61_5.prefab_name] ~= nil then
						local var_61_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_5.prefab_name].transform, "story_v_out_100011", "100011011", "story_v_out_100011.awb")

						arg_58_1:RecordAudio("100011011", var_61_10)
						arg_58_1:RecordAudio("100011011", var_61_10)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_100011", "100011011", "story_v_out_100011.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_100011", "100011011", "story_v_out_100011.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_11 = math.max(var_61_4, arg_58_1.talkMaxDuration)

			if var_61_3 <= arg_58_1.time_ and arg_58_1.time_ < var_61_3 + var_61_11 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_3) / var_61_11

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_3 + var_61_11 and arg_58_1.time_ < var_61_3 + var_61_11 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0014",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0014",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play100011012 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 100011012
		arg_62_1.duration_ = 15.07

		local var_62_0 = {
			ja = 15.066,
			ko = 9.6,
			zh = 8.766,
			en = 13.5
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
			arg_62_1.auto_ = false
		end

		function arg_62_1.playNext_(arg_64_0)
			arg_62_1.onStoryFinished_()
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 1.075

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_1 = arg_62_1:GetWordFromCfg(100011012)
				local var_65_2 = arg_62_1:FormatText(var_65_1.content)

				arg_62_1.text_.text = var_65_2

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_4 = 43 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 43)

				if (43 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 43)) > 0 and var_65_0 < var_65_4 then
					arg_62_1.talkMaxDuration = var_65_4

					if var_65_4 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_4 + 0
					end
				end

				arg_62_1.text_.text = var_65_2
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011012", "story_v_out_100011.awb") ~= 0 then
					local var_65_5 = manager.audio:GetVoiceLength("story_v_out_100011", "100011012", "story_v_out_100011.awb") / 1000

					if var_65_5 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + 0
					end

					if var_65_1.prefab_name ~= "" and arg_62_1.actors_[var_65_1.prefab_name] ~= nil then
						local var_65_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_1.prefab_name].transform, "story_v_out_100011", "100011012", "story_v_out_100011.awb")

						arg_62_1:RecordAudio("100011012", var_65_6)
						arg_62_1:RecordAudio("100011012", var_65_6)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_100011", "100011012", "story_v_out_100011.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_100011", "100011012", "story_v_out_100011.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_7 = math.max(var_65_0, arg_62_1.talkMaxDuration)

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_7 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - 0) / var_65_7

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= 0 + var_65_7 and arg_62_1.time_ < 0 + var_65_7 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/S0015",
		"TextureConfig/Background/S0011",
		"TextureConfig/Background/S0012",
		"TextureConfig/Background/S0016",
		"TextureConfig/Background/S0017",
		"TextureConfig/Background/S0013",
		"TextureConfig/Background/S0014"
	},
	voices = {
		"story_v_out_100011.awb"
	}
}
