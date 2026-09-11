return {
	Play324562001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324562001
		arg_1_1.duration_ = 6.9

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play324562002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

			if arg_1_1.bgs_.J21f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J21f")
				var_4_0.name = "J21f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J21f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J21f

				arg_1_1.bgs_.J21f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J21f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2.03299999982119

			if 2.03299999982119 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 0.733333333333333

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(1, 1, 1)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(1, 1, 1)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			if 0.333333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.333333333333333 + arg_4_0 then
				local var_4_9 = arg_1_1.var_.effecteqew

				if not arg_1_1.var_.effecteqew then
					var_4_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redtwister_out"), manager.ui.mainCamera.transform)
					var_4_9.name = "eqew"
					arg_1_1.var_.effecteqew = var_4_9
				else
					var_4_9.transform:SetParent(var_4_9000)
				end

				var_4_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_11 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_11 + 2 and arg_1_1.time_ < var_4_11 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_wind", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan.awb")

				local var_4_16 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_16 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_16

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_16
						arg_1_1.bgmTxt2_.text = var_4_16
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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_145", "se_story_145_fire01", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_18 = 1.9
			local var_4_19 = 1.35

			if 1.9 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_20 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_20:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_21 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(324562001).content)

				arg_1_1.text_.text = var_4_21

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_23 = 54 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_21) / 54)

				if (54 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_21) / 54)) > 0 and var_4_19 < var_4_23 then
					arg_1_1.talkMaxDuration = var_4_23
					var_4_18 = var_4_18 + 0.3

					if var_4_23 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_18
					end
				end

				arg_1_1.text_.text = var_4_21
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_24 = var_4_18 + 0.3
			local var_4_25 = math.max(var_4_19, arg_1_1.talkMaxDuration)

			if var_4_18 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_24) / var_4_25

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play324562002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324562002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play324562003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.975

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(324562002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 39 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 39)

				if (39 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 39)) > 0 and var_11_0 < var_11_3 then
					arg_8_1.talkMaxDuration = var_11_3

					if var_11_3 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_3 + 0
					end
				end

				arg_8_1.text_.text = var_11_1
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_4 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_4

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play324562003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324562003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play324562004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 1.3 < arg_12_1.time_ and arg_12_1.time_ <= 1.3 + arg_15_0 then
				arg_12_1:AudioAction("play", "effect", "se_story_150", "se_story_150_amb_cheer_loop", "")
			end

			local var_15_1 = 0
			local var_15_2 = 1.3

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_3 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(324562003).content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 52 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 52)

				if (52 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 52)) > 0 and var_15_2 < var_15_5 then
					arg_12_1.talkMaxDuration = var_15_5

					if var_15_5 + var_15_1 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + var_15_1
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_6 = math.max(var_15_2, arg_12_1.talkMaxDuration)

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_6 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_1) / var_15_6

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_1 + var_15_6 and arg_12_1.time_ < var_15_1 + var_15_6 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play324562004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324562004
		arg_16_1.duration_ = 3.17

		local var_16_0 = {
			zh = 2.2,
			ja = 3.166
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
				arg_16_0:Play324562005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.125

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1504].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10162")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_1 = arg_16_1:GetWordFromCfg(324562004)
				local var_19_2 = arg_16_1:FormatText(var_19_1.content)

				arg_16_1.text_.text = var_19_2

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 5 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 5)

				if (5 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 5)) > 0 and var_19_0 < var_19_4 then
					arg_16_1.talkMaxDuration = var_19_4

					if var_19_4 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_4 + 0
					end
				end

				arg_16_1.text_.text = var_19_2
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562004", "story_v_out_324562.awb") ~= 0 then
					local var_19_5 = manager.audio:GetVoiceLength("story_v_out_324562", "324562004", "story_v_out_324562.awb") / 1000

					if var_19_5 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + 0
					end

					if var_19_1.prefab_name ~= "" and arg_16_1.actors_[var_19_1.prefab_name] ~= nil then
						local var_19_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_1.prefab_name].transform, "story_v_out_324562", "324562004", "story_v_out_324562.awb")

						arg_16_1:RecordAudio("324562004", var_19_6)
						arg_16_1:RecordAudio("324562004", var_19_6)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_324562", "324562004", "story_v_out_324562.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_324562", "324562004", "story_v_out_324562.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play324562005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324562005
		arg_20_1.duration_ = 3.73

		local var_20_0 = {
			zh = 3.733,
			ja = 3.233
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play324562006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.325

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[1505].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10166")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_1 = arg_20_1:GetWordFromCfg(324562005)
				local var_23_2 = arg_20_1:FormatText(var_23_1.content)

				arg_20_1.text_.text = var_23_2

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 13 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 13)

				if (13 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 13)) > 0 and var_23_0 < var_23_4 then
					arg_20_1.talkMaxDuration = var_23_4

					if var_23_4 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_4 + 0
					end
				end

				arg_20_1.text_.text = var_23_2
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562005", "story_v_out_324562.awb") ~= 0 then
					local var_23_5 = manager.audio:GetVoiceLength("story_v_out_324562", "324562005", "story_v_out_324562.awb") / 1000

					if var_23_5 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + 0
					end

					if var_23_1.prefab_name ~= "" and arg_20_1.actors_[var_23_1.prefab_name] ~= nil then
						local var_23_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_1.prefab_name].transform, "story_v_out_324562", "324562005", "story_v_out_324562.awb")

						arg_20_1:RecordAudio("324562005", var_23_6)
						arg_20_1:RecordAudio("324562005", var_23_6)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_324562", "324562005", "story_v_out_324562.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_324562", "324562005", "story_v_out_324562.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_7 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_7 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_7

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_7 and arg_20_1.time_ < 0 + var_23_7 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play324562006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324562006
		arg_24_1.duration_ = 3.13

		local var_24_0 = {
			zh = 3.066,
			ja = 3.133
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
				arg_24_0:Play324562007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.25

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1506].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10166")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_1 = arg_24_1:GetWordFromCfg(324562006)
				local var_27_2 = arg_24_1:FormatText(var_27_1.content)

				arg_24_1.text_.text = var_27_2

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 10 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 10)

				if (10 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 10)) > 0 and var_27_0 < var_27_4 then
					arg_24_1.talkMaxDuration = var_27_4

					if var_27_4 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_4 + 0
					end
				end

				arg_24_1.text_.text = var_27_2
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562006", "story_v_out_324562.awb") ~= 0 then
					local var_27_5 = manager.audio:GetVoiceLength("story_v_out_324562", "324562006", "story_v_out_324562.awb") / 1000

					if var_27_5 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + 0
					end

					if var_27_1.prefab_name ~= "" and arg_24_1.actors_[var_27_1.prefab_name] ~= nil then
						local var_27_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_1.prefab_name].transform, "story_v_out_324562", "324562006", "story_v_out_324562.awb")

						arg_24_1:RecordAudio("324562006", var_27_6)
						arg_24_1:RecordAudio("324562006", var_27_6)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_324562", "324562006", "story_v_out_324562.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_324562", "324562006", "story_v_out_324562.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_7 = math.max(var_27_0, arg_24_1.talkMaxDuration)

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_7 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - 0) / var_27_7

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= 0 + var_27_7 and arg_24_1.time_ < 0 + var_27_7 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play324562007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 324562007
		arg_28_1.duration_ = 4.7

		local var_28_0 = {
			zh = 4.7,
			ja = 4.3
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play324562008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_31_0 = 0.6

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 then
				local var_31_1, var_31_2 = math.modf((arg_28_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_31_2 * 0.13, var_31_2 * 0.13, var_31_2 * 0.13) + arg_28_1.var_.shakeOldPos
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 then
				manager.ui.mainCamera.transform.localPosition = arg_28_1.var_.shakeOldPos
			end

			local var_31_3 = manager.ui.mainCamera.transform

			if 0.766666666666667 < arg_28_1.time_ and arg_28_1.time_ <= 0.766666666666667 + arg_31_0 then
				arg_28_1.var_.shakeOldPos = var_31_3.localPosition
			end

			local var_31_4 = 0.6

			if 0.766666666666667 <= arg_28_1.time_ and arg_28_1.time_ < 0.766666666666667 + var_31_4 then
				local var_31_5, var_31_6 = math.modf((arg_28_1.time_ - 0.766666666666667) / 0.066)

				var_31_3.localPosition = Vector3.New(var_31_6 * 0.13, var_31_6 * 0.13, var_31_6 * 0.13) + arg_28_1.var_.shakeOldPos
			end

			if arg_28_1.time_ >= 0.766666666666667 + var_31_4 and arg_28_1.time_ < 0.766666666666667 + var_31_4 + arg_31_0 then
				var_31_3.localPosition = arg_28_1.var_.shakeOldPos
			end

			local var_31_7 = 0

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_7 + arg_31_0 then
				arg_28_1.allBtn_.enabled = false
			end

			if arg_28_1.time_ >= var_31_7 + 1.5 and arg_28_1.time_ < var_31_7 + 1.5 + arg_31_0 then
				arg_28_1.allBtn_.enabled = true
			end

			if 0.1 < arg_28_1.time_ and arg_28_1.time_ <= 0.1 + arg_31_0 then
				arg_28_1:AudioAction("play", "effect", "se_story_150", "se_story_150_amb_cheer_loop_down", "")
			end

			if arg_28_1.frameCnt_ <= 1 then
				arg_28_1.dialog_:SetActive(false)
			end

			local var_31_9 = 1
			local var_31_10 = 0.4

			if 1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_9 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0

				arg_28_1.dialog_:SetActive(true)

				arg_28_1.dialogCg_.alpha = 0

				local var_31_11 = LeanTween.value(arg_28_1.dialog_, 0, 1, 0.3)

				var_31_11:setOnUpdate(LuaHelper.FloatAction(function(arg_32_0)
					arg_28_1.dialogCg_.alpha = arg_32_0
				end))
				var_31_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_28_1.dialog_)
					var_31_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_28_1.duration_ = arg_28_1.duration_ + 0.3

				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_12 = arg_28_1:GetWordFromCfg(324562007)
				local var_31_13 = arg_28_1:FormatText(var_31_12.content)

				arg_28_1.text_.text = var_31_13

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_15 = 16 <= 0 and var_31_10 or var_31_10 * (utf8.len(var_31_13) / 16)

				if (16 <= 0 and var_31_10 or var_31_10 * (utf8.len(var_31_13) / 16)) > 0 and var_31_10 < var_31_15 then
					arg_28_1.talkMaxDuration = var_31_15
					var_31_9 = var_31_9 + 0.3

					if var_31_15 + var_31_9 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_15 + var_31_9
					end
				end

				arg_28_1.text_.text = var_31_13
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562007", "story_v_out_324562.awb") ~= 0 then
					local var_31_16 = manager.audio:GetVoiceLength("story_v_out_324562", "324562007", "story_v_out_324562.awb") / 1000

					if var_31_16 + var_31_9 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_16 + var_31_9
					end

					if var_31_12.prefab_name ~= "" and arg_28_1.actors_[var_31_12.prefab_name] ~= nil then
						local var_31_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_12.prefab_name].transform, "story_v_out_324562", "324562007", "story_v_out_324562.awb")

						arg_28_1:RecordAudio("324562007", var_31_17)
						arg_28_1:RecordAudio("324562007", var_31_17)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_324562", "324562007", "story_v_out_324562.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_324562", "324562007", "story_v_out_324562.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_18 = var_31_9 + 0.3
			local var_31_19 = math.max(var_31_10, arg_28_1.talkMaxDuration)

			if var_31_9 + 0.3 <= arg_28_1.time_ and arg_28_1.time_ < var_31_18 + var_31_19 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_18) / var_31_19

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_18 + var_31_19 and arg_28_1.time_ < var_31_18 + var_31_19 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play324562008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 324562008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play324562009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 1.75

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_1 = arg_34_1:FormatText(arg_34_1:GetWordFromCfg(324562008).content)

				arg_34_1.text_.text = var_37_1

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_3 = 70 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_1) / 70)

				if (70 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_1) / 70)) > 0 and var_37_0 < var_37_3 then
					arg_34_1.talkMaxDuration = var_37_3

					if var_37_3 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_3 + 0
					end
				end

				arg_34_1.text_.text = var_37_1
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_4 = math.max(var_37_0, arg_34_1.talkMaxDuration)

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_4 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - 0) / var_37_4

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= 0 + var_37_4 and arg_34_1.time_ < 0 + var_37_4 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play324562009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 324562009
		arg_38_1.duration_ = 5.3

		local var_38_0 = {
			zh = 5.3,
			ja = 4.6
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play324562010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if arg_38_1.actors_["1170ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1170ui_story"))) then
				local var_41_0 = Object.Instantiate(Asset.Load("Char/" .. "1170ui_story"), arg_38_1.stage_.transform)

				var_41_0.name = "1170ui_story"
				var_41_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_38_1.actors_["1170ui_story"] = var_41_0

				local var_41_1 = var_41_0:GetComponentInChildren(typeof(CharacterEffect))

				var_41_1.enabled = true

				local var_41_2 = GameObjectTools.GetOrAddComponent(var_41_0, typeof(DynamicBoneHelper))

				if var_41_2 then
					var_41_2:EnableDynamicBone(false)
				end

				arg_38_1:ShowWeapon(var_41_1.transform, false)

				arg_38_1.var_["1170ui_story" .. "Animator"] = var_41_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_38_1.var_["1170ui_story" .. "Animator"].applyRootMotion = true
				arg_38_1.var_["1170ui_story" .. "LipSync"] = var_41_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_41_3 = arg_38_1.actors_["1170ui_story"].transform

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.moveOldPos1170ui_story = var_41_3.localPosition

				local var_41_4 = GameObjectTools.GetOrAddComponent(var_41_3.gameObject, typeof(DynamicBoneHelper))

				if var_41_4 then
					var_41_4:EnableDynamicBone(false)
				end
			end

			local var_41_5 = 0.001

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_5 then
				var_41_3.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1170ui_story, Vector3.New(0.03, -0.95, -6.08), (arg_38_1.time_ - 0) / var_41_5)
				var_41_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_41_3.position).x, (manager.ui.mainCamera.transform.position - var_41_3.position).y, (manager.ui.mainCamera.transform.position - var_41_3.position).z)
				var_41_3.localEulerAngles.z = 0
				var_41_3.localEulerAngles.x = 0
				var_41_3.localEulerAngles = var_41_3.localEulerAngles
			end

			if arg_38_1.time_ >= 0 + var_41_5 and arg_38_1.time_ < 0 + var_41_5 + arg_41_0 then
				var_41_3.localPosition = Vector3.New(0.03, -0.95, -6.08)
				var_41_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_41_3.position).x, (manager.ui.mainCamera.transform.position - var_41_3.position).y, (manager.ui.mainCamera.transform.position - var_41_3.position).z)
				var_41_3.localEulerAngles.z = 0
				var_41_3.localEulerAngles.x = 0
				var_41_3.localEulerAngles = var_41_3.localEulerAngles

				local var_41_6 = GameObjectTools.GetOrAddComponent(var_41_3.gameObject, typeof(DynamicBoneHelper))

				if var_41_6 then
					var_41_6:EnableDynamicBone(true)
				end
			end

			local var_41_7 = arg_38_1.actors_["1170ui_story"]

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(var_41_7) and arg_38_1.var_.characterEffect1170ui_story == nil then
				arg_38_1.var_.characterEffect1170ui_story = var_41_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_8 = 0.200000002980232

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_8 and not isNil(var_41_7) then
				if arg_38_1.var_.characterEffect1170ui_story and not isNil(var_41_7) then
					arg_38_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= 0 + var_41_8 and arg_38_1.time_ < 0 + var_41_8 + arg_41_0 and not isNil(var_41_7) and arg_38_1.var_.characterEffect1170ui_story then
				arg_38_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action3_1")
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_41_10 = 0
			local var_41_11 = 0.375

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_10 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_12 = arg_38_1:GetWordFromCfg(324562009)
				local var_41_13 = arg_38_1:FormatText(var_41_12.content)

				arg_38_1.text_.text = var_41_13

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_15 = 15 <= 0 and var_41_11 or var_41_11 * (utf8.len(var_41_13) / 15)

				if (15 <= 0 and var_41_11 or var_41_11 * (utf8.len(var_41_13) / 15)) > 0 and var_41_11 < var_41_15 then
					arg_38_1.talkMaxDuration = var_41_15

					if var_41_15 + var_41_10 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_15 + var_41_10
					end
				end

				arg_38_1.text_.text = var_41_13
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562009", "story_v_out_324562.awb") ~= 0 then
					local var_41_16 = manager.audio:GetVoiceLength("story_v_out_324562", "324562009", "story_v_out_324562.awb") / 1000

					if var_41_16 + var_41_10 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_16 + var_41_10
					end

					if var_41_12.prefab_name ~= "" and arg_38_1.actors_[var_41_12.prefab_name] ~= nil then
						local var_41_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_12.prefab_name].transform, "story_v_out_324562", "324562009", "story_v_out_324562.awb")

						arg_38_1:RecordAudio("324562009", var_41_17)
						arg_38_1:RecordAudio("324562009", var_41_17)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_324562", "324562009", "story_v_out_324562.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_324562", "324562009", "story_v_out_324562.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_18 = math.max(var_41_11, arg_38_1.talkMaxDuration)

			if var_41_10 <= arg_38_1.time_ and arg_38_1.time_ < var_41_10 + var_41_18 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_10) / var_41_18

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_10 + var_41_18 and arg_38_1.time_ < var_41_10 + var_41_18 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_38_1:InitPlayNodeList()
	end,
	Play324562010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 324562010
		arg_42_1.duration_ = 3.5

		local var_42_0 = {
			zh = 2.4,
			ja = 3.5
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
				arg_42_0:Play324562011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if arg_42_1.actors_["6148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6148ui_story"))) then
				local var_45_0 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_42_1.stage_.transform)

				var_45_0.name = "6148ui_story"
				var_45_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_42_1.actors_["6148ui_story"] = var_45_0

				local var_45_1 = var_45_0:GetComponentInChildren(typeof(CharacterEffect))

				var_45_1.enabled = true

				local var_45_2 = GameObjectTools.GetOrAddComponent(var_45_0, typeof(DynamicBoneHelper))

				if var_45_2 then
					var_45_2:EnableDynamicBone(false)
				end

				arg_42_1:ShowWeapon(var_45_1.transform, false)

				arg_42_1.var_["6148ui_story" .. "Animator"] = var_45_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_42_1.var_["6148ui_story" .. "Animator"].applyRootMotion = true
				arg_42_1.var_["6148ui_story" .. "LipSync"] = var_45_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_45_3 = arg_42_1.actors_["6148ui_story"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_3) and arg_42_1.var_.characterEffect6148ui_story == nil then
				arg_42_1.var_.characterEffect6148ui_story = var_45_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_4 = 0.200000002980232

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_4 and not isNil(var_45_3) then
				if arg_42_1.var_.characterEffect6148ui_story and not isNil(var_45_3) then
					arg_42_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= 0 + var_45_4 and arg_42_1.time_ < 0 + var_45_4 + arg_45_0 and not isNil(var_45_3) and arg_42_1.var_.characterEffect6148ui_story then
				arg_42_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_45_6 = arg_42_1.actors_["1170ui_story"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_6) and arg_42_1.var_.characterEffect1170ui_story == nil then
				arg_42_1.var_.characterEffect1170ui_story = var_45_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_7 = 0.200000002980232

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_7 and not isNil(var_45_6) then
				if arg_42_1.var_.characterEffect1170ui_story and not isNil(var_45_6) then
					arg_42_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_42_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_42_1.time_ - 0) / var_45_7)
				end
			end

			if arg_42_1.time_ >= 0 + var_45_7 and arg_42_1.time_ < 0 + var_45_7 + arg_45_0 and not isNil(var_45_6) and arg_42_1.var_.characterEffect1170ui_story then
				arg_42_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_42_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			local var_45_8 = 0
			local var_45_9 = 0.25

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_8 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6148")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_10 = arg_42_1:GetWordFromCfg(324562010)
				local var_45_11 = arg_42_1:FormatText(var_45_10.content)

				arg_42_1.text_.text = var_45_11

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_13 = 10 <= 0 and var_45_9 or var_45_9 * (utf8.len(var_45_11) / 10)

				if (10 <= 0 and var_45_9 or var_45_9 * (utf8.len(var_45_11) / 10)) > 0 and var_45_9 < var_45_13 then
					arg_42_1.talkMaxDuration = var_45_13

					if var_45_13 + var_45_8 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_13 + var_45_8
					end
				end

				arg_42_1.text_.text = var_45_11
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562010", "story_v_out_324562.awb") ~= 0 then
					local var_45_14 = manager.audio:GetVoiceLength("story_v_out_324562", "324562010", "story_v_out_324562.awb") / 1000

					if var_45_14 + var_45_8 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_14 + var_45_8
					end

					if var_45_10.prefab_name ~= "" and arg_42_1.actors_[var_45_10.prefab_name] ~= nil then
						local var_45_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_10.prefab_name].transform, "story_v_out_324562", "324562010", "story_v_out_324562.awb")

						arg_42_1:RecordAudio("324562010", var_45_15)
						arg_42_1:RecordAudio("324562010", var_45_15)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_324562", "324562010", "story_v_out_324562.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_324562", "324562010", "story_v_out_324562.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_16 = math.max(var_45_9, arg_42_1.talkMaxDuration)

			if var_45_8 <= arg_42_1.time_ and arg_42_1.time_ < var_45_8 + var_45_16 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_8) / var_45_16

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_8 + var_45_16 and arg_42_1.time_ < var_45_8 + var_45_16 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play324562011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 324562011
		arg_46_1.duration_ = 2.1

		local var_46_0 = {
			zh = 1.999999999999,
			ja = 2.1
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play324562012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["1170ui_story"]) and arg_46_1.var_.characterEffect1170ui_story == nil then
				arg_46_1.var_.characterEffect1170ui_story = arg_46_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_0 = 0.200000002980232

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["1170ui_story"]) then
				if arg_46_1.var_.characterEffect1170ui_story and not isNil(arg_46_1.actors_["1170ui_story"]) then
					arg_46_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["1170ui_story"]) and arg_46_1.var_.characterEffect1170ui_story then
				arg_46_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_49_2 = arg_46_1.actors_["6148ui_story"]

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(var_49_2) and arg_46_1.var_.characterEffect6148ui_story == nil then
				arg_46_1.var_.characterEffect6148ui_story = var_49_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_3 = 0.200000002980232

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_3 and not isNil(var_49_2) then
				if arg_46_1.var_.characterEffect6148ui_story and not isNil(var_49_2) then
					arg_46_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_46_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_46_1.time_ - 0) / var_49_3)
				end
			end

			if arg_46_1.time_ >= 0 + var_49_3 and arg_46_1.time_ < 0 + var_49_3 + arg_49_0 and not isNil(var_49_2) and arg_46_1.var_.characterEffect6148ui_story then
				arg_46_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_46_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action3_2")
			end

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_49_4 = 0
			local var_49_5 = 0.175

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_4 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_6 = arg_46_1:GetWordFromCfg(324562011)
				local var_49_7 = arg_46_1:FormatText(var_49_6.content)

				arg_46_1.text_.text = var_49_7

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_9 = 7 <= 0 and var_49_5 or var_49_5 * (utf8.len(var_49_7) / 7)

				if (7 <= 0 and var_49_5 or var_49_5 * (utf8.len(var_49_7) / 7)) > 0 and var_49_5 < var_49_9 then
					arg_46_1.talkMaxDuration = var_49_9

					if var_49_9 + var_49_4 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_9 + var_49_4
					end
				end

				arg_46_1.text_.text = var_49_7
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562011", "story_v_out_324562.awb") ~= 0 then
					local var_49_10 = manager.audio:GetVoiceLength("story_v_out_324562", "324562011", "story_v_out_324562.awb") / 1000

					if var_49_10 + var_49_4 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_10 + var_49_4
					end

					if var_49_6.prefab_name ~= "" and arg_46_1.actors_[var_49_6.prefab_name] ~= nil then
						local var_49_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_6.prefab_name].transform, "story_v_out_324562", "324562011", "story_v_out_324562.awb")

						arg_46_1:RecordAudio("324562011", var_49_11)
						arg_46_1:RecordAudio("324562011", var_49_11)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_324562", "324562011", "story_v_out_324562.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_324562", "324562011", "story_v_out_324562.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_12 = math.max(var_49_5, arg_46_1.talkMaxDuration)

			if var_49_4 <= arg_46_1.time_ and arg_46_1.time_ < var_49_4 + var_49_12 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_4) / var_49_12

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_4 + var_49_12 and arg_46_1.time_ < var_49_4 + var_49_12 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play324562012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 324562012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play324562013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos1170ui_story = arg_50_1.actors_["1170ui_story"].transform.localPosition

				local var_53_0 = GameObjectTools.GetOrAddComponent(arg_50_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_53_0 then
					var_53_0:EnableDynamicBone(false)
				end
			end

			local var_53_1 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_1 then
				arg_50_1.actors_["1170ui_story"].transform.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1170ui_story, Vector3.New(0, 100, 0), (arg_50_1.time_ - 0) / var_53_1)
				arg_50_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_50_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1170ui_story"].transform.position).z)
				arg_50_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_50_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_50_1.actors_["1170ui_story"].transform.localEulerAngles = arg_50_1.actors_["1170ui_story"].transform.localEulerAngles
			end

			if arg_50_1.time_ >= 0 + var_53_1 and arg_50_1.time_ < 0 + var_53_1 + arg_53_0 then
				arg_50_1.actors_["1170ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_50_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_50_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1170ui_story"].transform.position).z)
				arg_50_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_50_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_50_1.actors_["1170ui_story"].transform.localEulerAngles = arg_50_1.actors_["1170ui_story"].transform.localEulerAngles

				local var_53_2 = GameObjectTools.GetOrAddComponent(arg_50_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_53_2 then
					var_53_2:EnableDynamicBone(true)
				end
			end

			local var_53_3 = arg_50_1.actors_["1170ui_story"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_3) and arg_50_1.var_.characterEffect1170ui_story == nil then
				arg_50_1.var_.characterEffect1170ui_story = var_53_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_4 = 0.200000002980232

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_4 and not isNil(var_53_3) then
				if arg_50_1.var_.characterEffect1170ui_story and not isNil(var_53_3) then
					arg_50_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_50_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_50_1.time_ - 0) / var_53_4)
				end
			end

			if arg_50_1.time_ >= 0 + var_53_4 and arg_50_1.time_ < 0 + var_53_4 + arg_53_0 and not isNil(var_53_3) and arg_50_1.var_.characterEffect1170ui_story then
				arg_50_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_50_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			local var_53_5 = 0
			local var_53_6 = 1.425

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_5 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_7 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(324562012).content)

				arg_50_1.text_.text = var_53_7

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_9 = 57 <= 0 and var_53_6 or var_53_6 * (utf8.len(var_53_7) / 57)

				if (57 <= 0 and var_53_6 or var_53_6 * (utf8.len(var_53_7) / 57)) > 0 and var_53_6 < var_53_9 then
					arg_50_1.talkMaxDuration = var_53_9

					if var_53_9 + var_53_5 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_9 + var_53_5
					end
				end

				arg_50_1.text_.text = var_53_7
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_10 = math.max(var_53_6, arg_50_1.talkMaxDuration)

			if var_53_5 <= arg_50_1.time_ and arg_50_1.time_ < var_53_5 + var_53_10 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_5) / var_53_10

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_5 + var_53_10 and arg_50_1.time_ < var_53_5 + var_53_10 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play324562013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 324562013
		arg_54_1.duration_ = 2

		local var_54_0 = {
			zh = 2,
			ja = 1.833
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play324562014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(arg_54_1.actors_["1170ui_story"]) and arg_54_1.var_.characterEffect1170ui_story == nil then
				arg_54_1.var_.characterEffect1170ui_story = arg_54_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_0 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 and not isNil(arg_54_1.actors_["1170ui_story"]) then
				if arg_54_1.var_.characterEffect1170ui_story and not isNil(arg_54_1.actors_["1170ui_story"]) then
					arg_54_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 and not isNil(arg_54_1.actors_["1170ui_story"]) and arg_54_1.var_.characterEffect1170ui_story then
				arg_54_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_57_3 = 0
			local var_57_4 = 0.15

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_3 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1170")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_5 = arg_54_1:GetWordFromCfg(324562013)
				local var_57_6 = arg_54_1:FormatText(var_57_5.content)

				arg_54_1.text_.text = var_57_6

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_8 = 6 <= 0 and var_57_4 or var_57_4 * (utf8.len(var_57_6) / 6)

				if (6 <= 0 and var_57_4 or var_57_4 * (utf8.len(var_57_6) / 6)) > 0 and var_57_4 < var_57_8 then
					arg_54_1.talkMaxDuration = var_57_8

					if var_57_8 + var_57_3 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_8 + var_57_3
					end
				end

				arg_54_1.text_.text = var_57_6
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562013", "story_v_out_324562.awb") ~= 0 then
					local var_57_9 = manager.audio:GetVoiceLength("story_v_out_324562", "324562013", "story_v_out_324562.awb") / 1000

					if var_57_9 + var_57_3 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_9 + var_57_3
					end

					if var_57_5.prefab_name ~= "" and arg_54_1.actors_[var_57_5.prefab_name] ~= nil then
						local var_57_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_5.prefab_name].transform, "story_v_out_324562", "324562013", "story_v_out_324562.awb")

						arg_54_1:RecordAudio("324562013", var_57_10)
						arg_54_1:RecordAudio("324562013", var_57_10)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_324562", "324562013", "story_v_out_324562.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_324562", "324562013", "story_v_out_324562.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_11 = math.max(var_57_4, arg_54_1.talkMaxDuration)

			if var_57_3 <= arg_54_1.time_ and arg_54_1.time_ < var_57_3 + var_57_11 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_3) / var_57_11

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_3 + var_57_11 and arg_54_1.time_ < var_57_3 + var_57_11 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play324562014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 324562014
		arg_58_1.duration_ = 9

		local var_58_0 = {
			zh = 6.733,
			ja = 9
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
				arg_58_0:Play324562015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if arg_58_1.bgs_.ST32 == nil then
				local var_61_0 = Object.Instantiate(arg_58_1.paintGo_)

				var_61_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST32")
				var_61_0.name = "ST32"
				var_61_0.transform.parent = arg_58_1.stage_.transform
				var_61_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_58_1.bgs_.ST32 = var_61_0
			end

			if 2 < arg_58_1.time_ and arg_58_1.time_ <= 2 + arg_61_0 then
				local var_61_1 = arg_58_1.bgs_.ST32

				arg_58_1.bgs_.ST32.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_61_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_61_2 = var_61_1:GetComponent("SpriteRenderer")

				if var_61_2 and var_61_2.sprite then
					local var_61_3 = 2 * (var_61_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_61_1.transform.localScale = Vector3.New(var_61_3 / var_61_2.sprite.bounds.size.y < var_61_3 * manager.ui.mainCameraCom_.aspect / var_61_2.sprite.bounds.size.x and var_61_3 * manager.ui.mainCameraCom_.aspect / var_61_2.sprite.bounds.size.x or var_61_3 / var_61_2.sprite.bounds.size.y, var_61_3 / var_61_2.sprite.bounds.size.y < var_61_3 * manager.ui.mainCameraCom_.aspect / var_61_2.sprite.bounds.size.x and var_61_3 * manager.ui.mainCameraCom_.aspect / var_61_2.sprite.bounds.size.x or var_61_3 / var_61_2.sprite.bounds.size.y, 0)
				end

				for iter_61_0, iter_61_1 in pairs(arg_58_1.bgs_) do
					if iter_61_0 ~= "ST32" then
						iter_61_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_61_4 = 4

			if 4 < arg_58_1.time_ and arg_58_1.time_ <= var_61_4 + arg_61_0 then
				arg_58_1.allBtn_.enabled = false
			end

			if arg_58_1.time_ >= var_61_4 + 0.3 and arg_58_1.time_ < var_61_4 + 0.3 + arg_61_0 then
				arg_58_1.allBtn_.enabled = true
			end

			local var_61_5 = 0

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_5 + arg_61_0 then
				arg_58_1.mask_.enabled = true
				arg_58_1.mask_.raycastTarget = true

				arg_58_1:SetGaussion(false)
			end

			local var_61_6 = 2

			if var_61_5 <= arg_58_1.time_ and arg_58_1.time_ < var_61_5 + var_61_6 then
				local var_61_7 = Color.New(0, 0, 0)

				var_61_7.a = Mathf.Lerp(0, 1, (arg_58_1.time_ - var_61_5) / var_61_6)
				arg_58_1.mask_.color = var_61_7
			end

			if arg_58_1.time_ >= var_61_5 + var_61_6 and arg_58_1.time_ < var_61_5 + var_61_6 + arg_61_0 then
				local var_61_8 = Color.New(0, 0, 0)

				var_61_8.a = 1
				arg_58_1.mask_.color = var_61_8
			end

			local var_61_9 = 2

			if 2 < arg_58_1.time_ and arg_58_1.time_ <= var_61_9 + arg_61_0 then
				arg_58_1.mask_.enabled = true
				arg_58_1.mask_.raycastTarget = true

				arg_58_1:SetGaussion(false)
			end

			local var_61_10 = 2

			if var_61_9 <= arg_58_1.time_ and arg_58_1.time_ < var_61_9 + var_61_10 then
				local var_61_11 = Color.New(0, 0, 0)

				var_61_11.a = Mathf.Lerp(1, 0, (arg_58_1.time_ - var_61_9) / var_61_10)
				arg_58_1.mask_.color = var_61_11
			end

			if arg_58_1.time_ >= var_61_9 + var_61_10 and arg_58_1.time_ < var_61_9 + var_61_10 + arg_61_0 then
				local var_61_12 = Color.New(0, 0, 0)

				arg_58_1.mask_.enabled = false
				var_61_12.a = 0
				arg_58_1.mask_.color = var_61_12
			end

			local var_61_13 = "10164ui_story"

			if arg_58_1.actors_["10164ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10164ui_story"))) then
				local var_61_14 = Object.Instantiate(Asset.Load("Char/" .. "10164ui_story"), arg_58_1.stage_.transform)

				var_61_14.name = var_61_13
				var_61_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_58_1.actors_[var_61_13] = var_61_14

				local var_61_15 = var_61_14:GetComponentInChildren(typeof(CharacterEffect))

				var_61_15.enabled = true

				local var_61_16 = GameObjectTools.GetOrAddComponent(var_61_14, typeof(DynamicBoneHelper))

				if var_61_16 then
					var_61_16:EnableDynamicBone(false)
				end

				arg_58_1:ShowWeapon(var_61_15.transform, false)

				arg_58_1.var_[var_61_13 .. "Animator"] = var_61_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_58_1.var_[var_61_13 .. "Animator"].applyRootMotion = true
				arg_58_1.var_[var_61_13 .. "LipSync"] = var_61_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_61_17 = arg_58_1.actors_["10164ui_story"].transform

			if 3.8 < arg_58_1.time_ and arg_58_1.time_ <= 3.8 + arg_61_0 then
				arg_58_1.var_.moveOldPos10164ui_story = var_61_17.localPosition

				local var_61_18 = GameObjectTools.GetOrAddComponent(var_61_17.gameObject, typeof(DynamicBoneHelper))

				if var_61_18 then
					var_61_18:EnableDynamicBone(false)
				end
			end

			local var_61_19 = 0.001

			if 3.8 <= arg_58_1.time_ and arg_58_1.time_ < 3.8 + var_61_19 then
				var_61_17.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10164ui_story, Vector3.New(0, -1.08, -5.83), (arg_58_1.time_ - 3.8) / var_61_19)
				var_61_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_17.position).x, (manager.ui.mainCamera.transform.position - var_61_17.position).y, (manager.ui.mainCamera.transform.position - var_61_17.position).z)
				var_61_17.localEulerAngles.z = 0
				var_61_17.localEulerAngles.x = 0
				var_61_17.localEulerAngles = var_61_17.localEulerAngles
			end

			if arg_58_1.time_ >= 3.8 + var_61_19 and arg_58_1.time_ < 3.8 + var_61_19 + arg_61_0 then
				var_61_17.localPosition = Vector3.New(0, -1.08, -5.83)
				var_61_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_17.position).x, (manager.ui.mainCamera.transform.position - var_61_17.position).y, (manager.ui.mainCamera.transform.position - var_61_17.position).z)
				var_61_17.localEulerAngles.z = 0
				var_61_17.localEulerAngles.x = 0
				var_61_17.localEulerAngles = var_61_17.localEulerAngles

				local var_61_20 = GameObjectTools.GetOrAddComponent(var_61_17.gameObject, typeof(DynamicBoneHelper))

				if var_61_20 then
					var_61_20:EnableDynamicBone(true)
				end
			end

			local var_61_21 = arg_58_1.actors_["10164ui_story"]

			if 3.8 < arg_58_1.time_ and arg_58_1.time_ <= 3.8 + arg_61_0 and not isNil(var_61_21) and arg_58_1.var_.characterEffect10164ui_story == nil then
				arg_58_1.var_.characterEffect10164ui_story = var_61_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_22 = 0.200000002980232

			if 3.8 <= arg_58_1.time_ and arg_58_1.time_ < 3.8 + var_61_22 and not isNil(var_61_21) then
				if arg_58_1.var_.characterEffect10164ui_story and not isNil(var_61_21) then
					arg_58_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= 3.8 + var_61_22 and arg_58_1.time_ < 3.8 + var_61_22 + arg_61_0 and not isNil(var_61_21) and arg_58_1.var_.characterEffect10164ui_story then
				arg_58_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			if 3.8 < arg_58_1.time_ and arg_58_1.time_ <= 3.8 + arg_61_0 then
				arg_58_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action15_1")
			end

			if 3.8 < arg_58_1.time_ and arg_58_1.time_ <= 3.8 + arg_61_0 then
				arg_58_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			if 1.2 < arg_58_1.time_ and arg_58_1.time_ <= 1.2 + arg_61_0 then
				arg_58_1:AudioAction("play", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if 0.1 < arg_58_1.time_ and arg_58_1.time_ <= 0.1 + arg_61_0 then
				arg_58_1:AudioAction("stop", "effect", "se_story_148", "se_story_148_amb_wind", "")
			end

			if 0.1 < arg_58_1.time_ and arg_58_1.time_ <= 0.1 + arg_61_0 then
				arg_58_1:AudioAction("stop", "effect", "se_story_150", "se_story_150_amb_cheer_loop", "")
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_61_29 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

				if "" ~= "" then
					if arg_58_1.bgmTxt_.text ~= var_61_29 and arg_58_1.bgmTxt_.text ~= "" then
						if arg_58_1.bgmTxt2_.text ~= "" then
							arg_58_1.bgmTxt_.text = arg_58_1.bgmTxt2_.text
						end

						arg_58_1.bgmTxt2_.text = var_61_29

						arg_58_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_58_1.bgmTxt_.text = var_61_29
						arg_58_1.bgmTxt2_.text = var_61_29
					end

					if arg_58_1.bgmTimer then
						arg_58_1.bgmTimer:Stop()

						arg_58_1.bgmTimer = nil
					end

					if arg_58_1.settingData.show_music_name == 1 then
						arg_58_1.musicController:SetSelectedState("show")
						arg_58_1.musicAnimator_:Play("open", 0, 0)

						if arg_58_1.settingData.music_time ~= 0 then
							arg_58_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_58_1.settingData.music_time), function()
								if arg_58_1 == nil or isNil(arg_58_1.bgmTxt_) then
									return
								end

								arg_58_1.musicController:SetSelectedState("hide")
								arg_58_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_58_1.frameCnt_ <= 1 then
				arg_58_1.dialog_:SetActive(false)
			end

			local var_61_30 = 4
			local var_61_31 = 0.325

			if 4 < arg_58_1.time_ and arg_58_1.time_ <= var_61_30 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0

				arg_58_1.dialog_:SetActive(true)

				arg_58_1.dialogCg_.alpha = 0

				local var_61_32 = LeanTween.value(arg_58_1.dialog_, 0, 1, 0.3)

				var_61_32:setOnUpdate(LuaHelper.FloatAction(function(arg_63_0)
					arg_58_1.dialogCg_.alpha = arg_63_0
				end))
				var_61_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_58_1.dialog_)
					var_61_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_58_1.duration_ = arg_58_1.duration_ + 0.3

				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_33 = arg_58_1:GetWordFromCfg(324562014)
				local var_61_34 = arg_58_1:FormatText(var_61_33.content)

				arg_58_1.text_.text = var_61_34

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_36 = 13 <= 0 and var_61_31 or var_61_31 * (utf8.len(var_61_34) / 13)

				if (13 <= 0 and var_61_31 or var_61_31 * (utf8.len(var_61_34) / 13)) > 0 and var_61_31 < var_61_36 then
					arg_58_1.talkMaxDuration = var_61_36
					var_61_30 = var_61_30 + 0.3

					if var_61_36 + var_61_30 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_36 + var_61_30
					end
				end

				arg_58_1.text_.text = var_61_34
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562014", "story_v_out_324562.awb") ~= 0 then
					local var_61_37 = manager.audio:GetVoiceLength("story_v_out_324562", "324562014", "story_v_out_324562.awb") / 1000

					if var_61_37 + var_61_30 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_37 + var_61_30
					end

					if var_61_33.prefab_name ~= "" and arg_58_1.actors_[var_61_33.prefab_name] ~= nil then
						local var_61_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_33.prefab_name].transform, "story_v_out_324562", "324562014", "story_v_out_324562.awb")

						arg_58_1:RecordAudio("324562014", var_61_38)
						arg_58_1:RecordAudio("324562014", var_61_38)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_324562", "324562014", "story_v_out_324562.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_324562", "324562014", "story_v_out_324562.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_39 = var_61_30 + 0.3
			local var_61_40 = math.max(var_61_31, arg_58_1.talkMaxDuration)

			if var_61_30 + 0.3 <= arg_58_1.time_ and arg_58_1.time_ < var_61_39 + var_61_40 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_39) / var_61_40

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_39 + var_61_40 and arg_58_1.time_ < var_61_39 + var_61_40 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10164ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play324562015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 324562015
		arg_65_1.duration_ = 2.4

		local var_65_0 = {
			zh = 1.999999999999,
			ja = 2.4
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
				arg_65_0:Play324562016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if arg_65_1.actors_["1071ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1071ui_story"))) then
				local var_68_0 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_65_1.stage_.transform)

				var_68_0.name = "1071ui_story"
				var_68_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.actors_["1071ui_story"] = var_68_0

				local var_68_1 = var_68_0:GetComponentInChildren(typeof(CharacterEffect))

				var_68_1.enabled = true

				local var_68_2 = GameObjectTools.GetOrAddComponent(var_68_0, typeof(DynamicBoneHelper))

				if var_68_2 then
					var_68_2:EnableDynamicBone(false)
				end

				arg_65_1:ShowWeapon(var_68_1.transform, false)

				arg_65_1.var_["1071ui_story" .. "Animator"] = var_68_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_65_1.var_["1071ui_story" .. "Animator"].applyRootMotion = true
				arg_65_1.var_["1071ui_story" .. "LipSync"] = var_68_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_68_3 = arg_65_1.actors_["1071ui_story"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1071ui_story = var_68_3.localPosition
			end

			local var_68_4 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				var_68_3.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1071ui_story, Vector3.New(0.7, -1.05, -6.2), (arg_65_1.time_ - 0) / var_68_4)
				var_68_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_3.position).x, (manager.ui.mainCamera.transform.position - var_68_3.position).y, (manager.ui.mainCamera.transform.position - var_68_3.position).z)
				var_68_3.localEulerAngles.z = 0
				var_68_3.localEulerAngles.x = 0
				var_68_3.localEulerAngles = var_68_3.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				var_68_3.localPosition = Vector3.New(0.7, -1.05, -6.2)
				var_68_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_3.position).x, (manager.ui.mainCamera.transform.position - var_68_3.position).y, (manager.ui.mainCamera.transform.position - var_68_3.position).z)
				var_68_3.localEulerAngles.z = 0
				var_68_3.localEulerAngles.x = 0
				var_68_3.localEulerAngles = var_68_3.localEulerAngles
			end

			local var_68_5 = arg_65_1.actors_["1071ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.characterEffect1071ui_story == nil then
				arg_65_1.var_.characterEffect1071ui_story = var_68_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_6 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_6 and not isNil(var_68_5) then
				if arg_65_1.var_.characterEffect1071ui_story and not isNil(var_68_5) then
					arg_65_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_6 and arg_65_1.time_ < 0 + var_68_6 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.characterEffect1071ui_story then
				arg_65_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_68_8 = arg_65_1.actors_["10164ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.characterEffect10164ui_story == nil then
				arg_65_1.var_.characterEffect10164ui_story = var_68_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_9 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_9 and not isNil(var_68_8) then
				if arg_65_1.var_.characterEffect10164ui_story and not isNil(var_68_8) then
					arg_65_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_9)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_9 and arg_65_1.time_ < 0 + var_68_9 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.characterEffect10164ui_story then
				arg_65_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_68_10 = arg_65_1.actors_["10164ui_story"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10164ui_story = var_68_10.localPosition

				local var_68_11 = GameObjectTools.GetOrAddComponent(var_68_10.gameObject, typeof(DynamicBoneHelper))

				if var_68_11 then
					var_68_11:EnableDynamicBone(false)
				end
			end

			local var_68_12 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_12 then
				var_68_10.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10164ui_story, Vector3.New(-0.74, -1.08, -5.83), (arg_65_1.time_ - 0) / var_68_12)
				var_68_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_10.position).x, (manager.ui.mainCamera.transform.position - var_68_10.position).y, (manager.ui.mainCamera.transform.position - var_68_10.position).z)
				var_68_10.localEulerAngles.z = 0
				var_68_10.localEulerAngles.x = 0
				var_68_10.localEulerAngles = var_68_10.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_12 and arg_65_1.time_ < 0 + var_68_12 + arg_68_0 then
				var_68_10.localPosition = Vector3.New(-0.74, -1.08, -5.83)
				var_68_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_10.position).x, (manager.ui.mainCamera.transform.position - var_68_10.position).y, (manager.ui.mainCamera.transform.position - var_68_10.position).z)
				var_68_10.localEulerAngles.z = 0
				var_68_10.localEulerAngles.x = 0
				var_68_10.localEulerAngles = var_68_10.localEulerAngles

				local var_68_13 = GameObjectTools.GetOrAddComponent(var_68_10.gameObject, typeof(DynamicBoneHelper))

				if var_68_13 then
					var_68_13:EnableDynamicBone(true)
				end
			end

			local var_68_14 = 0
			local var_68_15 = 0.2

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_14 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_16 = arg_65_1:GetWordFromCfg(324562015)
				local var_68_17 = arg_65_1:FormatText(var_68_16.content)

				arg_65_1.text_.text = var_68_17

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_19 = 8 <= 0 and var_68_15 or var_68_15 * (utf8.len(var_68_17) / 8)

				if (8 <= 0 and var_68_15 or var_68_15 * (utf8.len(var_68_17) / 8)) > 0 and var_68_15 < var_68_19 then
					arg_65_1.talkMaxDuration = var_68_19

					if var_68_19 + var_68_14 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_19 + var_68_14
					end
				end

				arg_65_1.text_.text = var_68_17
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562015", "story_v_out_324562.awb") ~= 0 then
					local var_68_20 = manager.audio:GetVoiceLength("story_v_out_324562", "324562015", "story_v_out_324562.awb") / 1000

					if var_68_20 + var_68_14 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_20 + var_68_14
					end

					if var_68_16.prefab_name ~= "" and arg_65_1.actors_[var_68_16.prefab_name] ~= nil then
						local var_68_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_16.prefab_name].transform, "story_v_out_324562", "324562015", "story_v_out_324562.awb")

						arg_65_1:RecordAudio("324562015", var_68_21)
						arg_65_1:RecordAudio("324562015", var_68_21)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_324562", "324562015", "story_v_out_324562.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_324562", "324562015", "story_v_out_324562.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_22 = math.max(var_68_15, arg_65_1.talkMaxDuration)

			if var_68_14 <= arg_65_1.time_ and arg_65_1.time_ < var_68_14 + var_68_22 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_14) / var_68_22

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_14 + var_68_22 and arg_65_1.time_ < var_68_14 + var_68_22 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10164ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play324562016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 324562016
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play324562017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1071ui_story = arg_69_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1071ui_story"].transform.position).z)
				arg_69_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1071ui_story"].transform.localEulerAngles = arg_69_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1071ui_story"].transform.position).z)
				arg_69_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1071ui_story"].transform.localEulerAngles = arg_69_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["10164ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10164ui_story = var_72_1.localPosition

				local var_72_2 = GameObjectTools.GetOrAddComponent(var_72_1.gameObject, typeof(DynamicBoneHelper))

				if var_72_2 then
					var_72_2:EnableDynamicBone(false)
				end
			end

			local var_72_3 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_3 then
				var_72_1.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10164ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 0) / var_72_3)
				var_72_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_1.position).x, (manager.ui.mainCamera.transform.position - var_72_1.position).y, (manager.ui.mainCamera.transform.position - var_72_1.position).z)
				var_72_1.localEulerAngles.z = 0
				var_72_1.localEulerAngles.x = 0
				var_72_1.localEulerAngles = var_72_1.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_3 and arg_69_1.time_ < 0 + var_72_3 + arg_72_0 then
				var_72_1.localPosition = Vector3.New(0, 100, 0)
				var_72_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_1.position).x, (manager.ui.mainCamera.transform.position - var_72_1.position).y, (manager.ui.mainCamera.transform.position - var_72_1.position).z)
				var_72_1.localEulerAngles.z = 0
				var_72_1.localEulerAngles.x = 0
				var_72_1.localEulerAngles = var_72_1.localEulerAngles

				local var_72_4 = GameObjectTools.GetOrAddComponent(var_72_1.gameObject, typeof(DynamicBoneHelper))

				if var_72_4 then
					var_72_4:EnableDynamicBone(true)
				end
			end

			local var_72_5 = arg_69_1.actors_["1071ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect1071ui_story == nil then
				arg_69_1.var_.characterEffect1071ui_story = var_72_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_6 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_6 and not isNil(var_72_5) then
				if arg_69_1.var_.characterEffect1071ui_story and not isNil(var_72_5) then
					arg_69_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_6)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_6 and arg_69_1.time_ < 0 + var_72_6 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect1071ui_story then
				arg_69_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_72_7 = 0
			local var_72_8 = 0.85

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_7 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_9 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(324562016).content)

				arg_69_1.text_.text = var_72_9

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 34 <= 0 and var_72_8 or var_72_8 * (utf8.len(var_72_9) / 34)

				if (34 <= 0 and var_72_8 or var_72_8 * (utf8.len(var_72_9) / 34)) > 0 and var_72_8 < var_72_11 then
					arg_69_1.talkMaxDuration = var_72_11

					if var_72_11 + var_72_7 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_11 + var_72_7
					end
				end

				arg_69_1.text_.text = var_72_9
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_12 = math.max(var_72_8, arg_69_1.talkMaxDuration)

			if var_72_7 <= arg_69_1.time_ and arg_69_1.time_ < var_72_7 + var_72_12 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_7) / var_72_12

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_7 + var_72_12 and arg_69_1.time_ < var_72_7 + var_72_12 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10164ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play324562017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 324562017
		arg_73_1.duration_ = 9.4

		local var_73_0 = {
			zh = 7.266,
			ja = 9.4
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play324562018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1071ui_story = arg_73_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1071ui_story, Vector3.New(0.7, -1.05, -6.2), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1071ui_story"].transform.position).z)
				arg_73_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1071ui_story"].transform.localEulerAngles = arg_73_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -6.2)
				arg_73_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1071ui_story"].transform.position).z)
				arg_73_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1071ui_story"].transform.localEulerAngles = arg_73_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["1071ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1071ui_story == nil then
				arg_73_1.var_.characterEffect1071ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect1071ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1071ui_story then
				arg_73_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			local var_76_4 = 0
			local var_76_5 = 0.75

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_6 = arg_73_1:GetWordFromCfg(324562017)
				local var_76_7 = arg_73_1:FormatText(var_76_6.content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 30 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 30)

				if (30 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 30)) > 0 and var_76_5 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9

					if var_76_9 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562017", "story_v_out_324562.awb") ~= 0 then
					local var_76_10 = manager.audio:GetVoiceLength("story_v_out_324562", "324562017", "story_v_out_324562.awb") / 1000

					if var_76_10 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_4
					end

					if var_76_6.prefab_name ~= "" and arg_73_1.actors_[var_76_6.prefab_name] ~= nil then
						local var_76_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_6.prefab_name].transform, "story_v_out_324562", "324562017", "story_v_out_324562.awb")

						arg_73_1:RecordAudio("324562017", var_76_11)
						arg_73_1:RecordAudio("324562017", var_76_11)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_324562", "324562017", "story_v_out_324562.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_324562", "324562017", "story_v_out_324562.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_12 = math.max(var_76_5, arg_73_1.talkMaxDuration)

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_12 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_4) / var_76_12

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_4 + var_76_12 and arg_73_1.time_ < var_76_4 + var_76_12 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play324562018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 324562018
		arg_77_1.duration_ = 2.03

		local var_77_0 = {
			zh = 1.999999999999,
			ja = 2.033
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play324562019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10164ui_story = arg_77_1.actors_["10164ui_story"].transform.localPosition

				local var_80_0 = GameObjectTools.GetOrAddComponent(arg_77_1.actors_["10164ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_80_0 then
					var_80_0:EnableDynamicBone(false)
				end
			end

			local var_80_1 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_1 then
				arg_77_1.actors_["10164ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10164ui_story, Vector3.New(-0.74, -1.08, -5.83), (arg_77_1.time_ - 0) / var_80_1)
				arg_77_1.actors_["10164ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["10164ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10164ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10164ui_story"].transform.position).z)
				arg_77_1.actors_["10164ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["10164ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["10164ui_story"].transform.localEulerAngles = arg_77_1.actors_["10164ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_1 and arg_77_1.time_ < 0 + var_80_1 + arg_80_0 then
				arg_77_1.actors_["10164ui_story"].transform.localPosition = Vector3.New(-0.74, -1.08, -5.83)
				arg_77_1.actors_["10164ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["10164ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10164ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10164ui_story"].transform.position).z)
				arg_77_1.actors_["10164ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["10164ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["10164ui_story"].transform.localEulerAngles = arg_77_1.actors_["10164ui_story"].transform.localEulerAngles

				local var_80_2 = GameObjectTools.GetOrAddComponent(arg_77_1.actors_["10164ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_80_2 then
					var_80_2:EnableDynamicBone(true)
				end
			end

			local var_80_3 = arg_77_1.actors_["10164ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_3) and arg_77_1.var_.characterEffect10164ui_story == nil then
				arg_77_1.var_.characterEffect10164ui_story = var_80_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_4 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 and not isNil(var_80_3) then
				if arg_77_1.var_.characterEffect10164ui_story and not isNil(var_80_3) then
					arg_77_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 and not isNil(var_80_3) and arg_77_1.var_.characterEffect10164ui_story then
				arg_77_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			local var_80_6 = arg_77_1.actors_["1071ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_6) and arg_77_1.var_.characterEffect1071ui_story == nil then
				arg_77_1.var_.characterEffect1071ui_story = var_80_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_7 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 and not isNil(var_80_6) then
				if arg_77_1.var_.characterEffect1071ui_story and not isNil(var_80_6) then
					arg_77_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_7)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 and not isNil(var_80_6) and arg_77_1.var_.characterEffect1071ui_story then
				arg_77_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162actionlink/10162action41512")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_80_8 = 0
			local var_80_9 = 0.2

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_10 = arg_77_1:GetWordFromCfg(324562018)
				local var_80_11 = arg_77_1:FormatText(var_80_10.content)

				arg_77_1.text_.text = var_80_11

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_13 = 8 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 8)

				if (8 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 8)) > 0 and var_80_9 < var_80_13 then
					arg_77_1.talkMaxDuration = var_80_13

					if var_80_13 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_8
					end
				end

				arg_77_1.text_.text = var_80_11
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562018", "story_v_out_324562.awb") ~= 0 then
					local var_80_14 = manager.audio:GetVoiceLength("story_v_out_324562", "324562018", "story_v_out_324562.awb") / 1000

					if var_80_14 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_14 + var_80_8
					end

					if var_80_10.prefab_name ~= "" and arg_77_1.actors_[var_80_10.prefab_name] ~= nil then
						local var_80_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_10.prefab_name].transform, "story_v_out_324562", "324562018", "story_v_out_324562.awb")

						arg_77_1:RecordAudio("324562018", var_80_15)
						arg_77_1:RecordAudio("324562018", var_80_15)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_324562", "324562018", "story_v_out_324562.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_324562", "324562018", "story_v_out_324562.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_16 = math.max(var_80_9, arg_77_1.talkMaxDuration)

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_16 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_8) / var_80_16

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_8 + var_80_16 and arg_77_1.time_ < var_80_8 + var_80_16 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10164ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play324562019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 324562019
		arg_81_1.duration_ = 9.5

		local var_81_0 = {
			zh = 8,
			ja = 9.5
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play324562020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1071ui_story"]) and arg_81_1.var_.characterEffect1071ui_story == nil then
				arg_81_1.var_.characterEffect1071ui_story = arg_81_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1071ui_story"]) then
				if arg_81_1.var_.characterEffect1071ui_story and not isNil(arg_81_1.actors_["1071ui_story"]) then
					arg_81_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1071ui_story"]) and arg_81_1.var_.characterEffect1071ui_story then
				arg_81_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_84_2 = arg_81_1.actors_["10164ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect10164ui_story == nil then
				arg_81_1.var_.characterEffect10164ui_story = var_84_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_3 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.characterEffect10164ui_story and not isNil(var_84_2) then
					arg_81_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_81_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_3)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect10164ui_story then
				arg_81_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_81_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			local var_84_4 = 0
			local var_84_5 = 1.25

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(324562019)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 50 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 50)

				if (50 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 50)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562019", "story_v_out_324562.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_out_324562", "324562019", "story_v_out_324562.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_out_324562", "324562019", "story_v_out_324562.awb")

						arg_81_1:RecordAudio("324562019", var_84_11)
						arg_81_1:RecordAudio("324562019", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_324562", "324562019", "story_v_out_324562.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_324562", "324562019", "story_v_out_324562.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_12 = math.max(var_84_5, arg_81_1.talkMaxDuration)

			if var_84_4 <= arg_81_1.time_ and arg_81_1.time_ < var_84_4 + var_84_12 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_4) / var_84_12

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_4 + var_84_12 and arg_81_1.time_ < var_84_4 + var_84_12 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play324562020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 324562020
		arg_85_1.duration_ = 4.77

		local var_85_0 = {
			zh = 3.833,
			ja = 4.766
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play324562021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_2")
			end

			local var_88_0 = 0
			local var_88_1 = 0.5

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_2 = arg_85_1:GetWordFromCfg(324562020)
				local var_88_3 = arg_85_1:FormatText(var_88_2.content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 20 <= 0 and var_88_1 or var_88_1 * (utf8.len(var_88_3) / 20)

				if (20 <= 0 and var_88_1 or var_88_1 * (utf8.len(var_88_3) / 20)) > 0 and var_88_1 < var_88_5 then
					arg_85_1.talkMaxDuration = var_88_5

					if var_88_5 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562020", "story_v_out_324562.awb") ~= 0 then
					local var_88_6 = manager.audio:GetVoiceLength("story_v_out_324562", "324562020", "story_v_out_324562.awb") / 1000

					if var_88_6 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_0
					end

					if var_88_2.prefab_name ~= "" and arg_85_1.actors_[var_88_2.prefab_name] ~= nil then
						local var_88_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_2.prefab_name].transform, "story_v_out_324562", "324562020", "story_v_out_324562.awb")

						arg_85_1:RecordAudio("324562020", var_88_7)
						arg_85_1:RecordAudio("324562020", var_88_7)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_324562", "324562020", "story_v_out_324562.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_324562", "324562020", "story_v_out_324562.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_8 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_8 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_8

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_8 and arg_85_1.time_ < var_88_0 + var_88_8 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play324562021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 324562021
		arg_89_1.duration_ = 6.8

		local var_89_0 = {
			zh = 4.6,
			ja = 6.8
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play324562022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["10164ui_story"]) and arg_89_1.var_.characterEffect10164ui_story == nil then
				arg_89_1.var_.characterEffect10164ui_story = arg_89_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["10164ui_story"]) then
				if arg_89_1.var_.characterEffect10164ui_story and not isNil(arg_89_1.actors_["10164ui_story"]) then
					arg_89_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["10164ui_story"]) and arg_89_1.var_.characterEffect10164ui_story then
				arg_89_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			local var_92_2 = arg_89_1.actors_["1071ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.characterEffect1071ui_story == nil then
				arg_89_1.var_.characterEffect1071ui_story = var_92_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_3 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 and not isNil(var_92_2) then
				if arg_89_1.var_.characterEffect1071ui_story and not isNil(var_92_2) then
					arg_89_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_3)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.characterEffect1071ui_story then
				arg_89_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162actionlink/10162action41216")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_92_4 = 0
			local var_92_5 = 0.6

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(324562021)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 24 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 24)

				if (24 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 24)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562021", "story_v_out_324562.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_out_324562", "324562021", "story_v_out_324562.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_out_324562", "324562021", "story_v_out_324562.awb")

						arg_89_1:RecordAudio("324562021", var_92_11)
						arg_89_1:RecordAudio("324562021", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_324562", "324562021", "story_v_out_324562.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_324562", "324562021", "story_v_out_324562.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_12 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_12 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_12

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_12 and arg_89_1.time_ < var_92_4 + var_92_12 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play324562022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 324562022
		arg_93_1.duration_ = 4.07

		local var_93_0 = {
			zh = 2.6,
			ja = 4.066
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play324562023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1071ui_story"]) and arg_93_1.var_.characterEffect1071ui_story == nil then
				arg_93_1.var_.characterEffect1071ui_story = arg_93_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1071ui_story"]) then
				if arg_93_1.var_.characterEffect1071ui_story and not isNil(arg_93_1.actors_["1071ui_story"]) then
					arg_93_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1071ui_story"]) and arg_93_1.var_.characterEffect1071ui_story then
				arg_93_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_96_2 = arg_93_1.actors_["10164ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.characterEffect10164ui_story == nil then
				arg_93_1.var_.characterEffect10164ui_story = var_96_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_3 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_3 and not isNil(var_96_2) then
				if arg_93_1.var_.characterEffect10164ui_story and not isNil(var_96_2) then
					arg_93_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_93_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_3)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_3 and arg_93_1.time_ < 0 + var_96_3 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.characterEffect10164ui_story then
				arg_93_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_93_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_96_4 = 0
			local var_96_5 = 0.35

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(324562022)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 14 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 14)

				if (14 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 14)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562022", "story_v_out_324562.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_324562", "324562022", "story_v_out_324562.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_out_324562", "324562022", "story_v_out_324562.awb")

						arg_93_1:RecordAudio("324562022", var_96_11)
						arg_93_1:RecordAudio("324562022", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_324562", "324562022", "story_v_out_324562.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_324562", "324562022", "story_v_out_324562.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_12 = math.max(var_96_5, arg_93_1.talkMaxDuration)

			if var_96_4 <= arg_93_1.time_ and arg_93_1.time_ < var_96_4 + var_96_12 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_4) / var_96_12

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_4 + var_96_12 and arg_93_1.time_ < var_96_4 + var_96_12 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play324562023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 324562023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play324562024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1071ui_story"]) and arg_97_1.var_.characterEffect1071ui_story == nil then
				arg_97_1.var_.characterEffect1071ui_story = arg_97_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1071ui_story"]) then
				if arg_97_1.var_.characterEffect1071ui_story and not isNil(arg_97_1.actors_["1071ui_story"]) then
					arg_97_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1071ui_story"]) and arg_97_1.var_.characterEffect1071ui_story then
				arg_97_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_100_1 = 0
			local var_100_2 = 0.825

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(324562023).content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 33 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 33)

				if (33 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 33)) > 0 and var_100_2 < var_100_5 then
					arg_97_1.talkMaxDuration = var_100_5

					if var_100_5 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_6 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_6 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_6

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_6 and arg_97_1.time_ < var_100_1 + var_100_6 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play324562024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 324562024
		arg_101_1.duration_ = 10.43

		local var_101_0 = {
			zh = 10.366,
			ja = 10.433
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play324562025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1071ui_story"]) and arg_101_1.var_.characterEffect1071ui_story == nil then
				arg_101_1.var_.characterEffect1071ui_story = arg_101_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1071ui_story"]) then
				if arg_101_1.var_.characterEffect1071ui_story and not isNil(arg_101_1.actors_["1071ui_story"]) then
					arg_101_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1071ui_story"]) and arg_101_1.var_.characterEffect1071ui_story then
				arg_101_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_2")
			end

			local var_104_2 = 0
			local var_104_3 = 1.25

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_2 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_4 = arg_101_1:GetWordFromCfg(324562024)
				local var_104_5 = arg_101_1:FormatText(var_104_4.content)

				arg_101_1.text_.text = var_104_5

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_7 = 50 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 50)

				if (50 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 50)) > 0 and var_104_3 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_2
					end
				end

				arg_101_1.text_.text = var_104_5
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562024", "story_v_out_324562.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_324562", "324562024", "story_v_out_324562.awb") / 1000

					if var_104_8 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_2
					end

					if var_104_4.prefab_name ~= "" and arg_101_1.actors_[var_104_4.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_4.prefab_name].transform, "story_v_out_324562", "324562024", "story_v_out_324562.awb")

						arg_101_1:RecordAudio("324562024", var_104_9)
						arg_101_1:RecordAudio("324562024", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_324562", "324562024", "story_v_out_324562.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_324562", "324562024", "story_v_out_324562.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_10 = math.max(var_104_3, arg_101_1.talkMaxDuration)

			if var_104_2 <= arg_101_1.time_ and arg_101_1.time_ < var_104_2 + var_104_10 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_2) / var_104_10

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_2 + var_104_10 and arg_101_1.time_ < var_104_2 + var_104_10 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play324562025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 324562025
		arg_105_1.duration_ = 4.6

		local var_105_0 = {
			zh = 3.4,
			ja = 4.6
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play324562026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["10164ui_story"]) and arg_105_1.var_.characterEffect10164ui_story == nil then
				arg_105_1.var_.characterEffect10164ui_story = arg_105_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["10164ui_story"]) then
				if arg_105_1.var_.characterEffect10164ui_story and not isNil(arg_105_1.actors_["10164ui_story"]) then
					arg_105_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["10164ui_story"]) and arg_105_1.var_.characterEffect10164ui_story then
				arg_105_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			local var_108_2 = arg_105_1.actors_["1071ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.characterEffect1071ui_story == nil then
				arg_105_1.var_.characterEffect1071ui_story = var_108_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_3 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_3 and not isNil(var_108_2) then
				if arg_105_1.var_.characterEffect1071ui_story and not isNil(var_108_2) then
					arg_105_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_3)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_3 and arg_105_1.time_ < 0 + var_108_3 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.characterEffect1071ui_story then
				arg_105_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action16_2")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_108_4 = 0
			local var_108_5 = 0.375

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_6 = arg_105_1:GetWordFromCfg(324562025)
				local var_108_7 = arg_105_1:FormatText(var_108_6.content)

				arg_105_1.text_.text = var_108_7

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_9 = 15 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 15)

				if (15 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 15)) > 0 and var_108_5 < var_108_9 then
					arg_105_1.talkMaxDuration = var_108_9

					if var_108_9 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_4
					end
				end

				arg_105_1.text_.text = var_108_7
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562025", "story_v_out_324562.awb") ~= 0 then
					local var_108_10 = manager.audio:GetVoiceLength("story_v_out_324562", "324562025", "story_v_out_324562.awb") / 1000

					if var_108_10 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_4
					end

					if var_108_6.prefab_name ~= "" and arg_105_1.actors_[var_108_6.prefab_name] ~= nil then
						local var_108_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_6.prefab_name].transform, "story_v_out_324562", "324562025", "story_v_out_324562.awb")

						arg_105_1:RecordAudio("324562025", var_108_11)
						arg_105_1:RecordAudio("324562025", var_108_11)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_324562", "324562025", "story_v_out_324562.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_324562", "324562025", "story_v_out_324562.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_12 = math.max(var_108_5, arg_105_1.talkMaxDuration)

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_12 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_4) / var_108_12

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_4 + var_108_12 and arg_105_1.time_ < var_108_4 + var_108_12 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play324562026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 324562026
		arg_109_1.duration_ = 11.07

		local var_109_0 = {
			zh = 8.233,
			ja = 11.066
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play324562027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1071ui_story"]) and arg_109_1.var_.characterEffect1071ui_story == nil then
				arg_109_1.var_.characterEffect1071ui_story = arg_109_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1071ui_story"]) then
				if arg_109_1.var_.characterEffect1071ui_story and not isNil(arg_109_1.actors_["1071ui_story"]) then
					arg_109_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1071ui_story"]) and arg_109_1.var_.characterEffect1071ui_story then
				arg_109_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_112_2 = arg_109_1.actors_["10164ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.characterEffect10164ui_story == nil then
				arg_109_1.var_.characterEffect10164ui_story = var_112_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_3 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_3 and not isNil(var_112_2) then
				if arg_109_1.var_.characterEffect10164ui_story and not isNil(var_112_2) then
					arg_109_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_3)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_3 and arg_109_1.time_ < 0 + var_112_3 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.characterEffect10164ui_story then
				arg_109_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			local var_112_4 = 0
			local var_112_5 = 1.05

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_6 = arg_109_1:GetWordFromCfg(324562026)
				local var_112_7 = arg_109_1:FormatText(var_112_6.content)

				arg_109_1.text_.text = var_112_7

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 42 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 42)

				if (42 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 42)) > 0 and var_112_5 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_7
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562026", "story_v_out_324562.awb") ~= 0 then
					local var_112_10 = manager.audio:GetVoiceLength("story_v_out_324562", "324562026", "story_v_out_324562.awb") / 1000

					if var_112_10 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_4
					end

					if var_112_6.prefab_name ~= "" and arg_109_1.actors_[var_112_6.prefab_name] ~= nil then
						local var_112_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_6.prefab_name].transform, "story_v_out_324562", "324562026", "story_v_out_324562.awb")

						arg_109_1:RecordAudio("324562026", var_112_11)
						arg_109_1:RecordAudio("324562026", var_112_11)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_324562", "324562026", "story_v_out_324562.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_324562", "324562026", "story_v_out_324562.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_12 = math.max(var_112_5, arg_109_1.talkMaxDuration)

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_12 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_4) / var_112_12

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_4 + var_112_12 and arg_109_1.time_ < var_112_4 + var_112_12 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play324562027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 324562027
		arg_113_1.duration_ = 4.53

		local var_113_0 = {
			zh = 3.2,
			ja = 4.533
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play324562028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10164ui_story = arg_113_1.actors_["10164ui_story"].transform.localPosition

				local var_116_0 = GameObjectTools.GetOrAddComponent(arg_113_1.actors_["10164ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_116_0 then
					var_116_0:EnableDynamicBone(false)
				end
			end

			local var_116_1 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_1 then
				arg_113_1.actors_["10164ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10164ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_1)
				arg_113_1.actors_["10164ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10164ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10164ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10164ui_story"].transform.position).z)
				arg_113_1.actors_["10164ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10164ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10164ui_story"].transform.localEulerAngles = arg_113_1.actors_["10164ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_1 and arg_113_1.time_ < 0 + var_116_1 + arg_116_0 then
				arg_113_1.actors_["10164ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.actors_["10164ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10164ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10164ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10164ui_story"].transform.position).z)
				arg_113_1.actors_["10164ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10164ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10164ui_story"].transform.localEulerAngles = arg_113_1.actors_["10164ui_story"].transform.localEulerAngles

				local var_116_2 = GameObjectTools.GetOrAddComponent(arg_113_1.actors_["10164ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_116_2 then
					var_116_2:EnableDynamicBone(true)
				end
			end

			local var_116_3 = arg_113_1.actors_["1170ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1170ui_story = var_116_3.localPosition

				local var_116_4 = GameObjectTools.GetOrAddComponent(var_116_3.gameObject, typeof(DynamicBoneHelper))

				if var_116_4 then
					var_116_4:EnableDynamicBone(false)
				end
			end

			local var_116_5 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_5 then
				var_116_3.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1170ui_story, Vector3.New(-0.68, -0.95, -6.08), (arg_113_1.time_ - 0) / var_116_5)
				var_116_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_3.position).x, (manager.ui.mainCamera.transform.position - var_116_3.position).y, (manager.ui.mainCamera.transform.position - var_116_3.position).z)
				var_116_3.localEulerAngles.z = 0
				var_116_3.localEulerAngles.x = 0
				var_116_3.localEulerAngles = var_116_3.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_5 and arg_113_1.time_ < 0 + var_116_5 + arg_116_0 then
				var_116_3.localPosition = Vector3.New(-0.68, -0.95, -6.08)
				var_116_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_3.position).x, (manager.ui.mainCamera.transform.position - var_116_3.position).y, (manager.ui.mainCamera.transform.position - var_116_3.position).z)
				var_116_3.localEulerAngles.z = 0
				var_116_3.localEulerAngles.x = 0
				var_116_3.localEulerAngles = var_116_3.localEulerAngles

				local var_116_6 = GameObjectTools.GetOrAddComponent(var_116_3.gameObject, typeof(DynamicBoneHelper))

				if var_116_6 then
					var_116_6:EnableDynamicBone(true)
				end
			end

			local var_116_7 = arg_113_1.actors_["1170ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.characterEffect1170ui_story == nil then
				arg_113_1.var_.characterEffect1170ui_story = var_116_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_8 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_8 and not isNil(var_116_7) then
				if arg_113_1.var_.characterEffect1170ui_story and not isNil(var_116_7) then
					arg_113_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_8 and arg_113_1.time_ < 0 + var_116_8 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.characterEffect1170ui_story then
				arg_113_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_116_10 = arg_113_1.actors_["1071ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_10) and arg_113_1.var_.characterEffect1071ui_story == nil then
				arg_113_1.var_.characterEffect1071ui_story = var_116_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_11 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_11 and not isNil(var_116_10) then
				if arg_113_1.var_.characterEffect1071ui_story and not isNil(var_116_10) then
					arg_113_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_11)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_11 and arg_113_1.time_ < 0 + var_116_11 + arg_116_0 and not isNil(var_116_10) and arg_113_1.var_.characterEffect1071ui_story then
				arg_113_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action2_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_116_12 = 0
			local var_116_13 = 0.25

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_12 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_14 = arg_113_1:GetWordFromCfg(324562027)
				local var_116_15 = arg_113_1:FormatText(var_116_14.content)

				arg_113_1.text_.text = var_116_15

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_17 = 10 <= 0 and var_116_13 or var_116_13 * (utf8.len(var_116_15) / 10)

				if (10 <= 0 and var_116_13 or var_116_13 * (utf8.len(var_116_15) / 10)) > 0 and var_116_13 < var_116_17 then
					arg_113_1.talkMaxDuration = var_116_17

					if var_116_17 + var_116_12 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_17 + var_116_12
					end
				end

				arg_113_1.text_.text = var_116_15
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562027", "story_v_out_324562.awb") ~= 0 then
					local var_116_18 = manager.audio:GetVoiceLength("story_v_out_324562", "324562027", "story_v_out_324562.awb") / 1000

					if var_116_18 + var_116_12 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_18 + var_116_12
					end

					if var_116_14.prefab_name ~= "" and arg_113_1.actors_[var_116_14.prefab_name] ~= nil then
						local var_116_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_14.prefab_name].transform, "story_v_out_324562", "324562027", "story_v_out_324562.awb")

						arg_113_1:RecordAudio("324562027", var_116_19)
						arg_113_1:RecordAudio("324562027", var_116_19)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_324562", "324562027", "story_v_out_324562.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_324562", "324562027", "story_v_out_324562.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_20 = math.max(var_116_13, arg_113_1.talkMaxDuration)

			if var_116_12 <= arg_113_1.time_ and arg_113_1.time_ < var_116_12 + var_116_20 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_12) / var_116_20

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_12 + var_116_20 and arg_113_1.time_ < var_116_12 + var_116_20 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10164ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play324562028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 324562028
		arg_117_1.duration_ = 5.5

		local var_117_0 = {
			zh = 3.533,
			ja = 5.5
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play324562029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1071ui_story"]) and arg_117_1.var_.characterEffect1071ui_story == nil then
				arg_117_1.var_.characterEffect1071ui_story = arg_117_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1071ui_story"]) then
				if arg_117_1.var_.characterEffect1071ui_story and not isNil(arg_117_1.actors_["1071ui_story"]) then
					arg_117_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1071ui_story"]) and arg_117_1.var_.characterEffect1071ui_story then
				arg_117_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_120_2 = arg_117_1.actors_["1170ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect1170ui_story == nil then
				arg_117_1.var_.characterEffect1170ui_story = var_120_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_3 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_3 and not isNil(var_120_2) then
				if arg_117_1.var_.characterEffect1170ui_story and not isNil(var_120_2) then
					arg_117_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_3)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_3 and arg_117_1.time_ < 0 + var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect1170ui_story then
				arg_117_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			local var_120_4 = 0
			local var_120_5 = 0.5

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_6 = arg_117_1:GetWordFromCfg(324562028)
				local var_120_7 = arg_117_1:FormatText(var_120_6.content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 20 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 20)

				if (20 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 20)) > 0 and var_120_5 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562028", "story_v_out_324562.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_out_324562", "324562028", "story_v_out_324562.awb") / 1000

					if var_120_10 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_4
					end

					if var_120_6.prefab_name ~= "" and arg_117_1.actors_[var_120_6.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_6.prefab_name].transform, "story_v_out_324562", "324562028", "story_v_out_324562.awb")

						arg_117_1:RecordAudio("324562028", var_120_11)
						arg_117_1:RecordAudio("324562028", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_324562", "324562028", "story_v_out_324562.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_324562", "324562028", "story_v_out_324562.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_12 = math.max(var_120_5, arg_117_1.talkMaxDuration)

			if var_120_4 <= arg_117_1.time_ and arg_117_1.time_ < var_120_4 + var_120_12 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_4) / var_120_12

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_4 + var_120_12 and arg_117_1.time_ < var_120_4 + var_120_12 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play324562029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 324562029
		arg_121_1.duration_ = 3.93

		local var_121_0 = {
			zh = 3.933,
			ja = 3.266
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play324562030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1170ui_story"]) and arg_121_1.var_.characterEffect1170ui_story == nil then
				arg_121_1.var_.characterEffect1170ui_story = arg_121_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1170ui_story"]) then
				if arg_121_1.var_.characterEffect1170ui_story and not isNil(arg_121_1.actors_["1170ui_story"]) then
					arg_121_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1170ui_story"]) and arg_121_1.var_.characterEffect1170ui_story then
				arg_121_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_124_2 = arg_121_1.actors_["1071ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect1071ui_story == nil then
				arg_121_1.var_.characterEffect1071ui_story = var_124_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_3 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 and not isNil(var_124_2) then
				if arg_121_1.var_.characterEffect1071ui_story and not isNil(var_124_2) then
					arg_121_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_3)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect1071ui_story then
				arg_121_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action2_2")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_124_4 = 0
			local var_124_5 = 0.375

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(324562029)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 15 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 15)

				if (15 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 15)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562029", "story_v_out_324562.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_out_324562", "324562029", "story_v_out_324562.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_out_324562", "324562029", "story_v_out_324562.awb")

						arg_121_1:RecordAudio("324562029", var_124_11)
						arg_121_1:RecordAudio("324562029", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_324562", "324562029", "story_v_out_324562.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_324562", "324562029", "story_v_out_324562.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_5, arg_121_1.talkMaxDuration)

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_4) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_4 + var_124_12 and arg_121_1.time_ < var_124_4 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play324562030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 324562030
		arg_125_1.duration_ = 7.77

		local var_125_0 = {
			zh = 6.866,
			ja = 7.766
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play324562031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1071ui_story"]) and arg_125_1.var_.characterEffect1071ui_story == nil then
				arg_125_1.var_.characterEffect1071ui_story = arg_125_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1071ui_story"]) then
				if arg_125_1.var_.characterEffect1071ui_story and not isNil(arg_125_1.actors_["1071ui_story"]) then
					arg_125_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1071ui_story"]) and arg_125_1.var_.characterEffect1071ui_story then
				arg_125_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_128_2 = arg_125_1.actors_["1170ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.characterEffect1170ui_story == nil then
				arg_125_1.var_.characterEffect1170ui_story = var_128_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_3 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_3 and not isNil(var_128_2) then
				if arg_125_1.var_.characterEffect1170ui_story and not isNil(var_128_2) then
					arg_125_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_3)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_3 and arg_125_1.time_ < 0 + var_128_3 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.characterEffect1170ui_story then
				arg_125_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_2")
			end

			local var_128_4 = 0
			local var_128_5 = 0.75

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:GetWordFromCfg(324562030)
				local var_128_7 = arg_125_1:FormatText(var_128_6.content)

				arg_125_1.text_.text = var_128_7

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 30 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 30)

				if (30 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 30)) > 0 and var_128_5 < var_128_9 then
					arg_125_1.talkMaxDuration = var_128_9

					if var_128_9 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_7
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562030", "story_v_out_324562.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_out_324562", "324562030", "story_v_out_324562.awb") / 1000

					if var_128_10 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_4
					end

					if var_128_6.prefab_name ~= "" and arg_125_1.actors_[var_128_6.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_6.prefab_name].transform, "story_v_out_324562", "324562030", "story_v_out_324562.awb")

						arg_125_1:RecordAudio("324562030", var_128_11)
						arg_125_1:RecordAudio("324562030", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_324562", "324562030", "story_v_out_324562.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_324562", "324562030", "story_v_out_324562.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_12 = math.max(var_128_5, arg_125_1.talkMaxDuration)

			if var_128_4 <= arg_125_1.time_ and arg_125_1.time_ < var_128_4 + var_128_12 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_4) / var_128_12

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_4 + var_128_12 and arg_125_1.time_ < var_128_4 + var_128_12 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play324562031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 324562031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play324562032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1071ui_story"]) and arg_129_1.var_.characterEffect1071ui_story == nil then
				arg_129_1.var_.characterEffect1071ui_story = arg_129_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1071ui_story"]) then
				if arg_129_1.var_.characterEffect1071ui_story and not isNil(arg_129_1.actors_["1071ui_story"]) then
					arg_129_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_0)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1071ui_story"]) and arg_129_1.var_.characterEffect1071ui_story then
				arg_129_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_132_1 = 0
			local var_132_2 = 0.975

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_3 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(324562031).content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 39 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 39)

				if (39 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 39)) > 0 and var_132_2 < var_132_5 then
					arg_129_1.talkMaxDuration = var_132_5

					if var_132_5 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_6 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_6 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_6

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_6 and arg_129_1.time_ < var_132_1 + var_132_6 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play324562032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 324562032
		arg_133_1.duration_ = 9.8

		local var_133_0 = {
			zh = 9.5,
			ja = 9.8
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play324562033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1170ui_story"]) and arg_133_1.var_.characterEffect1170ui_story == nil then
				arg_133_1.var_.characterEffect1170ui_story = arg_133_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1170ui_story"]) then
				if arg_133_1.var_.characterEffect1170ui_story and not isNil(arg_133_1.actors_["1170ui_story"]) then
					arg_133_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1170ui_story"]) and arg_133_1.var_.characterEffect1170ui_story then
				arg_133_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action7_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_136_2 = 0
			local var_136_3 = 0.75

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_2 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_4 = arg_133_1:GetWordFromCfg(324562032)
				local var_136_5 = arg_133_1:FormatText(var_136_4.content)

				arg_133_1.text_.text = var_136_5

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_7 = 30 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_5) / 30)

				if (30 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_5) / 30)) > 0 and var_136_3 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_2
					end
				end

				arg_133_1.text_.text = var_136_5
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562032", "story_v_out_324562.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_out_324562", "324562032", "story_v_out_324562.awb") / 1000

					if var_136_8 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_2
					end

					if var_136_4.prefab_name ~= "" and arg_133_1.actors_[var_136_4.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_4.prefab_name].transform, "story_v_out_324562", "324562032", "story_v_out_324562.awb")

						arg_133_1:RecordAudio("324562032", var_136_9)
						arg_133_1:RecordAudio("324562032", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_324562", "324562032", "story_v_out_324562.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_324562", "324562032", "story_v_out_324562.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_3, arg_133_1.talkMaxDuration)

			if var_136_2 <= arg_133_1.time_ and arg_133_1.time_ < var_136_2 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_2) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_2 + var_136_10 and arg_133_1.time_ < var_136_2 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play324562033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 324562033
		arg_137_1.duration_ = 4.8

		local var_137_0 = {
			zh = 4.5,
			ja = 4.8
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play324562034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.55

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:GetWordFromCfg(324562033)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 22 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 22)

				if (22 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 22)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562033", "story_v_out_324562.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_out_324562", "324562033", "story_v_out_324562.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_out_324562", "324562033", "story_v_out_324562.awb")

						arg_137_1:RecordAudio("324562033", var_140_6)
						arg_137_1:RecordAudio("324562033", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_324562", "324562033", "story_v_out_324562.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_324562", "324562033", "story_v_out_324562.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_7 and arg_137_1.time_ < 0 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play324562034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 324562034
		arg_141_1.duration_ = 8.23

		local var_141_0 = {
			zh = 4.633,
			ja = 8.233
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
				arg_141_0:Play324562035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10164ui_story = arg_141_1.actors_["10164ui_story"].transform.localPosition

				local var_144_0 = GameObjectTools.GetOrAddComponent(arg_141_1.actors_["10164ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_144_0 then
					var_144_0:EnableDynamicBone(false)
				end
			end

			local var_144_1 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_1 then
				arg_141_1.actors_["10164ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10164ui_story, Vector3.New(0.7, -1.08, -5.83), (arg_141_1.time_ - 0) / var_144_1)
				arg_141_1.actors_["10164ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["10164ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10164ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10164ui_story"].transform.position).z)
				arg_141_1.actors_["10164ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["10164ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["10164ui_story"].transform.localEulerAngles = arg_141_1.actors_["10164ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_1 and arg_141_1.time_ < 0 + var_144_1 + arg_144_0 then
				arg_141_1.actors_["10164ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -5.83)
				arg_141_1.actors_["10164ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["10164ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10164ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10164ui_story"].transform.position).z)
				arg_141_1.actors_["10164ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["10164ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["10164ui_story"].transform.localEulerAngles = arg_141_1.actors_["10164ui_story"].transform.localEulerAngles

				local var_144_2 = GameObjectTools.GetOrAddComponent(arg_141_1.actors_["10164ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_144_2 then
					var_144_2:EnableDynamicBone(true)
				end
			end

			local var_144_3 = arg_141_1.actors_["10164ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_3) and arg_141_1.var_.characterEffect10164ui_story == nil then
				arg_141_1.var_.characterEffect10164ui_story = var_144_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_4 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 and not isNil(var_144_3) then
				if arg_141_1.var_.characterEffect10164ui_story and not isNil(var_144_3) then
					arg_141_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 and not isNil(var_144_3) and arg_141_1.var_.characterEffect10164ui_story then
				arg_141_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			local var_144_6 = arg_141_1.actors_["1170ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_6) and arg_141_1.var_.characterEffect1170ui_story == nil then
				arg_141_1.var_.characterEffect1170ui_story = var_144_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_7 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 and not isNil(var_144_6) then
				if arg_141_1.var_.characterEffect1170ui_story and not isNil(var_144_6) then
					arg_141_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_7)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 and not isNil(var_144_6) and arg_141_1.var_.characterEffect1170ui_story then
				arg_141_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action1_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_144_8 = arg_141_1.actors_["1071ui_story"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1071ui_story = var_144_8.localPosition
			end

			local var_144_9 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_9 then
				var_144_8.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_141_1.time_ - 0) / var_144_9)
				var_144_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_8.position).x, (manager.ui.mainCamera.transform.position - var_144_8.position).y, (manager.ui.mainCamera.transform.position - var_144_8.position).z)
				var_144_8.localEulerAngles.z = 0
				var_144_8.localEulerAngles.x = 0
				var_144_8.localEulerAngles = var_144_8.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_9 and arg_141_1.time_ < 0 + var_144_9 + arg_144_0 then
				var_144_8.localPosition = Vector3.New(0, 100, 0)
				var_144_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_8.position).x, (manager.ui.mainCamera.transform.position - var_144_8.position).y, (manager.ui.mainCamera.transform.position - var_144_8.position).z)
				var_144_8.localEulerAngles.z = 0
				var_144_8.localEulerAngles.x = 0
				var_144_8.localEulerAngles = var_144_8.localEulerAngles
			end

			local var_144_10 = 0
			local var_144_11 = 0.65

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_12 = arg_141_1:GetWordFromCfg(324562034)
				local var_144_13 = arg_141_1:FormatText(var_144_12.content)

				arg_141_1.text_.text = var_144_13

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_15 = 26 <= 0 and var_144_11 or var_144_11 * (utf8.len(var_144_13) / 26)

				if (26 <= 0 and var_144_11 or var_144_11 * (utf8.len(var_144_13) / 26)) > 0 and var_144_11 < var_144_15 then
					arg_141_1.talkMaxDuration = var_144_15

					if var_144_15 + var_144_10 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_15 + var_144_10
					end
				end

				arg_141_1.text_.text = var_144_13
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562034", "story_v_out_324562.awb") ~= 0 then
					local var_144_16 = manager.audio:GetVoiceLength("story_v_out_324562", "324562034", "story_v_out_324562.awb") / 1000

					if var_144_16 + var_144_10 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_16 + var_144_10
					end

					if var_144_12.prefab_name ~= "" and arg_141_1.actors_[var_144_12.prefab_name] ~= nil then
						local var_144_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_12.prefab_name].transform, "story_v_out_324562", "324562034", "story_v_out_324562.awb")

						arg_141_1:RecordAudio("324562034", var_144_17)
						arg_141_1:RecordAudio("324562034", var_144_17)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_324562", "324562034", "story_v_out_324562.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_324562", "324562034", "story_v_out_324562.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_18 = math.max(var_144_11, arg_141_1.talkMaxDuration)

			if var_144_10 <= arg_141_1.time_ and arg_141_1.time_ < var_144_10 + var_144_18 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_10) / var_144_18

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_10 + var_144_18 and arg_141_1.time_ < var_144_10 + var_144_18 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10164ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play324562035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 324562035
		arg_145_1.duration_ = 9.43

		local var_145_0 = {
			zh = 9.433,
			ja = 8.933
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
				arg_145_0:Play324562036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1170ui_story"]) and arg_145_1.var_.characterEffect1170ui_story == nil then
				arg_145_1.var_.characterEffect1170ui_story = arg_145_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1170ui_story"]) then
				if arg_145_1.var_.characterEffect1170ui_story and not isNil(arg_145_1.actors_["1170ui_story"]) then
					arg_145_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1170ui_story"]) and arg_145_1.var_.characterEffect1170ui_story then
				arg_145_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_148_2 = arg_145_1.actors_["10164ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.characterEffect10164ui_story == nil then
				arg_145_1.var_.characterEffect10164ui_story = var_148_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_3 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_3 and not isNil(var_148_2) then
				if arg_145_1.var_.characterEffect10164ui_story and not isNil(var_148_2) then
					arg_145_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_145_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_3)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_3 and arg_145_1.time_ < 0 + var_148_3 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.characterEffect10164ui_story then
				arg_145_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_145_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action7_2")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_148_4 = 0
			local var_148_5 = 1.05

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_6 = arg_145_1:GetWordFromCfg(324562035)
				local var_148_7 = arg_145_1:FormatText(var_148_6.content)

				arg_145_1.text_.text = var_148_7

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_9 = 42 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 42)

				if (42 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 42)) > 0 and var_148_5 < var_148_9 then
					arg_145_1.talkMaxDuration = var_148_9

					if var_148_9 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_9 + var_148_4
					end
				end

				arg_145_1.text_.text = var_148_7
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562035", "story_v_out_324562.awb") ~= 0 then
					local var_148_10 = manager.audio:GetVoiceLength("story_v_out_324562", "324562035", "story_v_out_324562.awb") / 1000

					if var_148_10 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_10 + var_148_4
					end

					if var_148_6.prefab_name ~= "" and arg_145_1.actors_[var_148_6.prefab_name] ~= nil then
						local var_148_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_6.prefab_name].transform, "story_v_out_324562", "324562035", "story_v_out_324562.awb")

						arg_145_1:RecordAudio("324562035", var_148_11)
						arg_145_1:RecordAudio("324562035", var_148_11)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_324562", "324562035", "story_v_out_324562.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_324562", "324562035", "story_v_out_324562.awb")
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

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play324562036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 324562036
		arg_149_1.duration_ = 3.3

		local var_149_0 = {
			zh = 2.966,
			ja = 3.3
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
				arg_149_0:Play324562037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["10164ui_story"]) and arg_149_1.var_.characterEffect10164ui_story == nil then
				arg_149_1.var_.characterEffect10164ui_story = arg_149_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["10164ui_story"]) then
				if arg_149_1.var_.characterEffect10164ui_story and not isNil(arg_149_1.actors_["10164ui_story"]) then
					arg_149_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["10164ui_story"]) and arg_149_1.var_.characterEffect10164ui_story then
				arg_149_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			local var_152_2 = arg_149_1.actors_["1170ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect1170ui_story == nil then
				arg_149_1.var_.characterEffect1170ui_story = var_152_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_3 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_3 and not isNil(var_152_2) then
				if arg_149_1.var_.characterEffect1170ui_story and not isNil(var_152_2) then
					arg_149_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_3)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_3 and arg_149_1.time_ < 0 + var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect1170ui_story then
				arg_149_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action8_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_152_4 = 0
			local var_152_5 = 0.275

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_6 = arg_149_1:GetWordFromCfg(324562036)
				local var_152_7 = arg_149_1:FormatText(var_152_6.content)

				arg_149_1.text_.text = var_152_7

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_9 = 11 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 11)

				if (11 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 11)) > 0 and var_152_5 < var_152_9 then
					arg_149_1.talkMaxDuration = var_152_9

					if var_152_9 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_9 + var_152_4
					end
				end

				arg_149_1.text_.text = var_152_7
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562036", "story_v_out_324562.awb") ~= 0 then
					local var_152_10 = manager.audio:GetVoiceLength("story_v_out_324562", "324562036", "story_v_out_324562.awb") / 1000

					if var_152_10 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_4
					end

					if var_152_6.prefab_name ~= "" and arg_149_1.actors_[var_152_6.prefab_name] ~= nil then
						local var_152_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_6.prefab_name].transform, "story_v_out_324562", "324562036", "story_v_out_324562.awb")

						arg_149_1:RecordAudio("324562036", var_152_11)
						arg_149_1:RecordAudio("324562036", var_152_11)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_324562", "324562036", "story_v_out_324562.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_324562", "324562036", "story_v_out_324562.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_12 = math.max(var_152_5, arg_149_1.talkMaxDuration)

			if var_152_4 <= arg_149_1.time_ and arg_149_1.time_ < var_152_4 + var_152_12 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_4) / var_152_12

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_4 + var_152_12 and arg_149_1.time_ < var_152_4 + var_152_12 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play324562037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 324562037
		arg_153_1.duration_ = 1.7

		local var_153_0 = {
			zh = 1.333,
			ja = 1.7
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
				arg_153_0:Play324562038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1071ui_story"]) and arg_153_1.var_.characterEffect1071ui_story == nil then
				arg_153_1.var_.characterEffect1071ui_story = arg_153_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1071ui_story"]) then
				if arg_153_1.var_.characterEffect1071ui_story and not isNil(arg_153_1.actors_["1071ui_story"]) then
					arg_153_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1071ui_story"]) and arg_153_1.var_.characterEffect1071ui_story then
				arg_153_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_156_2 = arg_153_1.actors_["10164ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.characterEffect10164ui_story == nil then
				arg_153_1.var_.characterEffect10164ui_story = var_156_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_3 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_3 and not isNil(var_156_2) then
				if arg_153_1.var_.characterEffect10164ui_story and not isNil(var_156_2) then
					arg_153_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_153_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_3)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_3 and arg_153_1.time_ < 0 + var_156_3 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.characterEffect10164ui_story then
				arg_153_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_153_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			local var_156_4 = 0
			local var_156_5 = 0.15

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_6 = arg_153_1:GetWordFromCfg(324562037)
				local var_156_7 = arg_153_1:FormatText(var_156_6.content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 6 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 6)

				if (6 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 6)) > 0 and var_156_5 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562037", "story_v_out_324562.awb") ~= 0 then
					local var_156_10 = manager.audio:GetVoiceLength("story_v_out_324562", "324562037", "story_v_out_324562.awb") / 1000

					if var_156_10 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_4
					end

					if var_156_6.prefab_name ~= "" and arg_153_1.actors_[var_156_6.prefab_name] ~= nil then
						local var_156_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_6.prefab_name].transform, "story_v_out_324562", "324562037", "story_v_out_324562.awb")

						arg_153_1:RecordAudio("324562037", var_156_11)
						arg_153_1:RecordAudio("324562037", var_156_11)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_324562", "324562037", "story_v_out_324562.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_324562", "324562037", "story_v_out_324562.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_12 = math.max(var_156_5, arg_153_1.talkMaxDuration)

			if var_156_4 <= arg_153_1.time_ and arg_153_1.time_ < var_156_4 + var_156_12 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_4) / var_156_12

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_4 + var_156_12 and arg_153_1.time_ < var_156_4 + var_156_12 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play324562038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 324562038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play324562039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["1071ui_story"]) and arg_157_1.var_.characterEffect1071ui_story == nil then
				arg_157_1.var_.characterEffect1071ui_story = arg_157_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["1071ui_story"]) then
				if arg_157_1.var_.characterEffect1071ui_story and not isNil(arg_157_1.actors_["1071ui_story"]) then
					arg_157_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_0)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["1071ui_story"]) and arg_157_1.var_.characterEffect1071ui_story then
				arg_157_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 1.1 < arg_157_1.time_ and arg_157_1.time_ <= 1.1 + arg_160_0 then
				arg_157_1:AudioAction("play", "effect", "se_story_side_1039", "se_story_1039_drawer", "")
			end

			local var_160_2 = 0
			local var_160_3 = 1.6

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_2 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_4 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(324562038).content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_6 = 64 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_4) / 64)

				if (64 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_4) / 64)) > 0 and var_160_3 < var_160_6 then
					arg_157_1.talkMaxDuration = var_160_6

					if var_160_6 + var_160_2 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_6 + var_160_2
					end
				end

				arg_157_1.text_.text = var_160_4
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_3, arg_157_1.talkMaxDuration)

			if var_160_2 <= arg_157_1.time_ and arg_157_1.time_ < var_160_2 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_2) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_2 + var_160_7 and arg_157_1.time_ < var_160_2 + var_160_7 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play324562039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 324562039
		arg_161_1.duration_ = 16.6

		local var_161_0 = {
			zh = 11.266,
			ja = 16.6
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
				arg_161_0:Play324562040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["10164ui_story"]) and arg_161_1.var_.characterEffect10164ui_story == nil then
				arg_161_1.var_.characterEffect10164ui_story = arg_161_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_0 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["10164ui_story"]) then
				if arg_161_1.var_.characterEffect10164ui_story and not isNil(arg_161_1.actors_["10164ui_story"]) then
					arg_161_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["10164ui_story"]) and arg_161_1.var_.characterEffect10164ui_story then
				arg_161_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action8_2")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_164_2 = 0
			local var_164_3 = 0.975

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_2 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_4 = arg_161_1:GetWordFromCfg(324562039)
				local var_164_5 = arg_161_1:FormatText(var_164_4.content)

				arg_161_1.text_.text = var_164_5

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_7 = 39 <= 0 and var_164_3 or var_164_3 * (utf8.len(var_164_5) / 39)

				if (39 <= 0 and var_164_3 or var_164_3 * (utf8.len(var_164_5) / 39)) > 0 and var_164_3 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_2 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_2
					end
				end

				arg_161_1.text_.text = var_164_5
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562039", "story_v_out_324562.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_out_324562", "324562039", "story_v_out_324562.awb") / 1000

					if var_164_8 + var_164_2 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_2
					end

					if var_164_4.prefab_name ~= "" and arg_161_1.actors_[var_164_4.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_4.prefab_name].transform, "story_v_out_324562", "324562039", "story_v_out_324562.awb")

						arg_161_1:RecordAudio("324562039", var_164_9)
						arg_161_1:RecordAudio("324562039", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_324562", "324562039", "story_v_out_324562.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_324562", "324562039", "story_v_out_324562.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_10 = math.max(var_164_3, arg_161_1.talkMaxDuration)

			if var_164_2 <= arg_161_1.time_ and arg_161_1.time_ < var_164_2 + var_164_10 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_2) / var_164_10

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_2 + var_164_10 and arg_161_1.time_ < var_164_2 + var_164_10 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play324562040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 324562040
		arg_165_1.duration_ = 7.47

		local var_165_0 = {
			zh = 7.466,
			ja = 7.133
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
			arg_165_1.auto_ = false
		end

		function arg_165_1.playNext_(arg_167_0)
			arg_165_1.onStoryFinished_()
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.525

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:GetWordFromCfg(324562040)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 21 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 21)

				if (21 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 21)) > 0 and var_168_0 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + 0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562040", "story_v_out_324562.awb") ~= 0 then
					local var_168_5 = manager.audio:GetVoiceLength("story_v_out_324562", "324562040", "story_v_out_324562.awb") / 1000

					if var_168_5 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + 0
					end

					if var_168_1.prefab_name ~= "" and arg_165_1.actors_[var_168_1.prefab_name] ~= nil then
						local var_168_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_1.prefab_name].transform, "story_v_out_324562", "324562040", "story_v_out_324562.awb")

						arg_165_1:RecordAudio("324562040", var_168_6)
						arg_165_1:RecordAudio("324562040", var_168_6)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_324562", "324562040", "story_v_out_324562.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_324562", "324562040", "story_v_out_324562.awb")
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
	assets = {
		"TextureConfig/Background/J21f",
		"TextureConfig/Background/ST32"
	},
	voices = {
		"story_v_out_324562.awb"
	}
}
