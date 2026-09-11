return {
	Play122141001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 122141001
		arg_1_1.duration_ = 3.27

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play122141002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.XH0508 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0508")
				var_4_0.name = "XH0508"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.XH0508 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.XH0508

				arg_1_1.bgs_.XH0508.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "XH0508" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			local var_4_8 = arg_1_1.bgs_.XH0508.transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPosXH0508 = var_4_8.localPosition
			end

			local var_4_9 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_9 then
				var_4_8.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosXH0508, Vector3.New(0, 0.15, 2.5), (arg_1_1.time_ - 0) / var_4_9)
			end

			if arg_1_1.time_ >= 0 + var_4_9 and arg_1_1.time_ < 0 + var_4_9 + arg_4_0 then
				var_4_8.localPosition = Vector3.New(0, 0.15, 2.5)
			end

			local var_4_10 = arg_1_1.bgs_.XH0508.transform

			if 0.034 < arg_1_1.time_ and arg_1_1.time_ <= 0.034 + arg_4_0 then
				arg_1_1.var_.moveOldPosXH0508 = var_4_10.localPosition
			end

			local var_4_11 = 2.966

			if 0.034 <= arg_1_1.time_ and arg_1_1.time_ < 0.034 + var_4_11 then
				var_4_10.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosXH0508, Vector3.New(0, 0.15, 3), (arg_1_1.time_ - 0.034) / var_4_11)
			end

			if arg_1_1.time_ >= 0.034 + var_4_11 and arg_1_1.time_ < 0.034 + var_4_11 + arg_4_0 then
				var_4_10.localPosition = Vector3.New(0, 0.15, 3)
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0
				arg_1_1.fswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(122141001).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_12 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_13 = 9
			local var_4_14 = 0.6
			local var_4_15, var_4_16 = arg_1_1:GetPercentByPara(arg_1_1:FormatText(arg_1_1:GetWordFromCfg(122141001).content), 1)

			if var_4_12 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_17 = var_4_13 <= 0 and var_4_14 or var_4_14 * ((var_4_16 - arg_1_1.typewritterCharCountI18N) / var_4_13)

				if (var_4_13 <= 0 and var_4_14 or var_4_14 * ((var_4_16 - arg_1_1.typewritterCharCountI18N) / var_4_13)) > 0 and var_4_14 < var_4_17 then
					arg_1_1.talkMaxDuration = var_4_17

					if var_4_17 + var_4_12 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_17 + var_4_12
					end
				end
			end

			local var_4_18 = math.max(0.6, arg_1_1.talkMaxDuration)

			if var_4_12 <= arg_1_1.time_ and arg_1_1.time_ < var_4_12 + var_4_18 then
				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_15, (arg_1_1.time_ - var_4_12) / var_4_18)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_12 + var_4_18 and arg_1_1.time_ < var_4_12 + var_4_18 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_15

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_16
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				local var_4_19 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_20 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_21 = var_4_19:GetComponent("RectTransform")

				var_4_19:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_4_21.offsetMin = Vector2.New(0, 0)
				var_4_21.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_24 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_24 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_24

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_24
						arg_1_1.bgmTxt2_.text = var_4_24
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
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0508",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0508",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.966,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play122141002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 122141002
		arg_6_1.duration_ = 1.4

		local var_6_0 = {
			ja = 1.4,
			ko = 1.033,
			zh = 1.033
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
				arg_6_0:Play122141003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				arg_6_1.fswbg_:SetActive(false)
				arg_6_1.dialog_:SetActive(true)
				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_0 = 0
			local var_9_1 = 0.05

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_0 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				arg_6_1.dialog_:SetActive(true)

				arg_6_1.dialogCg_.alpha = 0

				local var_9_2 = LeanTween.value(arg_6_1.dialog_, 0, 1, 0.3)

				var_9_2:setOnUpdate(LuaHelper.FloatAction(function(arg_10_0)
					arg_6_1.dialogCg_.alpha = arg_10_0
				end))
				var_9_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_6_1.dialog_)
					var_9_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_6_1.duration_ = arg_6_1.duration_ + 0.3

				SetActive(arg_6_1.leftNameGo_, true)

				arg_6_1.leftNameTxt_.text = arg_6_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_1.leftNameTxt_.transform)

				arg_6_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_6_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_6_1:RecordName(arg_6_1.leftNameTxt_.text)
				SetActive(arg_6_1.iconTrs_.gameObject, false)
				arg_6_1.callingController_:SetSelectedState("normal")

				local var_9_3 = arg_6_1:GetWordFromCfg(122141002)
				local var_9_4 = arg_6_1:FormatText(var_9_3.content)

				arg_6_1.text_.text = var_9_4

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.text_)

				local var_9_6 = 2 <= 0 and var_9_1 or var_9_1 * (utf8.len(var_9_4) / 2)

				if (2 <= 0 and var_9_1 or var_9_1 * (utf8.len(var_9_4) / 2)) > 0 and var_9_1 < var_9_6 then
					arg_6_1.talkMaxDuration = var_9_6
					var_9_0 = var_9_0 + 0.3

					if var_9_6 + var_9_0 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_6 + var_9_0
					end
				end

				arg_6_1.text_.text = var_9_4
				arg_6_1.typewritter.percent = 0

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141002", "story_v_out_122141.awb") ~= 0 then
					local var_9_7 = manager.audio:GetVoiceLength("story_v_out_122141", "122141002", "story_v_out_122141.awb") / 1000

					if var_9_7 + var_9_0 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_7 + var_9_0
					end

					if var_9_3.prefab_name ~= "" and arg_6_1.actors_[var_9_3.prefab_name] ~= nil then
						local var_9_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_6_1.actors_[var_9_3.prefab_name].transform, "story_v_out_122141", "122141002", "story_v_out_122141.awb")

						arg_6_1:RecordAudio("122141002", var_9_8)
						arg_6_1:RecordAudio("122141002", var_9_8)
					else
						arg_6_1:AudioAction("play", "voice", "story_v_out_122141", "122141002", "story_v_out_122141.awb")
					end

					arg_6_1:RecordHistoryTalkVoice("story_v_out_122141", "122141002", "story_v_out_122141.awb")
				end

				arg_6_1:RecordContent(arg_6_1.text_.text)
			end

			local var_9_9 = var_9_0 + 0.3
			local var_9_10 = math.max(var_9_1, arg_6_1.talkMaxDuration)

			if var_9_0 + 0.3 <= arg_6_1.time_ and arg_6_1.time_ < var_9_9 + var_9_10 then
				arg_6_1.typewritter.percent = (arg_6_1.time_ - var_9_9) / var_9_10

				arg_6_1.typewritter:SetDirty()
			end

			if arg_6_1.time_ >= var_9_9 + var_9_10 and arg_6_1.time_ < var_9_9 + var_9_10 + arg_9_0 then
				arg_6_1.typewritter.percent = 1

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(true)
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play122141003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 122141003
		arg_12_1.duration_ = 2.42

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play122141004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.fswbg_:SetActive(true)
				arg_12_1.dialog_:SetActive(false)

				arg_12_1.fswtw_.percent = 0
				arg_12_1.fswt_.text = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(122141003).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.fswt_)

				arg_12_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_12_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_12_1.fswtw_:SetDirty()

				arg_12_1.typewritterCharCountI18N = 0

				SetActive(arg_12_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_12_1:ShowNextGo(false)
			end

			local var_15_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.var_.oldValueTypewriter = arg_12_1.fswtw_.percent

				SetActive(arg_12_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_12_1:ShowNextGo(false)
			end

			local var_15_1 = 36
			local var_15_2 = 2.4
			local var_15_3, var_15_4 = arg_12_1:GetPercentByPara(arg_12_1:FormatText(arg_12_1:GetWordFromCfg(122141003).content), 1)

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				local var_15_5 = var_15_1 <= 0 and var_15_2 or var_15_2 * ((var_15_4 - arg_12_1.typewritterCharCountI18N) / var_15_1)

				if (var_15_1 <= 0 and var_15_2 or var_15_2 * ((var_15_4 - arg_12_1.typewritterCharCountI18N) / var_15_1)) > 0 and var_15_2 < var_15_5 then
					arg_12_1.talkMaxDuration = var_15_5

					if var_15_5 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + var_15_0
					end
				end
			end

			local var_15_6 = math.max(2.4, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_6 then
				arg_12_1.fswtw_.percent = Mathf.Lerp(arg_12_1.var_.oldValueTypewriter, var_15_3, (arg_12_1.time_ - var_15_0) / var_15_6)
				arg_12_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_12_1.fswtw_:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_6 and arg_12_1.time_ < var_15_0 + var_15_6 + arg_15_0 then
				arg_12_1.fswtw_.percent = var_15_3

				arg_12_1.fswtw_:SetDirty()
				arg_12_1:ShowNextGo(true)

				arg_12_1.typewritterCharCountI18N = var_15_4
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play122141004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 122141004
		arg_16_1.duration_ = 1.63

		local var_16_0 = {
			ja = 1.633,
			ko = 1,
			zh = 1
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play122141005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.fswbg_:SetActive(false)
				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_16_1:ShowNextGo(false)
			end

			local var_19_0 = 0
			local var_19_1 = 0.05

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0

				arg_16_1.dialog_:SetActive(true)

				arg_16_1.dialogCg_.alpha = 0

				local var_19_2 = LeanTween.value(arg_16_1.dialog_, 0, 1, 0.3)

				var_19_2:setOnUpdate(LuaHelper.FloatAction(function(arg_20_0)
					arg_16_1.dialogCg_.alpha = arg_20_0
				end))
				var_19_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_16_1.dialog_)
					var_19_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_16_1.duration_ = arg_16_1.duration_ + 0.3

				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_3 = arg_16_1:GetWordFromCfg(122141004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_6 = 2 <= 0 and var_19_1 or var_19_1 * (utf8.len(var_19_4) / 2)

				if (2 <= 0 and var_19_1 or var_19_1 * (utf8.len(var_19_4) / 2)) > 0 and var_19_1 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6
					var_19_0 = var_19_0 + 0.3

					if var_19_6 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141004", "story_v_out_122141.awb") ~= 0 then
					local var_19_7 = manager.audio:GetVoiceLength("story_v_out_122141", "122141004", "story_v_out_122141.awb") / 1000

					if var_19_7 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_122141", "122141004", "story_v_out_122141.awb")

						arg_16_1:RecordAudio("122141004", var_19_8)
						arg_16_1:RecordAudio("122141004", var_19_8)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_122141", "122141004", "story_v_out_122141.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_122141", "122141004", "story_v_out_122141.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_9 = var_19_0 + 0.3
			local var_19_10 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 + 0.3 <= arg_16_1.time_ and arg_16_1.time_ < var_19_9 + var_19_10 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_9) / var_19_10

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_9 + var_19_10 and arg_16_1.time_ < var_19_9 + var_19_10 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play122141005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 122141005
		arg_22_1.duration_ = 3.95

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play122141006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.fswbg_:SetActive(true)
				arg_22_1.dialog_:SetActive(false)

				arg_22_1.fswtw_.percent = 0
				arg_22_1.fswt_.text = arg_22_1:FormatText(arg_22_1:GetWordFromCfg(122141005).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.fswt_)

				arg_22_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_22_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_22_1.fswtw_:SetDirty()

				arg_22_1.typewritterCharCountI18N = 0

				SetActive(arg_22_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_22_1:ShowNextGo(false)
			end

			local var_25_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				arg_22_1.var_.oldValueTypewriter = arg_22_1.fswtw_.percent

				SetActive(arg_22_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_22_1:ShowNextGo(false)
			end

			local var_25_1 = 59
			local var_25_2 = 3.93333333333333
			local var_25_3, var_25_4 = arg_22_1:GetPercentByPara(arg_22_1:FormatText(arg_22_1:GetWordFromCfg(122141005).content), 3)

			if var_25_0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0

				local var_25_5 = var_25_1 <= 0 and var_25_2 or var_25_2 * ((var_25_4 - arg_22_1.typewritterCharCountI18N) / var_25_1)

				if (var_25_1 <= 0 and var_25_2 or var_25_2 * ((var_25_4 - arg_22_1.typewritterCharCountI18N) / var_25_1)) > 0 and var_25_2 < var_25_5 then
					arg_22_1.talkMaxDuration = var_25_5

					if var_25_5 + var_25_0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_5 + var_25_0
					end
				end
			end

			local var_25_6 = math.max(3.93333333333333, arg_22_1.talkMaxDuration)

			if var_25_0 <= arg_22_1.time_ and arg_22_1.time_ < var_25_0 + var_25_6 then
				arg_22_1.fswtw_.percent = Mathf.Lerp(arg_22_1.var_.oldValueTypewriter, var_25_3, (arg_22_1.time_ - var_25_0) / var_25_6)
				arg_22_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_22_1.fswtw_:SetDirty()
			end

			if arg_22_1.time_ >= var_25_0 + var_25_6 and arg_22_1.time_ < var_25_0 + var_25_6 + arg_25_0 then
				arg_22_1.fswtw_.percent = var_25_3

				arg_22_1.fswtw_:SetDirty()
				arg_22_1:ShowNextGo(true)

				arg_22_1.typewritterCharCountI18N = var_25_4
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play122141006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 122141006
		arg_26_1.duration_ = 9

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play122141007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 2 < arg_26_1.time_ and arg_26_1.time_ <= 2 + arg_29_0 then
				local var_29_0 = arg_26_1.bgs_.XH0508

				arg_26_1.bgs_.XH0508.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_29_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_29_1 = var_29_0:GetComponent("SpriteRenderer")

				if var_29_1 and var_29_1.sprite then
					local var_29_2 = 2 * (var_29_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_29_0.transform.localScale = Vector3.New(var_29_2 / var_29_1.sprite.bounds.size.y < var_29_2 * manager.ui.mainCameraCom_.aspect / var_29_1.sprite.bounds.size.x and var_29_2 * manager.ui.mainCameraCom_.aspect / var_29_1.sprite.bounds.size.x or var_29_2 / var_29_1.sprite.bounds.size.y, var_29_2 / var_29_1.sprite.bounds.size.y < var_29_2 * manager.ui.mainCameraCom_.aspect / var_29_1.sprite.bounds.size.x and var_29_2 * manager.ui.mainCameraCom_.aspect / var_29_1.sprite.bounds.size.x or var_29_2 / var_29_1.sprite.bounds.size.y, 0)
				end

				for iter_29_0, iter_29_1 in pairs(arg_26_1.bgs_) do
					if iter_29_0 ~= "XH0508" then
						iter_29_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_29_3 = 0

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_3 + arg_29_0 then
				arg_26_1.mask_.enabled = true
				arg_26_1.mask_.raycastTarget = true

				arg_26_1:SetGaussion(false)
			end

			local var_29_4 = 2

			if var_29_3 <= arg_26_1.time_ and arg_26_1.time_ < var_29_3 + var_29_4 then
				local var_29_5 = Color.New(0, 0, 0)

				var_29_5.a = Mathf.Lerp(0, 1, (arg_26_1.time_ - var_29_3) / var_29_4)
				arg_26_1.mask_.color = var_29_5
			end

			if arg_26_1.time_ >= var_29_3 + var_29_4 and arg_26_1.time_ < var_29_3 + var_29_4 + arg_29_0 then
				local var_29_6 = Color.New(0, 0, 0)

				var_29_6.a = 1
				arg_26_1.mask_.color = var_29_6
			end

			local var_29_7 = 2

			if 2 < arg_26_1.time_ and arg_26_1.time_ <= var_29_7 + arg_29_0 then
				arg_26_1.mask_.enabled = true
				arg_26_1.mask_.raycastTarget = true

				arg_26_1:SetGaussion(false)
			end

			local var_29_8 = 2

			if var_29_7 <= arg_26_1.time_ and arg_26_1.time_ < var_29_7 + var_29_8 then
				local var_29_9 = Color.New(0, 0, 0)

				var_29_9.a = Mathf.Lerp(1, 0, (arg_26_1.time_ - var_29_7) / var_29_8)
				arg_26_1.mask_.color = var_29_9
			end

			if arg_26_1.time_ >= var_29_7 + var_29_8 and arg_26_1.time_ < var_29_7 + var_29_8 + arg_29_0 then
				local var_29_10 = Color.New(0, 0, 0)

				arg_26_1.mask_.enabled = false
				var_29_10.a = 0
				arg_26_1.mask_.color = var_29_10
			end

			if 2 < arg_26_1.time_ and arg_26_1.time_ <= 2 + arg_29_0 then
				arg_26_1.fswbg_:SetActive(false)
				arg_26_1.dialog_:SetActive(false)
				SetActive(arg_26_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_26_1:ShowNextGo(false)
			end

			local var_29_11 = arg_26_1.bgs_.XH0508.transform

			if 2.01666666666667 < arg_26_1.time_ and arg_26_1.time_ <= 2.01666666666667 + arg_29_0 then
				arg_26_1.var_.moveOldPosXH0508 = var_29_11.localPosition
			end

			local var_29_12 = 0.001

			if 2.01666666666667 <= arg_26_1.time_ and arg_26_1.time_ < 2.01666666666667 + var_29_12 then
				var_29_11.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPosXH0508, Vector3.New(0, 1, 9.5), (arg_26_1.time_ - 2.01666666666667) / var_29_12)
			end

			if arg_26_1.time_ >= 2.01666666666667 + var_29_12 and arg_26_1.time_ < 2.01666666666667 + var_29_12 + arg_29_0 then
				var_29_11.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_29_13 = arg_26_1.bgs_.XH0508.transform

			if 2.03333333333333 < arg_26_1.time_ and arg_26_1.time_ <= 2.03333333333333 + arg_29_0 then
				arg_26_1.var_.moveOldPosXH0508 = var_29_13.localPosition
			end

			local var_29_14 = 3.5

			if 2.03333333333333 <= arg_26_1.time_ and arg_26_1.time_ < 2.03333333333333 + var_29_14 then
				var_29_13.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPosXH0508, Vector3.New(0, 1, 10), (arg_26_1.time_ - 2.03333333333333) / var_29_14)
			end

			if arg_26_1.time_ >= 2.03333333333333 + var_29_14 and arg_26_1.time_ < 2.03333333333333 + var_29_14 + arg_29_0 then
				var_29_13.localPosition = Vector3.New(0, 1, 10)
			end

			local var_29_15 = 4

			if 4 < arg_26_1.time_ and arg_26_1.time_ <= var_29_15 + arg_29_0 then
				arg_26_1.allBtn_.enabled = false
			end

			if arg_26_1.time_ >= var_29_15 + 1.53333333333333 and arg_26_1.time_ < var_29_15 + 1.53333333333333 + arg_29_0 then
				arg_26_1.allBtn_.enabled = true
			end

			if arg_26_1.frameCnt_ <= 1 then
				arg_26_1.dialog_:SetActive(false)
			end

			local var_29_16 = 4
			local var_29_17 = 1.15

			if 4 < arg_26_1.time_ and arg_26_1.time_ <= var_29_16 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0

				arg_26_1.dialog_:SetActive(true)

				arg_26_1.dialogCg_.alpha = 0

				local var_29_18 = LeanTween.value(arg_26_1.dialog_, 0, 1, 0.3)

				var_29_18:setOnUpdate(LuaHelper.FloatAction(function(arg_30_0)
					arg_26_1.dialogCg_.alpha = arg_30_0
				end))
				var_29_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_26_1.dialog_)
					var_29_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_26_1.duration_ = arg_26_1.duration_ + 0.3

				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_19 = arg_26_1:FormatText(arg_26_1:GetWordFromCfg(122141006).content)

				arg_26_1.text_.text = var_29_19

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_21 = 46 <= 0 and var_29_17 or var_29_17 * (utf8.len(var_29_19) / 46)

				if (46 <= 0 and var_29_17 or var_29_17 * (utf8.len(var_29_19) / 46)) > 0 and var_29_17 < var_29_21 then
					arg_26_1.talkMaxDuration = var_29_21
					var_29_16 = var_29_16 + 0.3

					if var_29_21 + var_29_16 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_21 + var_29_16
					end
				end

				arg_26_1.text_.text = var_29_19
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_22 = var_29_16 + 0.3
			local var_29_23 = math.max(var_29_17, arg_26_1.talkMaxDuration)

			if var_29_16 + 0.3 <= arg_26_1.time_ and arg_26_1.time_ < var_29_22 + var_29_23 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_22) / var_29_23

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_22 + var_29_23 and arg_26_1.time_ < var_29_22 + var_29_23 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0508",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0508",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 2.03333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play122141007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 122141007
		arg_32_1.duration_ = 5.9

		local var_32_0 = {
			ja = 5.9,
			ko = 4.633,
			zh = 4.633
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play122141008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:AudioAction("play", "music", "bgm_activity_2_2_story_talk", "bgm_activity_2_2_story_talk", "bgm_activity_2_2_story_talk.awb")

				local var_35_2 = manager.audio:GetAudioName("bgm_activity_2_2_story_talk", "bgm_activity_2_2_story_talk")

				if "" ~= "" then
					if arg_32_1.bgmTxt_.text ~= var_35_2 and arg_32_1.bgmTxt_.text ~= "" then
						if arg_32_1.bgmTxt2_.text ~= "" then
							arg_32_1.bgmTxt_.text = arg_32_1.bgmTxt2_.text
						end

						arg_32_1.bgmTxt2_.text = var_35_2

						arg_32_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_32_1.bgmTxt_.text = var_35_2
						arg_32_1.bgmTxt2_.text = var_35_2
					end

					if arg_32_1.bgmTimer then
						arg_32_1.bgmTimer:Stop()

						arg_32_1.bgmTimer = nil
					end

					if arg_32_1.settingData.show_music_name == 1 then
						arg_32_1.musicController:SetSelectedState("show")
						arg_32_1.musicAnimator_:Play("open", 0, 0)

						if arg_32_1.settingData.music_time ~= 0 then
							arg_32_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_32_1.settingData.music_time), function()
								if arg_32_1 == nil or isNil(arg_32_1.bgmTxt_) then
									return
								end

								arg_32_1.musicController:SetSelectedState("hide")
								arg_32_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_35_3 = 0
			local var_35_4 = 0.425

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_3 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_5 = arg_32_1:GetWordFromCfg(122141007)
				local var_35_6 = arg_32_1:FormatText(var_35_5.content)

				arg_32_1.text_.text = var_35_6

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_8 = 17 <= 0 and var_35_4 or var_35_4 * (utf8.len(var_35_6) / 17)

				if (17 <= 0 and var_35_4 or var_35_4 * (utf8.len(var_35_6) / 17)) > 0 and var_35_4 < var_35_8 then
					arg_32_1.talkMaxDuration = var_35_8

					if var_35_8 + var_35_3 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_3
					end
				end

				arg_32_1.text_.text = var_35_6
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141007", "story_v_out_122141.awb") ~= 0 then
					local var_35_9 = manager.audio:GetVoiceLength("story_v_out_122141", "122141007", "story_v_out_122141.awb") / 1000

					if var_35_9 + var_35_3 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_3
					end

					if var_35_5.prefab_name ~= "" and arg_32_1.actors_[var_35_5.prefab_name] ~= nil then
						local var_35_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_5.prefab_name].transform, "story_v_out_122141", "122141007", "story_v_out_122141.awb")

						arg_32_1:RecordAudio("122141007", var_35_10)
						arg_32_1:RecordAudio("122141007", var_35_10)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_122141", "122141007", "story_v_out_122141.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_122141", "122141007", "story_v_out_122141.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_11 = math.max(var_35_4, arg_32_1.talkMaxDuration)

			if var_35_3 <= arg_32_1.time_ and arg_32_1.time_ < var_35_3 + var_35_11 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_3) / var_35_11

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_3 + var_35_11 and arg_32_1.time_ < var_35_3 + var_35_11 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play122141008 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 122141008
		arg_37_1.duration_ = 10.1

		local var_37_0 = {
			ja = 10.1,
			ko = 6.833,
			zh = 6.833
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play122141009(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.675

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:GetWordFromCfg(122141008)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 26 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 26)

				if (26 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 26)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141008", "story_v_out_122141.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_122141", "122141008", "story_v_out_122141.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_122141", "122141008", "story_v_out_122141.awb")

						arg_37_1:RecordAudio("122141008", var_40_6)
						arg_37_1:RecordAudio("122141008", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_122141", "122141008", "story_v_out_122141.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_122141", "122141008", "story_v_out_122141.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play122141009 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 122141009
		arg_41_1.duration_ = 1.53

		local var_41_0 = {
			ja = 1.533,
			ko = 1.433,
			zh = 1.433
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play122141010(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.05

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:GetWordFromCfg(122141009)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 2 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 2)

				if (2 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 2)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141009", "story_v_out_122141.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_122141", "122141009", "story_v_out_122141.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_122141", "122141009", "story_v_out_122141.awb")

						arg_41_1:RecordAudio("122141009", var_44_6)
						arg_41_1:RecordAudio("122141009", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_122141", "122141009", "story_v_out_122141.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_122141", "122141009", "story_v_out_122141.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play122141010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 122141010
		arg_45_1.duration_ = 15.8

		local var_45_0 = {
			ja = 15.8,
			ko = 7.366,
			zh = 7.366
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play122141011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.575

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:GetWordFromCfg(122141010)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 23 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 23)

				if (23 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 23)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141010", "story_v_out_122141.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_122141", "122141010", "story_v_out_122141.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_122141", "122141010", "story_v_out_122141.awb")

						arg_45_1:RecordAudio("122141010", var_48_6)
						arg_45_1:RecordAudio("122141010", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_122141", "122141010", "story_v_out_122141.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_122141", "122141010", "story_v_out_122141.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play122141011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 122141011
		arg_49_1.duration_ = 14

		local var_49_0 = {
			ja = 14,
			ko = 12.9,
			zh = 12.9
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play122141012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.95

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:GetWordFromCfg(122141011)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 38 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 38)

				if (38 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 38)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141011", "story_v_out_122141.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_122141", "122141011", "story_v_out_122141.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_122141", "122141011", "story_v_out_122141.awb")

						arg_49_1:RecordAudio("122141011", var_52_6)
						arg_49_1:RecordAudio("122141011", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_122141", "122141011", "story_v_out_122141.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_122141", "122141011", "story_v_out_122141.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_7 and arg_49_1.time_ < 0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play122141012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 122141012
		arg_53_1.duration_ = 14.33

		local var_53_0 = {
			ja = 14.333,
			ko = 10.066,
			zh = 10.066
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play122141013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.9

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(122141012)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 36 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 36)

				if (36 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 36)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141012", "story_v_out_122141.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_122141", "122141012", "story_v_out_122141.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_122141", "122141012", "story_v_out_122141.awb")

						arg_53_1:RecordAudio("122141012", var_56_6)
						arg_53_1:RecordAudio("122141012", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_122141", "122141012", "story_v_out_122141.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_122141", "122141012", "story_v_out_122141.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play122141013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 122141013
		arg_57_1.duration_ = 2.47

		local var_57_0 = {
			ja = 2.233,
			ko = 2.466,
			zh = 2.466
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play122141014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.1

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:GetWordFromCfg(122141013)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 4 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 4)

				if (4 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 4)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141013", "story_v_out_122141.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_122141", "122141013", "story_v_out_122141.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_122141", "122141013", "story_v_out_122141.awb")

						arg_57_1:RecordAudio("122141013", var_60_6)
						arg_57_1:RecordAudio("122141013", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_122141", "122141013", "story_v_out_122141.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_122141", "122141013", "story_v_out_122141.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play122141014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 122141014
		arg_61_1.duration_ = 13.13

		local var_61_0 = {
			ja = 13.133,
			ko = 12.566,
			zh = 12.566
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play122141015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 1.025

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:GetWordFromCfg(122141014)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 41 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 41)

				if (41 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 41)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141014", "story_v_out_122141.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_122141", "122141014", "story_v_out_122141.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_122141", "122141014", "story_v_out_122141.awb")

						arg_61_1:RecordAudio("122141014", var_64_6)
						arg_61_1:RecordAudio("122141014", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_122141", "122141014", "story_v_out_122141.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_122141", "122141014", "story_v_out_122141.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play122141015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 122141015
		arg_65_1.duration_ = 5.9

		local var_65_0 = {
			ja = 5.9,
			ko = 4.366,
			zh = 4.366
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play122141016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.325

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_1 = arg_65_1:GetWordFromCfg(122141015)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 13 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 13)

				if (13 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 13)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141015", "story_v_out_122141.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_122141", "122141015", "story_v_out_122141.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_122141", "122141015", "story_v_out_122141.awb")

						arg_65_1:RecordAudio("122141015", var_68_6)
						arg_65_1:RecordAudio("122141015", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_122141", "122141015", "story_v_out_122141.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_122141", "122141015", "story_v_out_122141.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play122141016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 122141016
		arg_69_1.duration_ = 4.2

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play122141017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_0 = 2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				local var_72_1 = Color.New(0, 0, 0)

				var_72_1.a = Mathf.Lerp(0, 1, (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.mask_.color = var_72_1
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				local var_72_2 = Color.New(0, 0, 0)

				var_72_2.a = 1
				arg_69_1.mask_.color = var_72_2
			end

			local var_72_3 = 2

			if 2 < arg_69_1.time_ and arg_69_1.time_ <= var_72_3 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_4 = 1

			if var_72_3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_3 + var_72_4 then
				local var_72_5 = Color.New(0, 0, 0)

				var_72_5.a = Mathf.Lerp(1, 0, (arg_69_1.time_ - var_72_3) / var_72_4)
				arg_69_1.mask_.color = var_72_5
			end

			if arg_69_1.time_ >= var_72_3 + var_72_4 and arg_69_1.time_ < var_72_3 + var_72_4 + arg_72_0 then
				local var_72_6 = Color.New(0, 0, 0)

				arg_69_1.mask_.enabled = false
				var_72_6.a = 0
				arg_69_1.mask_.color = var_72_6
			end

			if 2 < arg_69_1.time_ and arg_69_1.time_ <= 2 + arg_72_0 then
				arg_69_1.fswbg_:SetActive(true)
				arg_69_1.dialog_:SetActive(false)

				arg_69_1.fswtw_.percent = 0
				arg_69_1.fswt_.text = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(122141016).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.fswt_)

				arg_69_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_69_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_69_1.fswtw_:SetDirty()

				arg_69_1.typewritterCharCountI18N = 0

				SetActive(arg_69_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_69_1:ShowNextGo(false)
			end

			local var_72_7 = 2.03333333333332

			if 2.03333333333332 < arg_69_1.time_ and arg_69_1.time_ <= var_72_7 + arg_72_0 then
				arg_69_1.var_.oldValueTypewriter = arg_69_1.fswtw_.percent

				SetActive(arg_69_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_69_1:ShowNextGo(false)
			end

			local var_72_8 = 8
			local var_72_9 = 0.533333333333333
			local var_72_10, var_72_11 = arg_69_1:GetPercentByPara(arg_69_1:FormatText(arg_69_1:GetWordFromCfg(122141016).content), 1)

			if var_72_7 < arg_69_1.time_ and arg_69_1.time_ <= var_72_7 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				local var_72_12 = var_72_8 <= 0 and var_72_9 or var_72_9 * ((var_72_11 - arg_69_1.typewritterCharCountI18N) / var_72_8)

				if (var_72_8 <= 0 and var_72_9 or var_72_9 * ((var_72_11 - arg_69_1.typewritterCharCountI18N) / var_72_8)) > 0 and var_72_9 < var_72_12 then
					arg_69_1.talkMaxDuration = var_72_12

					if var_72_12 + var_72_7 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_12 + var_72_7
					end
				end
			end

			local var_72_13 = math.max(0.533333333333333, arg_69_1.talkMaxDuration)

			if var_72_7 <= arg_69_1.time_ and arg_69_1.time_ < var_72_7 + var_72_13 then
				arg_69_1.fswtw_.percent = Mathf.Lerp(arg_69_1.var_.oldValueTypewriter, var_72_10, (arg_69_1.time_ - var_72_7) / var_72_13)
				arg_69_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_69_1.fswtw_:SetDirty()
			end

			if arg_69_1.time_ >= var_72_7 + var_72_13 and arg_69_1.time_ < var_72_7 + var_72_13 + arg_72_0 then
				arg_69_1.fswtw_.percent = var_72_10

				arg_69_1.fswtw_:SetDirty()
				arg_69_1:ShowNextGo(true)

				arg_69_1.typewritterCharCountI18N = var_72_11
			end

			local var_72_14 = "STblack"

			if arg_69_1.bgs_.STblack == nil then
				local var_72_15 = Object.Instantiate(arg_69_1.paintGo_)

				var_72_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_72_14)
				var_72_15.name = var_72_14
				var_72_15.transform.parent = arg_69_1.stage_.transform
				var_72_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.bgs_[var_72_14] = var_72_15
			end

			if 2 < arg_69_1.time_ and arg_69_1.time_ <= 2 + arg_72_0 then
				local var_72_16 = arg_69_1.bgs_.STblack

				arg_69_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_72_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_17 = var_72_16:GetComponent("SpriteRenderer")

				if var_72_17 and var_72_17.sprite then
					local var_72_18 = 2 * (var_72_16.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_72_16.transform.localScale = Vector3.New(var_72_18 / var_72_17.sprite.bounds.size.y < var_72_18 * manager.ui.mainCameraCom_.aspect / var_72_17.sprite.bounds.size.x and var_72_18 * manager.ui.mainCameraCom_.aspect / var_72_17.sprite.bounds.size.x or var_72_18 / var_72_17.sprite.bounds.size.y, var_72_18 / var_72_17.sprite.bounds.size.y < var_72_18 * manager.ui.mainCameraCom_.aspect / var_72_17.sprite.bounds.size.x and var_72_18 * manager.ui.mainCameraCom_.aspect / var_72_17.sprite.bounds.size.x or var_72_18 / var_72_17.sprite.bounds.size.y, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "STblack" then
						iter_72_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 2.03333333333333 < arg_69_1.time_ and arg_69_1.time_ <= 2.03333333333333 + arg_72_0 then
				arg_69_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_72_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_69_1.bgmTxt_.text ~= var_72_21 and arg_69_1.bgmTxt_.text ~= "" then
						if arg_69_1.bgmTxt2_.text ~= "" then
							arg_69_1.bgmTxt_.text = arg_69_1.bgmTxt2_.text
						end

						arg_69_1.bgmTxt2_.text = var_72_21

						arg_69_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_69_1.bgmTxt_.text = var_72_21
						arg_69_1.bgmTxt2_.text = var_72_21
					end

					if arg_69_1.bgmTimer then
						arg_69_1.bgmTimer:Stop()

						arg_69_1.bgmTimer = nil
					end

					if arg_69_1.settingData.show_music_name == 1 then
						arg_69_1.musicController:SetSelectedState("show")
						arg_69_1.musicAnimator_:Play("open", 0, 0)

						if arg_69_1.settingData.music_time ~= 0 then
							arg_69_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_69_1.settingData.music_time), function()
								if arg_69_1 == nil or isNil(arg_69_1.bgmTxt_) then
									return
								end

								arg_69_1.musicController:SetSelectedState("hide")
								arg_69_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play122141017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 122141017
		arg_74_1.duration_ = 4.7

		local var_74_0 = {
			ja = 4.366666666666,
			ko = 4.7,
			zh = 4.7
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play122141018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.mask_.enabled = true
				arg_74_1.mask_.raycastTarget = true

				arg_74_1:SetGaussion(false)
			end

			local var_77_0 = 2

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 then
				local var_77_1 = Color.New(0, 0, 0)

				var_77_1.a = Mathf.Lerp(0, 1, (arg_74_1.time_ - 0) / var_77_0)
				arg_74_1.mask_.color = var_77_1
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 then
				local var_77_2 = Color.New(0, 0, 0)

				var_77_2.a = 1
				arg_74_1.mask_.color = var_77_2
			end

			local var_77_3 = 2

			if 2 < arg_74_1.time_ and arg_74_1.time_ <= var_77_3 + arg_77_0 then
				arg_74_1.mask_.enabled = true
				arg_74_1.mask_.raycastTarget = true

				arg_74_1:SetGaussion(false)
			end

			local var_77_4 = 1

			if var_77_3 <= arg_74_1.time_ and arg_74_1.time_ < var_77_3 + var_77_4 then
				local var_77_5 = Color.New(0, 0, 0)

				var_77_5.a = Mathf.Lerp(1, 0, (arg_74_1.time_ - var_77_3) / var_77_4)
				arg_74_1.mask_.color = var_77_5
			end

			if arg_74_1.time_ >= var_77_3 + var_77_4 and arg_74_1.time_ < var_77_3 + var_77_4 + arg_77_0 then
				local var_77_6 = Color.New(0, 0, 0)

				arg_74_1.mask_.enabled = false
				var_77_6.a = 0
				arg_74_1.mask_.color = var_77_6
			end

			if 2 < arg_74_1.time_ and arg_74_1.time_ <= 2 + arg_77_0 then
				local var_77_7 = arg_74_1.bgs_.XH0508

				arg_74_1.bgs_.XH0508.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_77_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_77_8 = var_77_7:GetComponent("SpriteRenderer")

				if var_77_8 and var_77_8.sprite then
					local var_77_9 = 2 * (var_77_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_77_7.transform.localScale = Vector3.New(var_77_9 / var_77_8.sprite.bounds.size.y < var_77_9 * manager.ui.mainCameraCom_.aspect / var_77_8.sprite.bounds.size.x and var_77_9 * manager.ui.mainCameraCom_.aspect / var_77_8.sprite.bounds.size.x or var_77_9 / var_77_8.sprite.bounds.size.y, var_77_9 / var_77_8.sprite.bounds.size.y < var_77_9 * manager.ui.mainCameraCom_.aspect / var_77_8.sprite.bounds.size.x and var_77_9 * manager.ui.mainCameraCom_.aspect / var_77_8.sprite.bounds.size.x or var_77_9 / var_77_8.sprite.bounds.size.y, 0)
				end

				for iter_77_0, iter_77_1 in pairs(arg_74_1.bgs_) do
					if iter_77_0 ~= "XH0508" then
						iter_77_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1.96666666666667 < arg_74_1.time_ and arg_74_1.time_ <= 1.96666666666667 + arg_77_0 then
				arg_74_1.fswbg_:SetActive(false)
				arg_74_1.dialog_:SetActive(false)
				SetActive(arg_74_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_74_1:ShowNextGo(false)
			end

			if arg_74_1.frameCnt_ <= 1 then
				arg_74_1.dialog_:SetActive(false)
			end

			local var_77_10 = 2.9
			local var_77_11 = 0.1

			if 2.9 < arg_74_1.time_ and arg_74_1.time_ <= var_77_10 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0

				arg_74_1.dialog_:SetActive(true)

				arg_74_1.dialogCg_.alpha = 0

				local var_77_12 = LeanTween.value(arg_74_1.dialog_, 0, 1, 0.3)

				var_77_12:setOnUpdate(LuaHelper.FloatAction(function(arg_78_0)
					arg_74_1.dialogCg_.alpha = arg_78_0
				end))
				var_77_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_74_1.dialog_)
					var_77_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_74_1.duration_ = arg_74_1.duration_ + 0.3

				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_13 = arg_74_1:GetWordFromCfg(122141017)
				local var_77_14 = arg_74_1:FormatText(var_77_13.content)

				arg_74_1.text_.text = var_77_14

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_16 = 4 <= 0 and var_77_11 or var_77_11 * (utf8.len(var_77_14) / 4)

				if (4 <= 0 and var_77_11 or var_77_11 * (utf8.len(var_77_14) / 4)) > 0 and var_77_11 < var_77_16 then
					arg_74_1.talkMaxDuration = var_77_16
					var_77_10 = var_77_10 + 0.3

					if var_77_16 + var_77_10 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_16 + var_77_10
					end
				end

				arg_74_1.text_.text = var_77_14
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141017", "story_v_out_122141.awb") ~= 0 then
					local var_77_17 = manager.audio:GetVoiceLength("story_v_out_122141", "122141017", "story_v_out_122141.awb") / 1000

					if var_77_17 + var_77_10 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_17 + var_77_10
					end

					if var_77_13.prefab_name ~= "" and arg_74_1.actors_[var_77_13.prefab_name] ~= nil then
						local var_77_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_13.prefab_name].transform, "story_v_out_122141", "122141017", "story_v_out_122141.awb")

						arg_74_1:RecordAudio("122141017", var_77_18)
						arg_74_1:RecordAudio("122141017", var_77_18)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_122141", "122141017", "story_v_out_122141.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_122141", "122141017", "story_v_out_122141.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_19 = var_77_10 + 0.3
			local var_77_20 = math.max(var_77_11, arg_74_1.talkMaxDuration)

			if var_77_10 + 0.3 <= arg_74_1.time_ and arg_74_1.time_ < var_77_19 + var_77_20 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_19) / var_77_20

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_19 + var_77_20 and arg_74_1.time_ < var_77_19 + var_77_20 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play122141018 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 122141018
		arg_80_1.duration_ = 4.87

		local var_80_0 = {
			ja = 4.866,
			ko = 3.999999999999,
			zh = 3.999999999999
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play122141019(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if arg_80_1.bgs_.XH0506 == nil then
				local var_83_0 = Object.Instantiate(arg_80_1.paintGo_)

				var_83_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0506")
				var_83_0.name = "XH0506"
				var_83_0.transform.parent = arg_80_1.stage_.transform
				var_83_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_80_1.bgs_.XH0506 = var_83_0
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				local var_83_1 = arg_80_1.bgs_.XH0506

				arg_80_1.bgs_.XH0506.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_83_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_83_2 = var_83_1:GetComponent("SpriteRenderer")

				if var_83_2 and var_83_2.sprite then
					local var_83_3 = 2 * (var_83_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_83_1.transform.localScale = Vector3.New(var_83_3 / var_83_2.sprite.bounds.size.y < var_83_3 * manager.ui.mainCameraCom_.aspect / var_83_2.sprite.bounds.size.x and var_83_3 * manager.ui.mainCameraCom_.aspect / var_83_2.sprite.bounds.size.x or var_83_3 / var_83_2.sprite.bounds.size.y, var_83_3 / var_83_2.sprite.bounds.size.y < var_83_3 * manager.ui.mainCameraCom_.aspect / var_83_2.sprite.bounds.size.x and var_83_3 * manager.ui.mainCameraCom_.aspect / var_83_2.sprite.bounds.size.x or var_83_3 / var_83_2.sprite.bounds.size.y, 0)
				end

				for iter_83_0, iter_83_1 in pairs(arg_80_1.bgs_) do
					if iter_83_0 ~= "XH0506" then
						iter_83_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_83_4 = 0

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1.mask_.enabled = true
				arg_80_1.mask_.raycastTarget = true

				arg_80_1:SetGaussion(false)
			end

			local var_83_5 = 2

			if var_83_4 <= arg_80_1.time_ and arg_80_1.time_ < var_83_4 + var_83_5 then
				local var_83_6 = Color.New(1, 1, 1)

				var_83_6.a = Mathf.Lerp(1, 0, (arg_80_1.time_ - var_83_4) / var_83_5)
				arg_80_1.mask_.color = var_83_6
			end

			if arg_80_1.time_ >= var_83_4 + var_83_5 and arg_80_1.time_ < var_83_4 + var_83_5 + arg_83_0 then
				local var_83_7 = Color.New(1, 1, 1)

				arg_80_1.mask_.enabled = false
				var_83_7.a = 0
				arg_80_1.mask_.color = var_83_7
			end

			local var_83_8 = "1184ui_story"

			if arg_80_1.actors_["1184ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1184ui_story"))) then
				local var_83_9 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_80_1.stage_.transform)

				var_83_9.name = var_83_8
				var_83_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_80_1.actors_[var_83_8] = var_83_9

				local var_83_10 = var_83_9:GetComponentInChildren(typeof(CharacterEffect))

				var_83_10.enabled = true

				local var_83_11 = GameObjectTools.GetOrAddComponent(var_83_9, typeof(DynamicBoneHelper))

				if var_83_11 then
					var_83_11:EnableDynamicBone(false)
				end

				arg_80_1:ShowWeapon(var_83_10.transform, false)

				arg_80_1.var_[var_83_8 .. "Animator"] = var_83_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_80_1.var_[var_83_8 .. "Animator"].applyRootMotion = true
				arg_80_1.var_[var_83_8 .. "LipSync"] = var_83_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_83_12 = arg_80_1.actors_["1184ui_story"].transform

			if 1.8 < arg_80_1.time_ and arg_80_1.time_ <= 1.8 + arg_83_0 then
				arg_80_1.var_.moveOldPos1184ui_story = var_83_12.localPosition

				arg_80_1:ShowWeapon(arg_80_1.var_["1184ui_story" .. "Animator"].transform, true)
			end

			local var_83_13 = 0.001

			if 1.8 <= arg_80_1.time_ and arg_80_1.time_ < 1.8 + var_83_13 then
				var_83_12.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_80_1.time_ - 1.8) / var_83_13)
				var_83_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_12.position).x, (manager.ui.mainCamera.transform.position - var_83_12.position).y, (manager.ui.mainCamera.transform.position - var_83_12.position).z)
				var_83_12.localEulerAngles.z = 0
				var_83_12.localEulerAngles.x = 0
				var_83_12.localEulerAngles = var_83_12.localEulerAngles
			end

			if arg_80_1.time_ >= 1.8 + var_83_13 and arg_80_1.time_ < 1.8 + var_83_13 + arg_83_0 then
				var_83_12.localPosition = Vector3.New(0, -0.97, -6)
				var_83_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_12.position).x, (manager.ui.mainCamera.transform.position - var_83_12.position).y, (manager.ui.mainCamera.transform.position - var_83_12.position).z)
				var_83_12.localEulerAngles.z = 0
				var_83_12.localEulerAngles.x = 0
				var_83_12.localEulerAngles = var_83_12.localEulerAngles
			end

			local var_83_14 = arg_80_1.actors_["1184ui_story"]

			if 1.8 < arg_80_1.time_ and arg_80_1.time_ <= 1.8 + arg_83_0 and not isNil(var_83_14) and arg_80_1.var_.characterEffect1184ui_story == nil then
				arg_80_1.var_.characterEffect1184ui_story = var_83_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_15 = 0.200000002980232

			if 1.8 <= arg_80_1.time_ and arg_80_1.time_ < 1.8 + var_83_15 and not isNil(var_83_14) then
				if arg_80_1.var_.characterEffect1184ui_story and not isNil(var_83_14) then
					arg_80_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 1.8 + var_83_15 and arg_80_1.time_ < 1.8 + var_83_15 + arg_83_0 and not isNil(var_83_14) and arg_80_1.var_.characterEffect1184ui_story then
				arg_80_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 1.8 < arg_80_1.time_ and arg_80_1.time_ <= 1.8 + arg_83_0 then
				arg_80_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 1.8 < arg_80_1.time_ and arg_80_1.time_ <= 1.8 + arg_83_0 then
				arg_80_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			if 2.00000000298023 < arg_80_1.time_ and arg_80_1.time_ <= 2.00000000298023 + arg_83_0 then
				arg_80_1:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_83_19 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if "" ~= "" then
					if arg_80_1.bgmTxt_.text ~= var_83_19 and arg_80_1.bgmTxt_.text ~= "" then
						if arg_80_1.bgmTxt2_.text ~= "" then
							arg_80_1.bgmTxt_.text = arg_80_1.bgmTxt2_.text
						end

						arg_80_1.bgmTxt2_.text = var_83_19

						arg_80_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_80_1.bgmTxt_.text = var_83_19
						arg_80_1.bgmTxt2_.text = var_83_19
					end

					if arg_80_1.bgmTimer then
						arg_80_1.bgmTimer:Stop()

						arg_80_1.bgmTimer = nil
					end

					if arg_80_1.settingData.show_music_name == 1 then
						arg_80_1.musicController:SetSelectedState("show")
						arg_80_1.musicAnimator_:Play("open", 0, 0)

						if arg_80_1.settingData.music_time ~= 0 then
							arg_80_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_80_1.settingData.music_time), function()
								if arg_80_1 == nil or isNil(arg_80_1.bgmTxt_) then
									return
								end

								arg_80_1.musicController:SetSelectedState("hide")
								arg_80_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_80_1.frameCnt_ <= 1 then
				arg_80_1.dialog_:SetActive(false)
			end

			local var_83_20 = 2
			local var_83_21 = 0.125

			if 2 < arg_80_1.time_ and arg_80_1.time_ <= var_83_20 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0

				arg_80_1.dialog_:SetActive(true)

				arg_80_1.dialogCg_.alpha = 0

				local var_83_22 = LeanTween.value(arg_80_1.dialog_, 0, 1, 0.3)

				var_83_22:setOnUpdate(LuaHelper.FloatAction(function(arg_85_0)
					arg_80_1.dialogCg_.alpha = arg_85_0
				end))
				var_83_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_80_1.dialog_)
					var_83_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_80_1.duration_ = arg_80_1.duration_ + 0.3

				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_23 = arg_80_1:GetWordFromCfg(122141018)
				local var_83_24 = arg_80_1:FormatText(var_83_23.content)

				arg_80_1.text_.text = var_83_24

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_26 = 5 <= 0 and var_83_21 or var_83_21 * (utf8.len(var_83_24) / 5)

				if (5 <= 0 and var_83_21 or var_83_21 * (utf8.len(var_83_24) / 5)) > 0 and var_83_21 < var_83_26 then
					arg_80_1.talkMaxDuration = var_83_26
					var_83_20 = var_83_20 + 0.3

					if var_83_26 + var_83_20 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_26 + var_83_20
					end
				end

				arg_80_1.text_.text = var_83_24
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141018", "story_v_out_122141.awb") ~= 0 then
					local var_83_27 = manager.audio:GetVoiceLength("story_v_out_122141", "122141018", "story_v_out_122141.awb") / 1000

					if var_83_27 + var_83_20 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_27 + var_83_20
					end

					if var_83_23.prefab_name ~= "" and arg_80_1.actors_[var_83_23.prefab_name] ~= nil then
						local var_83_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_23.prefab_name].transform, "story_v_out_122141", "122141018", "story_v_out_122141.awb")

						arg_80_1:RecordAudio("122141018", var_83_28)
						arg_80_1:RecordAudio("122141018", var_83_28)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_122141", "122141018", "story_v_out_122141.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_122141", "122141018", "story_v_out_122141.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_29 = var_83_20 + 0.3
			local var_83_30 = math.max(var_83_21, arg_80_1.talkMaxDuration)

			if var_83_20 + 0.3 <= arg_80_1.time_ and arg_80_1.time_ < var_83_29 + var_83_30 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_29) / var_83_30

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_29 + var_83_30 and arg_80_1.time_ < var_83_29 + var_83_30 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play122141019 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 122141019
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play122141020(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["1184ui_story"]) and arg_87_1.var_.characterEffect1184ui_story == nil then
				arg_87_1.var_.characterEffect1184ui_story = arg_87_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_0 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["1184ui_story"]) then
				if arg_87_1.var_.characterEffect1184ui_story and not isNil(arg_87_1.actors_["1184ui_story"]) then
					arg_87_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_0)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["1184ui_story"]) and arg_87_1.var_.characterEffect1184ui_story then
				arg_87_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_90_1 = arg_87_1.actors_["1184ui_story"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1184ui_story = var_90_1.localPosition

				arg_87_1:ShowWeapon(arg_87_1.var_["1184ui_story" .. "Animator"].transform, false)
			end

			local var_90_2 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_2 then
				var_90_1.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_87_1.time_ - 0) / var_90_2)
				var_90_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_1.position).x, (manager.ui.mainCamera.transform.position - var_90_1.position).y, (manager.ui.mainCamera.transform.position - var_90_1.position).z)
				var_90_1.localEulerAngles.z = 0
				var_90_1.localEulerAngles.x = 0
				var_90_1.localEulerAngles = var_90_1.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_2 and arg_87_1.time_ < 0 + var_90_2 + arg_90_0 then
				var_90_1.localPosition = Vector3.New(0, 100, 0)
				var_90_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_1.position).x, (manager.ui.mainCamera.transform.position - var_90_1.position).y, (manager.ui.mainCamera.transform.position - var_90_1.position).z)
				var_90_1.localEulerAngles.z = 0
				var_90_1.localEulerAngles.x = 0
				var_90_1.localEulerAngles = var_90_1.localEulerAngles
			end

			local var_90_3 = 0
			local var_90_4 = 1.275

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_3 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_5 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(122141019).content)

				arg_87_1.text_.text = var_90_5

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_7 = 51 <= 0 and var_90_4 or var_90_4 * (utf8.len(var_90_5) / 51)

				if (51 <= 0 and var_90_4 or var_90_4 * (utf8.len(var_90_5) / 51)) > 0 and var_90_4 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_3 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_3
					end
				end

				arg_87_1.text_.text = var_90_5
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_8 = math.max(var_90_4, arg_87_1.talkMaxDuration)

			if var_90_3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_3 + var_90_8 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_3) / var_90_8

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_3 + var_90_8 and arg_87_1.time_ < var_90_3 + var_90_8 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play122141020 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 122141020
		arg_91_1.duration_ = 10.5

		local var_91_0 = {
			ja = 10.5,
			ko = 9.166,
			zh = 9.166
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play122141021(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["1184ui_story"]) and arg_91_1.var_.characterEffect1184ui_story == nil then
				arg_91_1.var_.characterEffect1184ui_story = arg_91_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["1184ui_story"]) then
				if arg_91_1.var_.characterEffect1184ui_story and not isNil(arg_91_1.actors_["1184ui_story"]) then
					arg_91_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["1184ui_story"]) and arg_91_1.var_.characterEffect1184ui_story then
				arg_91_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_94_2 = arg_91_1.actors_["1184ui_story"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1184ui_story = var_94_2.localPosition
			end

			local var_94_3 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_3 then
				var_94_2.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_91_1.time_ - 0) / var_94_3)
				var_94_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_2.position).x, (manager.ui.mainCamera.transform.position - var_94_2.position).y, (manager.ui.mainCamera.transform.position - var_94_2.position).z)
				var_94_2.localEulerAngles.z = 0
				var_94_2.localEulerAngles.x = 0
				var_94_2.localEulerAngles = var_94_2.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_3 and arg_91_1.time_ < 0 + var_94_3 + arg_94_0 then
				var_94_2.localPosition = Vector3.New(0, -0.97, -6)
				var_94_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_2.position).x, (manager.ui.mainCamera.transform.position - var_94_2.position).y, (manager.ui.mainCamera.transform.position - var_94_2.position).z)
				var_94_2.localEulerAngles.z = 0
				var_94_2.localEulerAngles.x = 0
				var_94_2.localEulerAngles = var_94_2.localEulerAngles
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_94_4 = 0
			local var_94_5 = 0.725

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_6 = arg_91_1:GetWordFromCfg(122141020)
				local var_94_7 = arg_91_1:FormatText(var_94_6.content)

				arg_91_1.text_.text = var_94_7

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_9 = 29 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 29)

				if (29 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 29)) > 0 and var_94_5 < var_94_9 then
					arg_91_1.talkMaxDuration = var_94_9

					if var_94_9 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_9 + var_94_4
					end
				end

				arg_91_1.text_.text = var_94_7
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141020", "story_v_out_122141.awb") ~= 0 then
					local var_94_10 = manager.audio:GetVoiceLength("story_v_out_122141", "122141020", "story_v_out_122141.awb") / 1000

					if var_94_10 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_10 + var_94_4
					end

					if var_94_6.prefab_name ~= "" and arg_91_1.actors_[var_94_6.prefab_name] ~= nil then
						local var_94_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_6.prefab_name].transform, "story_v_out_122141", "122141020", "story_v_out_122141.awb")

						arg_91_1:RecordAudio("122141020", var_94_11)
						arg_91_1:RecordAudio("122141020", var_94_11)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_122141", "122141020", "story_v_out_122141.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_122141", "122141020", "story_v_out_122141.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_12 = math.max(var_94_5, arg_91_1.talkMaxDuration)

			if var_94_4 <= arg_91_1.time_ and arg_91_1.time_ < var_94_4 + var_94_12 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_4) / var_94_12

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_4 + var_94_12 and arg_91_1.time_ < var_94_4 + var_94_12 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play122141021 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 122141021
		arg_95_1.duration_ = 4.4

		local var_95_0 = {
			ja = 4.4,
			ko = 3.366,
			zh = 3.366
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play122141022(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1184ui_story = arg_95_1.actors_["1184ui_story"].transform.localPosition

				arg_95_1:ShowWeapon(arg_95_1.var_["1184ui_story" .. "Animator"].transform, false)
			end

			local var_98_0 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				arg_95_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_95_1.time_ - 0) / var_98_0)
				arg_95_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1184ui_story"].transform.position).z)
				arg_95_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1184ui_story"].transform.localEulerAngles = arg_95_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				arg_95_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_95_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1184ui_story"].transform.position).z)
				arg_95_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1184ui_story"].transform.localEulerAngles = arg_95_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_98_1 = arg_95_1.actors_["1184ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1184ui_story == nil then
				arg_95_1.var_.characterEffect1184ui_story = var_98_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_2 and not isNil(var_98_1) then
				if arg_95_1.var_.characterEffect1184ui_story and not isNil(var_98_1) then
					arg_95_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_2 and arg_95_1.time_ < 0 + var_98_2 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1184ui_story then
				arg_95_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_98_4 = 0
			local var_98_5 = 0.275

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_6 = arg_95_1:GetWordFromCfg(122141021)
				local var_98_7 = arg_95_1:FormatText(var_98_6.content)

				arg_95_1.text_.text = var_98_7

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_9 = 11 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 11)

				if (11 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 11)) > 0 and var_98_5 < var_98_9 then
					arg_95_1.talkMaxDuration = var_98_9

					if var_98_9 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_4
					end
				end

				arg_95_1.text_.text = var_98_7
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141021", "story_v_out_122141.awb") ~= 0 then
					local var_98_10 = manager.audio:GetVoiceLength("story_v_out_122141", "122141021", "story_v_out_122141.awb") / 1000

					if var_98_10 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_4
					end

					if var_98_6.prefab_name ~= "" and arg_95_1.actors_[var_98_6.prefab_name] ~= nil then
						local var_98_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_6.prefab_name].transform, "story_v_out_122141", "122141021", "story_v_out_122141.awb")

						arg_95_1:RecordAudio("122141021", var_98_11)
						arg_95_1:RecordAudio("122141021", var_98_11)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_122141", "122141021", "story_v_out_122141.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_122141", "122141021", "story_v_out_122141.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_12 = math.max(var_98_5, arg_95_1.talkMaxDuration)

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_12 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_4) / var_98_12

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_4 + var_98_12 and arg_95_1.time_ < var_98_4 + var_98_12 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play122141022 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 122141022
		arg_99_1.duration_ = 10.33

		local var_99_0 = {
			ja = 10.333,
			ko = 8.466,
			zh = 8.466
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play122141023(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["1184ui_story"]) and arg_99_1.var_.characterEffect1184ui_story == nil then
				arg_99_1.var_.characterEffect1184ui_story = arg_99_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_0 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["1184ui_story"]) then
				if arg_99_1.var_.characterEffect1184ui_story and not isNil(arg_99_1.actors_["1184ui_story"]) then
					arg_99_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_0)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["1184ui_story"]) and arg_99_1.var_.characterEffect1184ui_story then
				arg_99_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_102_1 = 0
			local var_102_2 = 0.7

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_3 = arg_99_1:GetWordFromCfg(122141022)
				local var_102_4 = arg_99_1:FormatText(var_102_3.content)

				arg_99_1.text_.text = var_102_4

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_6 = 28 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_4) / 28)

				if (28 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_4) / 28)) > 0 and var_102_2 < var_102_6 then
					arg_99_1.talkMaxDuration = var_102_6

					if var_102_6 + var_102_1 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_6 + var_102_1
					end
				end

				arg_99_1.text_.text = var_102_4
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141022", "story_v_out_122141.awb") ~= 0 then
					local var_102_7 = manager.audio:GetVoiceLength("story_v_out_122141", "122141022", "story_v_out_122141.awb") / 1000

					if var_102_7 + var_102_1 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_1
					end

					if var_102_3.prefab_name ~= "" and arg_99_1.actors_[var_102_3.prefab_name] ~= nil then
						local var_102_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_3.prefab_name].transform, "story_v_out_122141", "122141022", "story_v_out_122141.awb")

						arg_99_1:RecordAudio("122141022", var_102_8)
						arg_99_1:RecordAudio("122141022", var_102_8)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_122141", "122141022", "story_v_out_122141.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_122141", "122141022", "story_v_out_122141.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_9 = math.max(var_102_2, arg_99_1.talkMaxDuration)

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_9 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_1) / var_102_9

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_1 + var_102_9 and arg_99_1.time_ < var_102_1 + var_102_9 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play122141023 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 122141023
		arg_103_1.duration_ = 4.87

		local var_103_0 = {
			ja = 4.866,
			ko = 3.433,
			zh = 3.433
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play122141024(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["1184ui_story"]) and arg_103_1.var_.characterEffect1184ui_story == nil then
				arg_103_1.var_.characterEffect1184ui_story = arg_103_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_0 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["1184ui_story"]) then
				if arg_103_1.var_.characterEffect1184ui_story and not isNil(arg_103_1.actors_["1184ui_story"]) then
					arg_103_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["1184ui_story"]) and arg_103_1.var_.characterEffect1184ui_story then
				arg_103_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action41213")
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_106_2 = 0
			local var_106_3 = 0.35

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_2 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_4 = arg_103_1:GetWordFromCfg(122141023)
				local var_106_5 = arg_103_1:FormatText(var_106_4.content)

				arg_103_1.text_.text = var_106_5

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_7 = 14 <= 0 and var_106_3 or var_106_3 * (utf8.len(var_106_5) / 14)

				if (14 <= 0 and var_106_3 or var_106_3 * (utf8.len(var_106_5) / 14)) > 0 and var_106_3 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_2 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_2
					end
				end

				arg_103_1.text_.text = var_106_5
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141023", "story_v_out_122141.awb") ~= 0 then
					local var_106_8 = manager.audio:GetVoiceLength("story_v_out_122141", "122141023", "story_v_out_122141.awb") / 1000

					if var_106_8 + var_106_2 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_2
					end

					if var_106_4.prefab_name ~= "" and arg_103_1.actors_[var_106_4.prefab_name] ~= nil then
						local var_106_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_4.prefab_name].transform, "story_v_out_122141", "122141023", "story_v_out_122141.awb")

						arg_103_1:RecordAudio("122141023", var_106_9)
						arg_103_1:RecordAudio("122141023", var_106_9)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_122141", "122141023", "story_v_out_122141.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_122141", "122141023", "story_v_out_122141.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_10 = math.max(var_106_3, arg_103_1.talkMaxDuration)

			if var_106_2 <= arg_103_1.time_ and arg_103_1.time_ < var_106_2 + var_106_10 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_2) / var_106_10

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_2 + var_106_10 and arg_103_1.time_ < var_106_2 + var_106_10 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play122141024 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 122141024
		arg_107_1.duration_ = 6.83

		local var_107_0 = {
			ja = 6.833,
			ko = 6.066,
			zh = 6.066
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play122141025(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_110_0 = 0
			local var_110_1 = 0.675

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_2 = arg_107_1:GetWordFromCfg(122141024)
				local var_110_3 = arg_107_1:FormatText(var_110_2.content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 27 <= 0 and var_110_1 or var_110_1 * (utf8.len(var_110_3) / 27)

				if (27 <= 0 and var_110_1 or var_110_1 * (utf8.len(var_110_3) / 27)) > 0 and var_110_1 < var_110_5 then
					arg_107_1.talkMaxDuration = var_110_5

					if var_110_5 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141024", "story_v_out_122141.awb") ~= 0 then
					local var_110_6 = manager.audio:GetVoiceLength("story_v_out_122141", "122141024", "story_v_out_122141.awb") / 1000

					if var_110_6 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_6 + var_110_0
					end

					if var_110_2.prefab_name ~= "" and arg_107_1.actors_[var_110_2.prefab_name] ~= nil then
						local var_110_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_2.prefab_name].transform, "story_v_out_122141", "122141024", "story_v_out_122141.awb")

						arg_107_1:RecordAudio("122141024", var_110_7)
						arg_107_1:RecordAudio("122141024", var_110_7)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_122141", "122141024", "story_v_out_122141.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_122141", "122141024", "story_v_out_122141.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_8 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_8 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_0) / var_110_8

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_8 and arg_107_1.time_ < var_110_0 + var_110_8 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play122141025 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 122141025
		arg_111_1.duration_ = 14.97

		local var_111_0 = {
			ja = 14.966,
			ko = 7.833,
			zh = 7.833
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play122141026(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1184ui_story"]) and arg_111_1.var_.characterEffect1184ui_story == nil then
				arg_111_1.var_.characterEffect1184ui_story = arg_111_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1184ui_story"]) then
				if arg_111_1.var_.characterEffect1184ui_story and not isNil(arg_111_1.actors_["1184ui_story"]) then
					arg_111_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_0)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1184ui_story"]) and arg_111_1.var_.characterEffect1184ui_story then
				arg_111_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_114_1 = 0
			local var_114_2 = 0.825

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_3 = arg_111_1:GetWordFromCfg(122141025)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_6 = 33 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_4) / 33)

				if (33 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_4) / 33)) > 0 and var_114_2 < var_114_6 then
					arg_111_1.talkMaxDuration = var_114_6

					if var_114_6 + var_114_1 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_6 + var_114_1
					end
				end

				arg_111_1.text_.text = var_114_4
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141025", "story_v_out_122141.awb") ~= 0 then
					local var_114_7 = manager.audio:GetVoiceLength("story_v_out_122141", "122141025", "story_v_out_122141.awb") / 1000

					if var_114_7 + var_114_1 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_1
					end

					if var_114_3.prefab_name ~= "" and arg_111_1.actors_[var_114_3.prefab_name] ~= nil then
						local var_114_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_3.prefab_name].transform, "story_v_out_122141", "122141025", "story_v_out_122141.awb")

						arg_111_1:RecordAudio("122141025", var_114_8)
						arg_111_1:RecordAudio("122141025", var_114_8)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_122141", "122141025", "story_v_out_122141.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_122141", "122141025", "story_v_out_122141.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_9 = math.max(var_114_2, arg_111_1.talkMaxDuration)

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_9 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_1) / var_114_9

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_1 + var_114_9 and arg_111_1.time_ < var_114_1 + var_114_9 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play122141026 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 122141026
		arg_115_1.duration_ = 22.03

		local var_115_0 = {
			ja = 22.033,
			ko = 14.066,
			zh = 14.066
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play122141027(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 1.125

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_1 = arg_115_1:GetWordFromCfg(122141026)
				local var_118_2 = arg_115_1:FormatText(var_118_1.content)

				arg_115_1.text_.text = var_118_2

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_4 = 45 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 45)

				if (45 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 45)) > 0 and var_118_0 < var_118_4 then
					arg_115_1.talkMaxDuration = var_118_4

					if var_118_4 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_4 + 0
					end
				end

				arg_115_1.text_.text = var_118_2
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141026", "story_v_out_122141.awb") ~= 0 then
					local var_118_5 = manager.audio:GetVoiceLength("story_v_out_122141", "122141026", "story_v_out_122141.awb") / 1000

					if var_118_5 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + 0
					end

					if var_118_1.prefab_name ~= "" and arg_115_1.actors_[var_118_1.prefab_name] ~= nil then
						local var_118_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_1.prefab_name].transform, "story_v_out_122141", "122141026", "story_v_out_122141.awb")

						arg_115_1:RecordAudio("122141026", var_118_6)
						arg_115_1:RecordAudio("122141026", var_118_6)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_122141", "122141026", "story_v_out_122141.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_122141", "122141026", "story_v_out_122141.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_7 = math.max(var_118_0, arg_115_1.talkMaxDuration)

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_7 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - 0) / var_118_7

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= 0 + var_118_7 and arg_115_1.time_ < 0 + var_118_7 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play122141027 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 122141027
		arg_119_1.duration_ = 5.87

		local var_119_0 = {
			ja = 5.866,
			ko = 4.966,
			zh = 4.966
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play122141028(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1184ui_story = arg_119_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_122_0 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 then
				arg_119_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_119_1.time_ - 0) / var_122_0)
				arg_119_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1184ui_story"].transform.position).z)
				arg_119_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1184ui_story"].transform.localEulerAngles = arg_119_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 then
				arg_119_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_119_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1184ui_story"].transform.position).z)
				arg_119_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1184ui_story"].transform.localEulerAngles = arg_119_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_122_1 = arg_119_1.actors_["1184ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1184ui_story == nil then
				arg_119_1.var_.characterEffect1184ui_story = var_122_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_2 and not isNil(var_122_1) then
				if arg_119_1.var_.characterEffect1184ui_story and not isNil(var_122_1) then
					arg_119_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_2 and arg_119_1.time_ < 0 + var_122_2 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1184ui_story then
				arg_119_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4135")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_122_4 = 0
			local var_122_5 = 0.55

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_6 = arg_119_1:GetWordFromCfg(122141027)
				local var_122_7 = arg_119_1:FormatText(var_122_6.content)

				arg_119_1.text_.text = var_122_7

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_9 = 22 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 22)

				if (22 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 22)) > 0 and var_122_5 < var_122_9 then
					arg_119_1.talkMaxDuration = var_122_9

					if var_122_9 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_9 + var_122_4
					end
				end

				arg_119_1.text_.text = var_122_7
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141027", "story_v_out_122141.awb") ~= 0 then
					local var_122_10 = manager.audio:GetVoiceLength("story_v_out_122141", "122141027", "story_v_out_122141.awb") / 1000

					if var_122_10 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_4
					end

					if var_122_6.prefab_name ~= "" and arg_119_1.actors_[var_122_6.prefab_name] ~= nil then
						local var_122_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_6.prefab_name].transform, "story_v_out_122141", "122141027", "story_v_out_122141.awb")

						arg_119_1:RecordAudio("122141027", var_122_11)
						arg_119_1:RecordAudio("122141027", var_122_11)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_122141", "122141027", "story_v_out_122141.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_122141", "122141027", "story_v_out_122141.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_12 = math.max(var_122_5, arg_119_1.talkMaxDuration)

			if var_122_4 <= arg_119_1.time_ and arg_119_1.time_ < var_122_4 + var_122_12 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_4) / var_122_12

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_4 + var_122_12 and arg_119_1.time_ < var_122_4 + var_122_12 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play122141028 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 122141028
		arg_123_1.duration_ = 11.43

		local var_123_0 = {
			ja = 11.433,
			ko = 4.466,
			zh = 4.466
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play122141029(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["1184ui_story"]) and arg_123_1.var_.characterEffect1184ui_story == nil then
				arg_123_1.var_.characterEffect1184ui_story = arg_123_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_0 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["1184ui_story"]) then
				if arg_123_1.var_.characterEffect1184ui_story and not isNil(arg_123_1.actors_["1184ui_story"]) then
					arg_123_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_0)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["1184ui_story"]) and arg_123_1.var_.characterEffect1184ui_story then
				arg_123_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_126_1 = 0
			local var_126_2 = 0.375

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_3 = arg_123_1:GetWordFromCfg(122141028)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_6 = 15 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_4) / 15)

				if (15 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_4) / 15)) > 0 and var_126_2 < var_126_6 then
					arg_123_1.talkMaxDuration = var_126_6

					if var_126_6 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_6 + var_126_1
					end
				end

				arg_123_1.text_.text = var_126_4
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141028", "story_v_out_122141.awb") ~= 0 then
					local var_126_7 = manager.audio:GetVoiceLength("story_v_out_122141", "122141028", "story_v_out_122141.awb") / 1000

					if var_126_7 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_1
					end

					if var_126_3.prefab_name ~= "" and arg_123_1.actors_[var_126_3.prefab_name] ~= nil then
						local var_126_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_3.prefab_name].transform, "story_v_out_122141", "122141028", "story_v_out_122141.awb")

						arg_123_1:RecordAudio("122141028", var_126_8)
						arg_123_1:RecordAudio("122141028", var_126_8)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_122141", "122141028", "story_v_out_122141.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_122141", "122141028", "story_v_out_122141.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_9 = math.max(var_126_2, arg_123_1.talkMaxDuration)

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_9 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_1) / var_126_9

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_1 + var_126_9 and arg_123_1.time_ < var_126_1 + var_126_9 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play122141029 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 122141029
		arg_127_1.duration_ = 11.83

		local var_127_0 = {
			ja = 11.833,
			ko = 6.933,
			zh = 6.933
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play122141030(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.6

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_1 = arg_127_1:GetWordFromCfg(122141029)
				local var_130_2 = arg_127_1:FormatText(var_130_1.content)

				arg_127_1.text_.text = var_130_2

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 24 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 24)

				if (24 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 24)) > 0 and var_130_0 < var_130_4 then
					arg_127_1.talkMaxDuration = var_130_4

					if var_130_4 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_4 + 0
					end
				end

				arg_127_1.text_.text = var_130_2
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141029", "story_v_out_122141.awb") ~= 0 then
					local var_130_5 = manager.audio:GetVoiceLength("story_v_out_122141", "122141029", "story_v_out_122141.awb") / 1000

					if var_130_5 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + 0
					end

					if var_130_1.prefab_name ~= "" and arg_127_1.actors_[var_130_1.prefab_name] ~= nil then
						local var_130_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_1.prefab_name].transform, "story_v_out_122141", "122141029", "story_v_out_122141.awb")

						arg_127_1:RecordAudio("122141029", var_130_6)
						arg_127_1:RecordAudio("122141029", var_130_6)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_122141", "122141029", "story_v_out_122141.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_122141", "122141029", "story_v_out_122141.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_7 and arg_127_1.time_ < 0 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play122141030 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 122141030
		arg_131_1.duration_ = 7.3

		local var_131_0 = {
			ja = 7.3,
			ko = 6.633,
			zh = 6.633
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play122141031(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1184ui_story"]) and arg_131_1.var_.characterEffect1184ui_story == nil then
				arg_131_1.var_.characterEffect1184ui_story = arg_131_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1184ui_story"]) then
				if arg_131_1.var_.characterEffect1184ui_story and not isNil(arg_131_1.actors_["1184ui_story"]) then
					arg_131_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1184ui_story"]) and arg_131_1.var_.characterEffect1184ui_story then
				arg_131_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_2")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_134_2 = 0
			local var_134_3 = 0.7

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_2 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_4 = arg_131_1:GetWordFromCfg(122141030)
				local var_134_5 = arg_131_1:FormatText(var_134_4.content)

				arg_131_1.text_.text = var_134_5

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_7 = 28 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_5) / 28)

				if (28 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_5) / 28)) > 0 and var_134_3 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_2
					end
				end

				arg_131_1.text_.text = var_134_5
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141030", "story_v_out_122141.awb") ~= 0 then
					local var_134_8 = manager.audio:GetVoiceLength("story_v_out_122141", "122141030", "story_v_out_122141.awb") / 1000

					if var_134_8 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_8 + var_134_2
					end

					if var_134_4.prefab_name ~= "" and arg_131_1.actors_[var_134_4.prefab_name] ~= nil then
						local var_134_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_4.prefab_name].transform, "story_v_out_122141", "122141030", "story_v_out_122141.awb")

						arg_131_1:RecordAudio("122141030", var_134_9)
						arg_131_1:RecordAudio("122141030", var_134_9)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_122141", "122141030", "story_v_out_122141.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_122141", "122141030", "story_v_out_122141.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_10 = math.max(var_134_3, arg_131_1.talkMaxDuration)

			if var_134_2 <= arg_131_1.time_ and arg_131_1.time_ < var_134_2 + var_134_10 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_2) / var_134_10

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_2 + var_134_10 and arg_131_1.time_ < var_134_2 + var_134_10 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play122141031 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 122141031
		arg_135_1.duration_ = 6.43

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play122141032(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1184ui_story = arg_135_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_138_0 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 then
				arg_135_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_135_1.time_ - 0) / var_138_0)
				arg_135_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1184ui_story"].transform.position).z)
				arg_135_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1184ui_story"].transform.localEulerAngles = arg_135_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 then
				arg_135_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_135_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1184ui_story"].transform.position).z)
				arg_135_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1184ui_story"].transform.localEulerAngles = arg_135_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_138_1 = 0

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.mask_.enabled = true
				arg_135_1.mask_.raycastTarget = false

				arg_135_1:SetGaussion(false)
			end

			local var_138_2 = 2

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 then
				local var_138_3 = Color.New(1, 1, 1)

				var_138_3.a = Mathf.Lerp(1, 0, (arg_135_1.time_ - var_138_1) / var_138_2)
				arg_135_1.mask_.color = var_138_3
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 then
				local var_138_4 = Color.New(1, 1, 1)

				arg_135_1.mask_.enabled = false
				var_138_4.a = 0
				arg_135_1.mask_.color = var_138_4
			end

			local var_138_5 = arg_135_1.bgs_.XH0506.transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPosXH0506 = var_138_5.localPosition
			end

			local var_138_6 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_6 then
				var_138_5.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPosXH0506, Vector3.New(0, 1, 9.5), (arg_135_1.time_ - 0) / var_138_6)
			end

			if arg_135_1.time_ >= 0 + var_138_6 and arg_135_1.time_ < 0 + var_138_6 + arg_138_0 then
				var_138_5.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_138_7 = arg_135_1.bgs_.XH0506.transform

			if 0.034000001847744 < arg_135_1.time_ and arg_135_1.time_ <= 0.034000001847744 + arg_138_0 then
				arg_135_1.var_.moveOldPosXH0506 = var_138_7.localPosition
			end

			local var_138_8 = 3.5

			if 0.034000001847744 <= arg_135_1.time_ and arg_135_1.time_ < 0.034000001847744 + var_138_8 then
				var_138_7.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPosXH0506, Vector3.New(0, 1, 10), (arg_135_1.time_ - 0.034000001847744) / var_138_8)
			end

			if arg_135_1.time_ >= 0.034000001847744 + var_138_8 and arg_135_1.time_ < 0.034000001847744 + var_138_8 + arg_138_0 then
				var_138_7.localPosition = Vector3.New(0, 1, 10)
			end

			local var_138_9 = 2

			if 2 < arg_135_1.time_ and arg_135_1.time_ <= var_138_9 + arg_138_0 then
				arg_135_1.allBtn_.enabled = false
			end

			if arg_135_1.time_ >= var_138_9 + 1.53400000184774 and arg_135_1.time_ < var_138_9 + 1.53400000184774 + arg_138_0 then
				arg_135_1.allBtn_.enabled = true
			end

			if arg_135_1.frameCnt_ <= 1 then
				arg_135_1.dialog_:SetActive(false)
			end

			local var_138_10 = 1.43333333333333
			local var_138_11 = 1.275

			if 1.43333333333333 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0

				arg_135_1.dialog_:SetActive(true)

				arg_135_1.dialogCg_.alpha = 0

				local var_138_12 = LeanTween.value(arg_135_1.dialog_, 0, 1, 0.3)

				var_138_12:setOnUpdate(LuaHelper.FloatAction(function(arg_139_0)
					arg_135_1.dialogCg_.alpha = arg_139_0
				end))
				var_138_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_135_1.dialog_)
					var_138_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_135_1.duration_ = arg_135_1.duration_ + 0.3

				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_13 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(122141031).content)

				arg_135_1.text_.text = var_138_13

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_15 = 51 <= 0 and var_138_11 or var_138_11 * (utf8.len(var_138_13) / 51)

				if (51 <= 0 and var_138_11 or var_138_11 * (utf8.len(var_138_13) / 51)) > 0 and var_138_11 < var_138_15 then
					arg_135_1.talkMaxDuration = var_138_15
					var_138_10 = var_138_10 + 0.3

					if var_138_15 + var_138_10 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_15 + var_138_10
					end
				end

				arg_135_1.text_.text = var_138_13
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_16 = var_138_10 + 0.3
			local var_138_17 = math.max(var_138_11, arg_135_1.talkMaxDuration)

			if var_138_10 + 0.3 <= arg_135_1.time_ and arg_135_1.time_ < var_138_16 + var_138_17 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_16) / var_138_17

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_16 + var_138_17 and arg_135_1.time_ < var_138_16 + var_138_17 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "XH0506",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0506",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 0.034000001847744,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play122141032 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 122141032
		arg_141_1.duration_ = 5.83

		local var_141_0 = {
			ja = 5.833,
			ko = 5.566,
			zh = 5.566
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play122141033(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.425

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_1 = arg_141_1:GetWordFromCfg(122141032)
				local var_144_2 = arg_141_1:FormatText(var_144_1.content)

				arg_141_1.text_.text = var_144_2

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 17 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 17)

				if (17 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 17)) > 0 and var_144_0 < var_144_4 then
					arg_141_1.talkMaxDuration = var_144_4

					if var_144_4 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_4 + 0
					end
				end

				arg_141_1.text_.text = var_144_2
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141032", "story_v_out_122141.awb") ~= 0 then
					local var_144_5 = manager.audio:GetVoiceLength("story_v_out_122141", "122141032", "story_v_out_122141.awb") / 1000

					if var_144_5 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + 0
					end

					if var_144_1.prefab_name ~= "" and arg_141_1.actors_[var_144_1.prefab_name] ~= nil then
						local var_144_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_1.prefab_name].transform, "story_v_out_122141", "122141032", "story_v_out_122141.awb")

						arg_141_1:RecordAudio("122141032", var_144_6)
						arg_141_1:RecordAudio("122141032", var_144_6)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_122141", "122141032", "story_v_out_122141.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_122141", "122141032", "story_v_out_122141.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play122141033 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 122141033
		arg_145_1.duration_ = 4.7

		local var_145_0 = {
			ja = 4.7,
			ko = 3.633,
			zh = 3.633
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play122141034(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1184ui_story = arg_145_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1184ui_story"].transform.position).z)
				arg_145_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1184ui_story"].transform.localEulerAngles = arg_145_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_145_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1184ui_story"].transform.position).z)
				arg_145_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1184ui_story"].transform.localEulerAngles = arg_145_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["1184ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1184ui_story == nil then
				arg_145_1.var_.characterEffect1184ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect1184ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1184ui_story then
				arg_145_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_148_4 = 0
			local var_148_5 = 0.25

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_6 = arg_145_1:GetWordFromCfg(122141033)
				local var_148_7 = arg_145_1:FormatText(var_148_6.content)

				arg_145_1.text_.text = var_148_7

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_9 = 10 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 10)

				if (10 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 10)) > 0 and var_148_5 < var_148_9 then
					arg_145_1.talkMaxDuration = var_148_9

					if var_148_9 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_9 + var_148_4
					end
				end

				arg_145_1.text_.text = var_148_7
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141033", "story_v_out_122141.awb") ~= 0 then
					local var_148_10 = manager.audio:GetVoiceLength("story_v_out_122141", "122141033", "story_v_out_122141.awb") / 1000

					if var_148_10 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_10 + var_148_4
					end

					if var_148_6.prefab_name ~= "" and arg_145_1.actors_[var_148_6.prefab_name] ~= nil then
						local var_148_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_6.prefab_name].transform, "story_v_out_122141", "122141033", "story_v_out_122141.awb")

						arg_145_1:RecordAudio("122141033", var_148_11)
						arg_145_1:RecordAudio("122141033", var_148_11)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_122141", "122141033", "story_v_out_122141.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_122141", "122141033", "story_v_out_122141.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_12 = math.max(var_148_5, arg_145_1.talkMaxDuration)

			if var_148_4 <= arg_145_1.time_ and arg_145_1.time_ < var_148_4 + var_148_12 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_4) / var_148_12

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_4 + var_148_12 and arg_145_1.time_ < var_148_4 + var_148_12 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play122141034 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 122141034
		arg_149_1.duration_ = 17.73

		local var_149_0 = {
			ja = 17.733,
			ko = 17.033,
			zh = 17.033
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play122141035(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1184ui_story"]) and arg_149_1.var_.characterEffect1184ui_story == nil then
				arg_149_1.var_.characterEffect1184ui_story = arg_149_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1184ui_story"]) then
				if arg_149_1.var_.characterEffect1184ui_story and not isNil(arg_149_1.actors_["1184ui_story"]) then
					arg_149_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_0)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1184ui_story"]) and arg_149_1.var_.characterEffect1184ui_story then
				arg_149_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_152_1 = 0
			local var_152_2 = 1.7

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_3 = arg_149_1:GetWordFromCfg(122141034)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_6 = 67 <= 0 and var_152_2 or var_152_2 * (utf8.len(var_152_4) / 67)

				if (67 <= 0 and var_152_2 or var_152_2 * (utf8.len(var_152_4) / 67)) > 0 and var_152_2 < var_152_6 then
					arg_149_1.talkMaxDuration = var_152_6

					if var_152_6 + var_152_1 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_6 + var_152_1
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141034", "story_v_out_122141.awb") ~= 0 then
					local var_152_7 = manager.audio:GetVoiceLength("story_v_out_122141", "122141034", "story_v_out_122141.awb") / 1000

					if var_152_7 + var_152_1 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_1
					end

					if var_152_3.prefab_name ~= "" and arg_149_1.actors_[var_152_3.prefab_name] ~= nil then
						local var_152_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_3.prefab_name].transform, "story_v_out_122141", "122141034", "story_v_out_122141.awb")

						arg_149_1:RecordAudio("122141034", var_152_8)
						arg_149_1:RecordAudio("122141034", var_152_8)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_122141", "122141034", "story_v_out_122141.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_122141", "122141034", "story_v_out_122141.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_9 = math.max(var_152_2, arg_149_1.talkMaxDuration)

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_9 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_1) / var_152_9

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_1 + var_152_9 and arg_149_1.time_ < var_152_1 + var_152_9 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play122141035 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 122141035
		arg_153_1.duration_ = 19.37

		local var_153_0 = {
			ja = 19.366,
			ko = 12.433,
			zh = 12.433
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play122141036(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 1.125

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:GetWordFromCfg(122141035)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 45 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 45)

				if (45 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 45)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141035", "story_v_out_122141.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_122141", "122141035", "story_v_out_122141.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_122141", "122141035", "story_v_out_122141.awb")

						arg_153_1:RecordAudio("122141035", var_156_6)
						arg_153_1:RecordAudio("122141035", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_122141", "122141035", "story_v_out_122141.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_122141", "122141035", "story_v_out_122141.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play122141036 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 122141036
		arg_157_1.duration_ = 8.93

		local var_157_0 = {
			ja = 8.933,
			ko = 4.333,
			zh = 4.333
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play122141037(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1184ui_story = arg_157_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1184ui_story"].transform.position).z)
				arg_157_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1184ui_story"].transform.localEulerAngles = arg_157_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_157_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1184ui_story"].transform.position).z)
				arg_157_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1184ui_story"].transform.localEulerAngles = arg_157_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["1184ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1184ui_story == nil then
				arg_157_1.var_.characterEffect1184ui_story = var_160_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 and not isNil(var_160_1) then
				if arg_157_1.var_.characterEffect1184ui_story and not isNil(var_160_1) then
					arg_157_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1184ui_story then
				arg_157_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_160_4 = 0
			local var_160_5 = 0.45

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_6 = arg_157_1:GetWordFromCfg(122141036)
				local var_160_7 = arg_157_1:FormatText(var_160_6.content)

				arg_157_1.text_.text = var_160_7

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_9 = 18 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 18)

				if (18 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 18)) > 0 and var_160_5 < var_160_9 then
					arg_157_1.talkMaxDuration = var_160_9

					if var_160_9 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_9 + var_160_4
					end
				end

				arg_157_1.text_.text = var_160_7
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141036", "story_v_out_122141.awb") ~= 0 then
					local var_160_10 = manager.audio:GetVoiceLength("story_v_out_122141", "122141036", "story_v_out_122141.awb") / 1000

					if var_160_10 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_4
					end

					if var_160_6.prefab_name ~= "" and arg_157_1.actors_[var_160_6.prefab_name] ~= nil then
						local var_160_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_6.prefab_name].transform, "story_v_out_122141", "122141036", "story_v_out_122141.awb")

						arg_157_1:RecordAudio("122141036", var_160_11)
						arg_157_1:RecordAudio("122141036", var_160_11)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_122141", "122141036", "story_v_out_122141.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_122141", "122141036", "story_v_out_122141.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_12 = math.max(var_160_5, arg_157_1.talkMaxDuration)

			if var_160_4 <= arg_157_1.time_ and arg_157_1.time_ < var_160_4 + var_160_12 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_4) / var_160_12

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_4 + var_160_12 and arg_157_1.time_ < var_160_4 + var_160_12 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play122141037 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 122141037
		arg_161_1.duration_ = 24.33

		local var_161_0 = {
			ja = 24.333,
			ko = 16.8,
			zh = 16.8
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play122141038(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["1184ui_story"]) and arg_161_1.var_.characterEffect1184ui_story == nil then
				arg_161_1.var_.characterEffect1184ui_story = arg_161_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_0 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["1184ui_story"]) then
				if arg_161_1.var_.characterEffect1184ui_story and not isNil(arg_161_1.actors_["1184ui_story"]) then
					arg_161_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_0)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["1184ui_story"]) and arg_161_1.var_.characterEffect1184ui_story then
				arg_161_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_164_1 = 0
			local var_164_2 = 1.325

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_3 = arg_161_1:GetWordFromCfg(122141037)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_6 = 53 <= 0 and var_164_2 or var_164_2 * (utf8.len(var_164_4) / 53)

				if (53 <= 0 and var_164_2 or var_164_2 * (utf8.len(var_164_4) / 53)) > 0 and var_164_2 < var_164_6 then
					arg_161_1.talkMaxDuration = var_164_6

					if var_164_6 + var_164_1 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_6 + var_164_1
					end
				end

				arg_161_1.text_.text = var_164_4
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141037", "story_v_out_122141.awb") ~= 0 then
					local var_164_7 = manager.audio:GetVoiceLength("story_v_out_122141", "122141037", "story_v_out_122141.awb") / 1000

					if var_164_7 + var_164_1 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_1
					end

					if var_164_3.prefab_name ~= "" and arg_161_1.actors_[var_164_3.prefab_name] ~= nil then
						local var_164_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_3.prefab_name].transform, "story_v_out_122141", "122141037", "story_v_out_122141.awb")

						arg_161_1:RecordAudio("122141037", var_164_8)
						arg_161_1:RecordAudio("122141037", var_164_8)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_122141", "122141037", "story_v_out_122141.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_122141", "122141037", "story_v_out_122141.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_9 = math.max(var_164_2, arg_161_1.talkMaxDuration)

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_9 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_1) / var_164_9

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_1 + var_164_9 and arg_161_1.time_ < var_164_1 + var_164_9 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play122141038 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 122141038
		arg_165_1.duration_ = 14.83

		local var_165_0 = {
			ja = 14.833,
			ko = 13.633,
			zh = 13.633
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play122141039(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 1.2

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:GetWordFromCfg(122141038)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 48 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 48)

				if (48 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 48)) > 0 and var_168_0 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + 0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141038", "story_v_out_122141.awb") ~= 0 then
					local var_168_5 = manager.audio:GetVoiceLength("story_v_out_122141", "122141038", "story_v_out_122141.awb") / 1000

					if var_168_5 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + 0
					end

					if var_168_1.prefab_name ~= "" and arg_165_1.actors_[var_168_1.prefab_name] ~= nil then
						local var_168_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_1.prefab_name].transform, "story_v_out_122141", "122141038", "story_v_out_122141.awb")

						arg_165_1:RecordAudio("122141038", var_168_6)
						arg_165_1:RecordAudio("122141038", var_168_6)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_122141", "122141038", "story_v_out_122141.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_122141", "122141038", "story_v_out_122141.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_7 and arg_165_1.time_ < 0 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play122141039 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 122141039
		arg_169_1.duration_ = 3.27

		local var_169_0 = {
			ja = 3.266,
			ko = 2.7,
			zh = 2.7
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play122141040(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.25

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:GetWordFromCfg(122141039)
				local var_172_2 = arg_169_1:FormatText(var_172_1.content)

				arg_169_1.text_.text = var_172_2

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 10 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 10)

				if (10 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 10)) > 0 and var_172_0 < var_172_4 then
					arg_169_1.talkMaxDuration = var_172_4

					if var_172_4 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_4 + 0
					end
				end

				arg_169_1.text_.text = var_172_2
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141039", "story_v_out_122141.awb") ~= 0 then
					local var_172_5 = manager.audio:GetVoiceLength("story_v_out_122141", "122141039", "story_v_out_122141.awb") / 1000

					if var_172_5 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + 0
					end

					if var_172_1.prefab_name ~= "" and arg_169_1.actors_[var_172_1.prefab_name] ~= nil then
						local var_172_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_1.prefab_name].transform, "story_v_out_122141", "122141039", "story_v_out_122141.awb")

						arg_169_1:RecordAudio("122141039", var_172_6)
						arg_169_1:RecordAudio("122141039", var_172_6)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_122141", "122141039", "story_v_out_122141.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_122141", "122141039", "story_v_out_122141.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_7 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_7 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_7

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_7 and arg_169_1.time_ < 0 + var_172_7 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play122141040 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 122141040
		arg_173_1.duration_ = 3.83

		local var_173_0 = {
			ja = 3.833,
			ko = 3.566,
			zh = 3.566
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play122141041(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1184ui_story = arg_173_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1184ui_story"].transform.position).z)
				arg_173_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1184ui_story"].transform.localEulerAngles = arg_173_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_173_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1184ui_story"].transform.position).z)
				arg_173_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1184ui_story"].transform.localEulerAngles = arg_173_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["1184ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1184ui_story == nil then
				arg_173_1.var_.characterEffect1184ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect1184ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1184ui_story then
				arg_173_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action435")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_176_4 = 0
			local var_176_5 = 0.375

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:GetWordFromCfg(122141040)
				local var_176_7 = arg_173_1:FormatText(var_176_6.content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 15 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 15)

				if (15 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 15)) > 0 and var_176_5 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141040", "story_v_out_122141.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_out_122141", "122141040", "story_v_out_122141.awb") / 1000

					if var_176_10 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_4
					end

					if var_176_6.prefab_name ~= "" and arg_173_1.actors_[var_176_6.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_6.prefab_name].transform, "story_v_out_122141", "122141040", "story_v_out_122141.awb")

						arg_173_1:RecordAudio("122141040", var_176_11)
						arg_173_1:RecordAudio("122141040", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_122141", "122141040", "story_v_out_122141.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_122141", "122141040", "story_v_out_122141.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_12 = math.max(var_176_5, arg_173_1.talkMaxDuration)

			if var_176_4 <= arg_173_1.time_ and arg_173_1.time_ < var_176_4 + var_176_12 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_4) / var_176_12

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_4 + var_176_12 and arg_173_1.time_ < var_176_4 + var_176_12 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play122141041 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 122141041
		arg_177_1.duration_ = 11.33

		local var_177_0 = {
			ja = 11.333,
			ko = 4.4,
			zh = 4.4
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play122141042(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1184ui_story"]) and arg_177_1.var_.characterEffect1184ui_story == nil then
				arg_177_1.var_.characterEffect1184ui_story = arg_177_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1184ui_story"]) then
				if arg_177_1.var_.characterEffect1184ui_story and not isNil(arg_177_1.actors_["1184ui_story"]) then
					arg_177_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_0)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1184ui_story"]) and arg_177_1.var_.characterEffect1184ui_story then
				arg_177_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_180_1 = 0
			local var_180_2 = 0.425

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_3 = arg_177_1:GetWordFromCfg(122141041)
				local var_180_4 = arg_177_1:FormatText(var_180_3.content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_6 = 17 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_4) / 17)

				if (17 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_4) / 17)) > 0 and var_180_2 < var_180_6 then
					arg_177_1.talkMaxDuration = var_180_6

					if var_180_6 + var_180_1 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_6 + var_180_1
					end
				end

				arg_177_1.text_.text = var_180_4
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141041", "story_v_out_122141.awb") ~= 0 then
					local var_180_7 = manager.audio:GetVoiceLength("story_v_out_122141", "122141041", "story_v_out_122141.awb") / 1000

					if var_180_7 + var_180_1 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_7 + var_180_1
					end

					if var_180_3.prefab_name ~= "" and arg_177_1.actors_[var_180_3.prefab_name] ~= nil then
						local var_180_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_3.prefab_name].transform, "story_v_out_122141", "122141041", "story_v_out_122141.awb")

						arg_177_1:RecordAudio("122141041", var_180_8)
						arg_177_1:RecordAudio("122141041", var_180_8)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_122141", "122141041", "story_v_out_122141.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_122141", "122141041", "story_v_out_122141.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_9 = math.max(var_180_2, arg_177_1.talkMaxDuration)

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_9 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_1) / var_180_9

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_1 + var_180_9 and arg_177_1.time_ < var_180_1 + var_180_9 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play122141042 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 122141042
		arg_181_1.duration_ = 9.93

		local var_181_0 = {
			ja = 8.233,
			ko = 9.933,
			zh = 9.933
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play122141043(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1184ui_story"]) and arg_181_1.var_.characterEffect1184ui_story == nil then
				arg_181_1.var_.characterEffect1184ui_story = arg_181_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1184ui_story"]) then
				if arg_181_1.var_.characterEffect1184ui_story and not isNil(arg_181_1.actors_["1184ui_story"]) then
					arg_181_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1184ui_story"]) and arg_181_1.var_.characterEffect1184ui_story then
				arg_181_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4513")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_184_2 = 0
			local var_184_3 = 0.75

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_2 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_4 = arg_181_1:GetWordFromCfg(122141042)
				local var_184_5 = arg_181_1:FormatText(var_184_4.content)

				arg_181_1.text_.text = var_184_5

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_7 = 30 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_5) / 30)

				if (30 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_5) / 30)) > 0 and var_184_3 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_2
					end
				end

				arg_181_1.text_.text = var_184_5
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141042", "story_v_out_122141.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_out_122141", "122141042", "story_v_out_122141.awb") / 1000

					if var_184_8 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_2
					end

					if var_184_4.prefab_name ~= "" and arg_181_1.actors_[var_184_4.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_4.prefab_name].transform, "story_v_out_122141", "122141042", "story_v_out_122141.awb")

						arg_181_1:RecordAudio("122141042", var_184_9)
						arg_181_1:RecordAudio("122141042", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_122141", "122141042", "story_v_out_122141.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_122141", "122141042", "story_v_out_122141.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_10 = math.max(var_184_3, arg_181_1.talkMaxDuration)

			if var_184_2 <= arg_181_1.time_ and arg_181_1.time_ < var_184_2 + var_184_10 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_2) / var_184_10

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_2 + var_184_10 and arg_181_1.time_ < var_184_2 + var_184_10 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play122141043 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 122141043
		arg_185_1.duration_ = 11.8

		local var_185_0 = {
			ja = 11.8,
			ko = 8.066,
			zh = 8.066
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play122141044(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["1184ui_story"]) and arg_185_1.var_.characterEffect1184ui_story == nil then
				arg_185_1.var_.characterEffect1184ui_story = arg_185_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_0 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["1184ui_story"]) then
				if arg_185_1.var_.characterEffect1184ui_story and not isNil(arg_185_1.actors_["1184ui_story"]) then
					arg_185_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_0)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["1184ui_story"]) and arg_185_1.var_.characterEffect1184ui_story then
				arg_185_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_188_1 = 0
			local var_188_2 = 0.575

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_3 = arg_185_1:GetWordFromCfg(122141043)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_6 = 23 <= 0 and var_188_2 or var_188_2 * (utf8.len(var_188_4) / 23)

				if (23 <= 0 and var_188_2 or var_188_2 * (utf8.len(var_188_4) / 23)) > 0 and var_188_2 < var_188_6 then
					arg_185_1.talkMaxDuration = var_188_6

					if var_188_6 + var_188_1 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_6 + var_188_1
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141043", "story_v_out_122141.awb") ~= 0 then
					local var_188_7 = manager.audio:GetVoiceLength("story_v_out_122141", "122141043", "story_v_out_122141.awb") / 1000

					if var_188_7 + var_188_1 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_1
					end

					if var_188_3.prefab_name ~= "" and arg_185_1.actors_[var_188_3.prefab_name] ~= nil then
						local var_188_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_3.prefab_name].transform, "story_v_out_122141", "122141043", "story_v_out_122141.awb")

						arg_185_1:RecordAudio("122141043", var_188_8)
						arg_185_1:RecordAudio("122141043", var_188_8)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_122141", "122141043", "story_v_out_122141.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_122141", "122141043", "story_v_out_122141.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_9 = math.max(var_188_2, arg_185_1.talkMaxDuration)

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_9 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_1) / var_188_9

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_1 + var_188_9 and arg_185_1.time_ < var_188_1 + var_188_9 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play122141044 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 122141044
		arg_189_1.duration_ = 19.3

		local var_189_0 = {
			ja = 19.3,
			ko = 14.966,
			zh = 14.966
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play122141045(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_192_0 = 0
			local var_192_1 = 1.25

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_2 = arg_189_1:GetWordFromCfg(122141044)
				local var_192_3 = arg_189_1:FormatText(var_192_2.content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 50 <= 0 and var_192_1 or var_192_1 * (utf8.len(var_192_3) / 50)

				if (50 <= 0 and var_192_1 or var_192_1 * (utf8.len(var_192_3) / 50)) > 0 and var_192_1 < var_192_5 then
					arg_189_1.talkMaxDuration = var_192_5

					if var_192_5 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_3
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141044", "story_v_out_122141.awb") ~= 0 then
					local var_192_6 = manager.audio:GetVoiceLength("story_v_out_122141", "122141044", "story_v_out_122141.awb") / 1000

					if var_192_6 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_6 + var_192_0
					end

					if var_192_2.prefab_name ~= "" and arg_189_1.actors_[var_192_2.prefab_name] ~= nil then
						local var_192_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_2.prefab_name].transform, "story_v_out_122141", "122141044", "story_v_out_122141.awb")

						arg_189_1:RecordAudio("122141044", var_192_7)
						arg_189_1:RecordAudio("122141044", var_192_7)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_122141", "122141044", "story_v_out_122141.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_122141", "122141044", "story_v_out_122141.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_8 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_8 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_8

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_8 and arg_189_1.time_ < var_192_0 + var_192_8 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play122141045 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 122141045
		arg_193_1.duration_ = 4.73

		local var_193_0 = {
			ja = 4.733,
			ko = 3.133,
			zh = 3.133
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play122141046(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["1184ui_story"]) and arg_193_1.var_.characterEffect1184ui_story == nil then
				arg_193_1.var_.characterEffect1184ui_story = arg_193_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_0 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["1184ui_story"]) then
				if arg_193_1.var_.characterEffect1184ui_story and not isNil(arg_193_1.actors_["1184ui_story"]) then
					arg_193_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["1184ui_story"]) and arg_193_1.var_.characterEffect1184ui_story then
				arg_193_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4139")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_196_4 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_193_1.bgmTxt_.text ~= var_196_4 and arg_193_1.bgmTxt_.text ~= "" then
						if arg_193_1.bgmTxt2_.text ~= "" then
							arg_193_1.bgmTxt_.text = arg_193_1.bgmTxt2_.text
						end

						arg_193_1.bgmTxt2_.text = var_196_4

						arg_193_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_193_1.bgmTxt_.text = var_196_4
						arg_193_1.bgmTxt2_.text = var_196_4
					end

					if arg_193_1.bgmTimer then
						arg_193_1.bgmTimer:Stop()

						arg_193_1.bgmTimer = nil
					end

					if arg_193_1.settingData.show_music_name == 1 then
						arg_193_1.musicController:SetSelectedState("show")
						arg_193_1.musicAnimator_:Play("open", 0, 0)

						if arg_193_1.settingData.music_time ~= 0 then
							arg_193_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_193_1.settingData.music_time), function()
								if arg_193_1 == nil or isNil(arg_193_1.bgmTxt_) then
									return
								end

								arg_193_1.musicController:SetSelectedState("hide")
								arg_193_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_196_5 = 0
			local var_196_6 = 0.325

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_5 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_7 = arg_193_1:GetWordFromCfg(122141045)
				local var_196_8 = arg_193_1:FormatText(var_196_7.content)

				arg_193_1.text_.text = var_196_8

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_10 = 13 <= 0 and var_196_6 or var_196_6 * (utf8.len(var_196_8) / 13)

				if (13 <= 0 and var_196_6 or var_196_6 * (utf8.len(var_196_8) / 13)) > 0 and var_196_6 < var_196_10 then
					arg_193_1.talkMaxDuration = var_196_10

					if var_196_10 + var_196_5 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_5
					end
				end

				arg_193_1.text_.text = var_196_8
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141045", "story_v_out_122141.awb") ~= 0 then
					local var_196_11 = manager.audio:GetVoiceLength("story_v_out_122141", "122141045", "story_v_out_122141.awb") / 1000

					if var_196_11 + var_196_5 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_11 + var_196_5
					end

					if var_196_7.prefab_name ~= "" and arg_193_1.actors_[var_196_7.prefab_name] ~= nil then
						local var_196_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_7.prefab_name].transform, "story_v_out_122141", "122141045", "story_v_out_122141.awb")

						arg_193_1:RecordAudio("122141045", var_196_12)
						arg_193_1:RecordAudio("122141045", var_196_12)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_122141", "122141045", "story_v_out_122141.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_122141", "122141045", "story_v_out_122141.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_13 = math.max(var_196_6, arg_193_1.talkMaxDuration)

			if var_196_5 <= arg_193_1.time_ and arg_193_1.time_ < var_196_5 + var_196_13 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_5) / var_196_13

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_5 + var_196_13 and arg_193_1.time_ < var_196_5 + var_196_13 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play122141046 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 122141046
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play122141047(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos1184ui_story = arg_198_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_201_0 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 then
				arg_198_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_198_1.time_ - 0) / var_201_0)
				arg_198_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1184ui_story"].transform.position).z)
				arg_198_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1184ui_story"].transform.localEulerAngles = arg_198_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 then
				arg_198_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_198_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1184ui_story"].transform.position).z)
				arg_198_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1184ui_story"].transform.localEulerAngles = arg_198_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_201_1 = 0
			local var_201_2 = 1.4

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_3 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(122141046).content)

				arg_198_1.text_.text = var_201_3

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_5 = 56 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_3) / 56)

				if (56 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_3) / 56)) > 0 and var_201_2 < var_201_5 then
					arg_198_1.talkMaxDuration = var_201_5

					if var_201_5 + var_201_1 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_5 + var_201_1
					end
				end

				arg_198_1.text_.text = var_201_3
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_6 = math.max(var_201_2, arg_198_1.talkMaxDuration)

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_6 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_1) / var_201_6

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_1 + var_201_6 and arg_198_1.time_ < var_201_1 + var_201_6 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play122141047 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 122141047
		arg_202_1.duration_ = 9

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play122141048(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if arg_202_1.bgs_.S0506a == nil then
				local var_205_0 = Object.Instantiate(arg_202_1.paintGo_)

				var_205_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0506a")
				var_205_0.name = "S0506a"
				var_205_0.transform.parent = arg_202_1.stage_.transform
				var_205_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_202_1.bgs_.S0506a = var_205_0
			end

			if 2 < arg_202_1.time_ and arg_202_1.time_ <= 2 + arg_205_0 then
				local var_205_1 = arg_202_1.bgs_.S0506a

				arg_202_1.bgs_.S0506a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_205_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_205_2 = var_205_1:GetComponent("SpriteRenderer")

				if var_205_2 and var_205_2.sprite then
					local var_205_3 = 2 * (var_205_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_205_1.transform.localScale = Vector3.New(var_205_3 / var_205_2.sprite.bounds.size.y < var_205_3 * manager.ui.mainCameraCom_.aspect / var_205_2.sprite.bounds.size.x and var_205_3 * manager.ui.mainCameraCom_.aspect / var_205_2.sprite.bounds.size.x or var_205_3 / var_205_2.sprite.bounds.size.y, var_205_3 / var_205_2.sprite.bounds.size.y < var_205_3 * manager.ui.mainCameraCom_.aspect / var_205_2.sprite.bounds.size.x and var_205_3 * manager.ui.mainCameraCom_.aspect / var_205_2.sprite.bounds.size.x or var_205_3 / var_205_2.sprite.bounds.size.y, 0)
				end

				for iter_205_0, iter_205_1 in pairs(arg_202_1.bgs_) do
					if iter_205_0 ~= "S0506a" then
						iter_205_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_205_4 = 0

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_4 + arg_205_0 then
				arg_202_1.mask_.enabled = true
				arg_202_1.mask_.raycastTarget = true

				arg_202_1:SetGaussion(false)
			end

			local var_205_5 = 2

			if var_205_4 <= arg_202_1.time_ and arg_202_1.time_ < var_205_4 + var_205_5 then
				local var_205_6 = Color.New(0, 0, 0)

				var_205_6.a = Mathf.Lerp(0, 1, (arg_202_1.time_ - var_205_4) / var_205_5)
				arg_202_1.mask_.color = var_205_6
			end

			if arg_202_1.time_ >= var_205_4 + var_205_5 and arg_202_1.time_ < var_205_4 + var_205_5 + arg_205_0 then
				local var_205_7 = Color.New(0, 0, 0)

				var_205_7.a = 1
				arg_202_1.mask_.color = var_205_7
			end

			local var_205_8 = 2

			if 2 < arg_202_1.time_ and arg_202_1.time_ <= var_205_8 + arg_205_0 then
				arg_202_1.mask_.enabled = true
				arg_202_1.mask_.raycastTarget = true

				arg_202_1:SetGaussion(false)
			end

			local var_205_9 = 2

			if var_205_8 <= arg_202_1.time_ and arg_202_1.time_ < var_205_8 + var_205_9 then
				local var_205_10 = Color.New(0, 0, 0)

				var_205_10.a = Mathf.Lerp(1, 0, (arg_202_1.time_ - var_205_8) / var_205_9)
				arg_202_1.mask_.color = var_205_10
			end

			if arg_202_1.time_ >= var_205_8 + var_205_9 and arg_202_1.time_ < var_205_8 + var_205_9 + arg_205_0 then
				local var_205_11 = Color.New(0, 0, 0)

				arg_202_1.mask_.enabled = false
				var_205_11.a = 0
				arg_202_1.mask_.color = var_205_11
			end

			local var_205_12 = arg_202_1.bgs_.S0506a.transform

			if 2 < arg_202_1.time_ and arg_202_1.time_ <= 2 + arg_205_0 then
				arg_202_1.var_.moveOldPosS0506a = var_205_12.localPosition
			end

			local var_205_13 = 3.5

			if 2 <= arg_202_1.time_ and arg_202_1.time_ < 2 + var_205_13 then
				var_205_12.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPosS0506a, Vector3.New(0, 1, 9.5), (arg_202_1.time_ - 2) / var_205_13)
			end

			if arg_202_1.time_ >= 2 + var_205_13 and arg_202_1.time_ < 2 + var_205_13 + arg_205_0 then
				var_205_12.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_205_14 = 4

			if 4 < arg_202_1.time_ and arg_202_1.time_ <= var_205_14 + arg_205_0 then
				arg_202_1.allBtn_.enabled = false
			end

			if arg_202_1.time_ >= var_205_14 + 1.5 and arg_202_1.time_ < var_205_14 + 1.5 + arg_205_0 then
				arg_202_1.allBtn_.enabled = true
			end

			if 2.53333333333333 < arg_202_1.time_ and arg_202_1.time_ <= 2.53333333333333 + arg_205_0 then
				arg_202_1:AudioAction("play", "music", "bgm_activity_2_2_story_ver_1_short", "bgm_activity_2_2_story_ver_1_short", "bgm_activity_2_2_story_ver_1_short.awb")

				local var_205_17 = manager.audio:GetAudioName("bgm_activity_2_2_story_ver_1_short", "bgm_activity_2_2_story_ver_1_short")

				if "" ~= "" then
					if arg_202_1.bgmTxt_.text ~= var_205_17 and arg_202_1.bgmTxt_.text ~= "" then
						if arg_202_1.bgmTxt2_.text ~= "" then
							arg_202_1.bgmTxt_.text = arg_202_1.bgmTxt2_.text
						end

						arg_202_1.bgmTxt2_.text = var_205_17

						arg_202_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_202_1.bgmTxt_.text = var_205_17
						arg_202_1.bgmTxt2_.text = var_205_17
					end

					if arg_202_1.bgmTimer then
						arg_202_1.bgmTimer:Stop()

						arg_202_1.bgmTimer = nil
					end

					if arg_202_1.settingData.show_music_name == 1 then
						arg_202_1.musicController:SetSelectedState("show")
						arg_202_1.musicAnimator_:Play("open", 0, 0)

						if arg_202_1.settingData.music_time ~= 0 then
							arg_202_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_202_1.settingData.music_time), function()
								if arg_202_1 == nil or isNil(arg_202_1.bgmTxt_) then
									return
								end

								arg_202_1.musicController:SetSelectedState("hide")
								arg_202_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_202_1.frameCnt_ <= 1 then
				arg_202_1.dialog_:SetActive(false)
			end

			local var_205_18 = 4
			local var_205_19 = 0.9

			if 4 < arg_202_1.time_ and arg_202_1.time_ <= var_205_18 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0

				arg_202_1.dialog_:SetActive(true)

				arg_202_1.dialogCg_.alpha = 0

				local var_205_20 = LeanTween.value(arg_202_1.dialog_, 0, 1, 0.3)

				var_205_20:setOnUpdate(LuaHelper.FloatAction(function(arg_207_0)
					arg_202_1.dialogCg_.alpha = arg_207_0
				end))
				var_205_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_202_1.dialog_)
					var_205_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_202_1.duration_ = arg_202_1.duration_ + 0.3

				SetActive(arg_202_1.leftNameGo_, false)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_21 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(122141047).content)

				arg_202_1.text_.text = var_205_21

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_23 = 36 <= 0 and var_205_19 or var_205_19 * (utf8.len(var_205_21) / 36)

				if (36 <= 0 and var_205_19 or var_205_19 * (utf8.len(var_205_21) / 36)) > 0 and var_205_19 < var_205_23 then
					arg_202_1.talkMaxDuration = var_205_23
					var_205_18 = var_205_18 + 0.3

					if var_205_23 + var_205_18 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_23 + var_205_18
					end
				end

				arg_202_1.text_.text = var_205_21
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_24 = var_205_18 + 0.3
			local var_205_25 = math.max(var_205_19, arg_202_1.talkMaxDuration)

			if var_205_18 + 0.3 <= arg_202_1.time_ and arg_202_1.time_ < var_205_24 + var_205_25 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_24) / var_205_25

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_24 + var_205_25 and arg_202_1.time_ < var_205_24 + var_205_25 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0506a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play122141048 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 122141048
		arg_209_1.duration_ = 9

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play122141049(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if arg_209_1.bgs_.SA0105 == nil then
				local var_212_0 = Object.Instantiate(arg_209_1.paintGo_)

				var_212_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SA0105")
				var_212_0.name = "SA0105"
				var_212_0.transform.parent = arg_209_1.stage_.transform
				var_212_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_209_1.bgs_.SA0105 = var_212_0
			end

			if 2 < arg_209_1.time_ and arg_209_1.time_ <= 2 + arg_212_0 then
				local var_212_1 = arg_209_1.bgs_.SA0105

				arg_209_1.bgs_.SA0105.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_212_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_212_2 = var_212_1:GetComponent("SpriteRenderer")

				if var_212_2 and var_212_2.sprite then
					local var_212_3 = 2 * (var_212_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_212_1.transform.localScale = Vector3.New(var_212_3 / var_212_2.sprite.bounds.size.y < var_212_3 * manager.ui.mainCameraCom_.aspect / var_212_2.sprite.bounds.size.x and var_212_3 * manager.ui.mainCameraCom_.aspect / var_212_2.sprite.bounds.size.x or var_212_3 / var_212_2.sprite.bounds.size.y, var_212_3 / var_212_2.sprite.bounds.size.y < var_212_3 * manager.ui.mainCameraCom_.aspect / var_212_2.sprite.bounds.size.x and var_212_3 * manager.ui.mainCameraCom_.aspect / var_212_2.sprite.bounds.size.x or var_212_3 / var_212_2.sprite.bounds.size.y, 0)
				end

				for iter_212_0, iter_212_1 in pairs(arg_209_1.bgs_) do
					if iter_212_0 ~= "SA0105" then
						iter_212_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_212_4 = 0

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_5 = 2

			if var_212_4 <= arg_209_1.time_ and arg_209_1.time_ < var_212_4 + var_212_5 then
				local var_212_6 = Color.New(0, 0, 0)

				var_212_6.a = Mathf.Lerp(0, 1, (arg_209_1.time_ - var_212_4) / var_212_5)
				arg_209_1.mask_.color = var_212_6
			end

			if arg_209_1.time_ >= var_212_4 + var_212_5 and arg_209_1.time_ < var_212_4 + var_212_5 + arg_212_0 then
				local var_212_7 = Color.New(0, 0, 0)

				var_212_7.a = 1
				arg_209_1.mask_.color = var_212_7
			end

			local var_212_8 = 2

			if 2 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_9 = 2

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_9 then
				local var_212_10 = Color.New(0, 0, 0)

				var_212_10.a = Mathf.Lerp(1, 0, (arg_209_1.time_ - var_212_8) / var_212_9)
				arg_209_1.mask_.color = var_212_10
			end

			if arg_209_1.time_ >= var_212_8 + var_212_9 and arg_209_1.time_ < var_212_8 + var_212_9 + arg_212_0 then
				local var_212_11 = Color.New(0, 0, 0)

				arg_209_1.mask_.enabled = false
				var_212_11.a = 0
				arg_209_1.mask_.color = var_212_11
			end

			local var_212_12 = arg_209_1.bgs_.SA0105.transform

			if 2 < arg_209_1.time_ and arg_209_1.time_ <= 2 + arg_212_0 then
				arg_209_1.var_.moveOldPosSA0105 = var_212_12.localPosition
			end

			local var_212_13 = 3.5

			if 2 <= arg_209_1.time_ and arg_209_1.time_ < 2 + var_212_13 then
				var_212_12.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPosSA0105, Vector3.New(0, 1, 9.5), (arg_209_1.time_ - 2) / var_212_13)
			end

			if arg_209_1.time_ >= 2 + var_212_13 and arg_209_1.time_ < 2 + var_212_13 + arg_212_0 then
				var_212_12.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_212_14 = 4

			if 4 < arg_209_1.time_ and arg_209_1.time_ <= var_212_14 + arg_212_0 then
				arg_209_1.allBtn_.enabled = false
			end

			if arg_209_1.time_ >= var_212_14 + 1.5 and arg_209_1.time_ < var_212_14 + 1.5 + arg_212_0 then
				arg_209_1.allBtn_.enabled = true
			end

			if arg_209_1.frameCnt_ <= 1 then
				arg_209_1.dialog_:SetActive(false)
			end

			local var_212_15 = 4
			local var_212_16 = 1.025

			if 4 < arg_209_1.time_ and arg_209_1.time_ <= var_212_15 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0

				arg_209_1.dialog_:SetActive(true)

				arg_209_1.dialogCg_.alpha = 0

				local var_212_17 = LeanTween.value(arg_209_1.dialog_, 0, 1, 0.3)

				var_212_17:setOnUpdate(LuaHelper.FloatAction(function(arg_213_0)
					arg_209_1.dialogCg_.alpha = arg_213_0
				end))
				var_212_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_209_1.dialog_)
					var_212_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_209_1.duration_ = arg_209_1.duration_ + 0.3

				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_18 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(122141048).content)

				arg_209_1.text_.text = var_212_18

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_20 = 41 <= 0 and var_212_16 or var_212_16 * (utf8.len(var_212_18) / 41)

				if (41 <= 0 and var_212_16 or var_212_16 * (utf8.len(var_212_18) / 41)) > 0 and var_212_16 < var_212_20 then
					arg_209_1.talkMaxDuration = var_212_20
					var_212_15 = var_212_15 + 0.3

					if var_212_20 + var_212_15 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_20 + var_212_15
					end
				end

				arg_209_1.text_.text = var_212_18
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_21 = var_212_15 + 0.3
			local var_212_22 = math.max(var_212_16, arg_209_1.talkMaxDuration)

			if var_212_15 + 0.3 <= arg_209_1.time_ and arg_209_1.time_ < var_212_21 + var_212_22 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_21) / var_212_22

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_21 + var_212_22 and arg_209_1.time_ < var_212_21 + var_212_22 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SA0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play122141049 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 122141049
		arg_215_1.duration_ = 9

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play122141050(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if arg_215_1.bgs_.S0905 == nil then
				local var_218_0 = Object.Instantiate(arg_215_1.paintGo_)

				var_218_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0905")
				var_218_0.name = "S0905"
				var_218_0.transform.parent = arg_215_1.stage_.transform
				var_218_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_215_1.bgs_.S0905 = var_218_0
			end

			if 2 < arg_215_1.time_ and arg_215_1.time_ <= 2 + arg_218_0 then
				local var_218_1 = arg_215_1.bgs_.S0905

				arg_215_1.bgs_.S0905.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_218_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_218_2 = var_218_1:GetComponent("SpriteRenderer")

				if var_218_2 and var_218_2.sprite then
					local var_218_3 = 2 * (var_218_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_218_1.transform.localScale = Vector3.New(var_218_3 / var_218_2.sprite.bounds.size.y < var_218_3 * manager.ui.mainCameraCom_.aspect / var_218_2.sprite.bounds.size.x and var_218_3 * manager.ui.mainCameraCom_.aspect / var_218_2.sprite.bounds.size.x or var_218_3 / var_218_2.sprite.bounds.size.y, var_218_3 / var_218_2.sprite.bounds.size.y < var_218_3 * manager.ui.mainCameraCom_.aspect / var_218_2.sprite.bounds.size.x and var_218_3 * manager.ui.mainCameraCom_.aspect / var_218_2.sprite.bounds.size.x or var_218_3 / var_218_2.sprite.bounds.size.y, 0)
				end

				for iter_218_0, iter_218_1 in pairs(arg_215_1.bgs_) do
					if iter_218_0 ~= "S0905" then
						iter_218_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_218_4 = 0

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1.mask_.enabled = true
				arg_215_1.mask_.raycastTarget = true

				arg_215_1:SetGaussion(false)
			end

			local var_218_5 = 2

			if var_218_4 <= arg_215_1.time_ and arg_215_1.time_ < var_218_4 + var_218_5 then
				local var_218_6 = Color.New(0, 0, 0)

				var_218_6.a = Mathf.Lerp(0, 1, (arg_215_1.time_ - var_218_4) / var_218_5)
				arg_215_1.mask_.color = var_218_6
			end

			if arg_215_1.time_ >= var_218_4 + var_218_5 and arg_215_1.time_ < var_218_4 + var_218_5 + arg_218_0 then
				local var_218_7 = Color.New(0, 0, 0)

				var_218_7.a = 1
				arg_215_1.mask_.color = var_218_7
			end

			local var_218_8 = 2

			if 2 < arg_215_1.time_ and arg_215_1.time_ <= var_218_8 + arg_218_0 then
				arg_215_1.mask_.enabled = true
				arg_215_1.mask_.raycastTarget = true

				arg_215_1:SetGaussion(false)
			end

			local var_218_9 = 2

			if var_218_8 <= arg_215_1.time_ and arg_215_1.time_ < var_218_8 + var_218_9 then
				local var_218_10 = Color.New(0, 0, 0)

				var_218_10.a = Mathf.Lerp(1, 0, (arg_215_1.time_ - var_218_8) / var_218_9)
				arg_215_1.mask_.color = var_218_10
			end

			if arg_215_1.time_ >= var_218_8 + var_218_9 and arg_215_1.time_ < var_218_8 + var_218_9 + arg_218_0 then
				local var_218_11 = Color.New(0, 0, 0)

				arg_215_1.mask_.enabled = false
				var_218_11.a = 0
				arg_215_1.mask_.color = var_218_11
			end

			local var_218_12 = arg_215_1.bgs_.S0905.transform

			if 2 < arg_215_1.time_ and arg_215_1.time_ <= 2 + arg_218_0 then
				arg_215_1.var_.moveOldPosS0905 = var_218_12.localPosition
			end

			local var_218_13 = 3.5

			if 2 <= arg_215_1.time_ and arg_215_1.time_ < 2 + var_218_13 then
				var_218_12.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPosS0905, Vector3.New(0, 1, 9.5), (arg_215_1.time_ - 2) / var_218_13)
			end

			if arg_215_1.time_ >= 2 + var_218_13 and arg_215_1.time_ < 2 + var_218_13 + arg_218_0 then
				var_218_12.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_218_14 = 4

			if 4 < arg_215_1.time_ and arg_215_1.time_ <= var_218_14 + arg_218_0 then
				arg_215_1.allBtn_.enabled = false
			end

			if arg_215_1.time_ >= var_218_14 + 1.5 and arg_215_1.time_ < var_218_14 + 1.5 + arg_218_0 then
				arg_215_1.allBtn_.enabled = true
			end

			if arg_215_1.frameCnt_ <= 1 then
				arg_215_1.dialog_:SetActive(false)
			end

			local var_218_15 = 4
			local var_218_16 = 1.425

			if 4 < arg_215_1.time_ and arg_215_1.time_ <= var_218_15 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0

				arg_215_1.dialog_:SetActive(true)

				arg_215_1.dialogCg_.alpha = 0

				local var_218_17 = LeanTween.value(arg_215_1.dialog_, 0, 1, 0.3)

				var_218_17:setOnUpdate(LuaHelper.FloatAction(function(arg_219_0)
					arg_215_1.dialogCg_.alpha = arg_219_0
				end))
				var_218_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_215_1.dialog_)
					var_218_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_215_1.duration_ = arg_215_1.duration_ + 0.3

				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_18 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(122141049).content)

				arg_215_1.text_.text = var_218_18

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_20 = 57 <= 0 and var_218_16 or var_218_16 * (utf8.len(var_218_18) / 57)

				if (57 <= 0 and var_218_16 or var_218_16 * (utf8.len(var_218_18) / 57)) > 0 and var_218_16 < var_218_20 then
					arg_215_1.talkMaxDuration = var_218_20
					var_218_15 = var_218_15 + 0.3

					if var_218_20 + var_218_15 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_20 + var_218_15
					end
				end

				arg_215_1.text_.text = var_218_18
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_21 = var_218_15 + 0.3
			local var_218_22 = math.max(var_218_16, arg_215_1.talkMaxDuration)

			if var_218_15 + 0.3 <= arg_215_1.time_ and arg_215_1.time_ < var_218_21 + var_218_22 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_21) / var_218_22

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_21 + var_218_22 and arg_215_1.time_ < var_218_21 + var_218_22 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0905",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play122141050 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 122141050
		arg_221_1.duration_ = 9

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play122141051(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if arg_221_1.bgs_.OM0214 == nil then
				local var_224_0 = Object.Instantiate(arg_221_1.paintGo_)

				var_224_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "OM0214")
				var_224_0.name = "OM0214"
				var_224_0.transform.parent = arg_221_1.stage_.transform
				var_224_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_221_1.bgs_.OM0214 = var_224_0
			end

			if 2 < arg_221_1.time_ and arg_221_1.time_ <= 2 + arg_224_0 then
				local var_224_1 = arg_221_1.bgs_.OM0214

				arg_221_1.bgs_.OM0214.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_224_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_224_2 = var_224_1:GetComponent("SpriteRenderer")

				if var_224_2 and var_224_2.sprite then
					local var_224_3 = 2 * (var_224_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_224_1.transform.localScale = Vector3.New(var_224_3 / var_224_2.sprite.bounds.size.y < var_224_3 * manager.ui.mainCameraCom_.aspect / var_224_2.sprite.bounds.size.x and var_224_3 * manager.ui.mainCameraCom_.aspect / var_224_2.sprite.bounds.size.x or var_224_3 / var_224_2.sprite.bounds.size.y, var_224_3 / var_224_2.sprite.bounds.size.y < var_224_3 * manager.ui.mainCameraCom_.aspect / var_224_2.sprite.bounds.size.x and var_224_3 * manager.ui.mainCameraCom_.aspect / var_224_2.sprite.bounds.size.x or var_224_3 / var_224_2.sprite.bounds.size.y, 0)
				end

				for iter_224_0, iter_224_1 in pairs(arg_221_1.bgs_) do
					if iter_224_0 ~= "OM0214" then
						iter_224_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_224_4 = 0

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1.mask_.enabled = true
				arg_221_1.mask_.raycastTarget = true

				arg_221_1:SetGaussion(false)
			end

			local var_224_5 = 2

			if var_224_4 <= arg_221_1.time_ and arg_221_1.time_ < var_224_4 + var_224_5 then
				local var_224_6 = Color.New(0, 0, 0)

				var_224_6.a = Mathf.Lerp(0, 1, (arg_221_1.time_ - var_224_4) / var_224_5)
				arg_221_1.mask_.color = var_224_6
			end

			if arg_221_1.time_ >= var_224_4 + var_224_5 and arg_221_1.time_ < var_224_4 + var_224_5 + arg_224_0 then
				local var_224_7 = Color.New(0, 0, 0)

				var_224_7.a = 1
				arg_221_1.mask_.color = var_224_7
			end

			local var_224_8 = 2

			if 2 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 then
				arg_221_1.mask_.enabled = true
				arg_221_1.mask_.raycastTarget = true

				arg_221_1:SetGaussion(false)
			end

			local var_224_9 = 2

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_9 then
				local var_224_10 = Color.New(0, 0, 0)

				var_224_10.a = Mathf.Lerp(1, 0, (arg_221_1.time_ - var_224_8) / var_224_9)
				arg_221_1.mask_.color = var_224_10
			end

			if arg_221_1.time_ >= var_224_8 + var_224_9 and arg_221_1.time_ < var_224_8 + var_224_9 + arg_224_0 then
				local var_224_11 = Color.New(0, 0, 0)

				arg_221_1.mask_.enabled = false
				var_224_11.a = 0
				arg_221_1.mask_.color = var_224_11
			end

			local var_224_12 = arg_221_1.bgs_.OM0214.transform

			if 2 < arg_221_1.time_ and arg_221_1.time_ <= 2 + arg_224_0 then
				arg_221_1.var_.moveOldPosOM0214 = var_224_12.localPosition
			end

			local var_224_13 = 3.5

			if 2 <= arg_221_1.time_ and arg_221_1.time_ < 2 + var_224_13 then
				var_224_12.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPosOM0214, Vector3.New(0, 1, 9.5), (arg_221_1.time_ - 2) / var_224_13)
			end

			if arg_221_1.time_ >= 2 + var_224_13 and arg_221_1.time_ < 2 + var_224_13 + arg_224_0 then
				var_224_12.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_224_14 = 4

			if 4 < arg_221_1.time_ and arg_221_1.time_ <= var_224_14 + arg_224_0 then
				arg_221_1.allBtn_.enabled = false
			end

			if arg_221_1.time_ >= var_224_14 + 1.5 and arg_221_1.time_ < var_224_14 + 1.5 + arg_224_0 then
				arg_221_1.allBtn_.enabled = true
			end

			if arg_221_1.frameCnt_ <= 1 then
				arg_221_1.dialog_:SetActive(false)
			end

			local var_224_15 = 4
			local var_224_16 = 1.6

			if 4 < arg_221_1.time_ and arg_221_1.time_ <= var_224_15 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0

				arg_221_1.dialog_:SetActive(true)

				arg_221_1.dialogCg_.alpha = 0

				local var_224_17 = LeanTween.value(arg_221_1.dialog_, 0, 1, 0.3)

				var_224_17:setOnUpdate(LuaHelper.FloatAction(function(arg_225_0)
					arg_221_1.dialogCg_.alpha = arg_225_0
				end))
				var_224_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_221_1.dialog_)
					var_224_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_221_1.duration_ = arg_221_1.duration_ + 0.3

				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_18 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(122141050).content)

				arg_221_1.text_.text = var_224_18

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_20 = 64 <= 0 and var_224_16 or var_224_16 * (utf8.len(var_224_18) / 64)

				if (64 <= 0 and var_224_16 or var_224_16 * (utf8.len(var_224_18) / 64)) > 0 and var_224_16 < var_224_20 then
					arg_221_1.talkMaxDuration = var_224_20
					var_224_15 = var_224_15 + 0.3

					if var_224_20 + var_224_15 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_20 + var_224_15
					end
				end

				arg_221_1.text_.text = var_224_18
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_21 = var_224_15 + 0.3
			local var_224_22 = math.max(var_224_16, arg_221_1.talkMaxDuration)

			if var_224_15 + 0.3 <= arg_221_1.time_ and arg_221_1.time_ < var_224_21 + var_224_22 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_21) / var_224_22

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_21 + var_224_22 and arg_221_1.time_ < var_224_21 + var_224_22 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0214",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play122141051 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 122141051
		arg_227_1.duration_ = 9

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play122141052(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if arg_227_1.bgs_.A03 == nil then
				local var_230_0 = Object.Instantiate(arg_227_1.paintGo_)

				var_230_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A03")
				var_230_0.name = "A03"
				var_230_0.transform.parent = arg_227_1.stage_.transform
				var_230_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_227_1.bgs_.A03 = var_230_0
			end

			if 2 < arg_227_1.time_ and arg_227_1.time_ <= 2 + arg_230_0 then
				local var_230_1 = arg_227_1.bgs_.A03

				arg_227_1.bgs_.A03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_230_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_230_2 = var_230_1:GetComponent("SpriteRenderer")

				if var_230_2 and var_230_2.sprite then
					local var_230_3 = 2 * (var_230_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_230_1.transform.localScale = Vector3.New(var_230_3 / var_230_2.sprite.bounds.size.y < var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x and var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x or var_230_3 / var_230_2.sprite.bounds.size.y, var_230_3 / var_230_2.sprite.bounds.size.y < var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x and var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x or var_230_3 / var_230_2.sprite.bounds.size.y, 0)
				end

				for iter_230_0, iter_230_1 in pairs(arg_227_1.bgs_) do
					if iter_230_0 ~= "A03" then
						iter_230_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_230_4 = 0

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1.mask_.enabled = true
				arg_227_1.mask_.raycastTarget = true

				arg_227_1:SetGaussion(false)
			end

			local var_230_5 = 2

			if var_230_4 <= arg_227_1.time_ and arg_227_1.time_ < var_230_4 + var_230_5 then
				local var_230_6 = Color.New(0, 0, 0)

				var_230_6.a = Mathf.Lerp(0, 1, (arg_227_1.time_ - var_230_4) / var_230_5)
				arg_227_1.mask_.color = var_230_6
			end

			if arg_227_1.time_ >= var_230_4 + var_230_5 and arg_227_1.time_ < var_230_4 + var_230_5 + arg_230_0 then
				local var_230_7 = Color.New(0, 0, 0)

				var_230_7.a = 1
				arg_227_1.mask_.color = var_230_7
			end

			local var_230_8 = 2

			if 2 < arg_227_1.time_ and arg_227_1.time_ <= var_230_8 + arg_230_0 then
				arg_227_1.mask_.enabled = true
				arg_227_1.mask_.raycastTarget = true

				arg_227_1:SetGaussion(false)
			end

			local var_230_9 = 2

			if var_230_8 <= arg_227_1.time_ and arg_227_1.time_ < var_230_8 + var_230_9 then
				local var_230_10 = Color.New(0, 0, 0)

				var_230_10.a = Mathf.Lerp(1, 0, (arg_227_1.time_ - var_230_8) / var_230_9)
				arg_227_1.mask_.color = var_230_10
			end

			if arg_227_1.time_ >= var_230_8 + var_230_9 and arg_227_1.time_ < var_230_8 + var_230_9 + arg_230_0 then
				local var_230_11 = Color.New(0, 0, 0)

				arg_227_1.mask_.enabled = false
				var_230_11.a = 0
				arg_227_1.mask_.color = var_230_11
			end

			if arg_227_1.frameCnt_ <= 1 then
				arg_227_1.dialog_:SetActive(false)
			end

			local var_230_12 = 4
			local var_230_13 = 1.175

			if 4 < arg_227_1.time_ and arg_227_1.time_ <= var_230_12 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0

				arg_227_1.dialog_:SetActive(true)

				arg_227_1.dialogCg_.alpha = 0

				local var_230_14 = LeanTween.value(arg_227_1.dialog_, 0, 1, 0.3)

				var_230_14:setOnUpdate(LuaHelper.FloatAction(function(arg_231_0)
					arg_227_1.dialogCg_.alpha = arg_231_0
				end))
				var_230_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_227_1.dialog_)
					var_230_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_227_1.duration_ = arg_227_1.duration_ + 0.3

				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_15 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(122141051).content)

				arg_227_1.text_.text = var_230_15

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_17 = 47 <= 0 and var_230_13 or var_230_13 * (utf8.len(var_230_15) / 47)

				if (47 <= 0 and var_230_13 or var_230_13 * (utf8.len(var_230_15) / 47)) > 0 and var_230_13 < var_230_17 then
					arg_227_1.talkMaxDuration = var_230_17
					var_230_12 = var_230_12 + 0.3

					if var_230_17 + var_230_12 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_17 + var_230_12
					end
				end

				arg_227_1.text_.text = var_230_15
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_18 = var_230_12 + 0.3
			local var_230_19 = math.max(var_230_13, arg_227_1.talkMaxDuration)

			if var_230_12 + 0.3 <= arg_227_1.time_ and arg_227_1.time_ < var_230_18 + var_230_19 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_18) / var_230_19

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_18 + var_230_19 and arg_227_1.time_ < var_230_18 + var_230_19 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play122141052 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 122141052
		arg_233_1.duration_ = 12.2

		local var_233_0 = {
			ja = 5.1,
			ko = 12.2,
			zh = 12.2
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play122141053(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1184ui_story = arg_233_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_236_0 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 then
				arg_233_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_233_1.time_ - 0) / var_236_0)
				arg_233_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1184ui_story"].transform.position).z)
				arg_233_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1184ui_story"].transform.localEulerAngles = arg_233_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 then
				arg_233_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_233_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1184ui_story"].transform.position).z)
				arg_233_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1184ui_story"].transform.localEulerAngles = arg_233_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_236_1 = arg_233_1.actors_["1184ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1184ui_story == nil then
				arg_233_1.var_.characterEffect1184ui_story = var_236_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_2 and not isNil(var_236_1) then
				if arg_233_1.var_.characterEffect1184ui_story and not isNil(var_236_1) then
					arg_233_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_2 and arg_233_1.time_ < 0 + var_236_2 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1184ui_story then
				arg_233_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action10_2")
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_236_4 = 0
			local var_236_5 = 0.525

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_6 = arg_233_1:GetWordFromCfg(122141052)
				local var_236_7 = arg_233_1:FormatText(var_236_6.content)

				arg_233_1.text_.text = var_236_7

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_9 = 21 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 21)

				if (21 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 21)) > 0 and var_236_5 < var_236_9 then
					arg_233_1.talkMaxDuration = var_236_9

					if var_236_9 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_9 + var_236_4
					end
				end

				arg_233_1.text_.text = var_236_7
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141052", "story_v_out_122141.awb") ~= 0 then
					local var_236_10 = manager.audio:GetVoiceLength("story_v_out_122141", "122141052", "story_v_out_122141.awb") / 1000

					if var_236_10 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_10 + var_236_4
					end

					if var_236_6.prefab_name ~= "" and arg_233_1.actors_[var_236_6.prefab_name] ~= nil then
						local var_236_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_6.prefab_name].transform, "story_v_out_122141", "122141052", "story_v_out_122141.awb")

						arg_233_1:RecordAudio("122141052", var_236_11)
						arg_233_1:RecordAudio("122141052", var_236_11)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_122141", "122141052", "story_v_out_122141.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_122141", "122141052", "story_v_out_122141.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_12 = math.max(var_236_5, arg_233_1.talkMaxDuration)

			if var_236_4 <= arg_233_1.time_ and arg_233_1.time_ < var_236_4 + var_236_12 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_4) / var_236_12

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_4 + var_236_12 and arg_233_1.time_ < var_236_4 + var_236_12 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play122141053 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 122141053
		arg_237_1.duration_ = 10.4

		local var_237_0 = {
			ja = 6.333,
			ko = 10.4,
			zh = 10.4
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play122141054(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_240_0 = arg_237_1.actors_["1184ui_story"].transform

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1184ui_story = var_240_0.localPosition
			end

			local var_240_1 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_1 then
				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_237_1.time_ - 0) / var_240_1)
				var_240_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_0.position).x, (manager.ui.mainCamera.transform.position - var_240_0.position).y, (manager.ui.mainCamera.transform.position - var_240_0.position).z)
				var_240_0.localEulerAngles.z = 0
				var_240_0.localEulerAngles.x = 0
				var_240_0.localEulerAngles = var_240_0.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_1 and arg_237_1.time_ < 0 + var_240_1 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(0, -0.97, -6)
				var_240_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_0.position).x, (manager.ui.mainCamera.transform.position - var_240_0.position).y, (manager.ui.mainCamera.transform.position - var_240_0.position).z)
				var_240_0.localEulerAngles.z = 0
				var_240_0.localEulerAngles.x = 0
				var_240_0.localEulerAngles = var_240_0.localEulerAngles
			end

			local var_240_2 = arg_237_1.actors_["1184ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.characterEffect1184ui_story == nil then
				arg_237_1.var_.characterEffect1184ui_story = var_240_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_3 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_3 and not isNil(var_240_2) then
				if arg_237_1.var_.characterEffect1184ui_story and not isNil(var_240_2) then
					arg_237_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_3 and arg_237_1.time_ < 0 + var_240_3 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.characterEffect1184ui_story then
				arg_237_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_240_5 = 0
			local var_240_6 = 0.725

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_5 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_7 = arg_237_1:GetWordFromCfg(122141053)
				local var_240_8 = arg_237_1:FormatText(var_240_7.content)

				arg_237_1.text_.text = var_240_8

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_10 = 29 <= 0 and var_240_6 or var_240_6 * (utf8.len(var_240_8) / 29)

				if (29 <= 0 and var_240_6 or var_240_6 * (utf8.len(var_240_8) / 29)) > 0 and var_240_6 < var_240_10 then
					arg_237_1.talkMaxDuration = var_240_10

					if var_240_10 + var_240_5 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_10 + var_240_5
					end
				end

				arg_237_1.text_.text = var_240_8
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141053", "story_v_out_122141.awb") ~= 0 then
					local var_240_11 = manager.audio:GetVoiceLength("story_v_out_122141", "122141053", "story_v_out_122141.awb") / 1000

					if var_240_11 + var_240_5 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_11 + var_240_5
					end

					if var_240_7.prefab_name ~= "" and arg_237_1.actors_[var_240_7.prefab_name] ~= nil then
						local var_240_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_7.prefab_name].transform, "story_v_out_122141", "122141053", "story_v_out_122141.awb")

						arg_237_1:RecordAudio("122141053", var_240_12)
						arg_237_1:RecordAudio("122141053", var_240_12)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_122141", "122141053", "story_v_out_122141.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_122141", "122141053", "story_v_out_122141.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_13 = math.max(var_240_6, arg_237_1.talkMaxDuration)

			if var_240_5 <= arg_237_1.time_ and arg_237_1.time_ < var_240_5 + var_240_13 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_5) / var_240_13

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_5 + var_240_13 and arg_237_1.time_ < var_240_5 + var_240_13 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play122141054 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 122141054
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play122141055(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1184ui_story = arg_241_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1184ui_story"].transform.position).z)
				arg_241_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1184ui_story"].transform.localEulerAngles = arg_241_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_241_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1184ui_story"].transform.position).z)
				arg_241_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1184ui_story"].transform.localEulerAngles = arg_241_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_244_1 = 0
			local var_244_2 = 1.625

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_3 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(122141054).content)

				arg_241_1.text_.text = var_244_3

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 65 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_3) / 65)

				if (65 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_3) / 65)) > 0 and var_244_2 < var_244_5 then
					arg_241_1.talkMaxDuration = var_244_5

					if var_244_5 + var_244_1 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + var_244_1
					end
				end

				arg_241_1.text_.text = var_244_3
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_6 = math.max(var_244_2, arg_241_1.talkMaxDuration)

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_6 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_1) / var_244_6

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_1 + var_244_6 and arg_241_1.time_ < var_244_1 + var_244_6 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play122141055 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 122141055
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play122141056(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 1.325

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_1 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(122141055).content)

				arg_245_1.text_.text = var_248_1

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_3 = 53 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 53)

				if (53 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 53)) > 0 and var_248_0 < var_248_3 then
					arg_245_1.talkMaxDuration = var_248_3

					if var_248_3 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_3 + 0
					end
				end

				arg_245_1.text_.text = var_248_1
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_4 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_4 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_4

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_4 and arg_245_1.time_ < 0 + var_248_4 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play122141056 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 122141056
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play122141057(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0.65

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_1 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(122141056).content)

				arg_249_1.text_.text = var_252_1

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_3 = 26 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 26)

				if (26 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 26)) > 0 and var_252_0 < var_252_3 then
					arg_249_1.talkMaxDuration = var_252_3

					if var_252_3 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_3 + 0
					end
				end

				arg_249_1.text_.text = var_252_1
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_4 = math.max(var_252_0, arg_249_1.talkMaxDuration)

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - 0) / var_252_4

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play122141057 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 122141057
		arg_253_1.duration_ = 4.97

		local var_253_0 = {
			ja = 4.966,
			ko = 4.933,
			zh = 4.933
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play122141058(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1184ui_story = arg_253_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_256_0 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 then
				arg_253_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_253_1.time_ - 0) / var_256_0)
				arg_253_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1184ui_story"].transform.position).z)
				arg_253_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1184ui_story"].transform.localEulerAngles = arg_253_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 then
				arg_253_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_253_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1184ui_story"].transform.position).z)
				arg_253_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1184ui_story"].transform.localEulerAngles = arg_253_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_256_1 = arg_253_1.actors_["1184ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1184ui_story == nil then
				arg_253_1.var_.characterEffect1184ui_story = var_256_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 and not isNil(var_256_1) then
				if arg_253_1.var_.characterEffect1184ui_story and not isNil(var_256_1) then
					arg_253_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1184ui_story then
				arg_253_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_256_4 = 0
			local var_256_5 = 0.275

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_4 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_6 = arg_253_1:GetWordFromCfg(122141057)
				local var_256_7 = arg_253_1:FormatText(var_256_6.content)

				arg_253_1.text_.text = var_256_7

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_9 = 11 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 11)

				if (11 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 11)) > 0 and var_256_5 < var_256_9 then
					arg_253_1.talkMaxDuration = var_256_9

					if var_256_9 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_9 + var_256_4
					end
				end

				arg_253_1.text_.text = var_256_7
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141057", "story_v_out_122141.awb") ~= 0 then
					local var_256_10 = manager.audio:GetVoiceLength("story_v_out_122141", "122141057", "story_v_out_122141.awb") / 1000

					if var_256_10 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_10 + var_256_4
					end

					if var_256_6.prefab_name ~= "" and arg_253_1.actors_[var_256_6.prefab_name] ~= nil then
						local var_256_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_6.prefab_name].transform, "story_v_out_122141", "122141057", "story_v_out_122141.awb")

						arg_253_1:RecordAudio("122141057", var_256_11)
						arg_253_1:RecordAudio("122141057", var_256_11)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_122141", "122141057", "story_v_out_122141.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_122141", "122141057", "story_v_out_122141.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_12 = math.max(var_256_5, arg_253_1.talkMaxDuration)

			if var_256_4 <= arg_253_1.time_ and arg_253_1.time_ < var_256_4 + var_256_12 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_4) / var_256_12

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_4 + var_256_12 and arg_253_1.time_ < var_256_4 + var_256_12 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play122141058 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 122141058
		arg_257_1.duration_ = 6.67

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play122141059(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 1.96599999815226 < arg_257_1.time_ and arg_257_1.time_ <= 1.96599999815226 + arg_260_0 then
				arg_257_1.var_.moveOldPos1184ui_story = arg_257_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_260_0 = 0.001

			if 1.96599999815226 <= arg_257_1.time_ and arg_257_1.time_ < 1.96599999815226 + var_260_0 then
				arg_257_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_257_1.time_ - 1.96599999815226) / var_260_0)
				arg_257_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1184ui_story"].transform.position).z)
				arg_257_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1184ui_story"].transform.localEulerAngles = arg_257_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 1.96599999815226 + var_260_0 and arg_257_1.time_ < 1.96599999815226 + var_260_0 + arg_260_0 then
				arg_257_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_257_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1184ui_story"].transform.position).z)
				arg_257_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1184ui_story"].transform.localEulerAngles = arg_257_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.fswbg_:SetActive(true)
				arg_257_1.dialog_:SetActive(false)

				arg_257_1.fswtw_.percent = 0
				arg_257_1.fswt_.text = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(122141058).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.fswt_)

				arg_257_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_257_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_257_1.fswtw_:SetDirty()

				arg_257_1.typewritterCharCountI18N = 0

				SetActive(arg_257_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_257_1:ShowNextGo(false)
			end

			local var_260_1 = 3.8

			if 3.8 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.var_.oldValueTypewriter = arg_257_1.fswtw_.percent

				SetActive(arg_257_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_257_1:ShowNextGo(false)
			end

			local var_260_2 = 19
			local var_260_3 = 1.26666666666667
			local var_260_4, var_260_5 = arg_257_1:GetPercentByPara(arg_257_1:FormatText(arg_257_1:GetWordFromCfg(122141058).content), 1)

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0

				local var_260_6 = var_260_2 <= 0 and var_260_3 or var_260_3 * ((var_260_5 - arg_257_1.typewritterCharCountI18N) / var_260_2)

				if (var_260_2 <= 0 and var_260_3 or var_260_3 * ((var_260_5 - arg_257_1.typewritterCharCountI18N) / var_260_2)) > 0 and var_260_3 < var_260_6 then
					arg_257_1.talkMaxDuration = var_260_6

					if var_260_6 + var_260_1 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_6 + var_260_1
					end
				end
			end

			local var_260_7 = math.max(1.26666666666667, arg_257_1.talkMaxDuration)

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_7 then
				arg_257_1.fswtw_.percent = Mathf.Lerp(arg_257_1.var_.oldValueTypewriter, var_260_4, (arg_257_1.time_ - var_260_1) / var_260_7)
				arg_257_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_257_1.fswtw_:SetDirty()
			end

			if arg_257_1.time_ >= var_260_1 + var_260_7 and arg_257_1.time_ < var_260_1 + var_260_7 + arg_260_0 then
				arg_257_1.fswtw_.percent = var_260_4

				arg_257_1.fswtw_:SetDirty()
				arg_257_1:ShowNextGo(true)

				arg_257_1.typewritterCharCountI18N = var_260_5
			end

			if 3.8 < arg_257_1.time_ and arg_257_1.time_ <= 3.8 + arg_260_0 then
				local var_260_8 = arg_257_1.fswbg_.transform:Find("textbox/adapt/content") or arg_257_1.fswbg_.transform:Find("textbox/content")
				local var_260_9 = arg_257_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_260_10 = var_260_8:GetComponent("RectTransform")

				var_260_8:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_260_10.offsetMin = Vector2.New(0, 0)
				var_260_10.offsetMax = Vector2.New(0, 0)
			end

			local var_260_11 = 0

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_11 + arg_260_0 then
				arg_257_1.mask_.enabled = true
				arg_257_1.mask_.raycastTarget = true

				arg_257_1:SetGaussion(false)
			end

			local var_260_12 = 2

			if var_260_11 <= arg_257_1.time_ and arg_257_1.time_ < var_260_11 + var_260_12 then
				local var_260_13 = Color.New(0, 0, 0)

				var_260_13.a = Mathf.Lerp(0, 1, (arg_257_1.time_ - var_260_11) / var_260_12)
				arg_257_1.mask_.color = var_260_13
			end

			if arg_257_1.time_ >= var_260_11 + var_260_12 and arg_257_1.time_ < var_260_11 + var_260_12 + arg_260_0 then
				local var_260_14 = Color.New(0, 0, 0)

				var_260_14.a = 1
				arg_257_1.mask_.color = var_260_14
			end

			local var_260_15 = 2

			if 2 < arg_257_1.time_ and arg_257_1.time_ <= var_260_15 + arg_260_0 then
				arg_257_1.mask_.enabled = true
				arg_257_1.mask_.raycastTarget = true

				arg_257_1:SetGaussion(false)
			end

			local var_260_16 = 2

			if var_260_15 <= arg_257_1.time_ and arg_257_1.time_ < var_260_15 + var_260_16 then
				local var_260_17 = Color.New(0, 0, 0)

				var_260_17.a = Mathf.Lerp(1, 0, (arg_257_1.time_ - var_260_15) / var_260_16)
				arg_257_1.mask_.color = var_260_17
			end

			if arg_257_1.time_ >= var_260_15 + var_260_16 and arg_257_1.time_ < var_260_15 + var_260_16 + arg_260_0 then
				local var_260_18 = Color.New(0, 0, 0)

				arg_257_1.mask_.enabled = false
				var_260_18.a = 0
				arg_257_1.mask_.color = var_260_18
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play122141059 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 122141059
		arg_261_1.duration_ = 1.35

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play122141060(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.fswbg_:SetActive(true)
				arg_261_1.dialog_:SetActive(false)

				arg_261_1.fswtw_.percent = 0
				arg_261_1.fswt_.text = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(122141059).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.fswt_)

				arg_261_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_261_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_261_1.fswtw_:SetDirty()

				arg_261_1.typewritterCharCountI18N = 0

				SetActive(arg_261_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_261_1:ShowNextGo(false)
			end

			local var_264_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.var_.oldValueTypewriter = arg_261_1.fswtw_.percent

				SetActive(arg_261_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_261_1:ShowNextGo(false)
			end

			local var_264_1 = 20
			local var_264_2 = 1.33333333333333
			local var_264_3, var_264_4 = arg_261_1:GetPercentByPara(arg_261_1:FormatText(arg_261_1:GetWordFromCfg(122141059).content), 1)

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0

				local var_264_5 = var_264_1 <= 0 and var_264_2 or var_264_2 * ((var_264_4 - arg_261_1.typewritterCharCountI18N) / var_264_1)

				if (var_264_1 <= 0 and var_264_2 or var_264_2 * ((var_264_4 - arg_261_1.typewritterCharCountI18N) / var_264_1)) > 0 and var_264_2 < var_264_5 then
					arg_261_1.talkMaxDuration = var_264_5

					if var_264_5 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + var_264_0
					end
				end
			end

			local var_264_6 = math.max(1.33333333333333, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_6 then
				arg_261_1.fswtw_.percent = Mathf.Lerp(arg_261_1.var_.oldValueTypewriter, var_264_3, (arg_261_1.time_ - var_264_0) / var_264_6)
				arg_261_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_261_1.fswtw_:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_6 and arg_261_1.time_ < var_264_0 + var_264_6 + arg_264_0 then
				arg_261_1.fswtw_.percent = var_264_3

				arg_261_1.fswtw_:SetDirty()
				arg_261_1:ShowNextGo(true)

				arg_261_1.typewritterCharCountI18N = var_264_4
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play122141060 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 122141060
		arg_265_1.duration_ = 1.35

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play122141061(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.fswbg_:SetActive(true)
				arg_265_1.dialog_:SetActive(false)

				arg_265_1.fswtw_.percent = 0
				arg_265_1.fswt_.text = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(122141060).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.fswt_)

				arg_265_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_265_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_265_1.fswtw_:SetDirty()

				arg_265_1.typewritterCharCountI18N = 0

				SetActive(arg_265_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_265_1:ShowNextGo(false)
			end

			local var_268_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.var_.oldValueTypewriter = arg_265_1.fswtw_.percent

				SetActive(arg_265_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_265_1:ShowNextGo(false)
			end

			local var_268_1 = 20
			local var_268_2 = 1.33333333333333
			local var_268_3, var_268_4 = arg_265_1:GetPercentByPara(arg_265_1:FormatText(arg_265_1:GetWordFromCfg(122141060).content), 1)

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0

				local var_268_5 = var_268_1 <= 0 and var_268_2 or var_268_2 * ((var_268_4 - arg_265_1.typewritterCharCountI18N) / var_268_1)

				if (var_268_1 <= 0 and var_268_2 or var_268_2 * ((var_268_4 - arg_265_1.typewritterCharCountI18N) / var_268_1)) > 0 and var_268_2 < var_268_5 then
					arg_265_1.talkMaxDuration = var_268_5

					if var_268_5 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_5 + var_268_0
					end
				end
			end

			local var_268_6 = math.max(1.33333333333333, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_6 then
				arg_265_1.fswtw_.percent = Mathf.Lerp(arg_265_1.var_.oldValueTypewriter, var_268_3, (arg_265_1.time_ - var_268_0) / var_268_6)
				arg_265_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_265_1.fswtw_:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_6 and arg_265_1.time_ < var_268_0 + var_268_6 + arg_268_0 then
				arg_265_1.fswtw_.percent = var_268_3

				arg_265_1.fswtw_:SetDirty()
				arg_265_1:ShowNextGo(true)

				arg_265_1.typewritterCharCountI18N = var_268_4
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play122141061 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 122141061
		arg_269_1.duration_ = 1.35

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play122141062(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.fswbg_:SetActive(true)
				arg_269_1.dialog_:SetActive(false)

				arg_269_1.fswtw_.percent = 0
				arg_269_1.fswt_.text = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(122141061).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.fswt_)

				arg_269_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_269_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_269_1.fswtw_:SetDirty()

				arg_269_1.typewritterCharCountI18N = 0

				SetActive(arg_269_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_269_1:ShowNextGo(false)
			end

			local var_272_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.var_.oldValueTypewriter = arg_269_1.fswtw_.percent

				SetActive(arg_269_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_269_1:ShowNextGo(false)
			end

			local var_272_1 = 20
			local var_272_2 = 1.33333333333333
			local var_272_3, var_272_4 = arg_269_1:GetPercentByPara(arg_269_1:FormatText(arg_269_1:GetWordFromCfg(122141061).content), 1)

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0

				local var_272_5 = var_272_1 <= 0 and var_272_2 or var_272_2 * ((var_272_4 - arg_269_1.typewritterCharCountI18N) / var_272_1)

				if (var_272_1 <= 0 and var_272_2 or var_272_2 * ((var_272_4 - arg_269_1.typewritterCharCountI18N) / var_272_1)) > 0 and var_272_2 < var_272_5 then
					arg_269_1.talkMaxDuration = var_272_5

					if var_272_5 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + var_272_0
					end
				end
			end

			local var_272_6 = math.max(1.33333333333333, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_6 then
				arg_269_1.fswtw_.percent = Mathf.Lerp(arg_269_1.var_.oldValueTypewriter, var_272_3, (arg_269_1.time_ - var_272_0) / var_272_6)
				arg_269_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_269_1.fswtw_:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_6 and arg_269_1.time_ < var_272_0 + var_272_6 + arg_272_0 then
				arg_269_1.fswtw_.percent = var_272_3

				arg_269_1.fswtw_:SetDirty()
				arg_269_1:ShowNextGo(true)

				arg_269_1.typewritterCharCountI18N = var_272_4
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play122141062 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 122141062
		arg_273_1.duration_ = 12.08

		local var_273_0 = {
			ja = 9.01666666666667,
			ko = 12.0826666666667,
			zh = 12.0826666666667
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play122141063(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 3.8 < arg_273_1.time_ and arg_273_1.time_ <= 3.8 + arg_276_0 then
				arg_273_1.var_.moveOldPos1184ui_story = arg_273_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 3.8 <= arg_273_1.time_ and arg_273_1.time_ < 3.8 + var_276_0 then
				arg_273_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_273_1.time_ - 3.8) / var_276_0)
				arg_273_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1184ui_story"].transform.position).z)
				arg_273_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1184ui_story"].transform.localEulerAngles = arg_273_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 3.8 + var_276_0 and arg_273_1.time_ < 3.8 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_273_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1184ui_story"].transform.position).z)
				arg_273_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1184ui_story"].transform.localEulerAngles = arg_273_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_276_1 = arg_273_1.actors_["1184ui_story"]

			if 3.8 < arg_273_1.time_ and arg_273_1.time_ <= 3.8 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect1184ui_story == nil then
				arg_273_1.var_.characterEffect1184ui_story = var_276_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if 3.8 <= arg_273_1.time_ and arg_273_1.time_ < 3.8 + var_276_2 and not isNil(var_276_1) then
				if arg_273_1.var_.characterEffect1184ui_story and not isNil(var_276_1) then
					arg_273_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 3.8 + var_276_2 and arg_273_1.time_ < 3.8 + var_276_2 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect1184ui_story then
				arg_273_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 3.8 < arg_273_1.time_ and arg_273_1.time_ <= 3.8 + arg_276_0 then
				arg_273_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 3.8 < arg_273_1.time_ and arg_273_1.time_ <= 3.8 + arg_276_0 then
				arg_273_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			if 2 < arg_273_1.time_ and arg_273_1.time_ <= 2 + arg_276_0 then
				arg_273_1.fswbg_:SetActive(false)
				arg_273_1.dialog_:SetActive(false)
				SetActive(arg_273_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_273_1:ShowNextGo(false)
			end

			local var_276_4 = 0

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_4 + arg_276_0 then
				arg_273_1.mask_.enabled = true
				arg_273_1.mask_.raycastTarget = true

				arg_273_1:SetGaussion(false)
			end

			local var_276_5 = 2

			if var_276_4 <= arg_273_1.time_ and arg_273_1.time_ < var_276_4 + var_276_5 then
				local var_276_6 = Color.New(0, 0, 0)

				var_276_6.a = Mathf.Lerp(0, 1, (arg_273_1.time_ - var_276_4) / var_276_5)
				arg_273_1.mask_.color = var_276_6
			end

			if arg_273_1.time_ >= var_276_4 + var_276_5 and arg_273_1.time_ < var_276_4 + var_276_5 + arg_276_0 then
				local var_276_7 = Color.New(0, 0, 0)

				var_276_7.a = 1
				arg_273_1.mask_.color = var_276_7
			end

			local var_276_8 = 2.01666666666667

			if 2.01666666666667 < arg_273_1.time_ and arg_273_1.time_ <= var_276_8 + arg_276_0 then
				arg_273_1.mask_.enabled = true
				arg_273_1.mask_.raycastTarget = true

				arg_273_1:SetGaussion(false)
			end

			local var_276_9 = 2

			if var_276_8 <= arg_273_1.time_ and arg_273_1.time_ < var_276_8 + var_276_9 then
				local var_276_10 = Color.New(0, 0, 0)

				var_276_10.a = Mathf.Lerp(1, 0, (arg_273_1.time_ - var_276_8) / var_276_9)
				arg_273_1.mask_.color = var_276_10
			end

			if arg_273_1.time_ >= var_276_8 + var_276_9 and arg_273_1.time_ < var_276_8 + var_276_9 + arg_276_0 then
				local var_276_11 = Color.New(0, 0, 0)

				arg_273_1.mask_.enabled = false
				var_276_11.a = 0
				arg_273_1.mask_.color = var_276_11
			end

			if arg_273_1.frameCnt_ <= 1 then
				arg_273_1.dialog_:SetActive(false)
			end

			local var_276_12 = 4.01666666666667
			local var_276_13 = 0.65

			if 4.01666666666667 < arg_273_1.time_ and arg_273_1.time_ <= var_276_12 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0

				arg_273_1.dialog_:SetActive(true)

				arg_273_1.dialogCg_.alpha = 0

				local var_276_14 = LeanTween.value(arg_273_1.dialog_, 0, 1, 0.3)

				var_276_14:setOnUpdate(LuaHelper.FloatAction(function(arg_277_0)
					arg_273_1.dialogCg_.alpha = arg_277_0
				end))
				var_276_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_273_1.dialog_)
					var_276_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_273_1.duration_ = arg_273_1.duration_ + 0.3

				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_15 = arg_273_1:GetWordFromCfg(122141062)
				local var_276_16 = arg_273_1:FormatText(var_276_15.content)

				arg_273_1.text_.text = var_276_16

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_18 = 26 <= 0 and var_276_13 or var_276_13 * (utf8.len(var_276_16) / 26)

				if (26 <= 0 and var_276_13 or var_276_13 * (utf8.len(var_276_16) / 26)) > 0 and var_276_13 < var_276_18 then
					arg_273_1.talkMaxDuration = var_276_18
					var_276_12 = var_276_12 + 0.3

					if var_276_18 + var_276_12 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_18 + var_276_12
					end
				end

				arg_273_1.text_.text = var_276_16
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141062", "story_v_out_122141.awb") ~= 0 then
					local var_276_19 = manager.audio:GetVoiceLength("story_v_out_122141", "122141062", "story_v_out_122141.awb") / 1000

					if var_276_19 + var_276_12 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_19 + var_276_12
					end

					if var_276_15.prefab_name ~= "" and arg_273_1.actors_[var_276_15.prefab_name] ~= nil then
						local var_276_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_15.prefab_name].transform, "story_v_out_122141", "122141062", "story_v_out_122141.awb")

						arg_273_1:RecordAudio("122141062", var_276_20)
						arg_273_1:RecordAudio("122141062", var_276_20)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_122141", "122141062", "story_v_out_122141.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_122141", "122141062", "story_v_out_122141.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_21 = var_276_12 + 0.3
			local var_276_22 = math.max(var_276_13, arg_273_1.talkMaxDuration)

			if var_276_12 + 0.3 <= arg_273_1.time_ and arg_273_1.time_ < var_276_21 + var_276_22 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_21) / var_276_22

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_21 + var_276_22 and arg_273_1.time_ < var_276_21 + var_276_22 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play122141063 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 122141063
		arg_279_1.duration_ = 7.8

		local var_279_0 = {
			ja = 3.5,
			ko = 7.8,
			zh = 7.8
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
			arg_279_1.auto_ = false
		end

		function arg_279_1.playNext_(arg_281_0)
			arg_279_1.onStoryFinished_()
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0.4

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_1 = arg_279_1:GetWordFromCfg(122141063)
				local var_282_2 = arg_279_1:FormatText(var_282_1.content)

				arg_279_1.text_.text = var_282_2

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_4 = 16 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_2) / 16)

				if (16 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_2) / 16)) > 0 and var_282_0 < var_282_4 then
					arg_279_1.talkMaxDuration = var_282_4

					if var_282_4 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_4 + 0
					end
				end

				arg_279_1.text_.text = var_282_2
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122141", "122141063", "story_v_out_122141.awb") ~= 0 then
					local var_282_5 = manager.audio:GetVoiceLength("story_v_out_122141", "122141063", "story_v_out_122141.awb") / 1000

					if var_282_5 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_5 + 0
					end

					if var_282_1.prefab_name ~= "" and arg_279_1.actors_[var_282_1.prefab_name] ~= nil then
						local var_282_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_1.prefab_name].transform, "story_v_out_122141", "122141063", "story_v_out_122141.awb")

						arg_279_1:RecordAudio("122141063", var_282_6)
						arg_279_1:RecordAudio("122141063", var_282_6)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_122141", "122141063", "story_v_out_122141.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_122141", "122141063", "story_v_out_122141.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_7 = math.max(var_282_0, arg_279_1.talkMaxDuration)

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_7 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - 0) / var_282_7

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= 0 + var_282_7 and arg_279_1.time_ < 0 + var_282_7 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/XH0508",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/XH0506",
		"TextureConfig/Background/S0506a",
		"TextureConfig/Background/SA0105",
		"TextureConfig/Background/S0905",
		"TextureConfig/Background/OM0214",
		"TextureConfig/Background/A03"
	},
	voices = {
		"story_v_out_122141.awb"
	}
}
