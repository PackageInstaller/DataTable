return {
	Play321251001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321251001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play321251002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

			if arg_1_1.bgs_.MS2108 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS2108")
				var_4_0.name = "MS2108"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.MS2108 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.MS2108

				arg_1_1.bgs_.MS2108.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "MS2108" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			local var_4_9 = arg_1_1.bgs_.MS2108.transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPosMS2108 = var_4_9.localPosition
			end

			local var_4_10 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_10 then
				var_4_9.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosMS2108, Vector3.New(0, 1, 2), (arg_1_1.time_ - 0) / var_4_10)
			end

			if arg_1_1.time_ >= 0 + var_4_10 and arg_1_1.time_ < 0 + var_4_10 + arg_4_0 then
				var_4_9.localPosition = Vector3.New(0, 1, 2)
			end

			local var_4_11 = arg_1_1.bgs_.MS2108.transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPosMS2108 = var_4_11.localPosition
			end

			local var_4_12 = 5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_12 then
				var_4_11.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosMS2108, Vector3.New(0, 1, 2.5), (arg_1_1.time_ - 0) / var_4_12)
			end

			if arg_1_1.time_ >= 0 + var_4_12 and arg_1_1.time_ < 0 + var_4_12 + arg_4_0 then
				var_4_11.localPosition = Vector3.New(0, 1, 2.5)
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_13 = arg_1_1.var_.effectmamu1

				if not arg_1_1.var_.effectmamu1 then
					var_4_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavy_ui"), manager.ui.mainCamera.transform)
					var_4_13.name = "mamu1"
					arg_1_1.var_.effectmamu1 = var_4_13
				else
					var_4_13.transform:SetParent(var_4_9000)
				end

				var_4_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_13.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_4_15 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_4_16 = var_4_13.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_4_2, iter_4_3 in ipairs((var_4_16:ToTable())) do
					iter_4_3.transform.localScale = Vector3.New(iter_4_3.transform.localScale.x / var_4_15 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_4_16 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_4_3.transform.localScale.y / var_4_15, iter_4_3.transform.localScale.z)
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_20 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_20

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_20
						arg_1_1.bgmTxt2_.text = var_4_20
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

			if 0.533333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.533333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_osiris_room", "bgm_activity_4_0_story_osiris_room", "bgm_activity_4_0_story_osiris_room.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_4_0_story_osiris_room", "bgm_activity_4_0_story_osiris_room")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_23 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_23

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_23
						arg_1_1.bgmTxt2_.text = var_4_23
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

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drone05", "")
			end

			if 2.1 < arg_1_1.time_ and arg_1_1.time_ <= 2.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_clap01", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_26 = 2
			local var_4_27 = 0.625

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_28 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_28:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_29 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(321251001).content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 25 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_29) / 25)

				if (25 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_29) / 25)) > 0 and var_4_27 < var_4_31 then
					arg_1_1.talkMaxDuration = var_4_31
					var_4_26 = var_4_26 + 0.3

					if var_4_31 + var_4_26 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_26
					end
				end

				arg_1_1.text_.text = var_4_29
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_32 = var_4_26 + 0.3
			local var_4_33 = math.max(var_4_27, arg_1_1.talkMaxDuration)

			if var_4_26 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_32) / var_4_33

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play321251002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 321251002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play321251003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.95

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(321251002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 38 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 38)

				if (38 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 38)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play321251003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 321251003
		arg_13_1.duration_ = 3.5

		local var_13_0 = {
			zh = 1.866,
			ja = 3.5
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play321251004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.15

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:GetWordFromCfg(321251003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 6 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 6)

				if (6 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 6)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251003", "story_v_out_321251.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_321251", "321251003", "story_v_out_321251.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_321251", "321251003", "story_v_out_321251.awb")

						arg_13_1:RecordAudio("321251003", var_16_6)
						arg_13_1:RecordAudio("321251003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_321251", "321251003", "story_v_out_321251.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_321251", "321251003", "story_v_out_321251.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play321251004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 321251004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play321251005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "1011ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1011ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["1011ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["1011ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["1011ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_3) and arg_17_1.var_.characterEffect1011ui_story == nil then
				arg_17_1.var_.characterEffect1011ui_story = var_20_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_4 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 and not isNil(var_20_3) then
				if arg_17_1.var_.characterEffect1011ui_story and not isNil(var_20_3) then
					arg_17_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_4)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 and not isNil(var_20_3) and arg_17_1.var_.characterEffect1011ui_story then
				arg_17_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_20_5 = 0
			local var_20_6 = 1.3

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_7 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(321251004).content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 52 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_7) / 52)

				if (52 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_7) / 52)) > 0 and var_20_6 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_5
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_6, arg_17_1.talkMaxDuration)

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_5) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_5 + var_20_10 and arg_17_1.time_ < var_20_5 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play321251005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 321251005
		arg_21_1.duration_ = 9.6

		local var_21_0 = {
			zh = 8.066,
			ja = 9.6
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play321251006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1011ui_story"]) and arg_21_1.var_.characterEffect1011ui_story == nil then
				arg_21_1.var_.characterEffect1011ui_story = arg_21_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1011ui_story"]) then
				if arg_21_1.var_.characterEffect1011ui_story and not isNil(arg_21_1.actors_["1011ui_story"]) then
					arg_21_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1011ui_story"]) and arg_21_1.var_.characterEffect1011ui_story then
				arg_21_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_24_2 = 0
			local var_24_3 = 0.425

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:GetWordFromCfg(321251005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 18 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 18)

				if (18 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 18)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251005", "story_v_out_321251.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_321251", "321251005", "story_v_out_321251.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_321251", "321251005", "story_v_out_321251.awb")

						arg_21_1:RecordAudio("321251005", var_24_9)
						arg_21_1:RecordAudio("321251005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_321251", "321251005", "story_v_out_321251.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_321251", "321251005", "story_v_out_321251.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_10 and arg_21_1.time_ < var_24_2 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play321251006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 321251006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play321251007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1011ui_story"]) and arg_25_1.var_.characterEffect1011ui_story == nil then
				arg_25_1.var_.characterEffect1011ui_story = arg_25_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1011ui_story"]) then
				if arg_25_1.var_.characterEffect1011ui_story and not isNil(arg_25_1.actors_["1011ui_story"]) then
					arg_25_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1011ui_story"]) and arg_25_1.var_.characterEffect1011ui_story then
				arg_25_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_28_1 = 0
			local var_28_2 = 1.45

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(321251006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 58 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 58)

				if (58 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 58)) > 0 and var_28_2 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_6 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_6 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_6

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_6 and arg_25_1.time_ < var_28_1 + var_28_6 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play321251007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 321251007
		arg_29_1.duration_ = 9.57

		local var_29_0 = {
			zh = 7.5,
			ja = 9.566
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play321251008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1011ui_story"]) and arg_29_1.var_.characterEffect1011ui_story == nil then
				arg_29_1.var_.characterEffect1011ui_story = arg_29_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1011ui_story"]) then
				if arg_29_1.var_.characterEffect1011ui_story and not isNil(arg_29_1.actors_["1011ui_story"]) then
					arg_29_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1011ui_story"]) and arg_29_1.var_.characterEffect1011ui_story then
				arg_29_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_32_2 = 0
			local var_32_3 = 0.65

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_4 = arg_29_1:GetWordFromCfg(321251007)
				local var_32_5 = arg_29_1:FormatText(var_32_4.content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 26 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 26)

				if (26 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 26)) > 0 and var_32_3 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251007", "story_v_out_321251.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_321251", "321251007", "story_v_out_321251.awb") / 1000

					if var_32_8 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_2
					end

					if var_32_4.prefab_name ~= "" and arg_29_1.actors_[var_32_4.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_4.prefab_name].transform, "story_v_out_321251", "321251007", "story_v_out_321251.awb")

						arg_29_1:RecordAudio("321251007", var_32_9)
						arg_29_1:RecordAudio("321251007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_321251", "321251007", "story_v_out_321251.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_321251", "321251007", "story_v_out_321251.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_3, arg_29_1.talkMaxDuration)

			if var_32_2 <= arg_29_1.time_ and arg_29_1.time_ < var_32_2 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_2) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_2 + var_32_10 and arg_29_1.time_ < var_32_2 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play321251008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 321251008
		arg_33_1.duration_ = 3.97

		local var_33_0 = {
			zh = 3.966,
			ja = 3.1
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play321251009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.3

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:GetWordFromCfg(321251008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 12 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 12)

				if (12 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 12)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251008", "story_v_out_321251.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_321251", "321251008", "story_v_out_321251.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_321251", "321251008", "story_v_out_321251.awb")

						arg_33_1:RecordAudio("321251008", var_36_6)
						arg_33_1:RecordAudio("321251008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_321251", "321251008", "story_v_out_321251.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_321251", "321251008", "story_v_out_321251.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play321251009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 321251009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play321251010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1011ui_story"]) and arg_37_1.var_.characterEffect1011ui_story == nil then
				arg_37_1.var_.characterEffect1011ui_story = arg_37_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1011ui_story"]) then
				if arg_37_1.var_.characterEffect1011ui_story and not isNil(arg_37_1.actors_["1011ui_story"]) then
					arg_37_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1011ui_story"]) and arg_37_1.var_.characterEffect1011ui_story then
				arg_37_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.65

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(321251009).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 26 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 26)

				if (26 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 26)) > 0 and var_40_2 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_6 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_6 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_6

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_6 and arg_37_1.time_ < var_40_1 + var_40_6 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play321251010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 321251010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play321251011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 1.15

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(321251010).content)

				arg_41_1.text_.text = var_44_1

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_3 = 46 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 46)

				if (46 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 46)) > 0 and var_44_0 < var_44_3 then
					arg_41_1.talkMaxDuration = var_44_3

					if var_44_3 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_3 + 0
					end
				end

				arg_41_1.text_.text = var_44_1
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_4 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_4

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play321251011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 321251011
		arg_45_1.duration_ = 5.6

		local var_45_0 = {
			zh = 5.5,
			ja = 5.6
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
				arg_45_0:Play321251012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1011ui_story"]) and arg_45_1.var_.characterEffect1011ui_story == nil then
				arg_45_1.var_.characterEffect1011ui_story = arg_45_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1011ui_story"]) then
				if arg_45_1.var_.characterEffect1011ui_story and not isNil(arg_45_1.actors_["1011ui_story"]) then
					arg_45_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1011ui_story"]) and arg_45_1.var_.characterEffect1011ui_story then
				arg_45_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_48_2 = 0
			local var_48_3 = 0.475

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_4 = arg_45_1:GetWordFromCfg(321251011)
				local var_48_5 = arg_45_1:FormatText(var_48_4.content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 19 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 19)

				if (19 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 19)) > 0 and var_48_3 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251011", "story_v_out_321251.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_321251", "321251011", "story_v_out_321251.awb") / 1000

					if var_48_8 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_2
					end

					if var_48_4.prefab_name ~= "" and arg_45_1.actors_[var_48_4.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_4.prefab_name].transform, "story_v_out_321251", "321251011", "story_v_out_321251.awb")

						arg_45_1:RecordAudio("321251011", var_48_9)
						arg_45_1:RecordAudio("321251011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_321251", "321251011", "story_v_out_321251.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_321251", "321251011", "story_v_out_321251.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_3, arg_45_1.talkMaxDuration)

			if var_48_2 <= arg_45_1.time_ and arg_45_1.time_ < var_48_2 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_2) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_2 + var_48_10 and arg_45_1.time_ < var_48_2 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play321251012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 321251012
		arg_49_1.duration_ = 7.87

		local var_49_0 = {
			zh = 6.666,
			ja = 7.866
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
				arg_49_0:Play321251013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.475

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:GetWordFromCfg(321251012)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 19 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 19)

				if (19 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 19)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251012", "story_v_out_321251.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_321251", "321251012", "story_v_out_321251.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_321251", "321251012", "story_v_out_321251.awb")

						arg_49_1:RecordAudio("321251012", var_52_6)
						arg_49_1:RecordAudio("321251012", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_321251", "321251012", "story_v_out_321251.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_321251", "321251012", "story_v_out_321251.awb")
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
	Play321251013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 321251013
		arg_53_1.duration_ = 12.3

		local var_53_0 = {
			zh = 12.3,
			ja = 8.3
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
				arg_53_0:Play321251014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.975

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(321251013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 39 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 39)

				if (39 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 39)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251013", "story_v_out_321251.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_321251", "321251013", "story_v_out_321251.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_321251", "321251013", "story_v_out_321251.awb")

						arg_53_1:RecordAudio("321251013", var_56_6)
						arg_53_1:RecordAudio("321251013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_321251", "321251013", "story_v_out_321251.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_321251", "321251013", "story_v_out_321251.awb")
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
	Play321251014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 321251014
		arg_57_1.duration_ = 9.77

		local var_57_0 = {
			zh = 7.766,
			ja = 9.766
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
				arg_57_0:Play321251015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.625

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:GetWordFromCfg(321251014)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 25 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 25)

				if (25 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 25)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251014", "story_v_out_321251.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_321251", "321251014", "story_v_out_321251.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_321251", "321251014", "story_v_out_321251.awb")

						arg_57_1:RecordAudio("321251014", var_60_6)
						arg_57_1:RecordAudio("321251014", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_321251", "321251014", "story_v_out_321251.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_321251", "321251014", "story_v_out_321251.awb")
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
	Play321251015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 321251015
		arg_61_1.duration_ = 6.3

		local var_61_0 = {
			zh = 6.033,
			ja = 6.3
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
				arg_61_0:Play321251016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.6

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:GetWordFromCfg(321251015)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 24 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 24)

				if (24 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 24)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251015", "story_v_out_321251.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_321251", "321251015", "story_v_out_321251.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_321251", "321251015", "story_v_out_321251.awb")

						arg_61_1:RecordAudio("321251015", var_64_6)
						arg_61_1:RecordAudio("321251015", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_321251", "321251015", "story_v_out_321251.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_321251", "321251015", "story_v_out_321251.awb")
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
	Play321251016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 321251016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play321251017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1011ui_story"]) and arg_65_1.var_.characterEffect1011ui_story == nil then
				arg_65_1.var_.characterEffect1011ui_story = arg_65_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1011ui_story"]) then
				if arg_65_1.var_.characterEffect1011ui_story and not isNil(arg_65_1.actors_["1011ui_story"]) then
					arg_65_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_0)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1011ui_story"]) and arg_65_1.var_.characterEffect1011ui_story then
				arg_65_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_68_1 = 0
			local var_68_2 = 1.05

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(321251016).content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 42 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 42)

				if (42 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 42)) > 0 and var_68_2 < var_68_5 then
					arg_65_1.talkMaxDuration = var_68_5

					if var_68_5 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + var_68_1
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_6 = math.max(var_68_2, arg_65_1.talkMaxDuration)

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_6 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_1) / var_68_6

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_1 + var_68_6 and arg_65_1.time_ < var_68_1 + var_68_6 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play321251017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 321251017
		arg_69_1.duration_ = 5.09

		local var_69_0 = {
			zh = 4.69133333333333,
			ja = 5.09133333333333
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play321251018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if arg_69_1.bgs_.STblack == nil then
				local var_72_0 = Object.Instantiate(arg_69_1.paintGo_)

				var_72_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_72_0.name = "STblack"
				var_72_0.transform.parent = arg_69_1.stage_.transform
				var_72_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.bgs_.STblack = var_72_0
			end

			if 1.13333333333333 < arg_69_1.time_ and arg_69_1.time_ <= 1.13333333333333 + arg_72_0 then
				local var_72_1 = arg_69_1.bgs_.STblack

				arg_69_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_72_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_2 = var_72_1:GetComponent("SpriteRenderer")

				if var_72_2 and var_72_2.sprite then
					local var_72_3 = 2 * (var_72_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_72_1.transform.localScale = Vector3.New(var_72_3 / var_72_2.sprite.bounds.size.y < var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x and var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x or var_72_3 / var_72_2.sprite.bounds.size.y, var_72_3 / var_72_2.sprite.bounds.size.y < var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x and var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x or var_72_3 / var_72_2.sprite.bounds.size.y, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "STblack" then
						iter_72_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_72_4 = 2.96666666666667

			if 2.96666666666667 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.allBtn_.enabled = false
			end

			if arg_69_1.time_ >= var_72_4 + 0.3 and arg_69_1.time_ < var_72_4 + 0.3 + arg_72_0 then
				arg_69_1.allBtn_.enabled = true
			end

			local var_72_5 = 0

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_6 = 1.13333333333333

			if var_72_5 <= arg_69_1.time_ and arg_69_1.time_ < var_72_5 + var_72_6 then
				local var_72_7 = Color.New(0, 0, 0)

				var_72_7.a = Mathf.Lerp(0, 1, (arg_69_1.time_ - var_72_5) / var_72_6)
				arg_69_1.mask_.color = var_72_7
			end

			if arg_69_1.time_ >= var_72_5 + var_72_6 and arg_69_1.time_ < var_72_5 + var_72_6 + arg_72_0 then
				local var_72_8 = Color.New(0, 0, 0)

				var_72_8.a = 1
				arg_69_1.mask_.color = var_72_8
			end

			local var_72_9 = 1.13333333333333

			if 1.13333333333333 < arg_69_1.time_ and arg_69_1.time_ <= var_72_9 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_10 = 1.83333333333333

			if var_72_9 <= arg_69_1.time_ and arg_69_1.time_ < var_72_9 + var_72_10 then
				local var_72_11 = Color.New(0, 0, 0)

				var_72_11.a = Mathf.Lerp(1, 0, (arg_69_1.time_ - var_72_9) / var_72_10)
				arg_69_1.mask_.color = var_72_11
			end

			if arg_69_1.time_ >= var_72_9 + var_72_10 and arg_69_1.time_ < var_72_9 + var_72_10 + arg_72_0 then
				local var_72_12 = Color.New(0, 0, 0)

				arg_69_1.mask_.enabled = false
				var_72_12.a = 0
				arg_69_1.mask_.color = var_72_12
			end

			if 1.13333333333333 < arg_69_1.time_ and arg_69_1.time_ <= 1.13333333333333 + arg_72_0 then
				if arg_69_1.var_.effectmamu1 then
					Object.Destroy(arg_69_1.var_.effectmamu1)

					arg_69_1.var_.effectmamu1 = nil
				end
			end

			if 0.5 < arg_69_1.time_ and arg_69_1.time_ <= 0.5 + arg_72_0 then
				arg_69_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_drone05", "")
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_15 = 2.85833333333333
			local var_72_16 = 0.275

			if 2.85833333333333 < arg_69_1.time_ and arg_69_1.time_ <= var_72_15 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_17 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_17:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_18 = arg_69_1:GetWordFromCfg(321251017)
				local var_72_19 = arg_69_1:FormatText(var_72_18.content)

				arg_69_1.text_.text = var_72_19

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_21 = 11 <= 0 and var_72_16 or var_72_16 * (utf8.len(var_72_19) / 11)

				if (11 <= 0 and var_72_16 or var_72_16 * (utf8.len(var_72_19) / 11)) > 0 and var_72_16 < var_72_21 then
					arg_69_1.talkMaxDuration = var_72_21
					var_72_15 = var_72_15 + 0.3

					if var_72_21 + var_72_15 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_21 + var_72_15
					end
				end

				arg_69_1.text_.text = var_72_19
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251017", "story_v_out_321251.awb") ~= 0 then
					local var_72_22 = manager.audio:GetVoiceLength("story_v_out_321251", "321251017", "story_v_out_321251.awb") / 1000

					if var_72_22 + var_72_15 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_22 + var_72_15
					end

					if var_72_18.prefab_name ~= "" and arg_69_1.actors_[var_72_18.prefab_name] ~= nil then
						local var_72_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_18.prefab_name].transform, "story_v_out_321251", "321251017", "story_v_out_321251.awb")

						arg_69_1:RecordAudio("321251017", var_72_23)
						arg_69_1:RecordAudio("321251017", var_72_23)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_321251", "321251017", "story_v_out_321251.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_321251", "321251017", "story_v_out_321251.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_24 = var_72_15 + 0.3
			local var_72_25 = math.max(var_72_16, arg_69_1.talkMaxDuration)

			if var_72_15 + 0.3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_24 + var_72_25 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_24) / var_72_25

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_24 + var_72_25 and arg_69_1.time_ < var_72_24 + var_72_25 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play321251018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 321251018
		arg_75_1.duration_ = 3.03

		local var_75_0 = {
			zh = 2.4,
			ja = 3.033
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play321251019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.275

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:GetWordFromCfg(321251018)
				local var_78_2 = arg_75_1:FormatText(var_78_1.content)

				arg_75_1.text_.text = var_78_2

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_4 = 11 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 11)

				if (11 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 11)) > 0 and var_78_0 < var_78_4 then
					arg_75_1.talkMaxDuration = var_78_4

					if var_78_4 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_4 + 0
					end
				end

				arg_75_1.text_.text = var_78_2
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251018", "story_v_out_321251.awb") ~= 0 then
					local var_78_5 = manager.audio:GetVoiceLength("story_v_out_321251", "321251018", "story_v_out_321251.awb") / 1000

					if var_78_5 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + 0
					end

					if var_78_1.prefab_name ~= "" and arg_75_1.actors_[var_78_1.prefab_name] ~= nil then
						local var_78_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_1.prefab_name].transform, "story_v_out_321251", "321251018", "story_v_out_321251.awb")

						arg_75_1:RecordAudio("321251018", var_78_6)
						arg_75_1:RecordAudio("321251018", var_78_6)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_321251", "321251018", "story_v_out_321251.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_321251", "321251018", "story_v_out_321251.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_7 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_7 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_7

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_7 and arg_75_1.time_ < 0 + var_78_7 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play321251019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 321251019
		arg_79_1.duration_ = 5.13

		local var_79_0 = {
			zh = 3.466,
			ja = 5.133
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play321251020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.425

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_1 = arg_79_1:GetWordFromCfg(321251019)
				local var_82_2 = arg_79_1:FormatText(var_82_1.content)

				arg_79_1.text_.text = var_82_2

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_4 = 17 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_2) / 17)

				if (17 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_2) / 17)) > 0 and var_82_0 < var_82_4 then
					arg_79_1.talkMaxDuration = var_82_4

					if var_82_4 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_4 + 0
					end
				end

				arg_79_1.text_.text = var_82_2
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251019", "story_v_out_321251.awb") ~= 0 then
					local var_82_5 = manager.audio:GetVoiceLength("story_v_out_321251", "321251019", "story_v_out_321251.awb") / 1000

					if var_82_5 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + 0
					end

					if var_82_1.prefab_name ~= "" and arg_79_1.actors_[var_82_1.prefab_name] ~= nil then
						local var_82_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_1.prefab_name].transform, "story_v_out_321251", "321251019", "story_v_out_321251.awb")

						arg_79_1:RecordAudio("321251019", var_82_6)
						arg_79_1:RecordAudio("321251019", var_82_6)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_321251", "321251019", "story_v_out_321251.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_321251", "321251019", "story_v_out_321251.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_7 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_7 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_7

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_7 and arg_79_1.time_ < 0 + var_82_7 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play321251020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 321251020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play321251021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0.05

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_1 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(321251020).content)

				arg_83_1.text_.text = var_86_1

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_3 = 2 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 2)

				if (2 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 2)) > 0 and var_86_0 < var_86_3 then
					arg_83_1.talkMaxDuration = var_86_3

					if var_86_3 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_3 + 0
					end
				end

				arg_83_1.text_.text = var_86_1
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_4 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_4

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play321251021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 321251021
		arg_87_1.duration_ = 8.17

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play321251022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if arg_87_1.bgs_.Q01f == nil then
				local var_90_0 = Object.Instantiate(arg_87_1.paintGo_)

				var_90_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "Q01f")
				var_90_0.name = "Q01f"
				var_90_0.transform.parent = arg_87_1.stage_.transform
				var_90_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.bgs_.Q01f = var_90_0
			end

			if 1.499999999999 < arg_87_1.time_ and arg_87_1.time_ <= 1.499999999999 + arg_90_0 then
				local var_90_1 = arg_87_1.bgs_.Q01f

				arg_87_1.bgs_.Q01f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_90_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_90_2 = var_90_1:GetComponent("SpriteRenderer")

				if var_90_2 and var_90_2.sprite then
					local var_90_3 = 2 * (var_90_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_90_1.transform.localScale = Vector3.New(var_90_3 / var_90_2.sprite.bounds.size.y < var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x and var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x or var_90_3 / var_90_2.sprite.bounds.size.y, var_90_3 / var_90_2.sprite.bounds.size.y < var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x and var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x or var_90_3 / var_90_2.sprite.bounds.size.y, 0)
				end

				for iter_90_0, iter_90_1 in pairs(arg_87_1.bgs_) do
					if iter_90_0 ~= "Q01f" then
						iter_90_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_90_4 = 3.2

			if 3.2 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1.allBtn_.enabled = false
			end

			if arg_87_1.time_ >= var_90_4 + 0.3 and arg_87_1.time_ < var_90_4 + 0.3 + arg_90_0 then
				arg_87_1.allBtn_.enabled = true
			end

			local var_90_5 = 0

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_5 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_6 = 1.5

			if var_90_5 <= arg_87_1.time_ and arg_87_1.time_ < var_90_5 + var_90_6 then
				local var_90_7 = Color.New(0, 0, 0)

				var_90_7.a = Mathf.Lerp(0, 1, (arg_87_1.time_ - var_90_5) / var_90_6)
				arg_87_1.mask_.color = var_90_7
			end

			if arg_87_1.time_ >= var_90_5 + var_90_6 and arg_87_1.time_ < var_90_5 + var_90_6 + arg_90_0 then
				local var_90_8 = Color.New(0, 0, 0)

				var_90_8.a = 1
				arg_87_1.mask_.color = var_90_8
			end

			local var_90_9 = 1.5

			if 1.5 < arg_87_1.time_ and arg_87_1.time_ <= var_90_9 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_10 = 2

			if var_90_9 <= arg_87_1.time_ and arg_87_1.time_ < var_90_9 + var_90_10 then
				local var_90_11 = Color.New(0, 0, 0)

				var_90_11.a = Mathf.Lerp(1, 0, (arg_87_1.time_ - var_90_9) / var_90_10)
				arg_87_1.mask_.color = var_90_11
			end

			if arg_87_1.time_ >= var_90_9 + var_90_10 and arg_87_1.time_ < var_90_9 + var_90_10 + arg_90_0 then
				local var_90_12 = Color.New(0, 0, 0)

				arg_87_1.mask_.enabled = false
				var_90_12.a = 0
				arg_87_1.mask_.color = var_90_12
			end

			if arg_87_1.frameCnt_ <= 1 then
				arg_87_1.dialog_:SetActive(false)
			end

			local var_90_13 = 3.16666666666667
			local var_90_14 = 0.65

			if 3.16666666666667 < arg_87_1.time_ and arg_87_1.time_ <= var_90_13 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				arg_87_1.dialog_:SetActive(true)

				arg_87_1.dialogCg_.alpha = 0

				local var_90_15 = LeanTween.value(arg_87_1.dialog_, 0, 1, 0.3)

				var_90_15:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_87_1.dialogCg_.alpha = arg_91_0
				end))
				var_90_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_87_1.dialog_)
					var_90_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_87_1.duration_ = arg_87_1.duration_ + 0.3

				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_16 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(321251021).content)

				arg_87_1.text_.text = var_90_16

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_18 = 26 <= 0 and var_90_14 or var_90_14 * (utf8.len(var_90_16) / 26)

				if (26 <= 0 and var_90_14 or var_90_14 * (utf8.len(var_90_16) / 26)) > 0 and var_90_14 < var_90_18 then
					arg_87_1.talkMaxDuration = var_90_18
					var_90_13 = var_90_13 + 0.3

					if var_90_18 + var_90_13 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_18 + var_90_13
					end
				end

				arg_87_1.text_.text = var_90_16
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_19 = var_90_13 + 0.3
			local var_90_20 = math.max(var_90_14, arg_87_1.talkMaxDuration)

			if var_90_13 + 0.3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_19 + var_90_20 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_19) / var_90_20

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_19 + var_90_20 and arg_87_1.time_ < var_90_19 + var_90_20 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play321251022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 321251022
		arg_93_1.duration_ = 4

		local var_93_0 = {
			zh = 3.233,
			ja = 4
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
				arg_93_0:Play321251023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1011ui_story = arg_93_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1011ui_story"].transform.position).z)
				arg_93_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1011ui_story"].transform.localEulerAngles = arg_93_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_93_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1011ui_story"].transform.position).z)
				arg_93_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1011ui_story"].transform.localEulerAngles = arg_93_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["1011ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1011ui_story == nil then
				arg_93_1.var_.characterEffect1011ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect1011ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1011ui_story then
				arg_93_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_96_4 = 0
			local var_96_5 = 0.2

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(321251022)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 8 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 8)

				if (8 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 8)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251022", "story_v_out_321251.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_321251", "321251022", "story_v_out_321251.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_out_321251", "321251022", "story_v_out_321251.awb")

						arg_93_1:RecordAudio("321251022", var_96_11)
						arg_93_1:RecordAudio("321251022", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_321251", "321251022", "story_v_out_321251.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_321251", "321251022", "story_v_out_321251.awb")
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

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play321251023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 321251023
		arg_97_1.duration_ = 5.2

		local var_97_0 = {
			zh = 3.533,
			ja = 5.2
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play321251024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1011ui_story = arg_97_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1011ui_story"].transform.position).z)
				arg_97_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1011ui_story"].transform.localEulerAngles = arg_97_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_97_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1011ui_story"].transform.position).z)
				arg_97_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1011ui_story"].transform.localEulerAngles = arg_97_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_100_1 = 0
			local var_100_2 = 0.375

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:GetWordFromCfg(321251023)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_6 = 15 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_4) / 15)

				if (15 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_4) / 15)) > 0 and var_100_2 < var_100_6 then
					arg_97_1.talkMaxDuration = var_100_6

					if var_100_6 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251023", "story_v_out_321251.awb") ~= 0 then
					local var_100_7 = manager.audio:GetVoiceLength("story_v_out_321251", "321251023", "story_v_out_321251.awb") / 1000

					if var_100_7 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_1
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_321251", "321251023", "story_v_out_321251.awb")

						arg_97_1:RecordAudio("321251023", var_100_8)
						arg_97_1:RecordAudio("321251023", var_100_8)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_321251", "321251023", "story_v_out_321251.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_321251", "321251023", "story_v_out_321251.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_9 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_9 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_9

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_9 and arg_97_1.time_ < var_100_1 + var_100_9 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play321251024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 321251024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play321251025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1011ui_story"]) and arg_101_1.var_.characterEffect1011ui_story == nil then
				arg_101_1.var_.characterEffect1011ui_story = arg_101_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1011ui_story"]) then
				if arg_101_1.var_.characterEffect1011ui_story and not isNil(arg_101_1.actors_["1011ui_story"]) then
					arg_101_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1011ui_story"]) and arg_101_1.var_.characterEffect1011ui_story then
				arg_101_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 0.875

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(321251024).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 35 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 35)

				if (35 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 35)) > 0 and var_104_2 < var_104_5 then
					arg_101_1.talkMaxDuration = var_104_5

					if var_104_5 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + var_104_1
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_6 = math.max(var_104_2, arg_101_1.talkMaxDuration)

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_6 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_1) / var_104_6

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_1 + var_104_6 and arg_101_1.time_ < var_104_1 + var_104_6 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play321251025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 321251025
		arg_105_1.duration_ = 6.03

		local var_105_0 = {
			zh = 6.033,
			ja = 5.566
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
				arg_105_0:Play321251026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1011ui_story = arg_105_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1011ui_story"].transform.position).z)
				arg_105_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1011ui_story"].transform.localEulerAngles = arg_105_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_105_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1011ui_story"].transform.position).z)
				arg_105_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1011ui_story"].transform.localEulerAngles = arg_105_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["1011ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1011ui_story == nil then
				arg_105_1.var_.characterEffect1011ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect1011ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1011ui_story then
				arg_105_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_2")
			end

			if 0.034000001847744 < arg_105_1.time_ and arg_105_1.time_ <= 0.034000001847744 + arg_108_0 then
				arg_105_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva", "EmotionTimelineAnimator")
			end

			local var_108_4 = 0
			local var_108_5 = 0.375

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_6 = arg_105_1:GetWordFromCfg(321251025)
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

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251025", "story_v_out_321251.awb") ~= 0 then
					local var_108_10 = manager.audio:GetVoiceLength("story_v_out_321251", "321251025", "story_v_out_321251.awb") / 1000

					if var_108_10 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_4
					end

					if var_108_6.prefab_name ~= "" and arg_105_1.actors_[var_108_6.prefab_name] ~= nil then
						local var_108_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_6.prefab_name].transform, "story_v_out_321251", "321251025", "story_v_out_321251.awb")

						arg_105_1:RecordAudio("321251025", var_108_11)
						arg_105_1:RecordAudio("321251025", var_108_11)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_321251", "321251025", "story_v_out_321251.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_321251", "321251025", "story_v_out_321251.awb")
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

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play321251026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 321251026
		arg_109_1.duration_ = 3.57

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play321251027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 1.26666666666667 < arg_109_1.time_ and arg_109_1.time_ <= 1.26666666666667 + arg_112_0 then
				local var_112_0 = arg_109_1.bgs_.STblack

				arg_109_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_112_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_112_1 = var_112_0:GetComponent("SpriteRenderer")

				if var_112_1 and var_112_1.sprite then
					local var_112_2 = 2 * (var_112_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_112_0.transform.localScale = Vector3.New(var_112_2 / var_112_1.sprite.bounds.size.y < var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x and var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x or var_112_2 / var_112_1.sprite.bounds.size.y, var_112_2 / var_112_1.sprite.bounds.size.y < var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x and var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x or var_112_2 / var_112_1.sprite.bounds.size.y, 0)
				end

				for iter_112_0, iter_112_1 in pairs(arg_109_1.bgs_) do
					if iter_112_0 ~= "STblack" then
						iter_112_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_112_3 = 3.266666666666

			if 3.266666666666 < arg_109_1.time_ and arg_109_1.time_ <= var_112_3 + arg_112_0 then
				arg_109_1.allBtn_.enabled = false
			end

			if arg_109_1.time_ >= var_112_3 + 0.3 and arg_109_1.time_ < var_112_3 + 0.3 + arg_112_0 then
				arg_109_1.allBtn_.enabled = true
			end

			local var_112_4 = 0

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_5 = 1.26666666666667

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_5 then
				local var_112_6 = Color.New(0, 0, 0)

				var_112_6.a = Mathf.Lerp(0, 1, (arg_109_1.time_ - var_112_4) / var_112_5)
				arg_109_1.mask_.color = var_112_6
			end

			if arg_109_1.time_ >= var_112_4 + var_112_5 and arg_109_1.time_ < var_112_4 + var_112_5 + arg_112_0 then
				local var_112_7 = Color.New(0, 0, 0)

				var_112_7.a = 1
				arg_109_1.mask_.color = var_112_7
			end

			local var_112_8 = 1.26666666666667

			if 1.26666666666667 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_9 = 1.99999999999933

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_9 then
				local var_112_10 = Color.New(0, 0, 0)

				var_112_10.a = Mathf.Lerp(1, 0, (arg_109_1.time_ - var_112_8) / var_112_9)
				arg_109_1.mask_.color = var_112_10
			end

			if arg_109_1.time_ >= var_112_8 + var_112_9 and arg_109_1.time_ < var_112_8 + var_112_9 + arg_112_0 then
				local var_112_11 = Color.New(0, 0, 0)

				arg_109_1.mask_.enabled = false
				var_112_11.a = 0
				arg_109_1.mask_.color = var_112_11
			end

			local var_112_12 = arg_109_1.actors_["1011ui_story"].transform

			if 1.23333333333333 < arg_109_1.time_ and arg_109_1.time_ <= 1.23333333333333 + arg_112_0 then
				arg_109_1.var_.moveOldPos1011ui_story = var_112_12.localPosition
			end

			local var_112_13 = 0.001

			if 1.23333333333333 <= arg_109_1.time_ and arg_109_1.time_ < 1.23333333333333 + var_112_13 then
				var_112_12.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 1.23333333333333) / var_112_13)
				var_112_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_12.position).x, (manager.ui.mainCamera.transform.position - var_112_12.position).y, (manager.ui.mainCamera.transform.position - var_112_12.position).z)
				var_112_12.localEulerAngles.z = 0
				var_112_12.localEulerAngles.x = 0
				var_112_12.localEulerAngles = var_112_12.localEulerAngles
			end

			if arg_109_1.time_ >= 1.23333333333333 + var_112_13 and arg_109_1.time_ < 1.23333333333333 + var_112_13 + arg_112_0 then
				var_112_12.localPosition = Vector3.New(0, 100, 0)
				var_112_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_12.position).x, (manager.ui.mainCamera.transform.position - var_112_12.position).y, (manager.ui.mainCamera.transform.position - var_112_12.position).z)
				var_112_12.localEulerAngles.z = 0
				var_112_12.localEulerAngles.x = 0
				var_112_12.localEulerAngles = var_112_12.localEulerAngles
			end

			local var_112_14 = arg_109_1.actors_["1011ui_story"]

			if 1.23333333333333 < arg_109_1.time_ and arg_109_1.time_ <= 1.23333333333333 + arg_112_0 and not isNil(var_112_14) and arg_109_1.var_.characterEffect1011ui_story == nil then
				arg_109_1.var_.characterEffect1011ui_story = var_112_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_15 = 0.200000002980232

			if 1.23333333333333 <= arg_109_1.time_ and arg_109_1.time_ < 1.23333333333333 + var_112_15 and not isNil(var_112_14) then
				if arg_109_1.var_.characterEffect1011ui_story and not isNil(var_112_14) then
					arg_109_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 1.23333333333333) / var_112_15)
				end
			end

			if arg_109_1.time_ >= 1.23333333333333 + var_112_15 and arg_109_1.time_ < 1.23333333333333 + var_112_15 + arg_112_0 and not isNil(var_112_14) and arg_109_1.var_.characterEffect1011ui_story then
				arg_109_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 1.26666666666667 < arg_109_1.time_ and arg_109_1.time_ <= 1.26666666666667 + arg_112_0 then
				arg_109_1.fswbg_:SetActive(true)
				arg_109_1.dialog_:SetActive(false)

				arg_109_1.fswtw_.percent = 0
				arg_109_1.fswt_.text = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(321251026).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.fswt_)

				arg_109_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_109_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_109_1.fswtw_:SetDirty()

				arg_109_1.typewritterCharCountI18N = 0

				SetActive(arg_109_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_109_1:ShowNextGo(false)
			end

			local var_112_16 = 2.5

			if 2.5 < arg_109_1.time_ and arg_109_1.time_ <= var_112_16 + arg_112_0 then
				arg_109_1.var_.oldValueTypewriter = arg_109_1.fswtw_.percent

				SetActive(arg_109_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_109_1:ShowNextGo(false)
			end

			local var_112_17 = 5
			local var_112_18 = 0.333333333333333
			local var_112_19, var_112_20 = arg_109_1:GetPercentByPara(arg_109_1:FormatText(arg_109_1:GetWordFromCfg(321251026).content), 1)

			if var_112_16 < arg_109_1.time_ and arg_109_1.time_ <= var_112_16 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				local var_112_21 = var_112_17 <= 0 and var_112_18 or var_112_18 * ((var_112_20 - arg_109_1.typewritterCharCountI18N) / var_112_17)

				if (var_112_17 <= 0 and var_112_18 or var_112_18 * ((var_112_20 - arg_109_1.typewritterCharCountI18N) / var_112_17)) > 0 and var_112_18 < var_112_21 then
					arg_109_1.talkMaxDuration = var_112_21

					if var_112_21 + var_112_16 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_21 + var_112_16
					end
				end
			end

			local var_112_22 = math.max(0.333333333333333, arg_109_1.talkMaxDuration)

			if var_112_16 <= arg_109_1.time_ and arg_109_1.time_ < var_112_16 + var_112_22 then
				arg_109_1.fswtw_.percent = Mathf.Lerp(arg_109_1.var_.oldValueTypewriter, var_112_19, (arg_109_1.time_ - var_112_16) / var_112_22)
				arg_109_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_109_1.fswtw_:SetDirty()
			end

			if arg_109_1.time_ >= var_112_16 + var_112_22 and arg_109_1.time_ < var_112_16 + var_112_22 + arg_112_0 then
				arg_109_1.fswtw_.percent = var_112_19

				arg_109_1.fswtw_:SetDirty()
				arg_109_1:ShowNextGo(true)

				arg_109_1.typewritterCharCountI18N = var_112_20
			end

			if 1.23333333333333 < arg_109_1.time_ and arg_109_1.time_ <= 1.23333333333333 + arg_112_0 then
				local var_112_23 = arg_109_1.fswbg_.transform:Find("textbox/adapt/content") or arg_109_1.fswbg_.transform:Find("textbox/content")
				local var_112_24 = arg_109_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_112_25 = var_112_23:GetComponent("RectTransform")

				var_112_23:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_112_25.offsetMin = Vector2.New(0, 0)
				var_112_25.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.23333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play321251027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 321251027
		arg_113_1.duration_ = 1.6

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play321251028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.fswbg_:SetActive(true)
				arg_113_1.dialog_:SetActive(false)

				arg_113_1.fswtw_.percent = 0
				arg_113_1.fswt_.text = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(321251027).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.fswt_)

				arg_113_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_113_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_113_1.fswtw_:SetDirty()

				arg_113_1.typewritterCharCountI18N = 0

				SetActive(arg_113_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_113_1:ShowNextGo(false)
			end

			local var_116_0 = 1.2

			if 1.2 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.var_.oldValueTypewriter = arg_113_1.fswtw_.percent

				SetActive(arg_113_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_113_1:ShowNextGo(false)
			end

			local var_116_1 = 6
			local var_116_2 = 0.4
			local var_116_3, var_116_4 = arg_113_1:GetPercentByPara(arg_113_1:FormatText(arg_113_1:GetWordFromCfg(321251027).content), 1)

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				local var_116_5 = var_116_1 <= 0 and var_116_2 or var_116_2 * ((var_116_4 - arg_113_1.typewritterCharCountI18N) / var_116_1)

				if (var_116_1 <= 0 and var_116_2 or var_116_2 * ((var_116_4 - arg_113_1.typewritterCharCountI18N) / var_116_1)) > 0 and var_116_2 < var_116_5 then
					arg_113_1.talkMaxDuration = var_116_5

					if var_116_5 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + var_116_0
					end
				end
			end

			local var_116_6 = math.max(0.4, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_6 then
				arg_113_1.fswtw_.percent = Mathf.Lerp(arg_113_1.var_.oldValueTypewriter, var_116_3, (arg_113_1.time_ - var_116_0) / var_116_6)
				arg_113_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_113_1.fswtw_:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_6 and arg_113_1.time_ < var_116_0 + var_116_6 + arg_116_0 then
				arg_113_1.fswtw_.percent = var_116_3

				arg_113_1.fswtw_:SetDirty()
				arg_113_1:ShowNextGo(true)

				arg_113_1.typewritterCharCountI18N = var_116_4
			end

			local var_116_7 = 0

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_7 + arg_116_0 then
				arg_113_1.allBtn_.enabled = false
			end

			if arg_113_1.time_ >= var_116_7 + 1.2 and arg_113_1.time_ < var_116_7 + 1.2 + arg_116_0 then
				arg_113_1.allBtn_.enabled = true
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play321251028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 321251028
		arg_117_1.duration_ = 5.87

		local var_117_0 = {
			zh = 4.9996666696469,
			ja = 5.8666666696469
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
				arg_117_0:Play321251029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 1.33333333333333 < arg_117_1.time_ and arg_117_1.time_ <= 1.33333333333333 + arg_120_0 then
				local var_120_0 = arg_117_1.bgs_.Q01f

				arg_117_1.bgs_.Q01f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_120_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_120_1 = var_120_0:GetComponent("SpriteRenderer")

				if var_120_1 and var_120_1.sprite then
					local var_120_2 = 2 * (var_120_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_120_0.transform.localScale = Vector3.New(var_120_2 / var_120_1.sprite.bounds.size.y < var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x and var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x or var_120_2 / var_120_1.sprite.bounds.size.y, var_120_2 / var_120_1.sprite.bounds.size.y < var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x and var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x or var_120_2 / var_120_1.sprite.bounds.size.y, 0)
				end

				for iter_120_0, iter_120_1 in pairs(arg_117_1.bgs_) do
					if iter_120_0 ~= "Q01f" then
						iter_120_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_120_3 = 3.2666666696469

			if 3.2666666696469 < arg_117_1.time_ and arg_117_1.time_ <= var_120_3 + arg_120_0 then
				arg_117_1.allBtn_.enabled = false
			end

			if arg_117_1.time_ >= var_120_3 + 0.3 and arg_117_1.time_ < var_120_3 + 0.3 + arg_120_0 then
				arg_117_1.allBtn_.enabled = true
			end

			local var_120_4 = 0

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_5 = 1.33333333333333

			if var_120_4 <= arg_117_1.time_ and arg_117_1.time_ < var_120_4 + var_120_5 then
				local var_120_6 = Color.New(0, 0, 0)

				var_120_6.a = Mathf.Lerp(0, 1, (arg_117_1.time_ - var_120_4) / var_120_5)
				arg_117_1.mask_.color = var_120_6
			end

			if arg_117_1.time_ >= var_120_4 + var_120_5 and arg_117_1.time_ < var_120_4 + var_120_5 + arg_120_0 then
				local var_120_7 = Color.New(0, 0, 0)

				var_120_7.a = 1
				arg_117_1.mask_.color = var_120_7
			end

			local var_120_8 = 1.33333333333333

			if 1.33333333333333 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_9 = 2

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_9 then
				local var_120_10 = Color.New(0, 0, 0)

				var_120_10.a = Mathf.Lerp(1, 0, (arg_117_1.time_ - var_120_8) / var_120_9)
				arg_117_1.mask_.color = var_120_10
			end

			if arg_117_1.time_ >= var_120_8 + var_120_9 and arg_117_1.time_ < var_120_8 + var_120_9 + arg_120_0 then
				local var_120_11 = Color.New(0, 0, 0)

				arg_117_1.mask_.enabled = false
				var_120_11.a = 0
				arg_117_1.mask_.color = var_120_11
			end

			if 1.33333333333333 < arg_117_1.time_ and arg_117_1.time_ <= 1.33333333333333 + arg_120_0 then
				arg_117_1.fswbg_:SetActive(false)
				arg_117_1.dialog_:SetActive(false)
				SetActive(arg_117_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_117_1:ShowNextGo(false)
			end

			if 1.35 < arg_117_1.time_ and arg_117_1.time_ <= 1.35 + arg_120_0 then
				arg_117_1.fswbg_:SetActive(false)
				arg_117_1.dialog_:SetActive(false)
				SetActive(arg_117_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_117_1:ShowNextGo(false)
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_12 = 3.2666666696469
			local var_120_13 = 0.15

			if 3.2666666696469 < arg_117_1.time_ and arg_117_1.time_ <= var_120_12 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_14 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_14:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_15 = arg_117_1:GetWordFromCfg(321251028)
				local var_120_16 = arg_117_1:FormatText(var_120_15.content)

				arg_117_1.text_.text = var_120_16

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_18 = 6 <= 0 and var_120_13 or var_120_13 * (utf8.len(var_120_16) / 6)

				if (6 <= 0 and var_120_13 or var_120_13 * (utf8.len(var_120_16) / 6)) > 0 and var_120_13 < var_120_18 then
					arg_117_1.talkMaxDuration = var_120_18
					var_120_12 = var_120_12 + 0.3

					if var_120_18 + var_120_12 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_18 + var_120_12
					end
				end

				arg_117_1.text_.text = var_120_16
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251028", "story_v_out_321251.awb") ~= 0 then
					local var_120_19 = manager.audio:GetVoiceLength("story_v_out_321251", "321251028", "story_v_out_321251.awb") / 1000

					if var_120_19 + var_120_12 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_19 + var_120_12
					end

					if var_120_15.prefab_name ~= "" and arg_117_1.actors_[var_120_15.prefab_name] ~= nil then
						local var_120_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_15.prefab_name].transform, "story_v_out_321251", "321251028", "story_v_out_321251.awb")

						arg_117_1:RecordAudio("321251028", var_120_20)
						arg_117_1:RecordAudio("321251028", var_120_20)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_321251", "321251028", "story_v_out_321251.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_321251", "321251028", "story_v_out_321251.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_21 = var_120_12 + 0.3
			local var_120_22 = math.max(var_120_13, arg_117_1.talkMaxDuration)

			if var_120_12 + 0.3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_21 + var_120_22 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_21) / var_120_22

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_21 + var_120_22 and arg_117_1.time_ < var_120_21 + var_120_22 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play321251029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 321251029
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play321251030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1011ui_story = arg_123_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1011ui_story"].transform.position).z)
				arg_123_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1011ui_story"].transform.localEulerAngles = arg_123_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1011ui_story"].transform.position).z)
				arg_123_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1011ui_story"].transform.localEulerAngles = arg_123_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_126_1 = arg_123_1.actors_["1011ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1011ui_story == nil then
				arg_123_1.var_.characterEffect1011ui_story = var_126_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_2 and not isNil(var_126_1) then
				if arg_123_1.var_.characterEffect1011ui_story and not isNil(var_126_1) then
					arg_123_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_2)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_2 and arg_123_1.time_ < 0 + var_126_2 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1011ui_story then
				arg_123_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_126_3 = 0
			local var_126_4 = 1.025

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_3 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_5 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(321251029).content)

				arg_123_1.text_.text = var_126_5

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_7 = 41 <= 0 and var_126_4 or var_126_4 * (utf8.len(var_126_5) / 41)

				if (41 <= 0 and var_126_4 or var_126_4 * (utf8.len(var_126_5) / 41)) > 0 and var_126_4 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_3 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_3
					end
				end

				arg_123_1.text_.text = var_126_5
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_8 = math.max(var_126_4, arg_123_1.talkMaxDuration)

			if var_126_3 <= arg_123_1.time_ and arg_123_1.time_ < var_126_3 + var_126_8 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_3) / var_126_8

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_3 + var_126_8 and arg_123_1.time_ < var_126_3 + var_126_8 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play321251030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 321251030
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play321251031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 1 < arg_127_1.time_ and arg_127_1.time_ <= 1 + arg_130_0 then
				arg_127_1:AudioAction("play", "effect", "se_story_140", "se_story_140_water", "")
			end

			local var_130_1 = 0
			local var_130_2 = 1.075

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_3 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(321251030).content)

				arg_127_1.text_.text = var_130_3

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 43 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_3) / 43)

				if (43 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_3) / 43)) > 0 and var_130_2 < var_130_5 then
					arg_127_1.talkMaxDuration = var_130_5

					if var_130_5 + var_130_1 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + var_130_1
					end
				end

				arg_127_1.text_.text = var_130_3
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_6 = math.max(var_130_2, arg_127_1.talkMaxDuration)

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_6 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_1) / var_130_6

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_1 + var_130_6 and arg_127_1.time_ < var_130_1 + var_130_6 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play321251031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 321251031
		arg_131_1.duration_ = 4.83

		local var_131_0 = {
			zh = 2.1,
			ja = 4.833
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
				arg_131_0:Play321251032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1011ui_story = arg_131_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1011ui_story"].transform.position).z)
				arg_131_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1011ui_story"].transform.localEulerAngles = arg_131_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_131_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1011ui_story"].transform.position).z)
				arg_131_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1011ui_story"].transform.localEulerAngles = arg_131_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["1011ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1011ui_story == nil then
				arg_131_1.var_.characterEffect1011ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect1011ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1011ui_story then
				arg_131_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_134_4 = 0
			local var_134_5 = 0.2

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_6 = arg_131_1:GetWordFromCfg(321251031)
				local var_134_7 = arg_131_1:FormatText(var_134_6.content)

				arg_131_1.text_.text = var_134_7

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_9 = 8 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 8)

				if (8 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 8)) > 0 and var_134_5 < var_134_9 then
					arg_131_1.talkMaxDuration = var_134_9

					if var_134_9 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_9 + var_134_4
					end
				end

				arg_131_1.text_.text = var_134_7
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251031", "story_v_out_321251.awb") ~= 0 then
					local var_134_10 = manager.audio:GetVoiceLength("story_v_out_321251", "321251031", "story_v_out_321251.awb") / 1000

					if var_134_10 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_4
					end

					if var_134_6.prefab_name ~= "" and arg_131_1.actors_[var_134_6.prefab_name] ~= nil then
						local var_134_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_6.prefab_name].transform, "story_v_out_321251", "321251031", "story_v_out_321251.awb")

						arg_131_1:RecordAudio("321251031", var_134_11)
						arg_131_1:RecordAudio("321251031", var_134_11)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_321251", "321251031", "story_v_out_321251.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_321251", "321251031", "story_v_out_321251.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_12 = math.max(var_134_5, arg_131_1.talkMaxDuration)

			if var_134_4 <= arg_131_1.time_ and arg_131_1.time_ < var_134_4 + var_134_12 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_4) / var_134_12

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_4 + var_134_12 and arg_131_1.time_ < var_134_4 + var_134_12 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play321251032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 321251032
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play321251033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1011ui_story"]) and arg_135_1.var_.characterEffect1011ui_story == nil then
				arg_135_1.var_.characterEffect1011ui_story = arg_135_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1011ui_story"]) then
				if arg_135_1.var_.characterEffect1011ui_story and not isNil(arg_135_1.actors_["1011ui_story"]) then
					arg_135_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_0)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1011ui_story"]) and arg_135_1.var_.characterEffect1011ui_story then
				arg_135_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_138_1 = 0
			local var_138_2 = 1.275

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_3 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(321251032).content)

				arg_135_1.text_.text = var_138_3

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 51 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 51)

				if (51 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 51)) > 0 and var_138_2 < var_138_5 then
					arg_135_1.talkMaxDuration = var_138_5

					if var_138_5 + var_138_1 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + var_138_1
					end
				end

				arg_135_1.text_.text = var_138_3
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_6 = math.max(var_138_2, arg_135_1.talkMaxDuration)

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_6 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_1) / var_138_6

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_1 + var_138_6 and arg_135_1.time_ < var_138_1 + var_138_6 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play321251033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 321251033
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play321251034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0.725

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_1 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(321251033).content)

				arg_139_1.text_.text = var_142_1

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_3 = 29 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 29)

				if (29 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 29)) > 0 and var_142_0 < var_142_3 then
					arg_139_1.talkMaxDuration = var_142_3

					if var_142_3 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_3 + 0
					end
				end

				arg_139_1.text_.text = var_142_1
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_4 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_4

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play321251034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 321251034
		arg_143_1.duration_ = 7.27

		local var_143_0 = {
			zh = 5.833,
			ja = 7.266
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play321251035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1011ui_story = arg_143_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1011ui_story"].transform.position).z)
				arg_143_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1011ui_story"].transform.localEulerAngles = arg_143_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_143_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1011ui_story"].transform.position).z)
				arg_143_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1011ui_story"].transform.localEulerAngles = arg_143_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_146_1 = arg_143_1.actors_["1011ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1011ui_story == nil then
				arg_143_1.var_.characterEffect1011ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect1011ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1011ui_story then
				arg_143_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_2", "EmotionTimelineAnimator")
			end

			local var_146_4 = 0
			local var_146_5 = 0.55

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_6 = arg_143_1:GetWordFromCfg(321251034)
				local var_146_7 = arg_143_1:FormatText(var_146_6.content)

				arg_143_1.text_.text = var_146_7

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_9 = 22 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 22)

				if (22 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 22)) > 0 and var_146_5 < var_146_9 then
					arg_143_1.talkMaxDuration = var_146_9

					if var_146_9 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_4
					end
				end

				arg_143_1.text_.text = var_146_7
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251034", "story_v_out_321251.awb") ~= 0 then
					local var_146_10 = manager.audio:GetVoiceLength("story_v_out_321251", "321251034", "story_v_out_321251.awb") / 1000

					if var_146_10 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_4
					end

					if var_146_6.prefab_name ~= "" and arg_143_1.actors_[var_146_6.prefab_name] ~= nil then
						local var_146_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_6.prefab_name].transform, "story_v_out_321251", "321251034", "story_v_out_321251.awb")

						arg_143_1:RecordAudio("321251034", var_146_11)
						arg_143_1:RecordAudio("321251034", var_146_11)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_321251", "321251034", "story_v_out_321251.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_321251", "321251034", "story_v_out_321251.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_12 = math.max(var_146_5, arg_143_1.talkMaxDuration)

			if var_146_4 <= arg_143_1.time_ and arg_143_1.time_ < var_146_4 + var_146_12 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_4) / var_146_12

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_4 + var_146_12 and arg_143_1.time_ < var_146_4 + var_146_12 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play321251035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 321251035
		arg_147_1.duration_ = 4.63

		local var_147_0 = {
			zh = 3.333,
			ja = 4.633
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play321251036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["1011ui_story"]) and arg_147_1.var_.characterEffect1011ui_story == nil then
				arg_147_1.var_.characterEffect1011ui_story = arg_147_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["1011ui_story"]) then
				if arg_147_1.var_.characterEffect1011ui_story and not isNil(arg_147_1.actors_["1011ui_story"]) then
					arg_147_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_0)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["1011ui_story"]) and arg_147_1.var_.characterEffect1011ui_story then
				arg_147_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_150_1 = 0
			local var_150_2 = 0.3

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[1186].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_3 = arg_147_1:GetWordFromCfg(321251035)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_6 = 12 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_4) / 12)

				if (12 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_4) / 12)) > 0 and var_150_2 < var_150_6 then
					arg_147_1.talkMaxDuration = var_150_6

					if var_150_6 + var_150_1 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_6 + var_150_1
					end
				end

				arg_147_1.text_.text = var_150_4
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251035", "story_v_out_321251.awb") ~= 0 then
					local var_150_7 = manager.audio:GetVoiceLength("story_v_out_321251", "321251035", "story_v_out_321251.awb") / 1000

					if var_150_7 + var_150_1 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_1
					end

					if var_150_3.prefab_name ~= "" and arg_147_1.actors_[var_150_3.prefab_name] ~= nil then
						local var_150_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_3.prefab_name].transform, "story_v_out_321251", "321251035", "story_v_out_321251.awb")

						arg_147_1:RecordAudio("321251035", var_150_8)
						arg_147_1:RecordAudio("321251035", var_150_8)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_321251", "321251035", "story_v_out_321251.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_321251", "321251035", "story_v_out_321251.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_9 = math.max(var_150_2, arg_147_1.talkMaxDuration)

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_9 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_1) / var_150_9

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_1 + var_150_9 and arg_147_1.time_ < var_150_1 + var_150_9 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play321251036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 321251036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play321251037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1011ui_story = arg_151_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1011ui_story"].transform.position).z)
				arg_151_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1011ui_story"].transform.localEulerAngles = arg_151_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_151_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1011ui_story"].transform.position).z)
				arg_151_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1011ui_story"].transform.localEulerAngles = arg_151_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_154_1 = 0
			local var_154_2 = 0.6

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_3 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(321251036).content)

				arg_151_1.text_.text = var_154_3

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 24 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 24)

				if (24 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 24)) > 0 and var_154_2 < var_154_5 then
					arg_151_1.talkMaxDuration = var_154_5

					if var_154_5 + var_154_1 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + var_154_1
					end
				end

				arg_151_1.text_.text = var_154_3
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_6 = math.max(var_154_2, arg_151_1.talkMaxDuration)

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_6 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_1) / var_154_6

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_1 + var_154_6 and arg_151_1.time_ < var_154_1 + var_154_6 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play321251037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 321251037
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play321251038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 1.45

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_1 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(321251037).content)

				arg_155_1.text_.text = var_158_1

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_3 = 58 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 58)

				if (58 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 58)) > 0 and var_158_0 < var_158_3 then
					arg_155_1.talkMaxDuration = var_158_3

					if var_158_3 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_3 + 0
					end
				end

				arg_155_1.text_.text = var_158_1
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_4 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_4

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play321251038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 321251038
		arg_159_1.duration_ = 8.23

		local var_159_0 = {
			zh = 6.766,
			ja = 8.233
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play321251039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				local var_162_0 = arg_159_1.var_.effectCHIDUN1

				if not arg_159_1.var_.effectCHIDUN1 then
					var_162_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_162_0.name = "CHIDUN1"
					arg_159_1.var_.effectCHIDUN1 = var_162_0
				else
					var_162_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_162_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_162_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_162_2 = 0

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_2 + arg_162_0 then
				arg_159_1.allBtn_.enabled = false
			end

			if arg_159_1.time_ >= var_162_2 + 1 and arg_159_1.time_ < var_162_2 + 1 + arg_162_0 then
				arg_159_1.allBtn_.enabled = true
			end

			if arg_159_1.frameCnt_ <= 1 then
				arg_159_1.dialog_:SetActive(false)
			end

			local var_162_3 = 0.5
			local var_162_4 = 0.625

			if 0.5 < arg_159_1.time_ and arg_159_1.time_ <= var_162_3 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0

				arg_159_1.dialog_:SetActive(true)

				arg_159_1.dialogCg_.alpha = 0

				local var_162_5 = LeanTween.value(arg_159_1.dialog_, 0, 1, 0.3)

				var_162_5:setOnUpdate(LuaHelper.FloatAction(function(arg_163_0)
					arg_159_1.dialogCg_.alpha = arg_163_0
				end))
				var_162_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_159_1.dialog_)
					var_162_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_159_1.duration_ = arg_159_1.duration_ + 0.3

				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[1186].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_6 = arg_159_1:GetWordFromCfg(321251038)
				local var_162_7 = arg_159_1:FormatText(var_162_6.content)

				arg_159_1.text_.text = var_162_7

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_9 = 25 <= 0 and var_162_4 or var_162_4 * (utf8.len(var_162_7) / 25)

				if (25 <= 0 and var_162_4 or var_162_4 * (utf8.len(var_162_7) / 25)) > 0 and var_162_4 < var_162_9 then
					arg_159_1.talkMaxDuration = var_162_9
					var_162_3 = var_162_3 + 0.3

					if var_162_9 + var_162_3 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_3
					end
				end

				arg_159_1.text_.text = var_162_7
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251038", "story_v_out_321251.awb") ~= 0 then
					local var_162_10 = manager.audio:GetVoiceLength("story_v_out_321251", "321251038", "story_v_out_321251.awb") / 1000

					if var_162_10 + var_162_3 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_3
					end

					if var_162_6.prefab_name ~= "" and arg_159_1.actors_[var_162_6.prefab_name] ~= nil then
						local var_162_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_6.prefab_name].transform, "story_v_out_321251", "321251038", "story_v_out_321251.awb")

						arg_159_1:RecordAudio("321251038", var_162_11)
						arg_159_1:RecordAudio("321251038", var_162_11)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_321251", "321251038", "story_v_out_321251.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_321251", "321251038", "story_v_out_321251.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_12 = var_162_3 + 0.3
			local var_162_13 = math.max(var_162_4, arg_159_1.talkMaxDuration)

			if var_162_3 + 0.3 <= arg_159_1.time_ and arg_159_1.time_ < var_162_12 + var_162_13 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_12) / var_162_13

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_12 + var_162_13 and arg_159_1.time_ < var_162_12 + var_162_13 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play321251039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 321251039
		arg_165_1.duration_ = 11.67

		local var_165_0 = {
			zh = 7.633,
			ja = 11.666
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
				arg_165_0:Play321251040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.9

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[1186].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_1 = arg_165_1:GetWordFromCfg(321251039)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 36 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 36)

				if (36 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 36)) > 0 and var_168_0 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + 0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251039", "story_v_out_321251.awb") ~= 0 then
					local var_168_5 = manager.audio:GetVoiceLength("story_v_out_321251", "321251039", "story_v_out_321251.awb") / 1000

					if var_168_5 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + 0
					end

					if var_168_1.prefab_name ~= "" and arg_165_1.actors_[var_168_1.prefab_name] ~= nil then
						local var_168_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_1.prefab_name].transform, "story_v_out_321251", "321251039", "story_v_out_321251.awb")

						arg_165_1:RecordAudio("321251039", var_168_6)
						arg_165_1:RecordAudio("321251039", var_168_6)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_321251", "321251039", "story_v_out_321251.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_321251", "321251039", "story_v_out_321251.awb")
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
	Play321251040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 321251040
		arg_169_1.duration_ = 11.8

		local var_169_0 = {
			zh = 6.666,
			ja = 11.8
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
				arg_169_0:Play321251041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.8

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[1186].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_1 = arg_169_1:GetWordFromCfg(321251040)
				local var_172_2 = arg_169_1:FormatText(var_172_1.content)

				arg_169_1.text_.text = var_172_2

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 32 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 32)

				if (32 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 32)) > 0 and var_172_0 < var_172_4 then
					arg_169_1.talkMaxDuration = var_172_4

					if var_172_4 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_4 + 0
					end
				end

				arg_169_1.text_.text = var_172_2
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251040", "story_v_out_321251.awb") ~= 0 then
					local var_172_5 = manager.audio:GetVoiceLength("story_v_out_321251", "321251040", "story_v_out_321251.awb") / 1000

					if var_172_5 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + 0
					end

					if var_172_1.prefab_name ~= "" and arg_169_1.actors_[var_172_1.prefab_name] ~= nil then
						local var_172_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_1.prefab_name].transform, "story_v_out_321251", "321251040", "story_v_out_321251.awb")

						arg_169_1:RecordAudio("321251040", var_172_6)
						arg_169_1:RecordAudio("321251040", var_172_6)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_321251", "321251040", "story_v_out_321251.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_321251", "321251040", "story_v_out_321251.awb")
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
	Play321251041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 321251041
		arg_173_1.duration_ = 14.8

		local var_173_0 = {
			zh = 9.433,
			ja = 14.8
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
				arg_173_0:Play321251042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 1.025

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[1186].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_1 = arg_173_1:GetWordFromCfg(321251041)
				local var_176_2 = arg_173_1:FormatText(var_176_1.content)

				arg_173_1.text_.text = var_176_2

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 41 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 41)

				if (41 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 41)) > 0 and var_176_0 < var_176_4 then
					arg_173_1.talkMaxDuration = var_176_4

					if var_176_4 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_4 + 0
					end
				end

				arg_173_1.text_.text = var_176_2
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251041", "story_v_out_321251.awb") ~= 0 then
					local var_176_5 = manager.audio:GetVoiceLength("story_v_out_321251", "321251041", "story_v_out_321251.awb") / 1000

					if var_176_5 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + 0
					end

					if var_176_1.prefab_name ~= "" and arg_173_1.actors_[var_176_1.prefab_name] ~= nil then
						local var_176_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_1.prefab_name].transform, "story_v_out_321251", "321251041", "story_v_out_321251.awb")

						arg_173_1:RecordAudio("321251041", var_176_6)
						arg_173_1:RecordAudio("321251041", var_176_6)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_321251", "321251041", "story_v_out_321251.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_321251", "321251041", "story_v_out_321251.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_7 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_7

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play321251042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 321251042
		arg_177_1.duration_ = 7.3

		local var_177_0 = {
			zh = 7.3,
			ja = 5.633
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
				arg_177_0:Play321251043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.75

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1186].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_1 = arg_177_1:GetWordFromCfg(321251042)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.text_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 30 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 30)

				if (30 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 30)) > 0 and var_180_0 < var_180_4 then
					arg_177_1.talkMaxDuration = var_180_4

					if var_180_4 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_4 + 0
					end
				end

				arg_177_1.text_.text = var_180_2
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251042", "story_v_out_321251.awb") ~= 0 then
					local var_180_5 = manager.audio:GetVoiceLength("story_v_out_321251", "321251042", "story_v_out_321251.awb") / 1000

					if var_180_5 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + 0
					end

					if var_180_1.prefab_name ~= "" and arg_177_1.actors_[var_180_1.prefab_name] ~= nil then
						local var_180_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_1.prefab_name].transform, "story_v_out_321251", "321251042", "story_v_out_321251.awb")

						arg_177_1:RecordAudio("321251042", var_180_6)
						arg_177_1:RecordAudio("321251042", var_180_6)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_321251", "321251042", "story_v_out_321251.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_321251", "321251042", "story_v_out_321251.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play321251043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 321251043
		arg_181_1.duration_ = 14.63

		local var_181_0 = {
			zh = 6.1,
			ja = 14.633
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
				arg_181_0:Play321251044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.7

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[1186].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_1 = arg_181_1:GetWordFromCfg(321251043)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.text_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 28 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 28)

				if (28 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 28)) > 0 and var_184_0 < var_184_4 then
					arg_181_1.talkMaxDuration = var_184_4

					if var_184_4 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_4 + 0
					end
				end

				arg_181_1.text_.text = var_184_2
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251043", "story_v_out_321251.awb") ~= 0 then
					local var_184_5 = manager.audio:GetVoiceLength("story_v_out_321251", "321251043", "story_v_out_321251.awb") / 1000

					if var_184_5 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + 0
					end

					if var_184_1.prefab_name ~= "" and arg_181_1.actors_[var_184_1.prefab_name] ~= nil then
						local var_184_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_1.prefab_name].transform, "story_v_out_321251", "321251043", "story_v_out_321251.awb")

						arg_181_1:RecordAudio("321251043", var_184_6)
						arg_181_1:RecordAudio("321251043", var_184_6)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_321251", "321251043", "story_v_out_321251.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_321251", "321251043", "story_v_out_321251.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play321251044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 321251044
		arg_185_1.duration_ = 1.53

		local var_185_0 = {
			zh = 1.533,
			ja = 1.366
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
				arg_185_0:Play321251045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.1

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[1186].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_1 = arg_185_1:GetWordFromCfg(321251044)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 4 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 4)

				if (4 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 4)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251044", "story_v_out_321251.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_out_321251", "321251044", "story_v_out_321251.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_out_321251", "321251044", "story_v_out_321251.awb")

						arg_185_1:RecordAudio("321251044", var_188_6)
						arg_185_1:RecordAudio("321251044", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_321251", "321251044", "story_v_out_321251.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_321251", "321251044", "story_v_out_321251.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play321251045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 321251045
		arg_189_1.duration_ = 11.67

		local var_189_0 = {
			zh = 11.633,
			ja = 11.666
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
				arg_189_0:Play321251046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if arg_189_1.bgs_.L05j == nil then
				local var_192_0 = Object.Instantiate(arg_189_1.paintGo_)

				var_192_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L05j")
				var_192_0.name = "L05j"
				var_192_0.transform.parent = arg_189_1.stage_.transform
				var_192_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_189_1.bgs_.L05j = var_192_0
			end

			if 1.999999999999 < arg_189_1.time_ and arg_189_1.time_ <= 1.999999999999 + arg_192_0 then
				local var_192_1 = arg_189_1.bgs_.L05j

				arg_189_1.bgs_.L05j.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_192_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_192_2 = var_192_1:GetComponent("SpriteRenderer")

				if var_192_2 and var_192_2.sprite then
					local var_192_3 = 2 * (var_192_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_192_1.transform.localScale = Vector3.New(var_192_3 / var_192_2.sprite.bounds.size.y < var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x and var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x or var_192_3 / var_192_2.sprite.bounds.size.y, var_192_3 / var_192_2.sprite.bounds.size.y < var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x and var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x or var_192_3 / var_192_2.sprite.bounds.size.y, 0)
				end

				for iter_192_0, iter_192_1 in pairs(arg_189_1.bgs_) do
					if iter_192_0 ~= "L05j" then
						iter_192_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_192_4 = 3.999999999999

			if 3.999999999999 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.allBtn_.enabled = false
			end

			if arg_189_1.time_ >= var_192_4 + 0.3 and arg_189_1.time_ < var_192_4 + 0.3 + arg_192_0 then
				arg_189_1.allBtn_.enabled = true
			end

			local var_192_5 = 0

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_5 + arg_192_0 then
				arg_189_1.mask_.enabled = true
				arg_189_1.mask_.raycastTarget = true

				arg_189_1:SetGaussion(false)
			end

			local var_192_6 = 2

			if var_192_5 <= arg_189_1.time_ and arg_189_1.time_ < var_192_5 + var_192_6 then
				local var_192_7 = Color.New(0, 0, 0)

				var_192_7.a = Mathf.Lerp(0, 1, (arg_189_1.time_ - var_192_5) / var_192_6)
				arg_189_1.mask_.color = var_192_7
			end

			if arg_189_1.time_ >= var_192_5 + var_192_6 and arg_189_1.time_ < var_192_5 + var_192_6 + arg_192_0 then
				local var_192_8 = Color.New(0, 0, 0)

				var_192_8.a = 1
				arg_189_1.mask_.color = var_192_8
			end

			local var_192_9 = 2

			if 2 < arg_189_1.time_ and arg_189_1.time_ <= var_192_9 + arg_192_0 then
				arg_189_1.mask_.enabled = true
				arg_189_1.mask_.raycastTarget = true

				arg_189_1:SetGaussion(false)
			end

			local var_192_10 = 2

			if var_192_9 <= arg_189_1.time_ and arg_189_1.time_ < var_192_9 + var_192_10 then
				local var_192_11 = Color.New(0, 0, 0)

				var_192_11.a = Mathf.Lerp(1, 0, (arg_189_1.time_ - var_192_9) / var_192_10)
				arg_189_1.mask_.color = var_192_11
			end

			if arg_189_1.time_ >= var_192_9 + var_192_10 and arg_189_1.time_ < var_192_9 + var_192_10 + arg_192_0 then
				local var_192_12 = Color.New(0, 0, 0)

				arg_189_1.mask_.enabled = false
				var_192_12.a = 0
				arg_189_1.mask_.color = var_192_12
			end

			local var_192_13 = "1111ui_story"

			if arg_189_1.actors_["1111ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1111ui_story"))) then
				local var_192_14 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_189_1.stage_.transform)

				var_192_14.name = var_192_13
				var_192_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_189_1.actors_[var_192_13] = var_192_14

				local var_192_15 = var_192_14:GetComponentInChildren(typeof(CharacterEffect))

				var_192_15.enabled = true

				local var_192_16 = GameObjectTools.GetOrAddComponent(var_192_14, typeof(DynamicBoneHelper))

				if var_192_16 then
					var_192_16:EnableDynamicBone(false)
				end

				arg_189_1:ShowWeapon(var_192_15.transform, false)

				arg_189_1.var_[var_192_13 .. "Animator"] = var_192_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_189_1.var_[var_192_13 .. "Animator"].applyRootMotion = true
				arg_189_1.var_[var_192_13 .. "LipSync"] = var_192_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_192_17 = arg_189_1.actors_["1111ui_story"].transform

			if 3.7 < arg_189_1.time_ and arg_189_1.time_ <= 3.7 + arg_192_0 then
				arg_189_1.var_.moveOldPos1111ui_story = var_192_17.localPosition
			end

			local var_192_18 = 0.001

			if 3.7 <= arg_189_1.time_ and arg_189_1.time_ < 3.7 + var_192_18 then
				var_192_17.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_189_1.time_ - 3.7) / var_192_18)
				var_192_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_17.position).x, (manager.ui.mainCamera.transform.position - var_192_17.position).y, (manager.ui.mainCamera.transform.position - var_192_17.position).z)
				var_192_17.localEulerAngles.z = 0
				var_192_17.localEulerAngles.x = 0
				var_192_17.localEulerAngles = var_192_17.localEulerAngles
			end

			if arg_189_1.time_ >= 3.7 + var_192_18 and arg_189_1.time_ < 3.7 + var_192_18 + arg_192_0 then
				var_192_17.localPosition = Vector3.New(0, -0.87, -5.7)
				var_192_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_17.position).x, (manager.ui.mainCamera.transform.position - var_192_17.position).y, (manager.ui.mainCamera.transform.position - var_192_17.position).z)
				var_192_17.localEulerAngles.z = 0
				var_192_17.localEulerAngles.x = 0
				var_192_17.localEulerAngles = var_192_17.localEulerAngles
			end

			local var_192_19 = arg_189_1.actors_["1111ui_story"]

			if 3.7 < arg_189_1.time_ and arg_189_1.time_ <= 3.7 + arg_192_0 and not isNil(var_192_19) and arg_189_1.var_.characterEffect1111ui_story == nil then
				arg_189_1.var_.characterEffect1111ui_story = var_192_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_20 = 0.200000002980232

			if 3.7 <= arg_189_1.time_ and arg_189_1.time_ < 3.7 + var_192_20 and not isNil(var_192_19) then
				if arg_189_1.var_.characterEffect1111ui_story and not isNil(var_192_19) then
					arg_189_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 3.7 + var_192_20 and arg_189_1.time_ < 3.7 + var_192_20 + arg_192_0 and not isNil(var_192_19) and arg_189_1.var_.characterEffect1111ui_story then
				arg_189_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 3.7 < arg_189_1.time_ and arg_189_1.time_ <= 3.7 + arg_192_0 then
				arg_189_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 3.7 < arg_189_1.time_ and arg_189_1.time_ <= 3.7 + arg_192_0 then
				arg_189_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_192_22 = 1.999999999999

			arg_189_1.isInRecall_ = false

			if var_192_22 < arg_189_1.time_ and arg_189_1.time_ <= var_192_22 + arg_192_0 then
				arg_189_1.screenFilterGo_:SetActive(true)

				arg_189_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_192_2, iter_192_3 in pairs(arg_189_1.actors_) do
					for iter_192_4, iter_192_5 in ipairs((iter_192_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_192_5.color = iter_192_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_192_23 = 0.0166666666666667

			if var_192_22 <= arg_189_1.time_ and arg_189_1.time_ < var_192_22 + var_192_23 then
				arg_189_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_189_1.time_ - var_192_22) / var_192_23)
			end

			if arg_189_1.time_ >= var_192_22 + var_192_23 and arg_189_1.time_ < var_192_22 + var_192_23 + arg_192_0 then
				arg_189_1.screenFilterEffect_.weight = 1
			end

			if arg_189_1.frameCnt_ <= 1 then
				arg_189_1.dialog_:SetActive(false)
			end

			local var_192_24 = 4
			local var_192_25 = 0.875

			if 4 < arg_189_1.time_ and arg_189_1.time_ <= var_192_24 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0

				arg_189_1.dialog_:SetActive(true)

				arg_189_1.dialogCg_.alpha = 0

				local var_192_26 = LeanTween.value(arg_189_1.dialog_, 0, 1, 0.3)

				var_192_26:setOnUpdate(LuaHelper.FloatAction(function(arg_193_0)
					arg_189_1.dialogCg_.alpha = arg_193_0
				end))
				var_192_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_189_1.dialog_)
					var_192_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_189_1.duration_ = arg_189_1.duration_ + 0.3

				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_27 = arg_189_1:GetWordFromCfg(321251045)
				local var_192_28 = arg_189_1:FormatText(var_192_27.content)

				arg_189_1.text_.text = var_192_28

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_30 = 35 <= 0 and var_192_25 or var_192_25 * (utf8.len(var_192_28) / 35)

				if (35 <= 0 and var_192_25 or var_192_25 * (utf8.len(var_192_28) / 35)) > 0 and var_192_25 < var_192_30 then
					arg_189_1.talkMaxDuration = var_192_30
					var_192_24 = var_192_24 + 0.3

					if var_192_30 + var_192_24 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_30 + var_192_24
					end
				end

				arg_189_1.text_.text = var_192_28
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251045", "story_v_out_321251.awb") ~= 0 then
					local var_192_31 = manager.audio:GetVoiceLength("story_v_out_321251", "321251045", "story_v_out_321251.awb") / 1000

					if var_192_31 + var_192_24 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_31 + var_192_24
					end

					if var_192_27.prefab_name ~= "" and arg_189_1.actors_[var_192_27.prefab_name] ~= nil then
						local var_192_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_27.prefab_name].transform, "story_v_out_321251", "321251045", "story_v_out_321251.awb")

						arg_189_1:RecordAudio("321251045", var_192_32)
						arg_189_1:RecordAudio("321251045", var_192_32)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_321251", "321251045", "story_v_out_321251.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_321251", "321251045", "story_v_out_321251.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_33 = var_192_24 + 0.3
			local var_192_34 = math.max(var_192_25, arg_189_1.talkMaxDuration)

			if var_192_24 + 0.3 <= arg_189_1.time_ and arg_189_1.time_ < var_192_33 + var_192_34 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_33) / var_192_34

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_33 + var_192_34 and arg_189_1.time_ < var_192_33 + var_192_34 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play321251046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 321251046
		arg_195_1.duration_ = 11.13

		local var_195_0 = {
			zh = 11.133,
			ja = 9.6
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play321251047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 1.35

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_1 = arg_195_1:GetWordFromCfg(321251046)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 54 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 54)

				if (54 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 54)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251046", "story_v_out_321251.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_out_321251", "321251046", "story_v_out_321251.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_out_321251", "321251046", "story_v_out_321251.awb")

						arg_195_1:RecordAudio("321251046", var_198_6)
						arg_195_1:RecordAudio("321251046", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_321251", "321251046", "story_v_out_321251.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_321251", "321251046", "story_v_out_321251.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play321251047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 321251047
		arg_199_1.duration_ = 9.07

		local var_199_0 = {
			zh = 7.8,
			ja = 9.066
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play321251048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1111ui_story = arg_199_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_202_0 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 then
				arg_199_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_199_1.time_ - 0) / var_202_0)
				arg_199_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1111ui_story"].transform.position).z)
				arg_199_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1111ui_story"].transform.localEulerAngles = arg_199_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 then
				arg_199_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_199_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1111ui_story"].transform.position).z)
				arg_199_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1111ui_story"].transform.localEulerAngles = arg_199_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			local var_202_1 = 0
			local var_202_2 = 0.925

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_3 = arg_199_1:GetWordFromCfg(321251047)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_6 = 37 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_4) / 37)

				if (37 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_4) / 37)) > 0 and var_202_2 < var_202_6 then
					arg_199_1.talkMaxDuration = var_202_6

					if var_202_6 + var_202_1 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_6 + var_202_1
					end
				end

				arg_199_1.text_.text = var_202_4
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251047", "story_v_out_321251.awb") ~= 0 then
					local var_202_7 = manager.audio:GetVoiceLength("story_v_out_321251", "321251047", "story_v_out_321251.awb") / 1000

					if var_202_7 + var_202_1 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_1
					end

					if var_202_3.prefab_name ~= "" and arg_199_1.actors_[var_202_3.prefab_name] ~= nil then
						local var_202_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_3.prefab_name].transform, "story_v_out_321251", "321251047", "story_v_out_321251.awb")

						arg_199_1:RecordAudio("321251047", var_202_8)
						arg_199_1:RecordAudio("321251047", var_202_8)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_321251", "321251047", "story_v_out_321251.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_321251", "321251047", "story_v_out_321251.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_9 = math.max(var_202_2, arg_199_1.talkMaxDuration)

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_9 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_1) / var_202_9

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_1 + var_202_9 and arg_199_1.time_ < var_202_1 + var_202_9 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play321251048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 321251048
		arg_203_1.duration_ = 10.89

		local var_203_0 = {
			zh = 8.824333333332,
			ja = 10.891333333332
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play321251049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_9001
			local var_206_9000

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				local var_206_0 = arg_203_1.bgs_.L05j

				arg_203_1.bgs_.L05j.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_206_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_206_1 = var_206_0:GetComponent("SpriteRenderer")

				if var_206_1 and var_206_1.sprite then
					local var_206_2 = 2 * (var_206_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_206_0.transform.localScale = Vector3.New(var_206_2 / var_206_1.sprite.bounds.size.y < var_206_2 * manager.ui.mainCameraCom_.aspect / var_206_1.sprite.bounds.size.x and var_206_2 * manager.ui.mainCameraCom_.aspect / var_206_1.sprite.bounds.size.x or var_206_2 / var_206_1.sprite.bounds.size.y, var_206_2 / var_206_1.sprite.bounds.size.y < var_206_2 * manager.ui.mainCameraCom_.aspect / var_206_1.sprite.bounds.size.x and var_206_2 * manager.ui.mainCameraCom_.aspect / var_206_1.sprite.bounds.size.x or var_206_2 / var_206_1.sprite.bounds.size.y, 0)
				end

				for iter_206_0, iter_206_1 in pairs(arg_203_1.bgs_) do
					if iter_206_0 ~= "L05j" then
						iter_206_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_206_3 = "STwhite"

			if arg_203_1.bgs_.STwhite == nil then
				local var_206_4 = Object.Instantiate(arg_203_1.paintGo_)

				var_206_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_206_3)
				var_206_4.name = var_206_3
				var_206_4.transform.parent = arg_203_1.stage_.transform
				var_206_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_203_1.bgs_[var_206_3] = var_206_4
			end

			if 1.5 < arg_203_1.time_ and arg_203_1.time_ <= 1.5 + arg_206_0 then
				local var_206_5 = arg_203_1.bgs_.STwhite

				arg_203_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_206_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_206_6 = var_206_5:GetComponent("SpriteRenderer")

				if var_206_6 and var_206_6.sprite then
					local var_206_7 = 2 * (var_206_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_206_5.transform.localScale = Vector3.New(var_206_7 / var_206_6.sprite.bounds.size.y < var_206_7 * manager.ui.mainCameraCom_.aspect / var_206_6.sprite.bounds.size.x and var_206_7 * manager.ui.mainCameraCom_.aspect / var_206_6.sprite.bounds.size.x or var_206_7 / var_206_6.sprite.bounds.size.y, var_206_7 / var_206_6.sprite.bounds.size.y < var_206_7 * manager.ui.mainCameraCom_.aspect / var_206_6.sprite.bounds.size.x and var_206_7 * manager.ui.mainCameraCom_.aspect / var_206_6.sprite.bounds.size.x or var_206_7 / var_206_6.sprite.bounds.size.y, 0)
				end

				for iter_206_2, iter_206_3 in pairs(arg_203_1.bgs_) do
					if iter_206_2 ~= "STwhite" then
						iter_206_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_206_8 = 3

			if 3 < arg_203_1.time_ and arg_203_1.time_ <= var_206_8 + arg_206_0 then
				arg_203_1.allBtn_.enabled = false
			end

			if arg_203_1.time_ >= var_206_8 + 0.3 and arg_203_1.time_ < var_206_8 + 0.3 + arg_206_0 then
				arg_203_1.allBtn_.enabled = true
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				local var_206_9 = arg_203_1.var_.effecthuiyisha1

				if not arg_203_1.var_.effecthuiyisha1 then
					var_206_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), manager.ui.mainCamera.transform)
					var_206_9.name = "huiyisha1"
					arg_203_1.var_.effecthuiyisha1 = var_206_9
				else
					var_206_9.transform:SetParent(var_206_9001)
				end

				var_206_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_206_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.5 < arg_203_1.time_ and arg_203_1.time_ <= 1.5 + arg_206_0 then
				if arg_203_1.var_.effecthuiyisha1 then
					Object.Destroy(arg_203_1.var_.effecthuiyisha1)

					arg_203_1.var_.effecthuiyisha1 = nil
				end
			end

			local var_206_12 = arg_203_1.actors_["1111ui_story"].transform

			if 1.16666666666667 < arg_203_1.time_ and arg_203_1.time_ <= 1.16666666666667 + arg_206_0 then
				arg_203_1.var_.moveOldPos1111ui_story = var_206_12.localPosition
			end

			local var_206_13 = 0.001

			if 1.16666666666667 <= arg_203_1.time_ and arg_203_1.time_ < 1.16666666666667 + var_206_13 then
				var_206_12.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_203_1.time_ - 1.16666666666667) / var_206_13)
				var_206_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_12.position).x, (manager.ui.mainCamera.transform.position - var_206_12.position).y, (manager.ui.mainCamera.transform.position - var_206_12.position).z)
				var_206_12.localEulerAngles.z = 0
				var_206_12.localEulerAngles.x = 0
				var_206_12.localEulerAngles = var_206_12.localEulerAngles
			end

			if arg_203_1.time_ >= 1.16666666666667 + var_206_13 and arg_203_1.time_ < 1.16666666666667 + var_206_13 + arg_206_0 then
				var_206_12.localPosition = Vector3.New(0, 100, 0)
				var_206_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_12.position).x, (manager.ui.mainCamera.transform.position - var_206_12.position).y, (manager.ui.mainCamera.transform.position - var_206_12.position).z)
				var_206_12.localEulerAngles.z = 0
				var_206_12.localEulerAngles.x = 0
				var_206_12.localEulerAngles = var_206_12.localEulerAngles
			end

			if 1.5 < arg_203_1.time_ and arg_203_1.time_ <= 1.5 + arg_206_0 then
				local var_206_14 = arg_203_1.var_.effecthuiyisha2

				if not arg_203_1.var_.effecthuiyisha2 then
					var_206_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), manager.ui.mainCamera.transform)
					var_206_14.name = "huiyisha2"
					arg_203_1.var_.effecthuiyisha2 = var_206_14
				else
					var_206_14.transform:SetParent(var_206_9000)
				end

				var_206_14.transform.localPosition = Vector3.New(0, 0, 0)
				var_206_14.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 3 < arg_203_1.time_ and arg_203_1.time_ <= 3 + arg_206_0 then
				if arg_203_1.var_.effecthuiyisha2 then
					Object.Destroy(arg_203_1.var_.effecthuiyisha2)

					arg_203_1.var_.effecthuiyisha2 = nil
				end
			end

			local var_206_17 = 1.5

			arg_203_1.isInRecall_ = false

			if var_206_17 < arg_203_1.time_ and arg_203_1.time_ <= var_206_17 + arg_206_0 then
				arg_203_1.screenFilterGo_:SetActive(false)

				for iter_206_4, iter_206_5 in pairs(arg_203_1.actors_) do
					for iter_206_6, iter_206_7 in ipairs((iter_206_5:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_206_7.color = iter_206_7.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_206_18 = 0.0166666666666667

			if var_206_17 <= arg_203_1.time_ and arg_203_1.time_ < var_206_17 + var_206_18 then
				arg_203_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_203_1.time_ - var_206_17) / var_206_18)
			end

			if arg_203_1.time_ >= var_206_17 + var_206_18 and arg_203_1.time_ < var_206_17 + var_206_18 + arg_206_0 then
				arg_203_1.screenFilterEffect_.weight = 0
			end

			local var_206_19 = 0

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_19 + arg_206_0 then
				arg_203_1.allBtn_.enabled = false
			end

			if arg_203_1.time_ >= var_206_19 + 3.95833333333333 and arg_203_1.time_ < var_206_19 + 3.95833333333333 + arg_206_0 then
				arg_203_1.allBtn_.enabled = true
			end

			if arg_203_1.frameCnt_ <= 1 then
				arg_203_1.dialog_:SetActive(false)
			end

			local var_206_20 = 3.958333333332
			local var_206_21 = 0.525

			if 3.958333333332 < arg_203_1.time_ and arg_203_1.time_ <= var_206_20 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				arg_203_1.dialog_:SetActive(true)

				arg_203_1.dialogCg_.alpha = 0

				local var_206_22 = LeanTween.value(arg_203_1.dialog_, 0, 1, 0.3)

				var_206_22:setOnUpdate(LuaHelper.FloatAction(function(arg_207_0)
					arg_203_1.dialogCg_.alpha = arg_207_0
				end))
				var_206_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_203_1.dialog_)
					var_206_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_203_1.duration_ = arg_203_1.duration_ + 0.3

				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_23 = arg_203_1:GetWordFromCfg(321251048)
				local var_206_24 = arg_203_1:FormatText(var_206_23.content)

				arg_203_1.text_.text = var_206_24

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_26 = 21 <= 0 and var_206_21 or var_206_21 * (utf8.len(var_206_24) / 21)

				if (21 <= 0 and var_206_21 or var_206_21 * (utf8.len(var_206_24) / 21)) > 0 and var_206_21 < var_206_26 then
					arg_203_1.talkMaxDuration = var_206_26
					var_206_20 = var_206_20 + 0.3

					if var_206_26 + var_206_20 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_26 + var_206_20
					end
				end

				arg_203_1.text_.text = var_206_24
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251048", "story_v_out_321251.awb") ~= 0 then
					local var_206_27 = manager.audio:GetVoiceLength("story_v_out_321251", "321251048", "story_v_out_321251.awb") / 1000

					if var_206_27 + var_206_20 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_27 + var_206_20
					end

					if var_206_23.prefab_name ~= "" and arg_203_1.actors_[var_206_23.prefab_name] ~= nil then
						local var_206_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_23.prefab_name].transform, "story_v_out_321251", "321251048", "story_v_out_321251.awb")

						arg_203_1:RecordAudio("321251048", var_206_28)
						arg_203_1:RecordAudio("321251048", var_206_28)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_321251", "321251048", "story_v_out_321251.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_321251", "321251048", "story_v_out_321251.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_29 = var_206_20 + 0.3
			local var_206_30 = math.max(var_206_21, arg_203_1.talkMaxDuration)

			if var_206_20 + 0.3 <= arg_203_1.time_ and arg_203_1.time_ < var_206_29 + var_206_30 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_29) / var_206_30

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_29 + var_206_30 and arg_203_1.time_ < var_206_29 + var_206_30 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.16666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play321251049 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 321251049
		arg_209_1.duration_ = 15.1

		local var_209_0 = {
			zh = 9.833,
			ja = 15.1
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play321251050(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 1.025

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_1 = arg_209_1:GetWordFromCfg(321251049)
				local var_212_2 = arg_209_1:FormatText(var_212_1.content)

				arg_209_1.text_.text = var_212_2

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_4 = 41 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 41)

				if (41 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 41)) > 0 and var_212_0 < var_212_4 then
					arg_209_1.talkMaxDuration = var_212_4

					if var_212_4 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_4 + 0
					end
				end

				arg_209_1.text_.text = var_212_2
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251049", "story_v_out_321251.awb") ~= 0 then
					local var_212_5 = manager.audio:GetVoiceLength("story_v_out_321251", "321251049", "story_v_out_321251.awb") / 1000

					if var_212_5 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + 0
					end

					if var_212_1.prefab_name ~= "" and arg_209_1.actors_[var_212_1.prefab_name] ~= nil then
						local var_212_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_1.prefab_name].transform, "story_v_out_321251", "321251049", "story_v_out_321251.awb")

						arg_209_1:RecordAudio("321251049", var_212_6)
						arg_209_1:RecordAudio("321251049", var_212_6)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_321251", "321251049", "story_v_out_321251.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_321251", "321251049", "story_v_out_321251.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_7 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_7 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_7

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_7 and arg_209_1.time_ < 0 + var_212_7 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play321251050 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 321251050
		arg_213_1.duration_ = 7.1

		local var_213_0 = {
			zh = 5.5,
			ja = 7.1
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play321251051(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.65

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_1 = arg_213_1:GetWordFromCfg(321251050)
				local var_216_2 = arg_213_1:FormatText(var_216_1.content)

				arg_213_1.text_.text = var_216_2

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 26 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 26)

				if (26 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 26)) > 0 and var_216_0 < var_216_4 then
					arg_213_1.talkMaxDuration = var_216_4

					if var_216_4 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_4 + 0
					end
				end

				arg_213_1.text_.text = var_216_2
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251050", "story_v_out_321251.awb") ~= 0 then
					local var_216_5 = manager.audio:GetVoiceLength("story_v_out_321251", "321251050", "story_v_out_321251.awb") / 1000

					if var_216_5 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + 0
					end

					if var_216_1.prefab_name ~= "" and arg_213_1.actors_[var_216_1.prefab_name] ~= nil then
						local var_216_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_1.prefab_name].transform, "story_v_out_321251", "321251050", "story_v_out_321251.awb")

						arg_213_1:RecordAudio("321251050", var_216_6)
						arg_213_1:RecordAudio("321251050", var_216_6)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_321251", "321251050", "story_v_out_321251.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_321251", "321251050", "story_v_out_321251.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play321251051 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 321251051
		arg_217_1.duration_ = 8.8

		local var_217_0 = {
			zh = 8.499999999999,
			ja = 8.799999999999
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play321251052(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 1.999999999999 < arg_217_1.time_ and arg_217_1.time_ <= 1.999999999999 + arg_220_0 then
				local var_220_0 = arg_217_1.bgs_.Q01f

				arg_217_1.bgs_.Q01f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_220_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_220_1 = var_220_0:GetComponent("SpriteRenderer")

				if var_220_1 and var_220_1.sprite then
					local var_220_2 = 2 * (var_220_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_220_0.transform.localScale = Vector3.New(var_220_2 / var_220_1.sprite.bounds.size.y < var_220_2 * manager.ui.mainCameraCom_.aspect / var_220_1.sprite.bounds.size.x and var_220_2 * manager.ui.mainCameraCom_.aspect / var_220_1.sprite.bounds.size.x or var_220_2 / var_220_1.sprite.bounds.size.y, var_220_2 / var_220_1.sprite.bounds.size.y < var_220_2 * manager.ui.mainCameraCom_.aspect / var_220_1.sprite.bounds.size.x and var_220_2 * manager.ui.mainCameraCom_.aspect / var_220_1.sprite.bounds.size.x or var_220_2 / var_220_1.sprite.bounds.size.y, 0)
				end

				for iter_220_0, iter_220_1 in pairs(arg_217_1.bgs_) do
					if iter_220_0 ~= "Q01f" then
						iter_220_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_220_3 = 3.999999999999

			if 3.999999999999 < arg_217_1.time_ and arg_217_1.time_ <= var_220_3 + arg_220_0 then
				arg_217_1.allBtn_.enabled = false
			end

			if arg_217_1.time_ >= var_220_3 + 0.3 and arg_217_1.time_ < var_220_3 + 0.3 + arg_220_0 then
				arg_217_1.allBtn_.enabled = true
			end

			local var_220_4 = 0

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_4 + arg_220_0 then
				arg_217_1.mask_.enabled = true
				arg_217_1.mask_.raycastTarget = true

				arg_217_1:SetGaussion(false)
			end

			local var_220_5 = 2

			if var_220_4 <= arg_217_1.time_ and arg_217_1.time_ < var_220_4 + var_220_5 then
				local var_220_6 = Color.New(0, 0, 0)

				var_220_6.a = Mathf.Lerp(0, 1, (arg_217_1.time_ - var_220_4) / var_220_5)
				arg_217_1.mask_.color = var_220_6
			end

			if arg_217_1.time_ >= var_220_4 + var_220_5 and arg_217_1.time_ < var_220_4 + var_220_5 + arg_220_0 then
				local var_220_7 = Color.New(0, 0, 0)

				var_220_7.a = 1
				arg_217_1.mask_.color = var_220_7
			end

			local var_220_8 = 1.999999999999

			if 1.999999999999 < arg_217_1.time_ and arg_217_1.time_ <= var_220_8 + arg_220_0 then
				arg_217_1.mask_.enabled = true
				arg_217_1.mask_.raycastTarget = true

				arg_217_1:SetGaussion(false)
			end

			local var_220_9 = 2

			if var_220_8 <= arg_217_1.time_ and arg_217_1.time_ < var_220_8 + var_220_9 then
				local var_220_10 = Color.New(0, 0, 0)

				var_220_10.a = Mathf.Lerp(1, 0, (arg_217_1.time_ - var_220_8) / var_220_9)
				arg_217_1.mask_.color = var_220_10
			end

			if arg_217_1.time_ >= var_220_8 + var_220_9 and arg_217_1.time_ < var_220_8 + var_220_9 + arg_220_0 then
				local var_220_11 = Color.New(0, 0, 0)

				arg_217_1.mask_.enabled = false
				var_220_11.a = 0
				arg_217_1.mask_.color = var_220_11
			end

			local var_220_12 = arg_217_1.actors_["1011ui_story"].transform

			if 3.79999999701777 < arg_217_1.time_ and arg_217_1.time_ <= 3.79999999701777 + arg_220_0 then
				arg_217_1.var_.moveOldPos1011ui_story = var_220_12.localPosition
			end

			local var_220_13 = 0.001

			if 3.79999999701777 <= arg_217_1.time_ and arg_217_1.time_ < 3.79999999701777 + var_220_13 then
				var_220_12.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_217_1.time_ - 3.79999999701777) / var_220_13)
				var_220_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_220_12.position).x, (manager.ui.mainCamera.transform.position - var_220_12.position).y, (manager.ui.mainCamera.transform.position - var_220_12.position).z)
				var_220_12.localEulerAngles.z = 0
				var_220_12.localEulerAngles.x = 0
				var_220_12.localEulerAngles = var_220_12.localEulerAngles
			end

			if arg_217_1.time_ >= 3.79999999701777 + var_220_13 and arg_217_1.time_ < 3.79999999701777 + var_220_13 + arg_220_0 then
				var_220_12.localPosition = Vector3.New(0, -0.71, -6)
				var_220_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_220_12.position).x, (manager.ui.mainCamera.transform.position - var_220_12.position).y, (manager.ui.mainCamera.transform.position - var_220_12.position).z)
				var_220_12.localEulerAngles.z = 0
				var_220_12.localEulerAngles.x = 0
				var_220_12.localEulerAngles = var_220_12.localEulerAngles
			end

			local var_220_14 = arg_217_1.actors_["1011ui_story"]

			if 3.79999999701777 < arg_217_1.time_ and arg_217_1.time_ <= 3.79999999701777 + arg_220_0 and not isNil(var_220_14) and arg_217_1.var_.characterEffect1011ui_story == nil then
				arg_217_1.var_.characterEffect1011ui_story = var_220_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_15 = 0.200000002980232

			if 3.79999999701777 <= arg_217_1.time_ and arg_217_1.time_ < 3.79999999701777 + var_220_15 and not isNil(var_220_14) then
				if arg_217_1.var_.characterEffect1011ui_story and not isNil(var_220_14) then
					arg_217_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= 3.79999999701777 + var_220_15 and arg_217_1.time_ < 3.79999999701777 + var_220_15 + arg_220_0 and not isNil(var_220_14) and arg_217_1.var_.characterEffect1011ui_story then
				arg_217_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 3.79999999701777 < arg_217_1.time_ and arg_217_1.time_ <= 3.79999999701777 + arg_220_0 then
				arg_217_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 3.79999999701777 < arg_217_1.time_ and arg_217_1.time_ <= 3.79999999701777 + arg_220_0 then
				arg_217_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			if arg_217_1.frameCnt_ <= 1 then
				arg_217_1.dialog_:SetActive(false)
			end

			local var_220_17 = 3.999999999999
			local var_220_18 = 0.425

			if 3.999999999999 < arg_217_1.time_ and arg_217_1.time_ <= var_220_17 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0

				arg_217_1.dialog_:SetActive(true)

				arg_217_1.dialogCg_.alpha = 0

				local var_220_19 = LeanTween.value(arg_217_1.dialog_, 0, 1, 0.3)

				var_220_19:setOnUpdate(LuaHelper.FloatAction(function(arg_221_0)
					arg_217_1.dialogCg_.alpha = arg_221_0
				end))
				var_220_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_217_1.dialog_)
					var_220_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_217_1.duration_ = arg_217_1.duration_ + 0.3

				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_20 = arg_217_1:GetWordFromCfg(321251051)
				local var_220_21 = arg_217_1:FormatText(var_220_20.content)

				arg_217_1.text_.text = var_220_21

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_23 = 17 <= 0 and var_220_18 or var_220_18 * (utf8.len(var_220_21) / 17)

				if (17 <= 0 and var_220_18 or var_220_18 * (utf8.len(var_220_21) / 17)) > 0 and var_220_18 < var_220_23 then
					arg_217_1.talkMaxDuration = var_220_23
					var_220_17 = var_220_17 + 0.3

					if var_220_23 + var_220_17 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_23 + var_220_17
					end
				end

				arg_217_1.text_.text = var_220_21
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251051", "story_v_out_321251.awb") ~= 0 then
					local var_220_24 = manager.audio:GetVoiceLength("story_v_out_321251", "321251051", "story_v_out_321251.awb") / 1000

					if var_220_24 + var_220_17 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_24 + var_220_17
					end

					if var_220_20.prefab_name ~= "" and arg_217_1.actors_[var_220_20.prefab_name] ~= nil then
						local var_220_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_20.prefab_name].transform, "story_v_out_321251", "321251051", "story_v_out_321251.awb")

						arg_217_1:RecordAudio("321251051", var_220_25)
						arg_217_1:RecordAudio("321251051", var_220_25)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_321251", "321251051", "story_v_out_321251.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_321251", "321251051", "story_v_out_321251.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_26 = var_220_17 + 0.3
			local var_220_27 = math.max(var_220_18, arg_217_1.talkMaxDuration)

			if var_220_17 + 0.3 <= arg_217_1.time_ and arg_217_1.time_ < var_220_26 + var_220_27 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_26) / var_220_27

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_26 + var_220_27 and arg_217_1.time_ < var_220_26 + var_220_27 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.79999999701777,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play321251052 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 321251052
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play321251053(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["1011ui_story"]) and arg_223_1.var_.characterEffect1011ui_story == nil then
				arg_223_1.var_.characterEffect1011ui_story = arg_223_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_0 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["1011ui_story"]) then
				if arg_223_1.var_.characterEffect1011ui_story and not isNil(arg_223_1.actors_["1011ui_story"]) then
					arg_223_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_0)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["1011ui_story"]) and arg_223_1.var_.characterEffect1011ui_story then
				arg_223_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_226_1 = 0
			local var_226_2 = 0.75

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_3 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(321251052).content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 30 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 30)

				if (30 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 30)) > 0 and var_226_2 < var_226_5 then
					arg_223_1.talkMaxDuration = var_226_5

					if var_226_5 + var_226_1 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + var_226_1
					end
				end

				arg_223_1.text_.text = var_226_3
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_6 = math.max(var_226_2, arg_223_1.talkMaxDuration)

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_6 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_1) / var_226_6

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_1 + var_226_6 and arg_223_1.time_ < var_226_1 + var_226_6 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play321251053 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 321251053
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play321251054(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 1.35

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_1 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(321251053).content)

				arg_227_1.text_.text = var_230_1

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_3 = 54 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 54)

				if (54 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 54)) > 0 and var_230_0 < var_230_3 then
					arg_227_1.talkMaxDuration = var_230_3

					if var_230_3 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_3 + 0
					end
				end

				arg_227_1.text_.text = var_230_1
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_4 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_4 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_4

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_4 and arg_227_1.time_ < 0 + var_230_4 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play321251054 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 321251054
		arg_231_1.duration_ = 13

		local var_231_0 = {
			zh = 9.4,
			ja = 13
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play321251055(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1011ui_story = arg_231_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1011ui_story"].transform.position).z)
				arg_231_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1011ui_story"].transform.localEulerAngles = arg_231_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_231_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1011ui_story"].transform.position).z)
				arg_231_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1011ui_story"].transform.localEulerAngles = arg_231_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_234_1 = arg_231_1.actors_["1011ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect1011ui_story == nil then
				arg_231_1.var_.characterEffect1011ui_story = var_234_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_2 and not isNil(var_234_1) then
				if arg_231_1.var_.characterEffect1011ui_story and not isNil(var_234_1) then
					arg_231_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_2 and arg_231_1.time_ < 0 + var_234_2 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect1011ui_story then
				arg_231_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_234_4 = 0
			local var_234_5 = 0.95

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_6 = arg_231_1:GetWordFromCfg(321251054)
				local var_234_7 = arg_231_1:FormatText(var_234_6.content)

				arg_231_1.text_.text = var_234_7

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_9 = 38 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 38)

				if (38 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 38)) > 0 and var_234_5 < var_234_9 then
					arg_231_1.talkMaxDuration = var_234_9

					if var_234_9 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_9 + var_234_4
					end
				end

				arg_231_1.text_.text = var_234_7
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251054", "story_v_out_321251.awb") ~= 0 then
					local var_234_10 = manager.audio:GetVoiceLength("story_v_out_321251", "321251054", "story_v_out_321251.awb") / 1000

					if var_234_10 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_10 + var_234_4
					end

					if var_234_6.prefab_name ~= "" and arg_231_1.actors_[var_234_6.prefab_name] ~= nil then
						local var_234_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_6.prefab_name].transform, "story_v_out_321251", "321251054", "story_v_out_321251.awb")

						arg_231_1:RecordAudio("321251054", var_234_11)
						arg_231_1:RecordAudio("321251054", var_234_11)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_321251", "321251054", "story_v_out_321251.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_321251", "321251054", "story_v_out_321251.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_12 = math.max(var_234_5, arg_231_1.talkMaxDuration)

			if var_234_4 <= arg_231_1.time_ and arg_231_1.time_ < var_234_4 + var_234_12 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_4) / var_234_12

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_4 + var_234_12 and arg_231_1.time_ < var_234_4 + var_234_12 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play321251055 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 321251055
		arg_235_1.duration_ = 9.2

		local var_235_0 = {
			zh = 9.2,
			ja = 6.7
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play321251056(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.875

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_1 = arg_235_1:GetWordFromCfg(321251055)
				local var_238_2 = arg_235_1:FormatText(var_238_1.content)

				arg_235_1.text_.text = var_238_2

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_4 = 35 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 35)

				if (35 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 35)) > 0 and var_238_0 < var_238_4 then
					arg_235_1.talkMaxDuration = var_238_4

					if var_238_4 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_4 + 0
					end
				end

				arg_235_1.text_.text = var_238_2
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251055", "story_v_out_321251.awb") ~= 0 then
					local var_238_5 = manager.audio:GetVoiceLength("story_v_out_321251", "321251055", "story_v_out_321251.awb") / 1000

					if var_238_5 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + 0
					end

					if var_238_1.prefab_name ~= "" and arg_235_1.actors_[var_238_1.prefab_name] ~= nil then
						local var_238_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_1.prefab_name].transform, "story_v_out_321251", "321251055", "story_v_out_321251.awb")

						arg_235_1:RecordAudio("321251055", var_238_6)
						arg_235_1:RecordAudio("321251055", var_238_6)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_321251", "321251055", "story_v_out_321251.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_321251", "321251055", "story_v_out_321251.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_7 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_7 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_7

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_7 and arg_235_1.time_ < 0 + var_238_7 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play321251056 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 321251056
		arg_239_1.duration_ = 10.93

		local var_239_0 = {
			zh = 10.733,
			ja = 10.933
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play321251057(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.9

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_1 = arg_239_1:GetWordFromCfg(321251056)
				local var_242_2 = arg_239_1:FormatText(var_242_1.content)

				arg_239_1.text_.text = var_242_2

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 36 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 36)

				if (36 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 36)) > 0 and var_242_0 < var_242_4 then
					arg_239_1.talkMaxDuration = var_242_4

					if var_242_4 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_4 + 0
					end
				end

				arg_239_1.text_.text = var_242_2
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251056", "story_v_out_321251.awb") ~= 0 then
					local var_242_5 = manager.audio:GetVoiceLength("story_v_out_321251", "321251056", "story_v_out_321251.awb") / 1000

					if var_242_5 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + 0
					end

					if var_242_1.prefab_name ~= "" and arg_239_1.actors_[var_242_1.prefab_name] ~= nil then
						local var_242_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_1.prefab_name].transform, "story_v_out_321251", "321251056", "story_v_out_321251.awb")

						arg_239_1:RecordAudio("321251056", var_242_6)
						arg_239_1:RecordAudio("321251056", var_242_6)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_321251", "321251056", "story_v_out_321251.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_321251", "321251056", "story_v_out_321251.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_7 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_7 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_7

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_7 and arg_239_1.time_ < 0 + var_242_7 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play321251057 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 321251057
		arg_243_1.duration_ = 9.33

		local var_243_0 = {
			zh = 8.533,
			ja = 9.333
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play321251058(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_2")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_246_0 = 0
			local var_246_1 = 0.85

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_2 = arg_243_1:GetWordFromCfg(321251057)
				local var_246_3 = arg_243_1:FormatText(var_246_2.content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 34 <= 0 and var_246_1 or var_246_1 * (utf8.len(var_246_3) / 34)

				if (34 <= 0 and var_246_1 or var_246_1 * (utf8.len(var_246_3) / 34)) > 0 and var_246_1 < var_246_5 then
					arg_243_1.talkMaxDuration = var_246_5

					if var_246_5 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + var_246_0
					end
				end

				arg_243_1.text_.text = var_246_3
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251057", "story_v_out_321251.awb") ~= 0 then
					local var_246_6 = manager.audio:GetVoiceLength("story_v_out_321251", "321251057", "story_v_out_321251.awb") / 1000

					if var_246_6 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_6 + var_246_0
					end

					if var_246_2.prefab_name ~= "" and arg_243_1.actors_[var_246_2.prefab_name] ~= nil then
						local var_246_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_2.prefab_name].transform, "story_v_out_321251", "321251057", "story_v_out_321251.awb")

						arg_243_1:RecordAudio("321251057", var_246_7)
						arg_243_1:RecordAudio("321251057", var_246_7)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_321251", "321251057", "story_v_out_321251.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_321251", "321251057", "story_v_out_321251.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_8 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_8 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_8

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_8 and arg_243_1.time_ < var_246_0 + var_246_8 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play321251058 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 321251058
		arg_247_1.duration_ = 15.63

		local var_247_0 = {
			zh = 10.866,
			ja = 15.633
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play321251059(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos1011ui_story = arg_247_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_250_0 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 then
				arg_247_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_247_1.time_ - 0) / var_250_0)
				arg_247_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1011ui_story"].transform.position).z)
				arg_247_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["1011ui_story"].transform.localEulerAngles = arg_247_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 then
				arg_247_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_247_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1011ui_story"].transform.position).z)
				arg_247_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["1011ui_story"].transform.localEulerAngles = arg_247_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_250_1 = 0
			local var_250_2 = 1

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_3 = arg_247_1:GetWordFromCfg(321251058)
				local var_250_4 = arg_247_1:FormatText(var_250_3.content)

				arg_247_1.text_.text = var_250_4

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_6 = 40 <= 0 and var_250_2 or var_250_2 * (utf8.len(var_250_4) / 40)

				if (40 <= 0 and var_250_2 or var_250_2 * (utf8.len(var_250_4) / 40)) > 0 and var_250_2 < var_250_6 then
					arg_247_1.talkMaxDuration = var_250_6

					if var_250_6 + var_250_1 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_6 + var_250_1
					end
				end

				arg_247_1.text_.text = var_250_4
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251058", "story_v_out_321251.awb") ~= 0 then
					local var_250_7 = manager.audio:GetVoiceLength("story_v_out_321251", "321251058", "story_v_out_321251.awb") / 1000

					if var_250_7 + var_250_1 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_1
					end

					if var_250_3.prefab_name ~= "" and arg_247_1.actors_[var_250_3.prefab_name] ~= nil then
						local var_250_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_3.prefab_name].transform, "story_v_out_321251", "321251058", "story_v_out_321251.awb")

						arg_247_1:RecordAudio("321251058", var_250_8)
						arg_247_1:RecordAudio("321251058", var_250_8)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_321251", "321251058", "story_v_out_321251.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_321251", "321251058", "story_v_out_321251.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_9 = math.max(var_250_2, arg_247_1.talkMaxDuration)

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_9 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_1) / var_250_9

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_1 + var_250_9 and arg_247_1.time_ < var_250_1 + var_250_9 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play321251059 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 321251059
		arg_251_1.duration_ = 7.23

		local var_251_0 = {
			zh = 4.733,
			ja = 7.233
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play321251060(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0.375

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_1 = arg_251_1:GetWordFromCfg(321251059)
				local var_254_2 = arg_251_1:FormatText(var_254_1.content)

				arg_251_1.text_.text = var_254_2

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 15 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 15)

				if (15 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 15)) > 0 and var_254_0 < var_254_4 then
					arg_251_1.talkMaxDuration = var_254_4

					if var_254_4 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_4 + 0
					end
				end

				arg_251_1.text_.text = var_254_2
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251059", "story_v_out_321251.awb") ~= 0 then
					local var_254_5 = manager.audio:GetVoiceLength("story_v_out_321251", "321251059", "story_v_out_321251.awb") / 1000

					if var_254_5 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + 0
					end

					if var_254_1.prefab_name ~= "" and arg_251_1.actors_[var_254_1.prefab_name] ~= nil then
						local var_254_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_1.prefab_name].transform, "story_v_out_321251", "321251059", "story_v_out_321251.awb")

						arg_251_1:RecordAudio("321251059", var_254_6)
						arg_251_1:RecordAudio("321251059", var_254_6)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_321251", "321251059", "story_v_out_321251.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_321251", "321251059", "story_v_out_321251.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_7 = math.max(var_254_0, arg_251_1.talkMaxDuration)

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_7 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - 0) / var_254_7

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= 0 + var_254_7 and arg_251_1.time_ < 0 + var_254_7 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play321251060 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 321251060
		arg_255_1.duration_ = 3.57

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"

			SetActive(arg_255_1.choicesGo_, true)

			for iter_256_0, iter_256_1 in ipairs(arg_255_1.choices_) do
				SetActive(iter_256_1.go, iter_256_0 <= 1)
			end

			arg_255_1.choices_[1].txt.text = arg_255_1:FormatText(StoryChoiceCfg[1292].name)
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play321251061(arg_255_1)
			end

			arg_255_1:RecordChoiceLog(321251060, 1292)
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["1011ui_story"]) and arg_255_1.var_.characterEffect1011ui_story == nil then
				arg_255_1.var_.characterEffect1011ui_story = arg_255_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_0 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["1011ui_story"]) then
				if arg_255_1.var_.characterEffect1011ui_story and not isNil(arg_255_1.actors_["1011ui_story"]) then
					arg_255_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_0)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["1011ui_story"]) and arg_255_1.var_.characterEffect1011ui_story then
				arg_255_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_258_1 = 0

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.mask_.enabled = true
				arg_255_1.mask_.raycastTarget = true

				arg_255_1:SetGaussion(false)
			end

			local var_258_2 = 1.4

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 then
				local var_258_3 = Color.New(1, 1, 1)

				var_258_3.a = Mathf.Lerp(0, 1, (arg_255_1.time_ - var_258_1) / var_258_2)
				arg_255_1.mask_.color = var_258_3
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 then
				local var_258_4 = Color.New(1, 1, 1)

				var_258_4.a = 1
				arg_255_1.mask_.color = var_258_4
			end

			local var_258_5 = 1.4

			if 1.4 < arg_255_1.time_ and arg_255_1.time_ <= var_258_5 + arg_258_0 then
				arg_255_1.mask_.enabled = true
				arg_255_1.mask_.raycastTarget = true

				arg_255_1:SetGaussion(false)
			end

			local var_258_6 = 1.4

			if var_258_5 <= arg_255_1.time_ and arg_255_1.time_ < var_258_5 + var_258_6 then
				local var_258_7 = Color.New(1, 1, 1)

				var_258_7.a = Mathf.Lerp(1, 0, (arg_255_1.time_ - var_258_5) / var_258_6)
				arg_255_1.mask_.color = var_258_7
			end

			if arg_255_1.time_ >= var_258_5 + var_258_6 and arg_255_1.time_ < var_258_5 + var_258_6 + arg_258_0 then
				local var_258_8 = Color.New(1, 1, 1)

				arg_255_1.mask_.enabled = false
				var_258_8.a = 0
				arg_255_1.mask_.color = var_258_8
			end

			if 1.4 < arg_255_1.time_ and arg_255_1.time_ <= 1.4 + arg_258_0 then
				local var_258_9 = arg_255_1.bgs_.STwhite

				arg_255_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_258_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_258_10 = var_258_9:GetComponent("SpriteRenderer")

				if var_258_10 and var_258_10.sprite then
					local var_258_11 = 2 * (var_258_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_258_9.transform.localScale = Vector3.New(var_258_11 / var_258_10.sprite.bounds.size.y < var_258_11 * manager.ui.mainCameraCom_.aspect / var_258_10.sprite.bounds.size.x and var_258_11 * manager.ui.mainCameraCom_.aspect / var_258_10.sprite.bounds.size.x or var_258_11 / var_258_10.sprite.bounds.size.y, var_258_11 / var_258_10.sprite.bounds.size.y < var_258_11 * manager.ui.mainCameraCom_.aspect / var_258_10.sprite.bounds.size.x and var_258_11 * manager.ui.mainCameraCom_.aspect / var_258_10.sprite.bounds.size.x or var_258_11 / var_258_10.sprite.bounds.size.y, 0)
				end

				for iter_258_0, iter_258_1 in pairs(arg_255_1.bgs_) do
					if iter_258_0 ~= "STwhite" then
						iter_258_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_258_12 = arg_255_1.actors_["1011ui_story"].transform

			if 1.4 < arg_255_1.time_ and arg_255_1.time_ <= 1.4 + arg_258_0 then
				arg_255_1.var_.moveOldPos1011ui_story = var_258_12.localPosition
			end

			local var_258_13 = 0.001

			if 1.4 <= arg_255_1.time_ and arg_255_1.time_ < 1.4 + var_258_13 then
				var_258_12.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_255_1.time_ - 1.4) / var_258_13)
				var_258_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_12.position).x, (manager.ui.mainCamera.transform.position - var_258_12.position).y, (manager.ui.mainCamera.transform.position - var_258_12.position).z)
				var_258_12.localEulerAngles.z = 0
				var_258_12.localEulerAngles.x = 0
				var_258_12.localEulerAngles = var_258_12.localEulerAngles
			end

			if arg_255_1.time_ >= 1.4 + var_258_13 and arg_255_1.time_ < 1.4 + var_258_13 + arg_258_0 then
				var_258_12.localPosition = Vector3.New(0, 100, 0)
				var_258_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_12.position).x, (manager.ui.mainCamera.transform.position - var_258_12.position).y, (manager.ui.mainCamera.transform.position - var_258_12.position).z)
				var_258_12.localEulerAngles.z = 0
				var_258_12.localEulerAngles.x = 0
				var_258_12.localEulerAngles = var_258_12.localEulerAngles
			end

			if 1.4 < arg_255_1.time_ and arg_255_1.time_ <= 1.4 + arg_258_0 then
				arg_255_1.fswbg_:SetActive(true)
				arg_255_1.dialog_:SetActive(false)

				arg_255_1.fswtw_.percent = 0
				arg_255_1.fswt_.text = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(102).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.fswt_)

				arg_255_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_255_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_255_1.fswtw_:SetDirty()

				arg_255_1.typewritterCharCountI18N = 0

				SetActive(arg_255_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_255_1:ShowNextGo(false)
			end

			local var_258_14 = 1.43400000184774

			if 1.43400000184774 < arg_255_1.time_ and arg_255_1.time_ <= var_258_14 + arg_258_0 then
				arg_255_1.var_.oldValueTypewriter = arg_255_1.fswtw_.percent

				SetActive(arg_255_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_255_1:ShowNextGo(false)
			end

			local var_258_15 = 0
			local var_258_16 = 1.36599999815226
			local var_258_17, var_258_18 = arg_255_1:GetPercentByPara(arg_255_1:FormatText(arg_255_1:GetWordFromCfg(102).content), 1)

			if var_258_14 < arg_255_1.time_ and arg_255_1.time_ <= var_258_14 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0

				local var_258_19 = var_258_15 <= 0 and var_258_16 or var_258_16 * ((var_258_18 - arg_255_1.typewritterCharCountI18N) / var_258_15)

				if (var_258_15 <= 0 and var_258_16 or var_258_16 * ((var_258_18 - arg_255_1.typewritterCharCountI18N) / var_258_15)) > 0 and var_258_16 < var_258_19 then
					arg_255_1.talkMaxDuration = var_258_19

					if var_258_19 + var_258_14 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_19 + var_258_14
					end
				end
			end

			local var_258_20 = math.max(1.36599999815226, arg_255_1.talkMaxDuration)

			if var_258_14 <= arg_255_1.time_ and arg_255_1.time_ < var_258_14 + var_258_20 then
				arg_255_1.fswtw_.percent = Mathf.Lerp(arg_255_1.var_.oldValueTypewriter, var_258_17, (arg_255_1.time_ - var_258_14) / var_258_20)
				arg_255_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_255_1.fswtw_:SetDirty()
			end

			if arg_255_1.time_ >= var_258_14 + var_258_20 and arg_255_1.time_ < var_258_14 + var_258_20 + arg_258_0 then
				arg_255_1.fswtw_.percent = var_258_17

				arg_255_1.fswtw_:SetDirty()
				arg_255_1:ShowNextGo(true)

				arg_255_1.typewritterCharCountI18N = var_258_18
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play321251061 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 321251061
		arg_259_1.duration_ = 1

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"

			SetActive(arg_259_1.choicesGo_, true)

			for iter_260_0, iter_260_1 in ipairs(arg_259_1.choices_) do
				SetActive(iter_260_1.go, iter_260_0 <= 1)
			end

			arg_259_1.choices_[1].txt.text = arg_259_1:FormatText(StoryChoiceCfg[1293].name)
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play321251062(arg_259_1)
			end

			arg_259_1:RecordChoiceLog(321251061, 1293)
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			return
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play321251062 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 321251062
		arg_263_1.duration_ = 8.8

		local var_263_0 = {
			zh = 8.79966666666667,
			ja = 7.36666666666667
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play321251063(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 1.86666666666667 < arg_263_1.time_ and arg_263_1.time_ <= 1.86666666666667 + arg_266_0 then
				arg_263_1.var_.moveOldPos1011ui_story = arg_263_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_266_0 = 0.001

			if 1.86666666666667 <= arg_263_1.time_ and arg_263_1.time_ < 1.86666666666667 + var_266_0 then
				arg_263_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_263_1.time_ - 1.86666666666667) / var_266_0)
				arg_263_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1011ui_story"].transform.position).z)
				arg_263_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1011ui_story"].transform.localEulerAngles = arg_263_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 1.86666666666667 + var_266_0 and arg_263_1.time_ < 1.86666666666667 + var_266_0 + arg_266_0 then
				arg_263_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_263_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1011ui_story"].transform.position).z)
				arg_263_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1011ui_story"].transform.localEulerAngles = arg_263_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_266_1 = arg_263_1.actors_["1011ui_story"]

			if 1.86666666666667 < arg_263_1.time_ and arg_263_1.time_ <= 1.86666666666667 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1011ui_story == nil then
				arg_263_1.var_.characterEffect1011ui_story = var_266_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if 1.86666666666667 <= arg_263_1.time_ and arg_263_1.time_ < 1.86666666666667 + var_266_2 and not isNil(var_266_1) then
				if arg_263_1.var_.characterEffect1011ui_story and not isNil(var_266_1) then
					arg_263_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 1.86666666666667 + var_266_2 and arg_263_1.time_ < 1.86666666666667 + var_266_2 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1011ui_story then
				arg_263_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 1.86666666666667 < arg_263_1.time_ and arg_263_1.time_ <= 1.86666666666667 + arg_266_0 then
				arg_263_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0.666666666666667 < arg_263_1.time_ and arg_263_1.time_ <= 0.666666666666667 + arg_266_0 then
				arg_263_1.fswbg_:SetActive(true)
				arg_263_1.dialog_:SetActive(false)

				arg_263_1.fswtw_.percent = 0
				arg_263_1.fswt_.text = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(102).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.fswt_)

				arg_263_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_263_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_263_1.fswtw_:SetDirty()

				arg_263_1.typewritterCharCountI18N = 0

				SetActive(arg_263_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_263_1:ShowNextGo(false)
			end

			local var_266_4 = 0.700666668514411

			if 0.700666668514411 < arg_263_1.time_ and arg_263_1.time_ <= var_266_4 + arg_266_0 then
				arg_263_1.var_.oldValueTypewriter = arg_263_1.fswtw_.percent

				SetActive(arg_263_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_263_1:ShowNextGo(false)
			end

			local var_266_5 = 0
			local var_266_6 = 1.36599999815226
			local var_266_7, var_266_8 = arg_263_1:GetPercentByPara(arg_263_1:FormatText(arg_263_1:GetWordFromCfg(102).content), 1)

			if var_266_4 < arg_263_1.time_ and arg_263_1.time_ <= var_266_4 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0

				local var_266_9 = var_266_5 <= 0 and var_266_6 or var_266_6 * ((var_266_8 - arg_263_1.typewritterCharCountI18N) / var_266_5)

				if (var_266_5 <= 0 and var_266_6 or var_266_6 * ((var_266_8 - arg_263_1.typewritterCharCountI18N) / var_266_5)) > 0 and var_266_6 < var_266_9 then
					arg_263_1.talkMaxDuration = var_266_9

					if var_266_9 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_9 + var_266_4
					end
				end
			end

			local var_266_10 = math.max(1.36599999815226, arg_263_1.talkMaxDuration)

			if var_266_4 <= arg_263_1.time_ and arg_263_1.time_ < var_266_4 + var_266_10 then
				arg_263_1.fswtw_.percent = Mathf.Lerp(arg_263_1.var_.oldValueTypewriter, var_266_7, (arg_263_1.time_ - var_266_4) / var_266_10)
				arg_263_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_263_1.fswtw_:SetDirty()
			end

			if arg_263_1.time_ >= var_266_4 + var_266_10 and arg_263_1.time_ < var_266_4 + var_266_10 + arg_266_0 then
				arg_263_1.fswtw_.percent = var_266_7

				arg_263_1.fswtw_:SetDirty()
				arg_263_1:ShowNextGo(true)

				arg_263_1.typewritterCharCountI18N = var_266_8
			end

			local var_266_11 = 0

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_11 + arg_266_0 then
				arg_263_1.mask_.enabled = true
				arg_263_1.mask_.raycastTarget = true

				arg_263_1:SetGaussion(false)
			end

			local var_266_12 = 0.766666666666667

			if var_266_11 <= arg_263_1.time_ and arg_263_1.time_ < var_266_11 + var_266_12 then
				local var_266_13 = Color.New(1, 1, 1)

				var_266_13.a = Mathf.Lerp(0, 1, (arg_263_1.time_ - var_266_11) / var_266_12)
				arg_263_1.mask_.color = var_266_13
			end

			if arg_263_1.time_ >= var_266_11 + var_266_12 and arg_263_1.time_ < var_266_11 + var_266_12 + arg_266_0 then
				local var_266_14 = Color.New(1, 1, 1)

				var_266_14.a = 1
				arg_263_1.mask_.color = var_266_14
			end

			local var_266_15 = 0.666666666666667

			if 0.666666666666667 < arg_263_1.time_ and arg_263_1.time_ <= var_266_15 + arg_266_0 then
				arg_263_1.mask_.enabled = true
				arg_263_1.mask_.raycastTarget = true

				arg_263_1:SetGaussion(false)
			end

			local var_266_16 = 1.5

			if var_266_15 <= arg_263_1.time_ and arg_263_1.time_ < var_266_15 + var_266_16 then
				local var_266_17 = Color.New(1, 1, 1)

				var_266_17.a = Mathf.Lerp(1, 0, (arg_263_1.time_ - var_266_15) / var_266_16)
				arg_263_1.mask_.color = var_266_17
			end

			if arg_263_1.time_ >= var_266_15 + var_266_16 and arg_263_1.time_ < var_266_15 + var_266_16 + arg_266_0 then
				local var_266_18 = Color.New(1, 1, 1)

				arg_263_1.mask_.enabled = false
				var_266_18.a = 0
				arg_263_1.mask_.color = var_266_18
			end

			if 0.666666666666667 < arg_263_1.time_ and arg_263_1.time_ <= 0.666666666666667 + arg_266_0 then
				local var_266_19 = arg_263_1.bgs_.Q01f

				arg_263_1.bgs_.Q01f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_266_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_266_20 = var_266_19:GetComponent("SpriteRenderer")

				if var_266_20 and var_266_20.sprite then
					local var_266_21 = 2 * (var_266_19.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_266_19.transform.localScale = Vector3.New(var_266_21 / var_266_20.sprite.bounds.size.y < var_266_21 * manager.ui.mainCameraCom_.aspect / var_266_20.sprite.bounds.size.x and var_266_21 * manager.ui.mainCameraCom_.aspect / var_266_20.sprite.bounds.size.x or var_266_21 / var_266_20.sprite.bounds.size.y, var_266_21 / var_266_20.sprite.bounds.size.y < var_266_21 * manager.ui.mainCameraCom_.aspect / var_266_20.sprite.bounds.size.x and var_266_21 * manager.ui.mainCameraCom_.aspect / var_266_20.sprite.bounds.size.x or var_266_21 / var_266_20.sprite.bounds.size.y, 0)
				end

				for iter_266_0, iter_266_1 in pairs(arg_263_1.bgs_) do
					if iter_266_0 ~= "Q01f" then
						iter_266_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_266_22 = 2.16666666666667
			local var_266_23 = 0.25

			if 2.16666666666667 < arg_263_1.time_ and arg_263_1.time_ <= var_266_22 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_24 = arg_263_1:GetWordFromCfg(321251062)
				local var_266_25 = arg_263_1:FormatText(var_266_24.content)

				arg_263_1.text_.text = var_266_25

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_27 = 10 <= 0 and var_266_23 or var_266_23 * (utf8.len(var_266_25) / 10)

				if (10 <= 0 and var_266_23 or var_266_23 * (utf8.len(var_266_25) / 10)) > 0 and var_266_23 < var_266_27 then
					arg_263_1.talkMaxDuration = var_266_27

					if var_266_27 + var_266_22 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_27 + var_266_22
					end
				end

				arg_263_1.text_.text = var_266_25
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251062", "story_v_out_321251.awb") ~= 0 then
					local var_266_28 = manager.audio:GetVoiceLength("story_v_out_321251", "321251062", "story_v_out_321251.awb") / 1000

					if var_266_28 + var_266_22 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_28 + var_266_22
					end

					if var_266_24.prefab_name ~= "" and arg_263_1.actors_[var_266_24.prefab_name] ~= nil then
						local var_266_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_24.prefab_name].transform, "story_v_out_321251", "321251062", "story_v_out_321251.awb")

						arg_263_1:RecordAudio("321251062", var_266_29)
						arg_263_1:RecordAudio("321251062", var_266_29)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_321251", "321251062", "story_v_out_321251.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_321251", "321251062", "story_v_out_321251.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_30 = math.max(var_266_23, arg_263_1.talkMaxDuration)

			if var_266_22 <= arg_263_1.time_ and arg_263_1.time_ < var_266_22 + var_266_30 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_22) / var_266_30

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_22 + var_266_30 and arg_263_1.time_ < var_266_22 + var_266_30 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play321251063 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 321251063
		arg_267_1.duration_ = 14.83

		local var_267_0 = {
			zh = 12.466,
			ja = 14.833
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play321251064(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 1.3

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_1 = arg_267_1:GetWordFromCfg(321251063)
				local var_270_2 = arg_267_1:FormatText(var_270_1.content)

				arg_267_1.text_.text = var_270_2

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_4 = 52 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 52)

				if (52 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 52)) > 0 and var_270_0 < var_270_4 then
					arg_267_1.talkMaxDuration = var_270_4

					if var_270_4 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_4 + 0
					end
				end

				arg_267_1.text_.text = var_270_2
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251063", "story_v_out_321251.awb") ~= 0 then
					local var_270_5 = manager.audio:GetVoiceLength("story_v_out_321251", "321251063", "story_v_out_321251.awb") / 1000

					if var_270_5 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_5 + 0
					end

					if var_270_1.prefab_name ~= "" and arg_267_1.actors_[var_270_1.prefab_name] ~= nil then
						local var_270_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_1.prefab_name].transform, "story_v_out_321251", "321251063", "story_v_out_321251.awb")

						arg_267_1:RecordAudio("321251063", var_270_6)
						arg_267_1:RecordAudio("321251063", var_270_6)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_321251", "321251063", "story_v_out_321251.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_321251", "321251063", "story_v_out_321251.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_7 = math.max(var_270_0, arg_267_1.talkMaxDuration)

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_7 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - 0) / var_270_7

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= 0 + var_270_7 and arg_267_1.time_ < 0 + var_270_7 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play321251064 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 321251064
		arg_271_1.duration_ = 11.47

		local var_271_0 = {
			zh = 7.933,
			ja = 11.466
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play321251065(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1011ui_story = arg_271_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_274_0 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 then
				arg_271_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_271_1.time_ - 0) / var_274_0)
				arg_271_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1011ui_story"].transform.position).z)
				arg_271_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["1011ui_story"].transform.localEulerAngles = arg_271_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 then
				arg_271_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_271_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1011ui_story"].transform.position).z)
				arg_271_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["1011ui_story"].transform.localEulerAngles = arg_271_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_274_1 = 0
			local var_274_2 = 0.575

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_3 = arg_271_1:GetWordFromCfg(321251064)
				local var_274_4 = arg_271_1:FormatText(var_274_3.content)

				arg_271_1.text_.text = var_274_4

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_6 = 23 <= 0 and var_274_2 or var_274_2 * (utf8.len(var_274_4) / 23)

				if (23 <= 0 and var_274_2 or var_274_2 * (utf8.len(var_274_4) / 23)) > 0 and var_274_2 < var_274_6 then
					arg_271_1.talkMaxDuration = var_274_6

					if var_274_6 + var_274_1 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_6 + var_274_1
					end
				end

				arg_271_1.text_.text = var_274_4
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251064", "story_v_out_321251.awb") ~= 0 then
					local var_274_7 = manager.audio:GetVoiceLength("story_v_out_321251", "321251064", "story_v_out_321251.awb") / 1000

					if var_274_7 + var_274_1 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_7 + var_274_1
					end

					if var_274_3.prefab_name ~= "" and arg_271_1.actors_[var_274_3.prefab_name] ~= nil then
						local var_274_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_3.prefab_name].transform, "story_v_out_321251", "321251064", "story_v_out_321251.awb")

						arg_271_1:RecordAudio("321251064", var_274_8)
						arg_271_1:RecordAudio("321251064", var_274_8)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_321251", "321251064", "story_v_out_321251.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_321251", "321251064", "story_v_out_321251.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_9 = math.max(var_274_2, arg_271_1.talkMaxDuration)

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_9 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_1) / var_274_9

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_1 + var_274_9 and arg_271_1.time_ < var_274_1 + var_274_9 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play321251065 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 321251065
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play321251066(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos1011ui_story = arg_275_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_278_0 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 then
				arg_275_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_275_1.time_ - 0) / var_278_0)
				arg_275_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1011ui_story"].transform.position).z)
				arg_275_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1011ui_story"].transform.localEulerAngles = arg_275_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 then
				arg_275_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_275_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1011ui_story"].transform.position).z)
				arg_275_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1011ui_story"].transform.localEulerAngles = arg_275_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_278_1 = arg_275_1.actors_["1011ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1011ui_story == nil then
				arg_275_1.var_.characterEffect1011ui_story = var_278_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_2 and not isNil(var_278_1) then
				if arg_275_1.var_.characterEffect1011ui_story and not isNil(var_278_1) then
					arg_275_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_2)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_2 and arg_275_1.time_ < 0 + var_278_2 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1011ui_story then
				arg_275_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_278_3 = 0
			local var_278_4 = 1.375

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_3 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_5 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(321251065).content)

				arg_275_1.text_.text = var_278_5

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_7 = 55 <= 0 and var_278_4 or var_278_4 * (utf8.len(var_278_5) / 55)

				if (55 <= 0 and var_278_4 or var_278_4 * (utf8.len(var_278_5) / 55)) > 0 and var_278_4 < var_278_7 then
					arg_275_1.talkMaxDuration = var_278_7

					if var_278_7 + var_278_3 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_7 + var_278_3
					end
				end

				arg_275_1.text_.text = var_278_5
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_8 = math.max(var_278_4, arg_275_1.talkMaxDuration)

			if var_278_3 <= arg_275_1.time_ and arg_275_1.time_ < var_278_3 + var_278_8 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_3) / var_278_8

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_3 + var_278_8 and arg_275_1.time_ < var_278_3 + var_278_8 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play321251066 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 321251066
		arg_279_1.duration_ = 3.4

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"

			SetActive(arg_279_1.choicesGo_, true)

			for iter_280_0, iter_280_1 in ipairs(arg_279_1.choices_) do
				SetActive(iter_280_1.go, iter_280_0 <= 1)
			end

			arg_279_1.choices_[1].txt.text = arg_279_1:FormatText(StoryChoiceCfg[1271].name)
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play321251067(arg_279_1)
			end

			arg_279_1:RecordChoiceLog(321251066, 1271)
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 1.4 < arg_279_1.time_ and arg_279_1.time_ <= 1.4 + arg_282_0 then
				local var_282_0 = arg_279_1.bgs_.STblack

				arg_279_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_282_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_282_1 = var_282_0:GetComponent("SpriteRenderer")

				if var_282_1 and var_282_1.sprite then
					local var_282_2 = 2 * (var_282_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_282_0.transform.localScale = Vector3.New(var_282_2 / var_282_1.sprite.bounds.size.y < var_282_2 * manager.ui.mainCameraCom_.aspect / var_282_1.sprite.bounds.size.x and var_282_2 * manager.ui.mainCameraCom_.aspect / var_282_1.sprite.bounds.size.x or var_282_2 / var_282_1.sprite.bounds.size.y, var_282_2 / var_282_1.sprite.bounds.size.y < var_282_2 * manager.ui.mainCameraCom_.aspect / var_282_1.sprite.bounds.size.x and var_282_2 * manager.ui.mainCameraCom_.aspect / var_282_1.sprite.bounds.size.x or var_282_2 / var_282_1.sprite.bounds.size.y, 0)
				end

				for iter_282_0, iter_282_1 in pairs(arg_279_1.bgs_) do
					if iter_282_0 ~= "STblack" then
						iter_282_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_282_3 = 2.8

			if 2.8 < arg_279_1.time_ and arg_279_1.time_ <= var_282_3 + arg_282_0 then
				arg_279_1.allBtn_.enabled = false
			end

			if arg_279_1.time_ >= var_282_3 + 0.3 and arg_279_1.time_ < var_282_3 + 0.3 + arg_282_0 then
				arg_279_1.allBtn_.enabled = true
			end

			local var_282_4 = 0

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_4 + arg_282_0 then
				arg_279_1.mask_.enabled = true
				arg_279_1.mask_.raycastTarget = true

				arg_279_1:SetGaussion(false)
			end

			local var_282_5 = 1.4

			if var_282_4 <= arg_279_1.time_ and arg_279_1.time_ < var_282_4 + var_282_5 then
				local var_282_6 = Color.New(0, 0, 0)

				var_282_6.a = Mathf.Lerp(0, 1, (arg_279_1.time_ - var_282_4) / var_282_5)
				arg_279_1.mask_.color = var_282_6
			end

			if arg_279_1.time_ >= var_282_4 + var_282_5 and arg_279_1.time_ < var_282_4 + var_282_5 + arg_282_0 then
				local var_282_7 = Color.New(0, 0, 0)

				var_282_7.a = 1
				arg_279_1.mask_.color = var_282_7
			end

			local var_282_8 = 1.4

			if 1.4 < arg_279_1.time_ and arg_279_1.time_ <= var_282_8 + arg_282_0 then
				arg_279_1.mask_.enabled = true
				arg_279_1.mask_.raycastTarget = true

				arg_279_1:SetGaussion(false)
			end

			local var_282_9 = 1.4

			if var_282_8 <= arg_279_1.time_ and arg_279_1.time_ < var_282_8 + var_282_9 then
				local var_282_10 = Color.New(0, 0, 0)

				var_282_10.a = Mathf.Lerp(1, 0, (arg_279_1.time_ - var_282_8) / var_282_9)
				arg_279_1.mask_.color = var_282_10
			end

			if arg_279_1.time_ >= var_282_8 + var_282_9 and arg_279_1.time_ < var_282_8 + var_282_9 + arg_282_0 then
				local var_282_11 = Color.New(0, 0, 0)

				arg_279_1.mask_.enabled = false
				var_282_11.a = 0
				arg_279_1.mask_.color = var_282_11
			end

			if 1.4 < arg_279_1.time_ and arg_279_1.time_ <= 1.4 + arg_282_0 then
				arg_279_1.fswbg_:SetActive(true)
				arg_279_1.dialog_:SetActive(false)

				arg_279_1.fswtw_.percent = 0
				arg_279_1.fswt_.text = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(102).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.fswt_)

				arg_279_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_279_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_279_1.fswtw_:SetDirty()

				arg_279_1.typewritterCharCountI18N = 0

				SetActive(arg_279_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_279_1:ShowNextGo(false)
			end

			local var_282_12 = 1.8

			if 1.8 < arg_279_1.time_ and arg_279_1.time_ <= var_282_12 + arg_282_0 then
				arg_279_1.var_.oldValueTypewriter = arg_279_1.fswtw_.percent

				SetActive(arg_279_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_279_1:ShowNextGo(false)
			end

			local var_282_13 = 0
			local var_282_14 = 0.366666666666667
			local var_282_15, var_282_16 = arg_279_1:GetPercentByPara(arg_279_1:FormatText(arg_279_1:GetWordFromCfg(102).content), 1)

			if var_282_12 < arg_279_1.time_ and arg_279_1.time_ <= var_282_12 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0

				local var_282_17 = var_282_13 <= 0 and var_282_14 or var_282_14 * ((var_282_16 - arg_279_1.typewritterCharCountI18N) / var_282_13)

				if (var_282_13 <= 0 and var_282_14 or var_282_14 * ((var_282_16 - arg_279_1.typewritterCharCountI18N) / var_282_13)) > 0 and var_282_14 < var_282_17 then
					arg_279_1.talkMaxDuration = var_282_17

					if var_282_17 + var_282_12 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_17 + var_282_12
					end
				end
			end

			local var_282_18 = math.max(0.366666666666667, arg_279_1.talkMaxDuration)

			if var_282_12 <= arg_279_1.time_ and arg_279_1.time_ < var_282_12 + var_282_18 then
				arg_279_1.fswtw_.percent = Mathf.Lerp(arg_279_1.var_.oldValueTypewriter, var_282_15, (arg_279_1.time_ - var_282_12) / var_282_18)
				arg_279_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_279_1.fswtw_:SetDirty()
			end

			if arg_279_1.time_ >= var_282_12 + var_282_18 and arg_279_1.time_ < var_282_12 + var_282_18 + arg_282_0 then
				arg_279_1.fswtw_.percent = var_282_15

				arg_279_1.fswtw_:SetDirty()
				arg_279_1:ShowNextGo(true)

				arg_279_1.typewritterCharCountI18N = var_282_16
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play321251067 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 321251067
		arg_283_1.duration_ = 1

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"

			SetActive(arg_283_1.choicesGo_, true)

			for iter_284_0, iter_284_1 in ipairs(arg_283_1.choices_) do
				SetActive(iter_284_1.go, iter_284_0 <= 1)
			end

			arg_283_1.choices_[1].txt.text = arg_283_1:FormatText(StoryChoiceCfg[1272].name)
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play321251068(arg_283_1)
			end

			arg_283_1:RecordChoiceLog(321251067, 1272)
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.allBtn_.enabled = false
			end

			if arg_283_1.time_ >= 0 + 0.5 and arg_283_1.time_ < 0 + 0.5 + arg_286_0 then
				arg_283_1.allBtn_.enabled = true
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play321251068 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 321251068
		arg_287_1.duration_ = 8.3

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play321251069(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if arg_287_1.bgs_.MS2107 == nil then
				local var_290_0 = Object.Instantiate(arg_287_1.paintGo_)

				var_290_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS2107")
				var_290_0.name = "MS2107"
				var_290_0.transform.parent = arg_287_1.stage_.transform
				var_290_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_287_1.bgs_.MS2107 = var_290_0
			end

			if 1.525 < arg_287_1.time_ and arg_287_1.time_ <= 1.525 + arg_290_0 then
				local var_290_1 = arg_287_1.bgs_.MS2107

				arg_287_1.bgs_.MS2107.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_290_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_290_2 = var_290_1:GetComponent("SpriteRenderer")

				if var_290_2 and var_290_2.sprite then
					local var_290_3 = 2 * (var_290_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_290_1.transform.localScale = Vector3.New(var_290_3 / var_290_2.sprite.bounds.size.y < var_290_3 * manager.ui.mainCameraCom_.aspect / var_290_2.sprite.bounds.size.x and var_290_3 * manager.ui.mainCameraCom_.aspect / var_290_2.sprite.bounds.size.x or var_290_3 / var_290_2.sprite.bounds.size.y, var_290_3 / var_290_2.sprite.bounds.size.y < var_290_3 * manager.ui.mainCameraCom_.aspect / var_290_2.sprite.bounds.size.x and var_290_3 * manager.ui.mainCameraCom_.aspect / var_290_2.sprite.bounds.size.x or var_290_3 / var_290_2.sprite.bounds.size.y, 0)
				end

				for iter_290_0, iter_290_1 in pairs(arg_287_1.bgs_) do
					if iter_290_0 ~= "MS2107" then
						iter_290_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_290_4 = 3.3

			if 3.3 < arg_287_1.time_ and arg_287_1.time_ <= var_290_4 + arg_290_0 then
				arg_287_1.allBtn_.enabled = false
			end

			if arg_287_1.time_ >= var_290_4 + 0.3 and arg_287_1.time_ < var_290_4 + 0.3 + arg_290_0 then
				arg_287_1.allBtn_.enabled = true
			end

			local var_290_5 = 0

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_5 + arg_290_0 then
				arg_287_1.mask_.enabled = true
				arg_287_1.mask_.raycastTarget = true

				arg_287_1:SetGaussion(false)
			end

			local var_290_6 = 1.525

			if var_290_5 <= arg_287_1.time_ and arg_287_1.time_ < var_290_5 + var_290_6 then
				local var_290_7 = Color.New(0, 0, 0)

				var_290_7.a = Mathf.Lerp(0, 1, (arg_287_1.time_ - var_290_5) / var_290_6)
				arg_287_1.mask_.color = var_290_7
			end

			if arg_287_1.time_ >= var_290_5 + var_290_6 and arg_287_1.time_ < var_290_5 + var_290_6 + arg_290_0 then
				local var_290_8 = Color.New(0, 0, 0)

				var_290_8.a = 1
				arg_287_1.mask_.color = var_290_8
			end

			local var_290_9 = 1.525

			if 1.525 < arg_287_1.time_ and arg_287_1.time_ <= var_290_9 + arg_290_0 then
				arg_287_1.mask_.enabled = true
				arg_287_1.mask_.raycastTarget = true

				arg_287_1:SetGaussion(false)
			end

			local var_290_10 = 2

			if var_290_9 <= arg_287_1.time_ and arg_287_1.time_ < var_290_9 + var_290_10 then
				local var_290_11 = Color.New(0, 0, 0)

				var_290_11.a = Mathf.Lerp(1, 0, (arg_287_1.time_ - var_290_9) / var_290_10)
				arg_287_1.mask_.color = var_290_11
			end

			if arg_287_1.time_ >= var_290_9 + var_290_10 and arg_287_1.time_ < var_290_9 + var_290_10 + arg_290_0 then
				local var_290_12 = Color.New(0, 0, 0)

				arg_287_1.mask_.enabled = false
				var_290_12.a = 0
				arg_287_1.mask_.color = var_290_12
			end

			local var_290_13 = arg_287_1.bgs_.MS2107.transform

			if 1.525 < arg_287_1.time_ and arg_287_1.time_ <= 1.525 + arg_290_0 then
				arg_287_1.var_.moveOldPosMS2107 = var_290_13.localPosition
			end

			local var_290_14 = 4

			if 1.525 <= arg_287_1.time_ and arg_287_1.time_ < 1.525 + var_290_14 then
				var_290_13.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPosMS2107, Vector3.New(0, 1, 9.5), (arg_287_1.time_ - 1.525) / var_290_14)
			end

			if arg_287_1.time_ >= 1.525 + var_290_14 and arg_287_1.time_ < 1.525 + var_290_14 + arg_290_0 then
				var_290_13.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_290_15 = 3.525

			if 3.525 < arg_287_1.time_ and arg_287_1.time_ <= var_290_15 + arg_290_0 then
				arg_287_1.allBtn_.enabled = false
			end

			if arg_287_1.time_ >= var_290_15 + 2 and arg_287_1.time_ < var_290_15 + 2 + arg_290_0 then
				arg_287_1.allBtn_.enabled = true
			end

			if 1.54166666666667 < arg_287_1.time_ and arg_287_1.time_ <= 1.54166666666667 + arg_290_0 then
				arg_287_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_thunder03", "")
			end

			if 1.525 < arg_287_1.time_ and arg_287_1.time_ <= 1.525 + arg_290_0 then
				arg_287_1.fswbg_:SetActive(false)
				arg_287_1.dialog_:SetActive(false)
				SetActive(arg_287_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_287_1:ShowNextGo(false)
			end

			if 1.54166666666667 < arg_287_1.time_ and arg_287_1.time_ <= 1.54166666666667 + arg_290_0 then
				arg_287_1.fswbg_:SetActive(false)
				arg_287_1.dialog_:SetActive(false)
				SetActive(arg_287_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_287_1:ShowNextGo(false)
			end

			if arg_287_1.frameCnt_ <= 1 then
				arg_287_1.dialog_:SetActive(false)
			end

			local var_290_17 = 3.3
			local var_290_18 = 1.525

			if 3.3 < arg_287_1.time_ and arg_287_1.time_ <= var_290_17 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0

				arg_287_1.dialog_:SetActive(true)

				arg_287_1.dialogCg_.alpha = 0

				local var_290_19 = LeanTween.value(arg_287_1.dialog_, 0, 1, 0.3)

				var_290_19:setOnUpdate(LuaHelper.FloatAction(function(arg_291_0)
					arg_287_1.dialogCg_.alpha = arg_291_0
				end))
				var_290_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_287_1.dialog_)
					var_290_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_287_1.duration_ = arg_287_1.duration_ + 0.3

				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_20 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(321251068).content)

				arg_287_1.text_.text = var_290_20

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_22 = 61 <= 0 and var_290_18 or var_290_18 * (utf8.len(var_290_20) / 61)

				if (61 <= 0 and var_290_18 or var_290_18 * (utf8.len(var_290_20) / 61)) > 0 and var_290_18 < var_290_22 then
					arg_287_1.talkMaxDuration = var_290_22
					var_290_17 = var_290_17 + 0.3

					if var_290_22 + var_290_17 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_22 + var_290_17
					end
				end

				arg_287_1.text_.text = var_290_20
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_23 = var_290_17 + 0.3
			local var_290_24 = math.max(var_290_18, arg_287_1.talkMaxDuration)

			if var_290_17 + 0.3 <= arg_287_1.time_ and arg_287_1.time_ < var_290_23 + var_290_24 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_23) / var_290_24

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_23 + var_290_24 and arg_287_1.time_ < var_290_23 + var_290_24 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2107",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 1.525,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play321251069 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 321251069
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play321251070(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 1

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_1 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(321251069).content)

				arg_293_1.text_.text = var_296_1

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_3 = 40 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 40)

				if (40 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 40)) > 0 and var_296_0 < var_296_3 then
					arg_293_1.talkMaxDuration = var_296_3

					if var_296_3 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_3 + 0
					end
				end

				arg_293_1.text_.text = var_296_1
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_4 = math.max(var_296_0, arg_293_1.talkMaxDuration)

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_4 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - 0) / var_296_4

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= 0 + var_296_4 and arg_293_1.time_ < 0 + var_296_4 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play321251070 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 321251070
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play321251071(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 1.325

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_1 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(321251070).content)

				arg_297_1.text_.text = var_300_1

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_3 = 53 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 53)

				if (53 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 53)) > 0 and var_300_0 < var_300_3 then
					arg_297_1.talkMaxDuration = var_300_3

					if var_300_3 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_3 + 0
					end
				end

				arg_297_1.text_.text = var_300_1
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_4 = math.max(var_300_0, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_4 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - 0) / var_300_4

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_4 and arg_297_1.time_ < 0 + var_300_4 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play321251071 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 321251071
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play321251072(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0.75

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_1 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(321251071).content)

				arg_301_1.text_.text = var_304_1

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_3 = 30 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 30)

				if (30 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 30)) > 0 and var_304_0 < var_304_3 then
					arg_301_1.talkMaxDuration = var_304_3

					if var_304_3 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_3 + 0
					end
				end

				arg_301_1.text_.text = var_304_1
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_4 = math.max(var_304_0, arg_301_1.talkMaxDuration)

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_4 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - 0) / var_304_4

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= 0 + var_304_4 and arg_301_1.time_ < 0 + var_304_4 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play321251072 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 321251072
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play321251073(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0.25

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_1 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(321251072).content)

				arg_305_1.text_.text = var_308_1

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_3 = 10 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 10)

				if (10 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 10)) > 0 and var_308_0 < var_308_3 then
					arg_305_1.talkMaxDuration = var_308_3

					if var_308_3 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_3 + 0
					end
				end

				arg_305_1.text_.text = var_308_1
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_4 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_4 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_4

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_4 and arg_305_1.time_ < 0 + var_308_4 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play321251073 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 321251073
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play321251074(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.075

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_1 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(321251073).content)

				arg_309_1.text_.text = var_312_1

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_3 = 3 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 3)

				if (3 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 3)) > 0 and var_312_0 < var_312_3 then
					arg_309_1.talkMaxDuration = var_312_3

					if var_312_3 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_3 + 0
					end
				end

				arg_309_1.text_.text = var_312_1
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_4 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_4 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_4

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_4 and arg_309_1.time_ < 0 + var_312_4 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play321251074 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 321251074
		arg_313_1.duration_ = 3.97

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"

			SetActive(arg_313_1.choicesGo_, true)

			for iter_314_0, iter_314_1 in ipairs(arg_313_1.choices_) do
				SetActive(iter_314_1.go, iter_314_0 <= 1)
			end

			arg_313_1.choices_[1].txt.text = arg_313_1:FormatText(StoryChoiceCfg[1273].name)
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play321251075(arg_313_1)
			end

			arg_313_1:RecordChoiceLog(321251074, 1273)
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.mask_.enabled = true
				arg_313_1.mask_.raycastTarget = true

				arg_313_1:SetGaussion(false)
			end

			local var_316_0 = 1.4

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 then
				local var_316_1 = Color.New(1, 1, 1)

				var_316_1.a = Mathf.Lerp(0, 1, (arg_313_1.time_ - 0) / var_316_0)
				arg_313_1.mask_.color = var_316_1
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 then
				local var_316_2 = Color.New(1, 1, 1)

				var_316_2.a = 1
				arg_313_1.mask_.color = var_316_2
			end

			local var_316_3 = 1.4

			if 1.4 < arg_313_1.time_ and arg_313_1.time_ <= var_316_3 + arg_316_0 then
				arg_313_1.mask_.enabled = true
				arg_313_1.mask_.raycastTarget = true

				arg_313_1:SetGaussion(false)
			end

			local var_316_4 = 2

			if var_316_3 <= arg_313_1.time_ and arg_313_1.time_ < var_316_3 + var_316_4 then
				local var_316_5 = Color.New(1, 1, 1)

				var_316_5.a = Mathf.Lerp(1, 0, (arg_313_1.time_ - var_316_3) / var_316_4)
				arg_313_1.mask_.color = var_316_5
			end

			if arg_313_1.time_ >= var_316_3 + var_316_4 and arg_313_1.time_ < var_316_3 + var_316_4 + arg_316_0 then
				local var_316_6 = Color.New(1, 1, 1)

				arg_313_1.mask_.enabled = false
				var_316_6.a = 0
				arg_313_1.mask_.color = var_316_6
			end

			if 1.4 < arg_313_1.time_ and arg_313_1.time_ <= 1.4 + arg_316_0 then
				local var_316_7 = arg_313_1.bgs_.STwhite

				arg_313_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_316_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_316_8 = var_316_7:GetComponent("SpriteRenderer")

				if var_316_8 and var_316_8.sprite then
					local var_316_9 = 2 * (var_316_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_316_7.transform.localScale = Vector3.New(var_316_9 / var_316_8.sprite.bounds.size.y < var_316_9 * manager.ui.mainCameraCom_.aspect / var_316_8.sprite.bounds.size.x and var_316_9 * manager.ui.mainCameraCom_.aspect / var_316_8.sprite.bounds.size.x or var_316_9 / var_316_8.sprite.bounds.size.y, var_316_9 / var_316_8.sprite.bounds.size.y < var_316_9 * manager.ui.mainCameraCom_.aspect / var_316_8.sprite.bounds.size.x and var_316_9 * manager.ui.mainCameraCom_.aspect / var_316_8.sprite.bounds.size.x or var_316_9 / var_316_8.sprite.bounds.size.y, 0)
				end

				for iter_316_0, iter_316_1 in pairs(arg_313_1.bgs_) do
					if iter_316_0 ~= "STwhite" then
						iter_316_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1.4 < arg_313_1.time_ and arg_313_1.time_ <= 1.4 + arg_316_0 then
				arg_313_1.fswbg_:SetActive(true)
				arg_313_1.dialog_:SetActive(false)

				arg_313_1.fswtw_.percent = 0
				arg_313_1.fswt_.text = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(102).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.fswt_)

				arg_313_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_313_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_313_1.fswtw_:SetDirty()

				arg_313_1.typewritterCharCountI18N = 0

				SetActive(arg_313_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_313_1:ShowNextGo(false)
			end

			local var_316_10 = 1.43400000184774

			if 1.43400000184774 < arg_313_1.time_ and arg_313_1.time_ <= var_316_10 + arg_316_0 then
				arg_313_1.var_.oldValueTypewriter = arg_313_1.fswtw_.percent

				SetActive(arg_313_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_313_1:ShowNextGo(false)
			end

			local var_316_11 = 0
			local var_316_12 = 1.36599999815226
			local var_316_13, var_316_14 = arg_313_1:GetPercentByPara(arg_313_1:FormatText(arg_313_1:GetWordFromCfg(102).content), 1)

			if var_316_10 < arg_313_1.time_ and arg_313_1.time_ <= var_316_10 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0

				local var_316_15 = var_316_11 <= 0 and var_316_12 or var_316_12 * ((var_316_14 - arg_313_1.typewritterCharCountI18N) / var_316_11)

				if (var_316_11 <= 0 and var_316_12 or var_316_12 * ((var_316_14 - arg_313_1.typewritterCharCountI18N) / var_316_11)) > 0 and var_316_12 < var_316_15 then
					arg_313_1.talkMaxDuration = var_316_15

					if var_316_15 + var_316_10 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_15 + var_316_10
					end
				end
			end

			local var_316_16 = math.max(1.36599999815226, arg_313_1.talkMaxDuration)

			if var_316_10 <= arg_313_1.time_ and arg_313_1.time_ < var_316_10 + var_316_16 then
				arg_313_1.fswtw_.percent = Mathf.Lerp(arg_313_1.var_.oldValueTypewriter, var_316_13, (arg_313_1.time_ - var_316_10) / var_316_16)
				arg_313_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_313_1.fswtw_:SetDirty()
			end

			if arg_313_1.time_ >= var_316_10 + var_316_16 and arg_313_1.time_ < var_316_10 + var_316_16 + arg_316_0 then
				arg_313_1.fswtw_.percent = var_316_13

				arg_313_1.fswtw_:SetDirty()
				arg_313_1:ShowNextGo(true)

				arg_313_1.typewritterCharCountI18N = var_316_14
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play321251075 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 321251075
		arg_317_1.duration_ = 1

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"

			SetActive(arg_317_1.choicesGo_, true)

			for iter_318_0, iter_318_1 in ipairs(arg_317_1.choices_) do
				SetActive(iter_318_1.go, iter_318_0 <= 1)
			end

			arg_317_1.choices_[1].txt.text = arg_317_1:FormatText(StoryChoiceCfg[1274].name)
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play321251076(arg_317_1)
			end

			arg_317_1:RecordChoiceLog(321251075, 1274)
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			return
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play321251076 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 321251076
		arg_321_1.duration_ = 1

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"

			SetActive(arg_321_1.choicesGo_, true)

			for iter_322_0, iter_322_1 in ipairs(arg_321_1.choices_) do
				SetActive(iter_322_1.go, iter_322_0 <= 1)
			end

			arg_321_1.choices_[1].txt.text = arg_321_1:FormatText(StoryChoiceCfg[1275].name)
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play321251077(arg_321_1)
			end

			arg_321_1:RecordChoiceLog(321251076, 1275)
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			return
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play321251077 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 321251077
		arg_325_1.duration_ = 70.87

		local var_325_0 = {
			zh = 69.9340000018477,
			ja = 70.8670000018477
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play321251078(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_9001
			local var_328_9000

			if 60.2 < arg_325_1.time_ and arg_325_1.time_ <= 60.2 + arg_328_0 then
				local var_328_0 = arg_325_1.bgs_.STblack

				arg_325_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_328_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_328_1 = var_328_0:GetComponent("SpriteRenderer")

				if var_328_1 and var_328_1.sprite then
					local var_328_2 = 2 * (var_328_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_328_0.transform.localScale = Vector3.New(var_328_2 / var_328_1.sprite.bounds.size.y < var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x and var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x or var_328_2 / var_328_1.sprite.bounds.size.y, var_328_2 / var_328_1.sprite.bounds.size.y < var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x and var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x or var_328_2 / var_328_1.sprite.bounds.size.y, 0)
				end

				for iter_328_0, iter_328_1 in pairs(arg_325_1.bgs_) do
					if iter_328_0 ~= "STblack" then
						iter_328_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_328_3 = "MS2114"

			if arg_325_1.bgs_.MS2114 == nil then
				local var_328_4 = Object.Instantiate(arg_325_1.paintGo_)

				var_328_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_328_3)
				var_328_4.name = var_328_3
				var_328_4.transform.parent = arg_325_1.stage_.transform
				var_328_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_325_1.bgs_[var_328_3] = var_328_4
			end

			if 60.8333333333333 < arg_325_1.time_ and arg_325_1.time_ <= 60.8333333333333 + arg_328_0 then
				local var_328_5 = arg_325_1.bgs_.MS2114

				arg_325_1.bgs_.MS2114.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_328_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_328_6 = var_328_5:GetComponent("SpriteRenderer")

				if var_328_6 and var_328_6.sprite then
					local var_328_7 = 2 * (var_328_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_328_5.transform.localScale = Vector3.New(var_328_7 / var_328_6.sprite.bounds.size.y < var_328_7 * manager.ui.mainCameraCom_.aspect / var_328_6.sprite.bounds.size.x and var_328_7 * manager.ui.mainCameraCom_.aspect / var_328_6.sprite.bounds.size.x or var_328_7 / var_328_6.sprite.bounds.size.y, var_328_7 / var_328_6.sprite.bounds.size.y < var_328_7 * manager.ui.mainCameraCom_.aspect / var_328_6.sprite.bounds.size.x and var_328_7 * manager.ui.mainCameraCom_.aspect / var_328_6.sprite.bounds.size.x or var_328_7 / var_328_6.sprite.bounds.size.y, 0)
				end

				for iter_328_2, iter_328_3 in pairs(arg_325_1.bgs_) do
					if iter_328_2 ~= "MS2114" then
						iter_328_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_328_8 = 62.5

			if 62.5 < arg_325_1.time_ and arg_325_1.time_ <= var_328_8 + arg_328_0 then
				arg_325_1.allBtn_.enabled = false
			end

			if arg_325_1.time_ >= var_328_8 + 0.3 and arg_325_1.time_ < var_328_8 + 0.3 + arg_328_0 then
				arg_325_1.allBtn_.enabled = true
			end

			local var_328_9 = 60.8333333333333

			if 60.8333333333333 < arg_325_1.time_ and arg_325_1.time_ <= var_328_9 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = true

				arg_325_1:SetGaussion(false)
			end

			local var_328_10 = 0.5

			if var_328_9 <= arg_325_1.time_ and arg_325_1.time_ < var_328_9 + var_328_10 then
				local var_328_11 = Color.New(0.09433961, 0.09433961, 0.09433961)

				var_328_11.a = Mathf.Lerp(1, 0, (arg_325_1.time_ - var_328_9) / var_328_10)
				arg_325_1.mask_.color = var_328_11
			end

			if arg_325_1.time_ >= var_328_9 + var_328_10 and arg_325_1.time_ < var_328_9 + var_328_10 + arg_328_0 then
				local var_328_12 = Color.New(0.09433961, 0.09433961, 0.09433961)

				arg_325_1.mask_.enabled = false
				var_328_12.a = 0
				arg_325_1.mask_.color = var_328_12
			end

			if 60.8333333333333 < arg_325_1.time_ and arg_325_1.time_ <= 60.8333333333333 + arg_328_0 then
				local var_328_13 = arg_325_1.var_.effectchongsheng1

				if not arg_325_1.var_.effectchongsheng1 then
					var_328_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_posui"), manager.ui.mainCamera.transform)
					var_328_13.name = "chongsheng1"
					arg_325_1.var_.effectchongsheng1 = var_328_13
				else
					var_328_13.transform:SetParent(var_328_9001)
				end

				var_328_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_328_13.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_328_15 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_328_16 = var_328_13.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_328_4, iter_328_5 in ipairs((var_328_16:ToTable())) do
					iter_328_5.transform.localScale = Vector3.New(iter_328_5.transform.localScale.x / var_328_15 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_328_16 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_328_5.transform.localScale.y / var_328_15, iter_328_5.transform.localScale.z)
				end
			end

			if 62.3333333333333 < arg_325_1.time_ and arg_325_1.time_ <= 62.3333333333333 + arg_328_0 then
				if arg_325_1.var_.effectchongsheng1 then
					Object.Destroy(arg_325_1.var_.effectchongsheng1)

					arg_325_1.var_.effectchongsheng1 = nil
				end
			end

			local var_328_19 = arg_325_1.bgs_.MS2114.transform

			if 60.8333333333333 < arg_325_1.time_ and arg_325_1.time_ <= 60.8333333333333 + arg_328_0 then
				arg_325_1.var_.moveOldPosMS2114 = var_328_19.localPosition
			end

			local var_328_20 = 0.1

			if 60.8333333333333 <= arg_325_1.time_ and arg_325_1.time_ < 60.8333333333333 + var_328_20 then
				var_328_19.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPosMS2114, Vector3.New(0, 1, 9.5), (arg_325_1.time_ - 60.8333333333333) / var_328_20)
			end

			if arg_325_1.time_ >= 60.8333333333333 + var_328_20 and arg_325_1.time_ < 60.8333333333333 + var_328_20 + arg_328_0 then
				var_328_19.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_328_21 = arg_325_1.bgs_.MS2114.transform

			if 60.9333333333333 < arg_325_1.time_ and arg_325_1.time_ <= 60.9333333333333 + arg_328_0 then
				arg_325_1.var_.moveOldPosMS2114 = var_328_21.localPosition
			end

			local var_328_22 = 4.5

			if 60.9333333333333 <= arg_325_1.time_ and arg_325_1.time_ < 60.9333333333333 + var_328_22 then
				var_328_21.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPosMS2114, Vector3.New(0, 1, 10), (arg_325_1.time_ - 60.9333333333333) / var_328_22)
			end

			if arg_325_1.time_ >= 60.9333333333333 + var_328_22 and arg_325_1.time_ < 60.9333333333333 + var_328_22 + arg_328_0 then
				var_328_21.localPosition = Vector3.New(0, 1, 10)
			end

			if 60.8333333333333 < arg_325_1.time_ and arg_325_1.time_ <= 60.8333333333333 + arg_328_0 then
				local var_328_23 = arg_325_1.var_.effectchongsheng2

				if not arg_325_1.var_.effectchongsheng2 then
					var_328_23 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian02_in_keep"), manager.ui.mainCamera.transform)
					var_328_23.name = "chongsheng2"
					arg_325_1.var_.effectchongsheng2 = var_328_23
				else
					var_328_23.transform:SetParent(var_328_9000)
				end

				var_328_23.transform.localPosition = Vector3.New(0, 0, 0)
				var_328_23.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 60.8333333333333 < arg_325_1.time_ and arg_325_1.time_ <= 60.8333333333333 + arg_328_0 then
				arg_325_1:AudioAction("play", "effect", "se_story_140", "se_story_140_glass", "")
			end

			local var_328_26 = 60.5

			if 60.5 < arg_325_1.time_ and arg_325_1.time_ <= var_328_26 + arg_328_0 then
				arg_325_1.allBtn_.enabled = false
			end

			if arg_325_1.time_ >= var_328_26 + 2.46666666666667 and arg_325_1.time_ < var_328_26 + 2.46666666666667 + arg_328_0 then
				arg_325_1.allBtn_.enabled = true
			end

			local var_328_27 = 60.1

			if 60.1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_27 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = true

				arg_325_1:SetGaussion(false)
			end

			local var_328_28 = 0.833333333333329

			if var_328_27 <= arg_325_1.time_ and arg_325_1.time_ < var_328_27 + var_328_28 then
				local var_328_29 = Color.New(0, 0, 0)

				var_328_29.a = Mathf.Lerp(1, 0, (arg_325_1.time_ - var_328_27) / var_328_28)
				arg_325_1.mask_.color = var_328_29
			end

			if arg_325_1.time_ >= var_328_27 + var_328_28 and arg_325_1.time_ < var_328_27 + var_328_28 + arg_328_0 then
				local var_328_30 = Color.New(0, 0, 0)

				arg_325_1.mask_.enabled = false
				var_328_30.a = 0
				arg_325_1.mask_.color = var_328_30
			end

			local var_328_31 = 0

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_31 + arg_328_0 then
				SetActive(arg_325_1.dialog_, false)
				SetActive(arg_325_1.allBtn_.gameObject, false)
				arg_325_1.hideBtnsController_:SetSelectedIndex(1)
				arg_325_1:StopAllVoice()

				arg_325_1.marker = "PlayCantSkipVideo"

				manager.video:Play("SofdecAsset/story/story_1032125.usm", function(arg_329_0)
					arg_325_1.time_ = var_328_31 + 60.4483333335569

					if arg_325_1.state_ == "pause" then
						arg_325_1.state_ = "playing"
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_330_0)
					arg_325_1.state_ = arg_330_0 and "pause" or "playing"
				end, 1032125)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_328_32 = 60.4583333333333

			if var_328_31 <= arg_325_1.time_ and arg_325_1.time_ < var_328_31 + var_328_32 then
				-- block empty
			end

			if arg_325_1.time_ >= var_328_31 + var_328_32 and arg_325_1.time_ < var_328_31 + var_328_32 + arg_328_0 then
				arg_325_1.marker = ""
			end

			local var_328_33 = 60.4583333333333

			if 60.4583333333333 < arg_325_1.time_ and arg_325_1.time_ <= var_328_33 + arg_328_0 then
				SetActive(arg_325_1.dialog_, true)
				SetActive(arg_325_1.allBtn_.gameObject, true)
				arg_325_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_325_1.isInLoopVideo = false
			end

			local var_328_34 = 0.474999999999994

			if var_328_33 <= arg_325_1.time_ and arg_325_1.time_ < var_328_33 + var_328_34 then
				-- block empty
			end

			if arg_325_1.time_ >= var_328_33 + var_328_34 and arg_325_1.time_ < var_328_33 + var_328_34 + arg_328_0 then
				arg_325_1.marker = ""
			end

			local var_328_35 = 0

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_35 + arg_328_0 then
				arg_325_1.var_.oldValueTypewriter = arg_325_1.fswtw_.percent

				SetActive(arg_325_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_325_1:ShowNextGo(false)
			end

			local var_328_36 = 0
			local var_328_37 = 0.034000001847744
			local var_328_38, var_328_39 = arg_325_1:GetPercentByPara(arg_325_1:FormatText(arg_325_1:GetWordFromCfg(102).content), 1)

			if var_328_35 < arg_325_1.time_ and arg_325_1.time_ <= var_328_35 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0

				local var_328_40 = var_328_36 <= 0 and var_328_37 or var_328_37 * ((var_328_39 - arg_325_1.typewritterCharCountI18N) / var_328_36)

				if (var_328_36 <= 0 and var_328_37 or var_328_37 * ((var_328_39 - arg_325_1.typewritterCharCountI18N) / var_328_36)) > 0 and var_328_37 < var_328_40 then
					arg_325_1.talkMaxDuration = var_328_40

					if var_328_40 + var_328_35 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_40 + var_328_35
					end
				end
			end

			local var_328_41 = math.max(0.034000001847744, arg_325_1.talkMaxDuration)

			if var_328_35 <= arg_325_1.time_ and arg_325_1.time_ < var_328_35 + var_328_41 then
				arg_325_1.fswtw_.percent = Mathf.Lerp(arg_325_1.var_.oldValueTypewriter, var_328_38, (arg_325_1.time_ - var_328_35) / var_328_41)
				arg_325_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_325_1.fswtw_:SetDirty()
			end

			if arg_325_1.time_ >= var_328_35 + var_328_41 and arg_325_1.time_ < var_328_35 + var_328_41 + arg_328_0 then
				arg_325_1.fswtw_.percent = var_328_38

				arg_325_1.fswtw_:SetDirty()
				arg_325_1:ShowNextGo(true)

				arg_325_1.typewritterCharCountI18N = var_328_39
			end

			local var_328_42 = 0.034000001847744

			if 0.034000001847744 < arg_325_1.time_ and arg_325_1.time_ <= var_328_42 + arg_328_0 then
				arg_325_1.var_.oldValueTypewriter = arg_325_1.fswtw_.percent

				SetActive(arg_325_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_325_1:ShowNextGo(false)
			end

			local var_328_43 = 0
			local var_328_44 = 0.599333331485624
			local var_328_45, var_328_46 = arg_325_1:GetPercentByPara(arg_325_1:FormatText(arg_325_1:GetWordFromCfg(102).content), 1)

			if var_328_42 < arg_325_1.time_ and arg_325_1.time_ <= var_328_42 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0

				local var_328_47 = var_328_43 <= 0 and var_328_44 or var_328_44 * ((var_328_46 - arg_325_1.typewritterCharCountI18N) / var_328_43)

				if (var_328_43 <= 0 and var_328_44 or var_328_44 * ((var_328_46 - arg_325_1.typewritterCharCountI18N) / var_328_43)) > 0 and var_328_44 < var_328_47 then
					arg_325_1.talkMaxDuration = var_328_47

					if var_328_47 + var_328_42 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_47 + var_328_42
					end
				end
			end

			local var_328_48 = math.max(0.599333331485624, arg_325_1.talkMaxDuration)

			if var_328_42 <= arg_325_1.time_ and arg_325_1.time_ < var_328_42 + var_328_48 then
				arg_325_1.fswtw_.percent = Mathf.Lerp(arg_325_1.var_.oldValueTypewriter, var_328_45, (arg_325_1.time_ - var_328_42) / var_328_48)
				arg_325_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_325_1.fswtw_:SetDirty()
			end

			if arg_325_1.time_ >= var_328_42 + var_328_48 and arg_325_1.time_ < var_328_42 + var_328_48 + arg_328_0 then
				arg_325_1.fswtw_.percent = var_328_45

				arg_325_1.fswtw_:SetDirty()
				arg_325_1:ShowNextGo(true)

				arg_325_1.typewritterCharCountI18N = var_328_46
			end

			if 60.4583333333333 < arg_325_1.time_ and arg_325_1.time_ <= 60.4583333333333 + arg_328_0 then
				arg_325_1.fswbg_:SetActive(false)
				arg_325_1.dialog_:SetActive(false)
				SetActive(arg_325_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_325_1:ShowNextGo(false)
			end

			if 60.4923333351811 < arg_325_1.time_ and arg_325_1.time_ <= 60.4923333351811 + arg_328_0 then
				arg_325_1.fswbg_:SetActive(false)
				arg_325_1.dialog_:SetActive(false)
				SetActive(arg_325_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_325_1:ShowNextGo(false)
			end

			if 61.9006666685143 < arg_325_1.time_ and arg_325_1.time_ <= 61.9006666685143 + arg_328_0 then
				arg_325_1.fswbg_:SetActive(false)
				arg_325_1.dialog_:SetActive(false)
				SetActive(arg_325_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_325_1:ShowNextGo(false)
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_328_51 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_325_1.bgmTxt_.text ~= var_328_51 and arg_325_1.bgmTxt_.text ~= "" then
						if arg_325_1.bgmTxt2_.text ~= "" then
							arg_325_1.bgmTxt_.text = arg_325_1.bgmTxt2_.text
						end

						arg_325_1.bgmTxt2_.text = var_328_51

						arg_325_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_325_1.bgmTxt_.text = var_328_51
						arg_325_1.bgmTxt2_.text = var_328_51
					end

					if arg_325_1.bgmTimer then
						arg_325_1.bgmTimer:Stop()

						arg_325_1.bgmTimer = nil
					end

					if arg_325_1.settingData.show_music_name == 1 then
						arg_325_1.musicController:SetSelectedState("show")
						arg_325_1.musicAnimator_:Play("open", 0, 0)

						if arg_325_1.settingData.music_time ~= 0 then
							arg_325_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_325_1.settingData.music_time), function()
								if arg_325_1 == nil or isNil(arg_325_1.bgmTxt_) then
									return
								end

								arg_325_1.musicController:SetSelectedState("hide")
								arg_325_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 60.8333333333333 < arg_325_1.time_ and arg_325_1.time_ <= 60.8333333333333 + arg_328_0 then
				arg_325_1:AudioAction("play", "music", "bgm_activity_4_0_story_osiris_room", "bgm_activity_4_0_story_osiris_room", "bgm_activity_4_0_story_osiris_room.awb")

				local var_328_54 = manager.audio:GetAudioName("bgm_activity_4_0_story_osiris_room", "bgm_activity_4_0_story_osiris_room")

				if "" ~= "" then
					if arg_325_1.bgmTxt_.text ~= var_328_54 and arg_325_1.bgmTxt_.text ~= "" then
						if arg_325_1.bgmTxt2_.text ~= "" then
							arg_325_1.bgmTxt_.text = arg_325_1.bgmTxt2_.text
						end

						arg_325_1.bgmTxt2_.text = var_328_54

						arg_325_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_325_1.bgmTxt_.text = var_328_54
						arg_325_1.bgmTxt2_.text = var_328_54
					end

					if arg_325_1.bgmTimer then
						arg_325_1.bgmTimer:Stop()

						arg_325_1.bgmTimer = nil
					end

					if arg_325_1.settingData.show_music_name == 1 then
						arg_325_1.musicController:SetSelectedState("show")
						arg_325_1.musicAnimator_:Play("open", 0, 0)

						if arg_325_1.settingData.music_time ~= 0 then
							arg_325_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_325_1.settingData.music_time), function()
								if arg_325_1 == nil or isNil(arg_325_1.bgmTxt_) then
									return
								end

								arg_325_1.musicController:SetSelectedState("hide")
								arg_325_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_325_1.frameCnt_ <= 1 then
				arg_325_1.dialog_:SetActive(false)
			end

			local var_328_55 = 62.5340000018477
			local var_328_56 = 0.725

			if 62.5340000018477 < arg_325_1.time_ and arg_325_1.time_ <= var_328_55 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0

				arg_325_1.dialog_:SetActive(true)

				arg_325_1.dialogCg_.alpha = 0

				local var_328_57 = LeanTween.value(arg_325_1.dialog_, 0, 1, 0.3)

				var_328_57:setOnUpdate(LuaHelper.FloatAction(function(arg_333_0)
					arg_325_1.dialogCg_.alpha = arg_333_0
				end))
				var_328_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_325_1.dialog_)
					var_328_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_325_1.duration_ = arg_325_1.duration_ + 0.3

				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_58 = arg_325_1:GetWordFromCfg(321251077)
				local var_328_59 = arg_325_1:FormatText(var_328_58.content)

				arg_325_1.text_.text = var_328_59

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_61 = 29 <= 0 and var_328_56 or var_328_56 * (utf8.len(var_328_59) / 29)

				if (29 <= 0 and var_328_56 or var_328_56 * (utf8.len(var_328_59) / 29)) > 0 and var_328_56 < var_328_61 then
					arg_325_1.talkMaxDuration = var_328_61
					var_328_55 = var_328_55 + 0.3

					if var_328_61 + var_328_55 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_61 + var_328_55
					end
				end

				arg_325_1.text_.text = var_328_59
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251077", "story_v_out_321251.awb") ~= 0 then
					local var_328_62 = manager.audio:GetVoiceLength("story_v_out_321251", "321251077", "story_v_out_321251.awb") / 1000

					if var_328_62 + var_328_55 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_62 + var_328_55
					end

					if var_328_58.prefab_name ~= "" and arg_325_1.actors_[var_328_58.prefab_name] ~= nil then
						local var_328_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_58.prefab_name].transform, "story_v_out_321251", "321251077", "story_v_out_321251.awb")

						arg_325_1:RecordAudio("321251077", var_328_63)
						arg_325_1:RecordAudio("321251077", var_328_63)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_321251", "321251077", "story_v_out_321251.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_321251", "321251077", "story_v_out_321251.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_64 = var_328_55 + 0.3
			local var_328_65 = math.max(var_328_56, arg_325_1.talkMaxDuration)

			if var_328_55 + 0.3 <= arg_325_1.time_ and arg_325_1.time_ < var_328_64 + var_328_65 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_64) / var_328_65

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_64 + var_328_65 and arg_325_1.time_ < var_328_64 + var_328_65 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2114",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 60.8333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2114",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.5,
				className = "StoryMoveNode",
				startTime = 60.9333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play321251078 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 321251078
		arg_335_1.duration_ = 9.47

		local var_335_0 = {
			zh = 9.466,
			ja = 9.366
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play321251079(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_338_0 = 0
			local var_338_1 = 0.925

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_2 = arg_335_1:GetWordFromCfg(321251078)
				local var_338_3 = arg_335_1:FormatText(var_338_2.content)

				arg_335_1.text_.text = var_338_3

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_5 = 37 <= 0 and var_338_1 or var_338_1 * (utf8.len(var_338_3) / 37)

				if (37 <= 0 and var_338_1 or var_338_1 * (utf8.len(var_338_3) / 37)) > 0 and var_338_1 < var_338_5 then
					arg_335_1.talkMaxDuration = var_338_5

					if var_338_5 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_5 + var_338_0
					end
				end

				arg_335_1.text_.text = var_338_3
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251078", "story_v_out_321251.awb") ~= 0 then
					local var_338_6 = manager.audio:GetVoiceLength("story_v_out_321251", "321251078", "story_v_out_321251.awb") / 1000

					if var_338_6 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_6 + var_338_0
					end

					if var_338_2.prefab_name ~= "" and arg_335_1.actors_[var_338_2.prefab_name] ~= nil then
						local var_338_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_2.prefab_name].transform, "story_v_out_321251", "321251078", "story_v_out_321251.awb")

						arg_335_1:RecordAudio("321251078", var_338_7)
						arg_335_1:RecordAudio("321251078", var_338_7)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_321251", "321251078", "story_v_out_321251.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_321251", "321251078", "story_v_out_321251.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_8 = math.max(var_338_1, arg_335_1.talkMaxDuration)

			if var_338_0 <= arg_335_1.time_ and arg_335_1.time_ < var_338_0 + var_338_8 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_0) / var_338_8

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_0 + var_338_8 and arg_335_1.time_ < var_338_0 + var_338_8 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play321251079 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 321251079
		arg_339_1.duration_ = 13.97

		local var_339_0 = {
			zh = 13.2,
			ja = 13.966
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play321251080(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 1.175

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_1 = arg_339_1:GetWordFromCfg(321251079)
				local var_342_2 = arg_339_1:FormatText(var_342_1.content)

				arg_339_1.text_.text = var_342_2

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_4 = 45 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_2) / 45)

				if (45 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_2) / 45)) > 0 and var_342_0 < var_342_4 then
					arg_339_1.talkMaxDuration = var_342_4

					if var_342_4 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_4 + 0
					end
				end

				arg_339_1.text_.text = var_342_2
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251079", "story_v_out_321251.awb") ~= 0 then
					local var_342_5 = manager.audio:GetVoiceLength("story_v_out_321251", "321251079", "story_v_out_321251.awb") / 1000

					if var_342_5 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_5 + 0
					end

					if var_342_1.prefab_name ~= "" and arg_339_1.actors_[var_342_1.prefab_name] ~= nil then
						local var_342_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_1.prefab_name].transform, "story_v_out_321251", "321251079", "story_v_out_321251.awb")

						arg_339_1:RecordAudio("321251079", var_342_6)
						arg_339_1:RecordAudio("321251079", var_342_6)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_321251", "321251079", "story_v_out_321251.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_321251", "321251079", "story_v_out_321251.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_7 = math.max(var_342_0, arg_339_1.talkMaxDuration)

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_7 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - 0) / var_342_7

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= 0 + var_342_7 and arg_339_1.time_ < 0 + var_342_7 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play321251080 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 321251080
		arg_343_1.duration_ = 10.5

		local var_343_0 = {
			zh = 4.8,
			ja = 10.5
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play321251081(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0.575

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_1 = arg_343_1:GetWordFromCfg(321251080)
				local var_346_2 = arg_343_1:FormatText(var_346_1.content)

				arg_343_1.text_.text = var_346_2

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_4 = 23 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_2) / 23)

				if (23 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_2) / 23)) > 0 and var_346_0 < var_346_4 then
					arg_343_1.talkMaxDuration = var_346_4

					if var_346_4 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_4 + 0
					end
				end

				arg_343_1.text_.text = var_346_2
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251080", "story_v_out_321251.awb") ~= 0 then
					local var_346_5 = manager.audio:GetVoiceLength("story_v_out_321251", "321251080", "story_v_out_321251.awb") / 1000

					if var_346_5 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_5 + 0
					end

					if var_346_1.prefab_name ~= "" and arg_343_1.actors_[var_346_1.prefab_name] ~= nil then
						local var_346_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_1.prefab_name].transform, "story_v_out_321251", "321251080", "story_v_out_321251.awb")

						arg_343_1:RecordAudio("321251080", var_346_6)
						arg_343_1:RecordAudio("321251080", var_346_6)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_321251", "321251080", "story_v_out_321251.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_321251", "321251080", "story_v_out_321251.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_7 = math.max(var_346_0, arg_343_1.talkMaxDuration)

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_7 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - 0) / var_346_7

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= 0 + var_346_7 and arg_343_1.time_ < 0 + var_346_7 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play321251081 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 321251081
		arg_347_1.duration_ = 16.9

		local var_347_0 = {
			zh = 11.8,
			ja = 16.9
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play321251082(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 1.05

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_1 = arg_347_1:GetWordFromCfg(321251081)
				local var_350_2 = arg_347_1:FormatText(var_350_1.content)

				arg_347_1.text_.text = var_350_2

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_4 = 42 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 42)

				if (42 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 42)) > 0 and var_350_0 < var_350_4 then
					arg_347_1.talkMaxDuration = var_350_4

					if var_350_4 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_4 + 0
					end
				end

				arg_347_1.text_.text = var_350_2
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251081", "story_v_out_321251.awb") ~= 0 then
					local var_350_5 = manager.audio:GetVoiceLength("story_v_out_321251", "321251081", "story_v_out_321251.awb") / 1000

					if var_350_5 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_5 + 0
					end

					if var_350_1.prefab_name ~= "" and arg_347_1.actors_[var_350_1.prefab_name] ~= nil then
						local var_350_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_1.prefab_name].transform, "story_v_out_321251", "321251081", "story_v_out_321251.awb")

						arg_347_1:RecordAudio("321251081", var_350_6)
						arg_347_1:RecordAudio("321251081", var_350_6)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_321251", "321251081", "story_v_out_321251.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_321251", "321251081", "story_v_out_321251.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_7 = math.max(var_350_0, arg_347_1.talkMaxDuration)

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_7 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - 0) / var_350_7

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= 0 + var_350_7 and arg_347_1.time_ < 0 + var_350_7 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play321251082 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 321251082
		arg_351_1.duration_ = 5.57

		local var_351_0 = {
			zh = 5.56666666666667,
			ja = 4.16666666666667
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play321251083(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.allBtn_.enabled = false
			end

			if arg_351_1.time_ >= 0 + 1 and arg_351_1.time_ < 0 + 1 + arg_354_0 then
				arg_351_1.allBtn_.enabled = true
			end

			if arg_351_1.frameCnt_ <= 1 then
				arg_351_1.dialog_:SetActive(false)
			end

			local var_354_0 = 0.866666666666667
			local var_354_1 = 0.425

			if 0.866666666666667 < arg_351_1.time_ and arg_351_1.time_ <= var_354_0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0

				arg_351_1.dialog_:SetActive(true)

				arg_351_1.dialogCg_.alpha = 0

				local var_354_2 = LeanTween.value(arg_351_1.dialog_, 0, 1, 0.3)

				var_354_2:setOnUpdate(LuaHelper.FloatAction(function(arg_355_0)
					arg_351_1.dialogCg_.alpha = arg_355_0
				end))
				var_354_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_351_1.dialog_)
					var_354_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_351_1.duration_ = arg_351_1.duration_ + 0.3

				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_3 = arg_351_1:GetWordFromCfg(321251082)
				local var_354_4 = arg_351_1:FormatText(var_354_3.content)

				arg_351_1.text_.text = var_354_4

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_6 = 17 <= 0 and var_354_1 or var_354_1 * (utf8.len(var_354_4) / 17)

				if (17 <= 0 and var_354_1 or var_354_1 * (utf8.len(var_354_4) / 17)) > 0 and var_354_1 < var_354_6 then
					arg_351_1.talkMaxDuration = var_354_6
					var_354_0 = var_354_0 + 0.3

					if var_354_6 + var_354_0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_6 + var_354_0
					end
				end

				arg_351_1.text_.text = var_354_4
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251082", "story_v_out_321251.awb") ~= 0 then
					local var_354_7 = manager.audio:GetVoiceLength("story_v_out_321251", "321251082", "story_v_out_321251.awb") / 1000

					if var_354_7 + var_354_0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_7 + var_354_0
					end

					if var_354_3.prefab_name ~= "" and arg_351_1.actors_[var_354_3.prefab_name] ~= nil then
						local var_354_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_3.prefab_name].transform, "story_v_out_321251", "321251082", "story_v_out_321251.awb")

						arg_351_1:RecordAudio("321251082", var_354_8)
						arg_351_1:RecordAudio("321251082", var_354_8)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_321251", "321251082", "story_v_out_321251.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_321251", "321251082", "story_v_out_321251.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_9 = var_354_0 + 0.3
			local var_354_10 = math.max(var_354_1, arg_351_1.talkMaxDuration)

			if var_354_0 + 0.3 <= arg_351_1.time_ and arg_351_1.time_ < var_354_9 + var_354_10 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_9) / var_354_10

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_9 + var_354_10 and arg_351_1.time_ < var_354_9 + var_354_10 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play321251083 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 321251083
		arg_357_1.duration_ = 7.3

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play321251084(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 0.575

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_1 = arg_357_1:GetWordFromCfg(321251083)
				local var_360_2 = arg_357_1:FormatText(var_360_1.content)

				arg_357_1.text_.text = var_360_2

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_4 = 23 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_2) / 23)

				if (23 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_2) / 23)) > 0 and var_360_0 < var_360_4 then
					arg_357_1.talkMaxDuration = var_360_4

					if var_360_4 + 0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_4 + 0
					end
				end

				arg_357_1.text_.text = var_360_2
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251083", "story_v_out_321251.awb") ~= 0 then
					local var_360_5 = manager.audio:GetVoiceLength("story_v_out_321251", "321251083", "story_v_out_321251.awb") / 1000

					if var_360_5 + 0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_5 + 0
					end

					if var_360_1.prefab_name ~= "" and arg_357_1.actors_[var_360_1.prefab_name] ~= nil then
						local var_360_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_1.prefab_name].transform, "story_v_out_321251", "321251083", "story_v_out_321251.awb")

						arg_357_1:RecordAudio("321251083", var_360_6)
						arg_357_1:RecordAudio("321251083", var_360_6)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_321251", "321251083", "story_v_out_321251.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_321251", "321251083", "story_v_out_321251.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_7 = math.max(var_360_0, arg_357_1.talkMaxDuration)

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_7 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - 0) / var_360_7

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= 0 + var_360_7 and arg_357_1.time_ < 0 + var_360_7 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play321251084 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 321251084
		arg_361_1.duration_ = 8.77

		local var_361_0 = {
			zh = 6.566,
			ja = 8.766
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play321251085(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0.575

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_1 = arg_361_1:GetWordFromCfg(321251084)
				local var_364_2 = arg_361_1:FormatText(var_364_1.content)

				arg_361_1.text_.text = var_364_2

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_4 = 23 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_2) / 23)

				if (23 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_2) / 23)) > 0 and var_364_0 < var_364_4 then
					arg_361_1.talkMaxDuration = var_364_4

					if var_364_4 + 0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_4 + 0
					end
				end

				arg_361_1.text_.text = var_364_2
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251084", "story_v_out_321251.awb") ~= 0 then
					local var_364_5 = manager.audio:GetVoiceLength("story_v_out_321251", "321251084", "story_v_out_321251.awb") / 1000

					if var_364_5 + 0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_5 + 0
					end

					if var_364_1.prefab_name ~= "" and arg_361_1.actors_[var_364_1.prefab_name] ~= nil then
						local var_364_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_1.prefab_name].transform, "story_v_out_321251", "321251084", "story_v_out_321251.awb")

						arg_361_1:RecordAudio("321251084", var_364_6)
						arg_361_1:RecordAudio("321251084", var_364_6)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_321251", "321251084", "story_v_out_321251.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_321251", "321251084", "story_v_out_321251.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_7 = math.max(var_364_0, arg_361_1.talkMaxDuration)

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_7 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - 0) / var_364_7

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= 0 + var_364_7 and arg_361_1.time_ < 0 + var_364_7 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play321251085 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 321251085
		arg_365_1.duration_ = 5.8

		local var_365_0 = {
			zh = 5.066666666666,
			ja = 5.799999999999
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play321251086(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_9001
			local var_368_9000

			if 1.499999999999 < arg_365_1.time_ and arg_365_1.time_ <= 1.499999999999 + arg_368_0 then
				if arg_365_1.var_.effectchongsheng2 then
					Object.Destroy(arg_365_1.var_.effectchongsheng2)

					arg_365_1.var_.effectchongsheng2 = nil
				end
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				local var_368_1 = arg_365_1.var_.effectchonsgheng3

				if not arg_365_1.var_.effectchonsgheng3 then
					var_368_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), manager.ui.mainCamera.transform)
					var_368_1.name = "chonsgheng3"
					arg_365_1.var_.effectchonsgheng3 = var_368_1
				else
					var_368_1.transform:SetParent(var_368_9001)
				end

				var_368_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_368_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.499999999999 < arg_365_1.time_ and arg_365_1.time_ <= 1.499999999999 + arg_368_0 then
				if arg_365_1.var_.effectchonsgheng3 then
					Object.Destroy(arg_365_1.var_.effectchonsgheng3)

					arg_365_1.var_.effectchonsgheng3 = nil
				end
			end

			if 1.499999999999 < arg_365_1.time_ and arg_365_1.time_ <= 1.499999999999 + arg_368_0 then
				local var_368_4 = arg_365_1.var_.effectchonsgheng4

				if not arg_365_1.var_.effectchonsgheng4 then
					var_368_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), manager.ui.mainCamera.transform)
					var_368_4.name = "chonsgheng4"
					arg_365_1.var_.effectchonsgheng4 = var_368_4
				else
					var_368_4.transform:SetParent(var_368_9000)
				end

				var_368_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_368_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.999999999999 < arg_365_1.time_ and arg_365_1.time_ <= 2.999999999999 + arg_368_0 then
				if arg_365_1.var_.effectchonsgheng4 then
					Object.Destroy(arg_365_1.var_.effectchonsgheng4)

					arg_365_1.var_.effectchonsgheng4 = nil
				end
			end

			local var_368_7 = arg_365_1.bgs_.MS2114.transform

			if 1.1 < arg_365_1.time_ and arg_365_1.time_ <= 1.1 + arg_368_0 then
				arg_365_1.var_.moveOldPosMS2114 = var_368_7.localPosition
			end

			local var_368_8 = 0.001

			if 1.1 <= arg_365_1.time_ and arg_365_1.time_ < 1.1 + var_368_8 then
				var_368_7.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPosMS2114, Vector3.New(0, 1, 4), (arg_365_1.time_ - 1.1) / var_368_8)
			end

			if arg_365_1.time_ >= 1.1 + var_368_8 and arg_365_1.time_ < 1.1 + var_368_8 + arg_368_0 then
				var_368_7.localPosition = Vector3.New(0, 1, 4)
			end

			local var_368_9 = arg_365_1.bgs_.MS2114.transform

			if 1.11666666666667 < arg_365_1.time_ and arg_365_1.time_ <= 1.11666666666667 + arg_368_0 then
				arg_365_1.var_.moveOldPosMS2114 = var_368_9.localPosition
			end

			local var_368_10 = 3.95

			if 1.11666666666667 <= arg_365_1.time_ and arg_365_1.time_ < 1.11666666666667 + var_368_10 then
				var_368_9.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPosMS2114, Vector3.New(0, 1.48, 5.31), (arg_365_1.time_ - 1.11666666666667) / var_368_10)
			end

			if arg_365_1.time_ >= 1.11666666666667 + var_368_10 and arg_365_1.time_ < 1.11666666666667 + var_368_10 + arg_368_0 then
				var_368_9.localPosition = Vector3.New(0, 1.48, 5.31)
			end

			local var_368_11 = 0

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_11 + arg_368_0 then
				arg_365_1.allBtn_.enabled = false
			end

			if arg_365_1.time_ >= var_368_11 + 4.4 and arg_365_1.time_ < var_368_11 + 4.4 + arg_368_0 then
				arg_365_1.allBtn_.enabled = true
			end

			if arg_365_1.frameCnt_ <= 1 then
				arg_365_1.dialog_:SetActive(false)
			end

			local var_368_12 = 2.499999999999
			local var_368_13 = 0.125

			if 2.499999999999 < arg_365_1.time_ and arg_365_1.time_ <= var_368_12 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0

				arg_365_1.dialog_:SetActive(true)

				arg_365_1.dialogCg_.alpha = 0

				local var_368_14 = LeanTween.value(arg_365_1.dialog_, 0, 1, 0.3)

				var_368_14:setOnUpdate(LuaHelper.FloatAction(function(arg_369_0)
					arg_365_1.dialogCg_.alpha = arg_369_0
				end))
				var_368_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_365_1.dialog_)
					var_368_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_365_1.duration_ = arg_365_1.duration_ + 0.3

				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_15 = arg_365_1:GetWordFromCfg(321251085)
				local var_368_16 = arg_365_1:FormatText(var_368_15.content)

				arg_365_1.text_.text = var_368_16

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_18 = 5 <= 0 and var_368_13 or var_368_13 * (utf8.len(var_368_16) / 5)

				if (5 <= 0 and var_368_13 or var_368_13 * (utf8.len(var_368_16) / 5)) > 0 and var_368_13 < var_368_18 then
					arg_365_1.talkMaxDuration = var_368_18
					var_368_12 = var_368_12 + 0.3

					if var_368_18 + var_368_12 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_18 + var_368_12
					end
				end

				arg_365_1.text_.text = var_368_16
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251085", "story_v_out_321251.awb") ~= 0 then
					local var_368_19 = manager.audio:GetVoiceLength("story_v_out_321251", "321251085", "story_v_out_321251.awb") / 1000

					if var_368_19 + var_368_12 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_19 + var_368_12
					end

					if var_368_15.prefab_name ~= "" and arg_365_1.actors_[var_368_15.prefab_name] ~= nil then
						local var_368_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_15.prefab_name].transform, "story_v_out_321251", "321251085", "story_v_out_321251.awb")

						arg_365_1:RecordAudio("321251085", var_368_20)
						arg_365_1:RecordAudio("321251085", var_368_20)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_321251", "321251085", "story_v_out_321251.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_321251", "321251085", "story_v_out_321251.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_21 = var_368_12 + 0.3
			local var_368_22 = math.max(var_368_13, arg_365_1.talkMaxDuration)

			if var_368_12 + 0.3 <= arg_365_1.time_ and arg_365_1.time_ < var_368_21 + var_368_22 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_21) / var_368_22

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_21 + var_368_22 and arg_365_1.time_ < var_368_21 + var_368_22 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2114",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666666,
				className = "StoryMoveNode",
				startTime = 1.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2114",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.95,
				className = "StoryMoveNode",
				startTime = 1.11666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_365_1:InitPlayNodeList()
	end,
	Play321251086 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 321251086
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play321251087(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.moveOldPos1011ui_story = arg_371_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_374_0 = 0.001

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 then
				arg_371_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_371_1.time_ - 0) / var_374_0)
				arg_371_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1011ui_story"].transform.position).z)
				arg_371_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1011ui_story"].transform.localEulerAngles = arg_371_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 then
				arg_371_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_371_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1011ui_story"].transform.position).z)
				arg_371_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1011ui_story"].transform.localEulerAngles = arg_371_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_374_1 = arg_371_1.actors_["1011ui_story"]

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(var_374_1) and arg_371_1.var_.characterEffect1011ui_story == nil then
				arg_371_1.var_.characterEffect1011ui_story = var_374_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_2 = 0.200000002980232

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_2 and not isNil(var_374_1) then
				if arg_371_1.var_.characterEffect1011ui_story and not isNil(var_374_1) then
					arg_371_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_371_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_371_1.time_ - 0) / var_374_2)
				end
			end

			if arg_371_1.time_ >= 0 + var_374_2 and arg_371_1.time_ < 0 + var_374_2 + arg_374_0 and not isNil(var_374_1) and arg_371_1.var_.characterEffect1011ui_story then
				arg_371_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_371_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0.034000001847744 < arg_371_1.time_ and arg_371_1.time_ <= 0.034000001847744 + arg_374_0 then
				arg_371_1:AudioAction("play", "effect", "se_story_140", "se_story_140_scythe7", "")
			end

			local var_374_4 = 0
			local var_374_5 = 0.8

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_4 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_6 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(321251086).content)

				arg_371_1.text_.text = var_374_6

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_8 = 32 <= 0 and var_374_5 or var_374_5 * (utf8.len(var_374_6) / 32)

				if (32 <= 0 and var_374_5 or var_374_5 * (utf8.len(var_374_6) / 32)) > 0 and var_374_5 < var_374_8 then
					arg_371_1.talkMaxDuration = var_374_8

					if var_374_8 + var_374_4 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_8 + var_374_4
					end
				end

				arg_371_1.text_.text = var_374_6
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_9 = math.max(var_374_5, arg_371_1.talkMaxDuration)

			if var_374_4 <= arg_371_1.time_ and arg_371_1.time_ < var_374_4 + var_374_9 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_4) / var_374_9

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_4 + var_374_9 and arg_371_1.time_ < var_374_4 + var_374_9 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play321251087 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 321251087
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play321251088(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0.95

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, false)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_1 = arg_375_1:FormatText(arg_375_1:GetWordFromCfg(321251087).content)

				arg_375_1.text_.text = var_378_1

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_3 = 38 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_1) / 38)

				if (38 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_1) / 38)) > 0 and var_378_0 < var_378_3 then
					arg_375_1.talkMaxDuration = var_378_3

					if var_378_3 + 0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_3 + 0
					end
				end

				arg_375_1.text_.text = var_378_1
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_4 = math.max(var_378_0, arg_375_1.talkMaxDuration)

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_4 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - 0) / var_378_4

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= 0 + var_378_4 and arg_375_1.time_ < 0 + var_378_4 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play321251088 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 321251088
		arg_379_1.duration_ = 4.43

		local var_379_0 = {
			zh = 4.433,
			ja = 3.833
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
			arg_379_1.auto_ = false
		end

		function arg_379_1.playNext_(arg_381_0)
			arg_379_1.onStoryFinished_()
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(arg_379_1.actors_["1011ui_story"]) and arg_379_1.var_.characterEffect1011ui_story == nil then
				arg_379_1.var_.characterEffect1011ui_story = arg_379_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_0 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 and not isNil(arg_379_1.actors_["1011ui_story"]) then
				if arg_379_1.var_.characterEffect1011ui_story and not isNil(arg_379_1.actors_["1011ui_story"]) then
					arg_379_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 and not isNil(arg_379_1.actors_["1011ui_story"]) and arg_379_1.var_.characterEffect1011ui_story then
				arg_379_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_382_2 = 0
			local var_382_3 = 0.3

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_2 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_4 = arg_379_1:GetWordFromCfg(321251088)
				local var_382_5 = arg_379_1:FormatText(var_382_4.content)

				arg_379_1.text_.text = var_382_5

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_7 = 12 <= 0 and var_382_3 or var_382_3 * (utf8.len(var_382_5) / 12)

				if (12 <= 0 and var_382_3 or var_382_3 * (utf8.len(var_382_5) / 12)) > 0 and var_382_3 < var_382_7 then
					arg_379_1.talkMaxDuration = var_382_7

					if var_382_7 + var_382_2 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_7 + var_382_2
					end
				end

				arg_379_1.text_.text = var_382_5
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321251", "321251088", "story_v_out_321251.awb") ~= 0 then
					local var_382_8 = manager.audio:GetVoiceLength("story_v_out_321251", "321251088", "story_v_out_321251.awb") / 1000

					if var_382_8 + var_382_2 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_8 + var_382_2
					end

					if var_382_4.prefab_name ~= "" and arg_379_1.actors_[var_382_4.prefab_name] ~= nil then
						local var_382_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_4.prefab_name].transform, "story_v_out_321251", "321251088", "story_v_out_321251.awb")

						arg_379_1:RecordAudio("321251088", var_382_9)
						arg_379_1:RecordAudio("321251088", var_382_9)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_321251", "321251088", "story_v_out_321251.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_321251", "321251088", "story_v_out_321251.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_10 = math.max(var_382_3, arg_379_1.talkMaxDuration)

			if var_382_2 <= arg_379_1.time_ and arg_379_1.time_ < var_382_2 + var_382_10 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_2) / var_382_10

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_2 + var_382_10 and arg_379_1.time_ < var_382_2 + var_382_10 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/MS2108",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/Q01f",
		"TextureConfig/Background/L05j",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/MS2107",
		"TextureConfig/Background/MS2114",
		"SofdecAsset/story/story_1032125.usm"
	},
	voices = {
		"story_v_out_321251.awb"
	},
	skipMarkers = {
		321251077
	}
}
