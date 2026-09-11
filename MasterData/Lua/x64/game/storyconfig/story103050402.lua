return {
	Play305042001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 305042001
		arg_1_1.duration_ = 7.6

		local var_1_0 = {
			zh = 7.6,
			ja = 7.466
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play305042002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.B04g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B04g")
				var_4_0.name = "B04g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B04g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B04g

				arg_1_1.bgs_.B04g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B04g" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "1148ui_story"

			if arg_1_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_1_1.stage_.transform)

				var_4_10.name = var_4_9
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_9] = var_4_10

				local var_4_11 = var_4_10:GetComponentInChildren(typeof(CharacterEffect))

				var_4_11.enabled = true

				local var_4_12 = GameObjectTools.GetOrAddComponent(var_4_10, typeof(DynamicBoneHelper))

				if var_4_12 then
					var_4_12:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_11.transform, false)

				arg_1_1.var_[var_4_9 .. "Animator"] = var_4_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_9 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_9 .. "LipSync"] = var_4_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_13 = arg_1_1.actors_["1148ui_story"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect1148ui_story == nil then
				arg_1_1.var_.characterEffect1148ui_story = var_4_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_14 = 0.200000002980232

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_14 and not isNil(var_4_13) then
				if arg_1_1.var_.characterEffect1148ui_story and not isNil(var_4_13) then
					arg_1_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_14 and arg_1_1.time_ < 0 + var_4_14 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect1148ui_story then
				arg_1_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_drone02", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous.awb")

				local var_4_19 = manager.audio:GetAudioName("bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_19 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_19

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_19
						arg_1_1.bgmTxt2_.text = var_4_19
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_21 = 1.5
			local var_4_22 = 0.8

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_23 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_23:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_24 = arg_1_1:GetWordFromCfg(305042001)
				local var_4_25 = arg_1_1:FormatText(var_4_24.content)

				arg_1_1.text_.text = var_4_25

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_27 = 32 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 32)

				if (32 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 32)) > 0 and var_4_22 < var_4_27 then
					arg_1_1.talkMaxDuration = var_4_27
					var_4_21 = var_4_21 + 0.3

					if var_4_27 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_21
					end
				end

				arg_1_1.text_.text = var_4_25
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042001", "story_v_out_305042.awb") ~= 0 then
					local var_4_28 = manager.audio:GetVoiceLength("story_v_out_305042", "305042001", "story_v_out_305042.awb") / 1000

					if var_4_28 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_21
					end

					if var_4_24.prefab_name ~= "" and arg_1_1.actors_[var_4_24.prefab_name] ~= nil then
						local var_4_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_24.prefab_name].transform, "story_v_out_305042", "305042001", "story_v_out_305042.awb")

						arg_1_1:RecordAudio("305042001", var_4_29)
						arg_1_1:RecordAudio("305042001", var_4_29)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_305042", "305042001", "story_v_out_305042.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_305042", "305042001", "story_v_out_305042.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_30 = var_4_21 + 0.3
			local var_4_31 = math.max(var_4_22, arg_1_1.talkMaxDuration)

			if var_4_21 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_30) / var_4_31

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play305042002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 305042002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play305042003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(arg_8_1.actors_["1148ui_story"]) and arg_8_1.var_.characterEffect1148ui_story == nil then
				arg_8_1.var_.characterEffect1148ui_story = arg_8_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_0 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 and not isNil(arg_8_1.actors_["1148ui_story"]) then
				if arg_8_1.var_.characterEffect1148ui_story and not isNil(arg_8_1.actors_["1148ui_story"]) then
					arg_8_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_0)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 and not isNil(arg_8_1.actors_["1148ui_story"]) and arg_8_1.var_.characterEffect1148ui_story then
				arg_8_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_11_1 = 0
			local var_11_2 = 1.5

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_3 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(305042002).content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 60 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 60)

				if (60 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 60)) > 0 and var_11_2 < var_11_5 then
					arg_8_1.talkMaxDuration = var_11_5

					if var_11_5 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + var_11_1
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_6 = math.max(var_11_2, arg_8_1.talkMaxDuration)

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_6 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_1) / var_11_6

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_1 + var_11_6 and arg_8_1.time_ < var_11_1 + var_11_6 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play305042003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 305042003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play305042004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.625

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(305042003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 25 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 25)

				if (25 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 25)) > 0 and var_15_0 < var_15_3 then
					arg_12_1.talkMaxDuration = var_15_3

					if var_15_3 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_3 + 0
					end
				end

				arg_12_1.text_.text = var_15_1
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_4 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_4

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play305042004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 305042004
		arg_16_1.duration_ = 8.67

		local var_16_0 = {
			zh = 7.7,
			ja = 8.666
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
				arg_16_0:Play305042005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1148ui_story = arg_16_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_19_0 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 then
				arg_16_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_16_1.time_ - 0) / var_19_0)
				arg_16_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1148ui_story"].transform.position).z)
				arg_16_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1148ui_story"].transform.localEulerAngles = arg_16_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 then
				arg_16_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_16_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1148ui_story"].transform.position).z)
				arg_16_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1148ui_story"].transform.localEulerAngles = arg_16_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_19_1 = arg_16_1.actors_["1148ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_1) and arg_16_1.var_.characterEffect1148ui_story == nil then
				arg_16_1.var_.characterEffect1148ui_story = var_19_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_2 and not isNil(var_19_1) then
				if arg_16_1.var_.characterEffect1148ui_story and not isNil(var_19_1) then
					arg_16_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_2 and arg_16_1.time_ < 0 + var_19_2 + arg_19_0 and not isNil(var_19_1) and arg_16_1.var_.characterEffect1148ui_story then
				arg_16_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_19_4 = 0
			local var_19_5 = 0.975

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_6 = arg_16_1:GetWordFromCfg(305042004)
				local var_19_7 = arg_16_1:FormatText(var_19_6.content)

				arg_16_1.text_.text = var_19_7

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_9 = 39 <= 0 and var_19_5 or var_19_5 * (utf8.len(var_19_7) / 39)

				if (39 <= 0 and var_19_5 or var_19_5 * (utf8.len(var_19_7) / 39)) > 0 and var_19_5 < var_19_9 then
					arg_16_1.talkMaxDuration = var_19_9

					if var_19_9 + var_19_4 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_9 + var_19_4
					end
				end

				arg_16_1.text_.text = var_19_7
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042004", "story_v_out_305042.awb") ~= 0 then
					local var_19_10 = manager.audio:GetVoiceLength("story_v_out_305042", "305042004", "story_v_out_305042.awb") / 1000

					if var_19_10 + var_19_4 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_10 + var_19_4
					end

					if var_19_6.prefab_name ~= "" and arg_16_1.actors_[var_19_6.prefab_name] ~= nil then
						local var_19_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_6.prefab_name].transform, "story_v_out_305042", "305042004", "story_v_out_305042.awb")

						arg_16_1:RecordAudio("305042004", var_19_11)
						arg_16_1:RecordAudio("305042004", var_19_11)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_305042", "305042004", "story_v_out_305042.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_305042", "305042004", "story_v_out_305042.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_12 = math.max(var_19_5, arg_16_1.talkMaxDuration)

			if var_19_4 <= arg_16_1.time_ and arg_16_1.time_ < var_19_4 + var_19_12 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_4) / var_19_12

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_4 + var_19_12 and arg_16_1.time_ < var_19_4 + var_19_12 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play305042005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 305042005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play305042006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1148ui_story"]) and arg_20_1.var_.characterEffect1148ui_story == nil then
				arg_20_1.var_.characterEffect1148ui_story = arg_20_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1148ui_story"]) then
				if arg_20_1.var_.characterEffect1148ui_story and not isNil(arg_20_1.actors_["1148ui_story"]) then
					arg_20_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_0)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1148ui_story"]) and arg_20_1.var_.characterEffect1148ui_story then
				arg_20_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_23_1 = 0
			local var_23_2 = 0.475

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_3 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(305042005).content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 19 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_3) / 19)

				if (19 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_3) / 19)) > 0 and var_23_2 < var_23_5 then
					arg_20_1.talkMaxDuration = var_23_5

					if var_23_5 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + var_23_1
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_6 = math.max(var_23_2, arg_20_1.talkMaxDuration)

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_6 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_1) / var_23_6

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_1 + var_23_6 and arg_20_1.time_ < var_23_1 + var_23_6 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play305042006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 305042006
		arg_24_1.duration_ = 14.07

		local var_24_0 = {
			zh = 10.3,
			ja = 14.066
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
				arg_24_0:Play305042007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1148ui_story"]) and arg_24_1.var_.characterEffect1148ui_story == nil then
				arg_24_1.var_.characterEffect1148ui_story = arg_24_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1148ui_story"]) then
				if arg_24_1.var_.characterEffect1148ui_story and not isNil(arg_24_1.actors_["1148ui_story"]) then
					arg_24_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1148ui_story"]) and arg_24_1.var_.characterEffect1148ui_story then
				arg_24_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_27_2 = 0
			local var_27_3 = 1.325

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_4 = arg_24_1:GetWordFromCfg(305042006)
				local var_27_5 = arg_24_1:FormatText(var_27_4.content)

				arg_24_1.text_.text = var_27_5

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_7 = 53 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_5) / 53)

				if (53 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_5) / 53)) > 0 and var_27_3 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_2
					end
				end

				arg_24_1.text_.text = var_27_5
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042006", "story_v_out_305042.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_305042", "305042006", "story_v_out_305042.awb") / 1000

					if var_27_8 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_2
					end

					if var_27_4.prefab_name ~= "" and arg_24_1.actors_[var_27_4.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_4.prefab_name].transform, "story_v_out_305042", "305042006", "story_v_out_305042.awb")

						arg_24_1:RecordAudio("305042006", var_27_9)
						arg_24_1:RecordAudio("305042006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_305042", "305042006", "story_v_out_305042.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_305042", "305042006", "story_v_out_305042.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_10 = math.max(var_27_3, arg_24_1.talkMaxDuration)

			if var_27_2 <= arg_24_1.time_ and arg_24_1.time_ < var_27_2 + var_27_10 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_2) / var_27_10

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_2 + var_27_10 and arg_24_1.time_ < var_27_2 + var_27_10 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play305042007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 305042007
		arg_28_1.duration_ = 12.03

		local var_28_0 = {
			zh = 6.966,
			ja = 12.033
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
				arg_28_0:Play305042008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action457")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_31_0 = 0
			local var_31_1 = 0.775

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_2 = arg_28_1:GetWordFromCfg(305042007)
				local var_31_3 = arg_28_1:FormatText(var_31_2.content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 31 <= 0 and var_31_1 or var_31_1 * (utf8.len(var_31_3) / 31)

				if (31 <= 0 and var_31_1 or var_31_1 * (utf8.len(var_31_3) / 31)) > 0 and var_31_1 < var_31_5 then
					arg_28_1.talkMaxDuration = var_31_5

					if var_31_5 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_3
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042007", "story_v_out_305042.awb") ~= 0 then
					local var_31_6 = manager.audio:GetVoiceLength("story_v_out_305042", "305042007", "story_v_out_305042.awb") / 1000

					if var_31_6 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_6 + var_31_0
					end

					if var_31_2.prefab_name ~= "" and arg_28_1.actors_[var_31_2.prefab_name] ~= nil then
						local var_31_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_2.prefab_name].transform, "story_v_out_305042", "305042007", "story_v_out_305042.awb")

						arg_28_1:RecordAudio("305042007", var_31_7)
						arg_28_1:RecordAudio("305042007", var_31_7)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_305042", "305042007", "story_v_out_305042.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_305042", "305042007", "story_v_out_305042.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_8 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_8 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_8

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_8 and arg_28_1.time_ < var_31_0 + var_31_8 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play305042008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 305042008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play305042009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1148ui_story"]) and arg_32_1.var_.characterEffect1148ui_story == nil then
				arg_32_1.var_.characterEffect1148ui_story = arg_32_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1148ui_story"]) then
				if arg_32_1.var_.characterEffect1148ui_story and not isNil(arg_32_1.actors_["1148ui_story"]) then
					arg_32_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_0)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1148ui_story"]) and arg_32_1.var_.characterEffect1148ui_story then
				arg_32_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_35_2 = 0
			local var_35_3 = 0.2

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_2 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_4 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(305042008).content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_6 = 8 <= 0 and var_35_3 or var_35_3 * (utf8.len(var_35_4) / 8)

				if (8 <= 0 and var_35_3 or var_35_3 * (utf8.len(var_35_4) / 8)) > 0 and var_35_3 < var_35_6 then
					arg_32_1.talkMaxDuration = var_35_6

					if var_35_6 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_6 + var_35_2
					end
				end

				arg_32_1.text_.text = var_35_4
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = math.max(var_35_3, arg_32_1.talkMaxDuration)

			if var_35_2 <= arg_32_1.time_ and arg_32_1.time_ < var_35_2 + var_35_7 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_2) / var_35_7

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_2 + var_35_7 and arg_32_1.time_ < var_35_2 + var_35_7 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play305042009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 305042009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play305042010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1148ui_story = arg_36_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_39_0 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 then
				arg_36_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_0)
				arg_36_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1148ui_story"].transform.position).z)
				arg_36_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1148ui_story"].transform.localEulerAngles = arg_36_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 then
				arg_36_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1148ui_story"].transform.position).z)
				arg_36_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1148ui_story"].transform.localEulerAngles = arg_36_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_39_1 = 0
			local var_39_2 = 0.85

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_3 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(305042009).content)

				arg_36_1.text_.text = var_39_3

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 34 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_3) / 34)

				if (34 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_3) / 34)) > 0 and var_39_2 < var_39_5 then
					arg_36_1.talkMaxDuration = var_39_5

					if var_39_5 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + var_39_1
					end
				end

				arg_36_1.text_.text = var_39_3
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_6 = math.max(var_39_2, arg_36_1.talkMaxDuration)

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_6 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_1) / var_39_6

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_1 + var_39_6 and arg_36_1.time_ < var_39_1 + var_39_6 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play305042010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 305042010
		arg_40_1.duration_ = 8.9

		local var_40_0 = {
			zh = 8.4,
			ja = 8.9
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play305042011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if arg_40_1.actors_["10002ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10002ui_story"))) then
				local var_43_0 = Object.Instantiate(Asset.Load("Char/" .. "10002ui_story"), arg_40_1.stage_.transform)

				var_43_0.name = "10002ui_story"
				var_43_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.actors_["10002ui_story"] = var_43_0

				local var_43_1 = var_43_0:GetComponentInChildren(typeof(CharacterEffect))

				var_43_1.enabled = true

				local var_43_2 = GameObjectTools.GetOrAddComponent(var_43_0, typeof(DynamicBoneHelper))

				if var_43_2 then
					var_43_2:EnableDynamicBone(false)
				end

				arg_40_1:ShowWeapon(var_43_1.transform, false)

				arg_40_1.var_["10002ui_story" .. "Animator"] = var_43_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_40_1.var_["10002ui_story" .. "Animator"].applyRootMotion = true
				arg_40_1.var_["10002ui_story" .. "LipSync"] = var_43_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_43_3 = arg_40_1.actors_["10002ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos10002ui_story = var_43_3.localPosition
			end

			local var_43_4 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_4 then
				var_43_3.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10002ui_story, Vector3.New(0, -1.2, -5.8), (arg_40_1.time_ - 0) / var_43_4)
				var_43_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_3.position).x, (manager.ui.mainCamera.transform.position - var_43_3.position).y, (manager.ui.mainCamera.transform.position - var_43_3.position).z)
				var_43_3.localEulerAngles.z = 0
				var_43_3.localEulerAngles.x = 0
				var_43_3.localEulerAngles = var_43_3.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_4 and arg_40_1.time_ < 0 + var_43_4 + arg_43_0 then
				var_43_3.localPosition = Vector3.New(0, -1.2, -5.8)
				var_43_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_3.position).x, (manager.ui.mainCamera.transform.position - var_43_3.position).y, (manager.ui.mainCamera.transform.position - var_43_3.position).z)
				var_43_3.localEulerAngles.z = 0
				var_43_3.localEulerAngles.x = 0
				var_43_3.localEulerAngles = var_43_3.localEulerAngles
			end

			local var_43_5 = arg_40_1.actors_["10002ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_5) and arg_40_1.var_.characterEffect10002ui_story == nil then
				arg_40_1.var_.characterEffect10002ui_story = var_43_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_6 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_6 and not isNil(var_43_5) then
				if arg_40_1.var_.characterEffect10002ui_story and not isNil(var_43_5) then
					arg_40_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_6 and arg_40_1.time_ < 0 + var_43_6 + arg_43_0 and not isNil(var_43_5) and arg_40_1.var_.characterEffect10002ui_story then
				arg_40_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_1")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			if 1 < arg_40_1.time_ and arg_40_1.time_ <= 1 + arg_43_0 then
				arg_40_1:AudioAction("play", "music", "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin.awb")

				local var_43_10 = manager.audio:GetAudioName("bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin")

				if "" ~= "" then
					if arg_40_1.bgmTxt_.text ~= var_43_10 and arg_40_1.bgmTxt_.text ~= "" then
						if arg_40_1.bgmTxt2_.text ~= "" then
							arg_40_1.bgmTxt_.text = arg_40_1.bgmTxt2_.text
						end

						arg_40_1.bgmTxt2_.text = var_43_10

						arg_40_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_40_1.bgmTxt_.text = var_43_10
						arg_40_1.bgmTxt2_.text = var_43_10
					end

					if arg_40_1.bgmTimer then
						arg_40_1.bgmTimer:Stop()

						arg_40_1.bgmTimer = nil
					end

					if arg_40_1.settingData.show_music_name == 1 then
						arg_40_1.musicController:SetSelectedState("show")
						arg_40_1.musicAnimator_:Play("open", 0, 0)

						if arg_40_1.settingData.music_time ~= 0 then
							arg_40_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_40_1.settingData.music_time), function()
								if arg_40_1 == nil or isNil(arg_40_1.bgmTxt_) then
									return
								end

								arg_40_1.musicController:SetSelectedState("hide")
								arg_40_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_43_11 = 0
			local var_43_12 = 0.9

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_11 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_13 = arg_40_1:GetWordFromCfg(305042010)
				local var_43_14 = arg_40_1:FormatText(var_43_13.content)

				arg_40_1.text_.text = var_43_14

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_16 = 36 <= 0 and var_43_12 or var_43_12 * (utf8.len(var_43_14) / 36)

				if (36 <= 0 and var_43_12 or var_43_12 * (utf8.len(var_43_14) / 36)) > 0 and var_43_12 < var_43_16 then
					arg_40_1.talkMaxDuration = var_43_16

					if var_43_16 + var_43_11 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_16 + var_43_11
					end
				end

				arg_40_1.text_.text = var_43_14
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042010", "story_v_out_305042.awb") ~= 0 then
					local var_43_17 = manager.audio:GetVoiceLength("story_v_out_305042", "305042010", "story_v_out_305042.awb") / 1000

					if var_43_17 + var_43_11 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_17 + var_43_11
					end

					if var_43_13.prefab_name ~= "" and arg_40_1.actors_[var_43_13.prefab_name] ~= nil then
						local var_43_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_13.prefab_name].transform, "story_v_out_305042", "305042010", "story_v_out_305042.awb")

						arg_40_1:RecordAudio("305042010", var_43_18)
						arg_40_1:RecordAudio("305042010", var_43_18)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_305042", "305042010", "story_v_out_305042.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_305042", "305042010", "story_v_out_305042.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_19 = math.max(var_43_12, arg_40_1.talkMaxDuration)

			if var_43_11 <= arg_40_1.time_ and arg_40_1.time_ < var_43_11 + var_43_19 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_11) / var_43_19

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_11 + var_43_19 and arg_40_1.time_ < var_43_11 + var_43_19 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play305042011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 305042011
		arg_45_1.duration_ = 9.23

		local var_45_0 = {
			zh = 6.1,
			ja = 9.233
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
				arg_45_0:Play305042012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.675

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:GetWordFromCfg(305042011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 27 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 27)

				if (27 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 27)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042011", "story_v_out_305042.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_305042", "305042011", "story_v_out_305042.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_305042", "305042011", "story_v_out_305042.awb")

						arg_45_1:RecordAudio("305042011", var_48_6)
						arg_45_1:RecordAudio("305042011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_305042", "305042011", "story_v_out_305042.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_305042", "305042011", "story_v_out_305042.awb")
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
	Play305042012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 305042012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play305042013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["10002ui_story"]) and arg_49_1.var_.characterEffect10002ui_story == nil then
				arg_49_1.var_.characterEffect10002ui_story = arg_49_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["10002ui_story"]) then
				if arg_49_1.var_.characterEffect10002ui_story and not isNil(arg_49_1.actors_["10002ui_story"]) then
					arg_49_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_49_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["10002ui_story"]) and arg_49_1.var_.characterEffect10002ui_story then
				arg_49_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_49_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_52_1 = 0
			local var_52_2 = 0.475

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(305042012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 19 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 19)

				if (19 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 19)) > 0 and var_52_2 < var_52_5 then
					arg_49_1.talkMaxDuration = var_52_5

					if var_52_5 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_6 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_6 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_6

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_6 and arg_49_1.time_ < var_52_1 + var_52_6 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play305042013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 305042013
		arg_53_1.duration_ = 10.43

		local var_53_0 = {
			zh = 8.433,
			ja = 10.433
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
				arg_53_0:Play305042014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["10002ui_story"]) and arg_53_1.var_.characterEffect10002ui_story == nil then
				arg_53_1.var_.characterEffect10002ui_story = arg_53_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["10002ui_story"]) then
				if arg_53_1.var_.characterEffect10002ui_story and not isNil(arg_53_1.actors_["10002ui_story"]) then
					arg_53_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["10002ui_story"]) and arg_53_1.var_.characterEffect10002ui_story then
				arg_53_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002actionlink/10002action432")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_56_2 = 0
			local var_56_3 = 1.025

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:GetWordFromCfg(305042013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 41 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 41)

				if (41 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 41)) > 0 and var_56_3 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042013", "story_v_out_305042.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_305042", "305042013", "story_v_out_305042.awb") / 1000

					if var_56_8 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_2
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_out_305042", "305042013", "story_v_out_305042.awb")

						arg_53_1:RecordAudio("305042013", var_56_9)
						arg_53_1:RecordAudio("305042013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_305042", "305042013", "story_v_out_305042.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_305042", "305042013", "story_v_out_305042.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_10 and arg_53_1.time_ < var_56_2 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play305042014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 305042014
		arg_57_1.duration_ = 11.37

		local var_57_0 = {
			zh = 11.366,
			ja = 9.166
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
				arg_57_0:Play305042015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 1.3

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:GetWordFromCfg(305042014)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 52 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 52)

				if (52 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 52)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042014", "story_v_out_305042.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_305042", "305042014", "story_v_out_305042.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_305042", "305042014", "story_v_out_305042.awb")

						arg_57_1:RecordAudio("305042014", var_60_6)
						arg_57_1:RecordAudio("305042014", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_305042", "305042014", "story_v_out_305042.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_305042", "305042014", "story_v_out_305042.awb")
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
	Play305042015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 305042015
		arg_61_1.duration_ = 11.83

		local var_61_0 = {
			zh = 8.766,
			ja = 11.833
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
				arg_61_0:Play305042016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.95

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:GetWordFromCfg(305042015)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 38 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 38)

				if (38 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 38)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042015", "story_v_out_305042.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_305042", "305042015", "story_v_out_305042.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_305042", "305042015", "story_v_out_305042.awb")

						arg_61_1:RecordAudio("305042015", var_64_6)
						arg_61_1:RecordAudio("305042015", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_305042", "305042015", "story_v_out_305042.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_305042", "305042015", "story_v_out_305042.awb")
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
	Play305042016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 305042016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play305042017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["10002ui_story"]) and arg_65_1.var_.characterEffect10002ui_story == nil then
				arg_65_1.var_.characterEffect10002ui_story = arg_65_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["10002ui_story"]) then
				if arg_65_1.var_.characterEffect10002ui_story and not isNil(arg_65_1.actors_["10002ui_story"]) then
					arg_65_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_0)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["10002ui_story"]) and arg_65_1.var_.characterEffect10002ui_story then
				arg_65_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_68_1 = 0
			local var_68_2 = 0.675

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(305042016).content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 27 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 27)

				if (27 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 27)) > 0 and var_68_2 < var_68_5 then
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
	Play305042017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 305042017
		arg_69_1.duration_ = 8.93

		local var_69_0 = {
			zh = 8.066,
			ja = 8.933
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
				arg_69_0:Play305042018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["10002ui_story"]) and arg_69_1.var_.characterEffect10002ui_story == nil then
				arg_69_1.var_.characterEffect10002ui_story = arg_69_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["10002ui_story"]) then
				if arg_69_1.var_.characterEffect10002ui_story and not isNil(arg_69_1.actors_["10002ui_story"]) then
					arg_69_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["10002ui_story"]) and arg_69_1.var_.characterEffect10002ui_story then
				arg_69_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action2_2")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_72_2 = 0
			local var_72_3 = 0.825

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_4 = arg_69_1:GetWordFromCfg(305042017)
				local var_72_5 = arg_69_1:FormatText(var_72_4.content)

				arg_69_1.text_.text = var_72_5

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_7 = 33 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 33)

				if (33 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 33)) > 0 and var_72_3 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_2
					end
				end

				arg_69_1.text_.text = var_72_5
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042017", "story_v_out_305042.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_305042", "305042017", "story_v_out_305042.awb") / 1000

					if var_72_8 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_2
					end

					if var_72_4.prefab_name ~= "" and arg_69_1.actors_[var_72_4.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_4.prefab_name].transform, "story_v_out_305042", "305042017", "story_v_out_305042.awb")

						arg_69_1:RecordAudio("305042017", var_72_9)
						arg_69_1:RecordAudio("305042017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_305042", "305042017", "story_v_out_305042.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_305042", "305042017", "story_v_out_305042.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_3, arg_69_1.talkMaxDuration)

			if var_72_2 <= arg_69_1.time_ and arg_69_1.time_ < var_72_2 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_2) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_2 + var_72_10 and arg_69_1.time_ < var_72_2 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play305042018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 305042018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play305042019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["10002ui_story"]) and arg_73_1.var_.characterEffect10002ui_story == nil then
				arg_73_1.var_.characterEffect10002ui_story = arg_73_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["10002ui_story"]) then
				if arg_73_1.var_.characterEffect10002ui_story and not isNil(arg_73_1.actors_["10002ui_story"]) then
					arg_73_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["10002ui_story"]) and arg_73_1.var_.characterEffect10002ui_story then
				arg_73_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_76_1 = 0
			local var_76_2 = 0.525

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(305042018).content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 21 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 21)

				if (21 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 21)) > 0 and var_76_2 < var_76_5 then
					arg_73_1.talkMaxDuration = var_76_5

					if var_76_5 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_6 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_6 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_6

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_6 and arg_73_1.time_ < var_76_1 + var_76_6 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play305042019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 305042019
		arg_77_1.duration_ = 3.47

		local var_77_0 = {
			zh = 3.466,
			ja = 0.999999999999
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
				arg_77_0:Play305042020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["10002ui_story"]) and arg_77_1.var_.characterEffect10002ui_story == nil then
				arg_77_1.var_.characterEffect10002ui_story = arg_77_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["10002ui_story"]) then
				if arg_77_1.var_.characterEffect10002ui_story and not isNil(arg_77_1.actors_["10002ui_story"]) then
					arg_77_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["10002ui_story"]) and arg_77_1.var_.characterEffect10002ui_story then
				arg_77_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_80_2 = 0
			local var_80_3 = 0.125

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_4 = arg_77_1:GetWordFromCfg(305042019)
				local var_80_5 = arg_77_1:FormatText(var_80_4.content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 5 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 5)

				if (5 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 5)) > 0 and var_80_3 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042019", "story_v_out_305042.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_305042", "305042019", "story_v_out_305042.awb") / 1000

					if var_80_8 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_2
					end

					if var_80_4.prefab_name ~= "" and arg_77_1.actors_[var_80_4.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_4.prefab_name].transform, "story_v_out_305042", "305042019", "story_v_out_305042.awb")

						arg_77_1:RecordAudio("305042019", var_80_9)
						arg_77_1:RecordAudio("305042019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_305042", "305042019", "story_v_out_305042.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_305042", "305042019", "story_v_out_305042.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_3, arg_77_1.talkMaxDuration)

			if var_80_2 <= arg_77_1.time_ and arg_77_1.time_ < var_80_2 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_2) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_2 + var_80_10 and arg_77_1.time_ < var_80_2 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play305042020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 305042020
		arg_81_1.duration_ = 13.23

		local var_81_0 = {
			zh = 10.6,
			ja = 13.233
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
				arg_81_0:Play305042021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_84_0 = 0
			local var_84_1 = 1.1

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_2 = arg_81_1:GetWordFromCfg(305042020)
				local var_84_3 = arg_81_1:FormatText(var_84_2.content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 44 <= 0 and var_84_1 or var_84_1 * (utf8.len(var_84_3) / 44)

				if (44 <= 0 and var_84_1 or var_84_1 * (utf8.len(var_84_3) / 44)) > 0 and var_84_1 < var_84_5 then
					arg_81_1.talkMaxDuration = var_84_5

					if var_84_5 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042020", "story_v_out_305042.awb") ~= 0 then
					local var_84_6 = manager.audio:GetVoiceLength("story_v_out_305042", "305042020", "story_v_out_305042.awb") / 1000

					if var_84_6 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_6 + var_84_0
					end

					if var_84_2.prefab_name ~= "" and arg_81_1.actors_[var_84_2.prefab_name] ~= nil then
						local var_84_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_2.prefab_name].transform, "story_v_out_305042", "305042020", "story_v_out_305042.awb")

						arg_81_1:RecordAudio("305042020", var_84_7)
						arg_81_1:RecordAudio("305042020", var_84_7)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_305042", "305042020", "story_v_out_305042.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_305042", "305042020", "story_v_out_305042.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_8 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_8 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_8

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_8 and arg_81_1.time_ < var_84_0 + var_84_8 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play305042021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 305042021
		arg_85_1.duration_ = 8.27

		local var_85_0 = {
			zh = 8.266,
			ja = 7.6
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
				arg_85_0:Play305042022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.875

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:GetWordFromCfg(305042021)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 35 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 35)

				if (35 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 35)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042021", "story_v_out_305042.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_out_305042", "305042021", "story_v_out_305042.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_out_305042", "305042021", "story_v_out_305042.awb")

						arg_85_1:RecordAudio("305042021", var_88_6)
						arg_85_1:RecordAudio("305042021", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_305042", "305042021", "story_v_out_305042.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_305042", "305042021", "story_v_out_305042.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play305042022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 305042022
		arg_89_1.duration_ = 13.87

		local var_89_0 = {
			zh = 12.566,
			ja = 13.866
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
				arg_89_0:Play305042023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 1.25

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:GetWordFromCfg(305042022)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 50 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 50)

				if (50 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 50)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042022", "story_v_out_305042.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_305042", "305042022", "story_v_out_305042.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_305042", "305042022", "story_v_out_305042.awb")

						arg_89_1:RecordAudio("305042022", var_92_6)
						arg_89_1:RecordAudio("305042022", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_305042", "305042022", "story_v_out_305042.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_305042", "305042022", "story_v_out_305042.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play305042023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 305042023
		arg_93_1.duration_ = 7

		local var_93_0 = {
			zh = 7,
			ja = 6.533
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
				arg_93_0:Play305042024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action4_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_96_0 = 0
			local var_96_1 = 0.625

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_2 = arg_93_1:GetWordFromCfg(305042023)
				local var_96_3 = arg_93_1:FormatText(var_96_2.content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 25 <= 0 and var_96_1 or var_96_1 * (utf8.len(var_96_3) / 25)

				if (25 <= 0 and var_96_1 or var_96_1 * (utf8.len(var_96_3) / 25)) > 0 and var_96_1 < var_96_5 then
					arg_93_1.talkMaxDuration = var_96_5

					if var_96_5 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042023", "story_v_out_305042.awb") ~= 0 then
					local var_96_6 = manager.audio:GetVoiceLength("story_v_out_305042", "305042023", "story_v_out_305042.awb") / 1000

					if var_96_6 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_0
					end

					if var_96_2.prefab_name ~= "" and arg_93_1.actors_[var_96_2.prefab_name] ~= nil then
						local var_96_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_2.prefab_name].transform, "story_v_out_305042", "305042023", "story_v_out_305042.awb")

						arg_93_1:RecordAudio("305042023", var_96_7)
						arg_93_1:RecordAudio("305042023", var_96_7)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_305042", "305042023", "story_v_out_305042.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_305042", "305042023", "story_v_out_305042.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_8 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_8 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_8

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_8 and arg_93_1.time_ < var_96_0 + var_96_8 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play305042024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 305042024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play305042025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["10002ui_story"]) and arg_97_1.var_.characterEffect10002ui_story == nil then
				arg_97_1.var_.characterEffect10002ui_story = arg_97_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["10002ui_story"]) then
				if arg_97_1.var_.characterEffect10002ui_story and not isNil(arg_97_1.actors_["10002ui_story"]) then
					arg_97_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["10002ui_story"]) and arg_97_1.var_.characterEffect10002ui_story then
				arg_97_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_100_1 = 0
			local var_100_2 = 0.325

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(305042024).content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 13 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 13)

				if (13 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 13)) > 0 and var_100_2 < var_100_5 then
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
	Play305042025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 305042025
		arg_101_1.duration_ = 10

		local var_101_0 = {
			zh = 10,
			ja = 7.233
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
				arg_101_0:Play305042026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["10002ui_story"]) and arg_101_1.var_.characterEffect10002ui_story == nil then
				arg_101_1.var_.characterEffect10002ui_story = arg_101_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["10002ui_story"]) then
				if arg_101_1.var_.characterEffect10002ui_story and not isNil(arg_101_1.actors_["10002ui_story"]) then
					arg_101_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["10002ui_story"]) and arg_101_1.var_.characterEffect10002ui_story then
				arg_101_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_104_2 = 0
			local var_104_3 = 0.725

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_2 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_4 = arg_101_1:GetWordFromCfg(305042025)
				local var_104_5 = arg_101_1:FormatText(var_104_4.content)

				arg_101_1.text_.text = var_104_5

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_7 = 29 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 29)

				if (29 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 29)) > 0 and var_104_3 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_2
					end
				end

				arg_101_1.text_.text = var_104_5
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042025", "story_v_out_305042.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_305042", "305042025", "story_v_out_305042.awb") / 1000

					if var_104_8 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_2
					end

					if var_104_4.prefab_name ~= "" and arg_101_1.actors_[var_104_4.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_4.prefab_name].transform, "story_v_out_305042", "305042025", "story_v_out_305042.awb")

						arg_101_1:RecordAudio("305042025", var_104_9)
						arg_101_1:RecordAudio("305042025", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_305042", "305042025", "story_v_out_305042.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_305042", "305042025", "story_v_out_305042.awb")
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
	Play305042026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 305042026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play305042027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["10002ui_story"]) and arg_105_1.var_.characterEffect10002ui_story == nil then
				arg_105_1.var_.characterEffect10002ui_story = arg_105_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["10002ui_story"]) then
				if arg_105_1.var_.characterEffect10002ui_story and not isNil(arg_105_1.actors_["10002ui_story"]) then
					arg_105_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_105_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_0)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["10002ui_story"]) and arg_105_1.var_.characterEffect10002ui_story then
				arg_105_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_105_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_108_1 = 0
			local var_108_2 = 0.7

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_3 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(305042026).content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 28 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 28)

				if (28 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 28)) > 0 and var_108_2 < var_108_5 then
					arg_105_1.talkMaxDuration = var_108_5

					if var_108_5 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + var_108_1
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_6 = math.max(var_108_2, arg_105_1.talkMaxDuration)

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_6 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_1) / var_108_6

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_1 + var_108_6 and arg_105_1.time_ < var_108_1 + var_108_6 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play305042027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 305042027
		arg_109_1.duration_ = 4.23

		local var_109_0 = {
			zh = 4.233,
			ja = 4.066
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
				arg_109_0:Play305042028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["10002ui_story"]) and arg_109_1.var_.characterEffect10002ui_story == nil then
				arg_109_1.var_.characterEffect10002ui_story = arg_109_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["10002ui_story"]) then
				if arg_109_1.var_.characterEffect10002ui_story and not isNil(arg_109_1.actors_["10002ui_story"]) then
					arg_109_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["10002ui_story"]) and arg_109_1.var_.characterEffect10002ui_story then
				arg_109_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action4_2")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_112_2 = 0
			local var_112_3 = 0.35

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_4 = arg_109_1:GetWordFromCfg(305042027)
				local var_112_5 = arg_109_1:FormatText(var_112_4.content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 14 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 14)

				if (14 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 14)) > 0 and var_112_3 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042027", "story_v_out_305042.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_305042", "305042027", "story_v_out_305042.awb") / 1000

					if var_112_8 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_2
					end

					if var_112_4.prefab_name ~= "" and arg_109_1.actors_[var_112_4.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_4.prefab_name].transform, "story_v_out_305042", "305042027", "story_v_out_305042.awb")

						arg_109_1:RecordAudio("305042027", var_112_9)
						arg_109_1:RecordAudio("305042027", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_305042", "305042027", "story_v_out_305042.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_305042", "305042027", "story_v_out_305042.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_3, arg_109_1.talkMaxDuration)

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_2) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_2 + var_112_10 and arg_109_1.time_ < var_112_2 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play305042028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 305042028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play305042029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10002ui_story = arg_113_1.actors_["10002ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["10002ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10002ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["10002ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10002ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10002ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10002ui_story"].transform.position).z)
				arg_113_1.actors_["10002ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10002ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10002ui_story"].transform.localEulerAngles = arg_113_1.actors_["10002ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["10002ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.actors_["10002ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10002ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10002ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10002ui_story"].transform.position).z)
				arg_113_1.actors_["10002ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10002ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10002ui_story"].transform.localEulerAngles = arg_113_1.actors_["10002ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["10002ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect10002ui_story == nil then
				arg_113_1.var_.characterEffect10002ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect10002ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_113_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_2)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect10002ui_story then
				arg_113_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_113_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_116_3 = 0
			local var_116_4 = 0.975

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_3 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_5 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(305042028).content)

				arg_113_1.text_.text = var_116_5

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_7 = 39 <= 0 and var_116_4 or var_116_4 * (utf8.len(var_116_5) / 39)

				if (39 <= 0 and var_116_4 or var_116_4 * (utf8.len(var_116_5) / 39)) > 0 and var_116_4 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_3 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_3
					end
				end

				arg_113_1.text_.text = var_116_5
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_8 = math.max(var_116_4, arg_113_1.talkMaxDuration)

			if var_116_3 <= arg_113_1.time_ and arg_113_1.time_ < var_116_3 + var_116_8 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_3) / var_116_8

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_3 + var_116_8 and arg_113_1.time_ < var_116_3 + var_116_8 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
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
	Play305042029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 305042029
		arg_117_1.duration_ = 16.13

		local var_117_0 = {
			zh = 8.8,
			ja = 16.133
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
				arg_117_0:Play305042030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if arg_117_1.actors_["1013ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1013ui_story"))) then
				local var_120_0 = Object.Instantiate(Asset.Load("Char/" .. "1013ui_story"), arg_117_1.stage_.transform)

				var_120_0.name = "1013ui_story"
				var_120_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_117_1.actors_["1013ui_story"] = var_120_0

				local var_120_1 = var_120_0:GetComponentInChildren(typeof(CharacterEffect))

				var_120_1.enabled = true

				local var_120_2 = GameObjectTools.GetOrAddComponent(var_120_0, typeof(DynamicBoneHelper))

				if var_120_2 then
					var_120_2:EnableDynamicBone(false)
				end

				arg_117_1:ShowWeapon(var_120_1.transform, false)

				arg_117_1.var_["1013ui_story" .. "Animator"] = var_120_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_117_1.var_["1013ui_story" .. "Animator"].applyRootMotion = true
				arg_117_1.var_["1013ui_story" .. "LipSync"] = var_120_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_120_3 = arg_117_1.actors_["1013ui_story"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1013ui_story = var_120_3.localPosition
			end

			local var_120_4 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				var_120_3.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1013ui_story, Vector3.New(0, -0.66, -6.15), (arg_117_1.time_ - 0) / var_120_4)
				var_120_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_3.position).x, (manager.ui.mainCamera.transform.position - var_120_3.position).y, (manager.ui.mainCamera.transform.position - var_120_3.position).z)
				var_120_3.localEulerAngles.z = 0
				var_120_3.localEulerAngles.x = 0
				var_120_3.localEulerAngles = var_120_3.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				var_120_3.localPosition = Vector3.New(0, -0.66, -6.15)
				var_120_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_3.position).x, (manager.ui.mainCamera.transform.position - var_120_3.position).y, (manager.ui.mainCamera.transform.position - var_120_3.position).z)
				var_120_3.localEulerAngles.z = 0
				var_120_3.localEulerAngles.x = 0
				var_120_3.localEulerAngles = var_120_3.localEulerAngles
			end

			local var_120_5 = arg_117_1.actors_["1013ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.characterEffect1013ui_story == nil then
				arg_117_1.var_.characterEffect1013ui_story = var_120_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_6 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_6 and not isNil(var_120_5) then
				if arg_117_1.var_.characterEffect1013ui_story and not isNil(var_120_5) then
					arg_117_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_6 and arg_117_1.time_ < 0 + var_120_6 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.characterEffect1013ui_story then
				arg_117_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action2_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_120_8 = 0
			local var_120_9 = 0.95

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_10 = arg_117_1:GetWordFromCfg(305042029)
				local var_120_11 = arg_117_1:FormatText(var_120_10.content)

				arg_117_1.text_.text = var_120_11

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_13 = 38 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_11) / 38)

				if (38 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_11) / 38)) > 0 and var_120_9 < var_120_13 then
					arg_117_1.talkMaxDuration = var_120_13

					if var_120_13 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_13 + var_120_8
					end
				end

				arg_117_1.text_.text = var_120_11
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042029", "story_v_out_305042.awb") ~= 0 then
					local var_120_14 = manager.audio:GetVoiceLength("story_v_out_305042", "305042029", "story_v_out_305042.awb") / 1000

					if var_120_14 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_14 + var_120_8
					end

					if var_120_10.prefab_name ~= "" and arg_117_1.actors_[var_120_10.prefab_name] ~= nil then
						local var_120_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_10.prefab_name].transform, "story_v_out_305042", "305042029", "story_v_out_305042.awb")

						arg_117_1:RecordAudio("305042029", var_120_15)
						arg_117_1:RecordAudio("305042029", var_120_15)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_305042", "305042029", "story_v_out_305042.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_305042", "305042029", "story_v_out_305042.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_16 = math.max(var_120_9, arg_117_1.talkMaxDuration)

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_16 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_8) / var_120_16

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_8 + var_120_16 and arg_117_1.time_ < var_120_8 + var_120_16 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play305042030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 305042030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play305042031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1013ui_story"]) and arg_121_1.var_.characterEffect1013ui_story == nil then
				arg_121_1.var_.characterEffect1013ui_story = arg_121_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1013ui_story"]) then
				if arg_121_1.var_.characterEffect1013ui_story and not isNil(arg_121_1.actors_["1013ui_story"]) then
					arg_121_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1013ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_0)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1013ui_story"]) and arg_121_1.var_.characterEffect1013ui_story then
				arg_121_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1013ui_story.fillRatio = 0.5
			end

			local var_124_1 = 0
			local var_124_2 = 0.8

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_3 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(305042030).content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 32 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 32)

				if (32 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 32)) > 0 and var_124_2 < var_124_5 then
					arg_121_1.talkMaxDuration = var_124_5

					if var_124_5 + var_124_1 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + var_124_1
					end
				end

				arg_121_1.text_.text = var_124_3
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_6 = math.max(var_124_2, arg_121_1.talkMaxDuration)

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_6 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_1) / var_124_6

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_1 + var_124_6 and arg_121_1.time_ < var_124_1 + var_124_6 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play305042031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 305042031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play305042032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.4

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_1 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(305042031).content)

				arg_125_1.text_.text = var_128_1

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_3 = 16 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 16)

				if (16 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 16)) > 0 and var_128_0 < var_128_3 then
					arg_125_1.talkMaxDuration = var_128_3

					if var_128_3 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_3 + 0
					end
				end

				arg_125_1.text_.text = var_128_1
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_4 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_4

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play305042032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 305042032
		arg_129_1.duration_ = 8.57

		local var_129_0 = {
			zh = 5,
			ja = 8.566
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play305042033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1013ui_story"]) and arg_129_1.var_.characterEffect1013ui_story == nil then
				arg_129_1.var_.characterEffect1013ui_story = arg_129_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1013ui_story"]) then
				if arg_129_1.var_.characterEffect1013ui_story and not isNil(arg_129_1.actors_["1013ui_story"]) then
					arg_129_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1013ui_story"]) and arg_129_1.var_.characterEffect1013ui_story then
				arg_129_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action425")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_132_2 = 0
			local var_132_3 = 0.675

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_2 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_4 = arg_129_1:GetWordFromCfg(305042032)
				local var_132_5 = arg_129_1:FormatText(var_132_4.content)

				arg_129_1.text_.text = var_132_5

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_7 = 27 <= 0 and var_132_3 or var_132_3 * (utf8.len(var_132_5) / 27)

				if (27 <= 0 and var_132_3 or var_132_3 * (utf8.len(var_132_5) / 27)) > 0 and var_132_3 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_2 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_2
					end
				end

				arg_129_1.text_.text = var_132_5
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042032", "story_v_out_305042.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_out_305042", "305042032", "story_v_out_305042.awb") / 1000

					if var_132_8 + var_132_2 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_2
					end

					if var_132_4.prefab_name ~= "" and arg_129_1.actors_[var_132_4.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_4.prefab_name].transform, "story_v_out_305042", "305042032", "story_v_out_305042.awb")

						arg_129_1:RecordAudio("305042032", var_132_9)
						arg_129_1:RecordAudio("305042032", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_305042", "305042032", "story_v_out_305042.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_305042", "305042032", "story_v_out_305042.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_10 = math.max(var_132_3, arg_129_1.talkMaxDuration)

			if var_132_2 <= arg_129_1.time_ and arg_129_1.time_ < var_132_2 + var_132_10 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_2) / var_132_10

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_2 + var_132_10 and arg_129_1.time_ < var_132_2 + var_132_10 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play305042033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 305042033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play305042034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1013ui_story"]) and arg_133_1.var_.characterEffect1013ui_story == nil then
				arg_133_1.var_.characterEffect1013ui_story = arg_133_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1013ui_story"]) then
				if arg_133_1.var_.characterEffect1013ui_story and not isNil(arg_133_1.actors_["1013ui_story"]) then
					arg_133_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1013ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_0)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1013ui_story"]) and arg_133_1.var_.characterEffect1013ui_story then
				arg_133_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1013ui_story.fillRatio = 0.5
			end

			local var_136_1 = arg_133_1.actors_["1013ui_story"].transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1013ui_story = var_136_1.localPosition
			end

			local var_136_2 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 then
				var_136_1.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1013ui_story, Vector3.New(0, 100, 0), (arg_133_1.time_ - 0) / var_136_2)
				var_136_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_1.position).x, (manager.ui.mainCamera.transform.position - var_136_1.position).y, (manager.ui.mainCamera.transform.position - var_136_1.position).z)
				var_136_1.localEulerAngles.z = 0
				var_136_1.localEulerAngles.x = 0
				var_136_1.localEulerAngles = var_136_1.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 then
				var_136_1.localPosition = Vector3.New(0, 100, 0)
				var_136_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_1.position).x, (manager.ui.mainCamera.transform.position - var_136_1.position).y, (manager.ui.mainCamera.transform.position - var_136_1.position).z)
				var_136_1.localEulerAngles.z = 0
				var_136_1.localEulerAngles.x = 0
				var_136_1.localEulerAngles = var_136_1.localEulerAngles
			end

			local var_136_3 = 0
			local var_136_4 = 1.1

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_3 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_5 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(305042033).content)

				arg_133_1.text_.text = var_136_5

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_7 = 44 <= 0 and var_136_4 or var_136_4 * (utf8.len(var_136_5) / 44)

				if (44 <= 0 and var_136_4 or var_136_4 * (utf8.len(var_136_5) / 44)) > 0 and var_136_4 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_3 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_3
					end
				end

				arg_133_1.text_.text = var_136_5
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_8 = math.max(var_136_4, arg_133_1.talkMaxDuration)

			if var_136_3 <= arg_133_1.time_ and arg_133_1.time_ < var_136_3 + var_136_8 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_3) / var_136_8

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_3 + var_136_8 and arg_133_1.time_ < var_136_3 + var_136_8 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play305042034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 305042034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play305042035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_140_1 = 0
			local var_140_2 = 0.5

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_3 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(305042034).content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 20 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 20)

				if (20 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 20)) > 0 and var_140_2 < var_140_5 then
					arg_137_1.talkMaxDuration = var_140_5

					if var_140_5 + var_140_1 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + var_140_1
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_6 = math.max(var_140_2, arg_137_1.talkMaxDuration)

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_6 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_1) / var_140_6

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_1 + var_140_6 and arg_137_1.time_ < var_140_1 + var_140_6 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play305042035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 305042035
		arg_141_1.duration_ = 7.97

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play305042036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if arg_141_1.bgs_.B06a == nil then
				local var_144_0 = Object.Instantiate(arg_141_1.paintGo_)

				var_144_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B06a")
				var_144_0.name = "B06a"
				var_144_0.transform.parent = arg_141_1.stage_.transform
				var_144_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_141_1.bgs_.B06a = var_144_0
			end

			if 1.66666666666667 < arg_141_1.time_ and arg_141_1.time_ <= 1.66666666666667 + arg_144_0 then
				local var_144_1 = arg_141_1.bgs_.B06a

				arg_141_1.bgs_.B06a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_144_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_144_2 = var_144_1:GetComponent("SpriteRenderer")

				if var_144_2 and var_144_2.sprite then
					local var_144_3 = 2 * (var_144_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_144_1.transform.localScale = Vector3.New(var_144_3 / var_144_2.sprite.bounds.size.y < var_144_3 * manager.ui.mainCameraCom_.aspect / var_144_2.sprite.bounds.size.x and var_144_3 * manager.ui.mainCameraCom_.aspect / var_144_2.sprite.bounds.size.x or var_144_3 / var_144_2.sprite.bounds.size.y, var_144_3 / var_144_2.sprite.bounds.size.y < var_144_3 * manager.ui.mainCameraCom_.aspect / var_144_2.sprite.bounds.size.x and var_144_3 * manager.ui.mainCameraCom_.aspect / var_144_2.sprite.bounds.size.x or var_144_3 / var_144_2.sprite.bounds.size.y, 0)
				end

				for iter_144_0, iter_144_1 in pairs(arg_141_1.bgs_) do
					if iter_144_0 ~= "B06a" then
						iter_144_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_144_4 = 0

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.allBtn_.enabled = false
			end

			if arg_141_1.time_ >= var_144_4 + 0.3 and arg_141_1.time_ < var_144_4 + 0.3 + arg_144_0 then
				arg_141_1.allBtn_.enabled = true
			end

			local var_144_5 = 0

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1.mask_.enabled = true
				arg_141_1.mask_.raycastTarget = true

				arg_141_1:SetGaussion(false)
			end

			local var_144_6 = 1.66666666666667

			if var_144_5 <= arg_141_1.time_ and arg_141_1.time_ < var_144_5 + var_144_6 then
				local var_144_7 = Color.New(0, 0, 0)

				var_144_7.a = Mathf.Lerp(0, 1, (arg_141_1.time_ - var_144_5) / var_144_6)
				arg_141_1.mask_.color = var_144_7
			end

			if arg_141_1.time_ >= var_144_5 + var_144_6 and arg_141_1.time_ < var_144_5 + var_144_6 + arg_144_0 then
				local var_144_8 = Color.New(0, 0, 0)

				var_144_8.a = 1
				arg_141_1.mask_.color = var_144_8
			end

			local var_144_9 = 1.66666666666667

			if 1.66666666666667 < arg_141_1.time_ and arg_141_1.time_ <= var_144_9 + arg_144_0 then
				arg_141_1.mask_.enabled = true
				arg_141_1.mask_.raycastTarget = true

				arg_141_1:SetGaussion(false)
			end

			local var_144_10 = 1.66666666666667

			if var_144_9 <= arg_141_1.time_ and arg_141_1.time_ < var_144_9 + var_144_10 then
				local var_144_11 = Color.New(0, 0, 0)

				var_144_11.a = Mathf.Lerp(1, 0, (arg_141_1.time_ - var_144_9) / var_144_10)
				arg_141_1.mask_.color = var_144_11
			end

			if arg_141_1.time_ >= var_144_9 + var_144_10 and arg_141_1.time_ < var_144_9 + var_144_10 + arg_144_0 then
				local var_144_12 = Color.New(0, 0, 0)

				arg_141_1.mask_.enabled = false
				var_144_12.a = 0
				arg_141_1.mask_.color = var_144_12
			end

			local var_144_13 = arg_141_1.actors_["1013ui_story"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1013ui_story = var_144_13.localPosition
			end

			local var_144_14 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_14 then
				var_144_13.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1013ui_story, Vector3.New(0, 100, 0), (arg_141_1.time_ - 0) / var_144_14)
				var_144_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_13.position).x, (manager.ui.mainCamera.transform.position - var_144_13.position).y, (manager.ui.mainCamera.transform.position - var_144_13.position).z)
				var_144_13.localEulerAngles.z = 0
				var_144_13.localEulerAngles.x = 0
				var_144_13.localEulerAngles = var_144_13.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_14 and arg_141_1.time_ < 0 + var_144_14 + arg_144_0 then
				var_144_13.localPosition = Vector3.New(0, 100, 0)
				var_144_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_13.position).x, (manager.ui.mainCamera.transform.position - var_144_13.position).y, (manager.ui.mainCamera.transform.position - var_144_13.position).z)
				var_144_13.localEulerAngles.z = 0
				var_144_13.localEulerAngles.x = 0
				var_144_13.localEulerAngles = var_144_13.localEulerAngles
			end

			if 1.2 < arg_141_1.time_ and arg_141_1.time_ <= 1.2 + arg_144_0 then
				arg_141_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drone03", "")
			end

			if 0.2 < arg_141_1.time_ and arg_141_1.time_ <= 0.2 + arg_144_0 then
				arg_141_1:AudioAction("stop", "effect", "se_story_148", "se_story_148_amb_drone02", "")
			end

			if 1 < arg_141_1.time_ and arg_141_1.time_ <= 1 + arg_144_0 then
				arg_141_1:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_144_19 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if "" ~= "" then
					if arg_141_1.bgmTxt_.text ~= var_144_19 and arg_141_1.bgmTxt_.text ~= "" then
						if arg_141_1.bgmTxt2_.text ~= "" then
							arg_141_1.bgmTxt_.text = arg_141_1.bgmTxt2_.text
						end

						arg_141_1.bgmTxt2_.text = var_144_19

						arg_141_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_141_1.bgmTxt_.text = var_144_19
						arg_141_1.bgmTxt2_.text = var_144_19
					end

					if arg_141_1.bgmTimer then
						arg_141_1.bgmTimer:Stop()

						arg_141_1.bgmTimer = nil
					end

					if arg_141_1.settingData.show_music_name == 1 then
						arg_141_1.musicController:SetSelectedState("show")
						arg_141_1.musicAnimator_:Play("open", 0, 0)

						if arg_141_1.settingData.music_time ~= 0 then
							arg_141_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_141_1.settingData.music_time), function()
								if arg_141_1 == nil or isNil(arg_141_1.bgmTxt_) then
									return
								end

								arg_141_1.musicController:SetSelectedState("hide")
								arg_141_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_141_1.frameCnt_ <= 1 then
				arg_141_1.dialog_:SetActive(false)
			end

			local var_144_20 = 2.96666666666667
			local var_144_21 = 1.225

			if 2.96666666666667 < arg_141_1.time_ and arg_141_1.time_ <= var_144_20 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0

				arg_141_1.dialog_:SetActive(true)

				arg_141_1.dialogCg_.alpha = 0

				local var_144_22 = LeanTween.value(arg_141_1.dialog_, 0, 1, 0.3)

				var_144_22:setOnUpdate(LuaHelper.FloatAction(function(arg_146_0)
					arg_141_1.dialogCg_.alpha = arg_146_0
				end))
				var_144_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_141_1.dialog_)
					var_144_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_141_1.duration_ = arg_141_1.duration_ + 0.3

				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_23 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(305042035).content)

				arg_141_1.text_.text = var_144_23

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_25 = 49 <= 0 and var_144_21 or var_144_21 * (utf8.len(var_144_23) / 49)

				if (49 <= 0 and var_144_21 or var_144_21 * (utf8.len(var_144_23) / 49)) > 0 and var_144_21 < var_144_25 then
					arg_141_1.talkMaxDuration = var_144_25
					var_144_20 = var_144_20 + 0.3

					if var_144_25 + var_144_20 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_25 + var_144_20
					end
				end

				arg_141_1.text_.text = var_144_23
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_26 = var_144_20 + 0.3
			local var_144_27 = math.max(var_144_21, arg_141_1.talkMaxDuration)

			if var_144_20 + 0.3 <= arg_141_1.time_ and arg_141_1.time_ < var_144_26 + var_144_27 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_26) / var_144_27

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_26 + var_144_27 and arg_141_1.time_ < var_144_26 + var_144_27 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
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
	Play305042036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 305042036
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play305042037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0.475

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_1 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(305042036).content)

				arg_148_1.text_.text = var_151_1

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_3 = 19 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_1) / 19)

				if (19 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_1) / 19)) > 0 and var_151_0 < var_151_3 then
					arg_148_1.talkMaxDuration = var_151_3

					if var_151_3 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_3 + 0
					end
				end

				arg_148_1.text_.text = var_151_1
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_4 = math.max(var_151_0, arg_148_1.talkMaxDuration)

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_4 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - 0) / var_151_4

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= 0 + var_151_4 and arg_148_1.time_ < 0 + var_151_4 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play305042037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 305042037
		arg_152_1.duration_ = 3.7

		local var_152_0 = {
			zh = 3.7,
			ja = 1.999999999999
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play305042038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if arg_152_1.actors_["1166ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1166ui_story"))) then
				local var_155_0 = Object.Instantiate(Asset.Load("Char/" .. "1166ui_story"), arg_152_1.stage_.transform)

				var_155_0.name = "1166ui_story"
				var_155_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_152_1.actors_["1166ui_story"] = var_155_0

				local var_155_1 = var_155_0:GetComponentInChildren(typeof(CharacterEffect))

				var_155_1.enabled = true

				local var_155_2 = GameObjectTools.GetOrAddComponent(var_155_0, typeof(DynamicBoneHelper))

				if var_155_2 then
					var_155_2:EnableDynamicBone(false)
				end

				arg_152_1:ShowWeapon(var_155_1.transform, false)

				arg_152_1.var_["1166ui_story" .. "Animator"] = var_155_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_152_1.var_["1166ui_story" .. "Animator"].applyRootMotion = true
				arg_152_1.var_["1166ui_story" .. "LipSync"] = var_155_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_155_3 = arg_152_1.actors_["1166ui_story"].transform

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos1166ui_story = var_155_3.localPosition

				local var_155_4 = GameObjectTools.GetOrAddComponent(var_155_3.gameObject, typeof(DynamicBoneHelper))

				if var_155_4 then
					var_155_4:EnableDynamicBone(false)
				end
			end

			local var_155_5 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_5 then
				var_155_3.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1166ui_story, Vector3.New(0, -0.75, -6.25), (arg_152_1.time_ - 0) / var_155_5)
				var_155_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_3.position).x, (manager.ui.mainCamera.transform.position - var_155_3.position).y, (manager.ui.mainCamera.transform.position - var_155_3.position).z)
				var_155_3.localEulerAngles.z = 0
				var_155_3.localEulerAngles.x = 0
				var_155_3.localEulerAngles = var_155_3.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_5 and arg_152_1.time_ < 0 + var_155_5 + arg_155_0 then
				var_155_3.localPosition = Vector3.New(0, -0.75, -6.25)
				var_155_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_3.position).x, (manager.ui.mainCamera.transform.position - var_155_3.position).y, (manager.ui.mainCamera.transform.position - var_155_3.position).z)
				var_155_3.localEulerAngles.z = 0
				var_155_3.localEulerAngles.x = 0
				var_155_3.localEulerAngles = var_155_3.localEulerAngles

				local var_155_6 = GameObjectTools.GetOrAddComponent(var_155_3.gameObject, typeof(DynamicBoneHelper))

				if var_155_6 then
					var_155_6:EnableDynamicBone(true)
				end
			end

			local var_155_7 = arg_152_1.actors_["1166ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_7) and arg_152_1.var_.characterEffect1166ui_story == nil then
				arg_152_1.var_.characterEffect1166ui_story = var_155_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_8 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_8 and not isNil(var_155_7) then
				if arg_152_1.var_.characterEffect1166ui_story and not isNil(var_155_7) then
					arg_152_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_8 and arg_152_1.time_ < 0 + var_155_8 + arg_155_0 and not isNil(var_155_7) and arg_152_1.var_.characterEffect1166ui_story then
				arg_152_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action4_1")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_155_10 = 0
			local var_155_11 = 0.425

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_10 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_12 = arg_152_1:GetWordFromCfg(305042037)
				local var_155_13 = arg_152_1:FormatText(var_155_12.content)

				arg_152_1.text_.text = var_155_13

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_15 = 17 <= 0 and var_155_11 or var_155_11 * (utf8.len(var_155_13) / 17)

				if (17 <= 0 and var_155_11 or var_155_11 * (utf8.len(var_155_13) / 17)) > 0 and var_155_11 < var_155_15 then
					arg_152_1.talkMaxDuration = var_155_15

					if var_155_15 + var_155_10 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_15 + var_155_10
					end
				end

				arg_152_1.text_.text = var_155_13
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042037", "story_v_out_305042.awb") ~= 0 then
					local var_155_16 = manager.audio:GetVoiceLength("story_v_out_305042", "305042037", "story_v_out_305042.awb") / 1000

					if var_155_16 + var_155_10 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_16 + var_155_10
					end

					if var_155_12.prefab_name ~= "" and arg_152_1.actors_[var_155_12.prefab_name] ~= nil then
						local var_155_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_12.prefab_name].transform, "story_v_out_305042", "305042037", "story_v_out_305042.awb")

						arg_152_1:RecordAudio("305042037", var_155_17)
						arg_152_1:RecordAudio("305042037", var_155_17)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_305042", "305042037", "story_v_out_305042.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_305042", "305042037", "story_v_out_305042.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_18 = math.max(var_155_11, arg_152_1.talkMaxDuration)

			if var_155_10 <= arg_152_1.time_ and arg_152_1.time_ < var_155_10 + var_155_18 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_10) / var_155_18

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_10 + var_155_18 and arg_152_1.time_ < var_155_10 + var_155_18 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play305042038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 305042038
		arg_156_1.duration_ = 8.43

		local var_156_0 = {
			zh = 8.433,
			ja = 1.333
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play305042039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 1.025

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_1 = arg_156_1:GetWordFromCfg(305042038)
				local var_159_2 = arg_156_1:FormatText(var_159_1.content)

				arg_156_1.text_.text = var_159_2

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_4 = 41 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 41)

				if (41 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 41)) > 0 and var_159_0 < var_159_4 then
					arg_156_1.talkMaxDuration = var_159_4

					if var_159_4 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_4 + 0
					end
				end

				arg_156_1.text_.text = var_159_2
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042038", "story_v_out_305042.awb") ~= 0 then
					local var_159_5 = manager.audio:GetVoiceLength("story_v_out_305042", "305042038", "story_v_out_305042.awb") / 1000

					if var_159_5 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + 0
					end

					if var_159_1.prefab_name ~= "" and arg_156_1.actors_[var_159_1.prefab_name] ~= nil then
						local var_159_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_1.prefab_name].transform, "story_v_out_305042", "305042038", "story_v_out_305042.awb")

						arg_156_1:RecordAudio("305042038", var_159_6)
						arg_156_1:RecordAudio("305042038", var_159_6)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_305042", "305042038", "story_v_out_305042.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_305042", "305042038", "story_v_out_305042.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_7 = math.max(var_159_0, arg_156_1.talkMaxDuration)

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_7 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - 0) / var_159_7

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= 0 + var_159_7 and arg_156_1.time_ < 0 + var_159_7 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play305042039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 305042039
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play305042040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(arg_160_1.actors_["1166ui_story"]) and arg_160_1.var_.characterEffect1166ui_story == nil then
				arg_160_1.var_.characterEffect1166ui_story = arg_160_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_0 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 and not isNil(arg_160_1.actors_["1166ui_story"]) then
				if arg_160_1.var_.characterEffect1166ui_story and not isNil(arg_160_1.actors_["1166ui_story"]) then
					arg_160_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_160_1.time_ - 0) / var_163_0)
				end
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 and not isNil(arg_160_1.actors_["1166ui_story"]) and arg_160_1.var_.characterEffect1166ui_story then
				arg_160_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1166ui_story.fillRatio = 0.5
			end

			local var_163_1 = 0
			local var_163_2 = 0.65

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_3 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(305042039).content)

				arg_160_1.text_.text = var_163_3

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_5 = 26 <= 0 and var_163_2 or var_163_2 * (utf8.len(var_163_3) / 26)

				if (26 <= 0 and var_163_2 or var_163_2 * (utf8.len(var_163_3) / 26)) > 0 and var_163_2 < var_163_5 then
					arg_160_1.talkMaxDuration = var_163_5

					if var_163_5 + var_163_1 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_5 + var_163_1
					end
				end

				arg_160_1.text_.text = var_163_3
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_6 = math.max(var_163_2, arg_160_1.talkMaxDuration)

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_6 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_1) / var_163_6

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_1 + var_163_6 and arg_160_1.time_ < var_163_1 + var_163_6 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play305042040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 305042040
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play305042041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos1166ui_story = arg_164_1.actors_["1166ui_story"].transform.localPosition

				local var_167_0 = GameObjectTools.GetOrAddComponent(arg_164_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_167_0 then
					var_167_0:EnableDynamicBone(false)
				end
			end

			local var_167_1 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_1 then
				arg_164_1.actors_["1166ui_story"].transform.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1166ui_story, Vector3.New(0, 100, 0), (arg_164_1.time_ - 0) / var_167_1)
				arg_164_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1166ui_story"].transform.position).z)
				arg_164_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["1166ui_story"].transform.localEulerAngles = arg_164_1.actors_["1166ui_story"].transform.localEulerAngles
			end

			if arg_164_1.time_ >= 0 + var_167_1 and arg_164_1.time_ < 0 + var_167_1 + arg_167_0 then
				arg_164_1.actors_["1166ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_164_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1166ui_story"].transform.position).z)
				arg_164_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["1166ui_story"].transform.localEulerAngles = arg_164_1.actors_["1166ui_story"].transform.localEulerAngles

				local var_167_2 = GameObjectTools.GetOrAddComponent(arg_164_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_167_2 then
					var_167_2:EnableDynamicBone(true)
				end
			end

			local var_167_3 = 0
			local var_167_4 = 1.375

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_3 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_5 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(305042040).content)

				arg_164_1.text_.text = var_167_5

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_7 = 55 <= 0 and var_167_4 or var_167_4 * (utf8.len(var_167_5) / 55)

				if (55 <= 0 and var_167_4 or var_167_4 * (utf8.len(var_167_5) / 55)) > 0 and var_167_4 < var_167_7 then
					arg_164_1.talkMaxDuration = var_167_7

					if var_167_7 + var_167_3 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_7 + var_167_3
					end
				end

				arg_164_1.text_.text = var_167_5
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_8 = math.max(var_167_4, arg_164_1.talkMaxDuration)

			if var_167_3 <= arg_164_1.time_ and arg_164_1.time_ < var_167_3 + var_167_8 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_3) / var_167_8

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_3 + var_167_8 and arg_164_1.time_ < var_167_3 + var_167_8 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play305042041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 305042041
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play305042042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0.625

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_1 = arg_168_1:FormatText(arg_168_1:GetWordFromCfg(305042041).content)

				arg_168_1.text_.text = var_171_1

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_3 = 25 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_1) / 25)

				if (25 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_1) / 25)) > 0 and var_171_0 < var_171_3 then
					arg_168_1.talkMaxDuration = var_171_3

					if var_171_3 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_3 + 0
					end
				end

				arg_168_1.text_.text = var_171_1
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_4 = math.max(var_171_0, arg_168_1.talkMaxDuration)

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_4 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - 0) / var_171_4

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= 0 + var_171_4 and arg_168_1.time_ < 0 + var_171_4 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play305042042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 305042042
		arg_172_1.duration_ = 7.8

		local var_172_0 = {
			zh = 7.8,
			ja = 1.999999999999
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play305042043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if arg_172_1.actors_["1037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1037ui_story"))) then
				local var_175_0 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_172_1.stage_.transform)

				var_175_0.name = "1037ui_story"
				var_175_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_172_1.actors_["1037ui_story"] = var_175_0

				local var_175_1 = var_175_0:GetComponentInChildren(typeof(CharacterEffect))

				var_175_1.enabled = true

				local var_175_2 = GameObjectTools.GetOrAddComponent(var_175_0, typeof(DynamicBoneHelper))

				if var_175_2 then
					var_175_2:EnableDynamicBone(false)
				end

				arg_172_1:ShowWeapon(var_175_1.transform, false)

				arg_172_1.var_["1037ui_story" .. "Animator"] = var_175_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_172_1.var_["1037ui_story" .. "Animator"].applyRootMotion = true
				arg_172_1.var_["1037ui_story" .. "LipSync"] = var_175_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_175_3 = arg_172_1.actors_["1037ui_story"].transform

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.moveOldPos1037ui_story = var_175_3.localPosition
			end

			local var_175_4 = 0.001

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_4 then
				var_175_3.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_172_1.time_ - 0) / var_175_4)
				var_175_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_175_3.position).x, (manager.ui.mainCamera.transform.position - var_175_3.position).y, (manager.ui.mainCamera.transform.position - var_175_3.position).z)
				var_175_3.localEulerAngles.z = 0
				var_175_3.localEulerAngles.x = 0
				var_175_3.localEulerAngles = var_175_3.localEulerAngles
			end

			if arg_172_1.time_ >= 0 + var_175_4 and arg_172_1.time_ < 0 + var_175_4 + arg_175_0 then
				var_175_3.localPosition = Vector3.New(0, -1.09, -5.81)
				var_175_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_175_3.position).x, (manager.ui.mainCamera.transform.position - var_175_3.position).y, (manager.ui.mainCamera.transform.position - var_175_3.position).z)
				var_175_3.localEulerAngles.z = 0
				var_175_3.localEulerAngles.x = 0
				var_175_3.localEulerAngles = var_175_3.localEulerAngles
			end

			local var_175_5 = arg_172_1.actors_["1037ui_story"]

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(var_175_5) and arg_172_1.var_.characterEffect1037ui_story == nil then
				arg_172_1.var_.characterEffect1037ui_story = var_175_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_6 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_6 and not isNil(var_175_5) then
				if arg_172_1.var_.characterEffect1037ui_story and not isNil(var_175_5) then
					arg_172_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= 0 + var_175_6 and arg_172_1.time_ < 0 + var_175_6 + arg_175_0 and not isNil(var_175_5) and arg_172_1.var_.characterEffect1037ui_story then
				arg_172_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action5_1")
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0.034000001847744 < arg_172_1.time_ and arg_172_1.time_ <= 0.034000001847744 + arg_175_0 then
				if arg_172_1.var_.characterEffect1037ui_story == nil then
					arg_172_1.var_.characterEffect1037ui_story = arg_172_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_172_1.var_.characterEffect1037ui_story.imageEffect:turnOn(false)
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				if arg_172_1.var_.characterEffect1037ui_story == nil then
					arg_172_1.var_.characterEffect1037ui_story = arg_172_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_175_9 = arg_172_1.var_.characterEffect1037ui_story

				arg_172_1.var_.characterEffect1037ui_story.imageEffect:turnOff()

				var_175_9.interferenceEffect.enabled = true
				var_175_9.interferenceEffect.noise = 0.001
				var_175_9.interferenceEffect.simTimeScale = 1
				var_175_9.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_175_10 = 0
			local var_175_11 = 0.825

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_10 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_12 = arg_172_1:GetWordFromCfg(305042042)
				local var_175_13 = arg_172_1:FormatText(var_175_12.content)

				arg_172_1.text_.text = var_175_13

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_15 = 33 <= 0 and var_175_11 or var_175_11 * (utf8.len(var_175_13) / 33)

				if (33 <= 0 and var_175_11 or var_175_11 * (utf8.len(var_175_13) / 33)) > 0 and var_175_11 < var_175_15 then
					arg_172_1.talkMaxDuration = var_175_15

					if var_175_15 + var_175_10 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_15 + var_175_10
					end
				end

				arg_172_1.text_.text = var_175_13
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042042", "story_v_out_305042.awb") ~= 0 then
					local var_175_16 = manager.audio:GetVoiceLength("story_v_out_305042", "305042042", "story_v_out_305042.awb") / 1000

					if var_175_16 + var_175_10 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_16 + var_175_10
					end

					if var_175_12.prefab_name ~= "" and arg_172_1.actors_[var_175_12.prefab_name] ~= nil then
						local var_175_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_12.prefab_name].transform, "story_v_out_305042", "305042042", "story_v_out_305042.awb")

						arg_172_1:RecordAudio("305042042", var_175_17)
						arg_172_1:RecordAudio("305042042", var_175_17)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_305042", "305042042", "story_v_out_305042.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_305042", "305042042", "story_v_out_305042.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_18 = math.max(var_175_11, arg_172_1.talkMaxDuration)

			if var_175_10 <= arg_172_1.time_ and arg_172_1.time_ < var_175_10 + var_175_18 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_10) / var_175_18

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_10 + var_175_18 and arg_172_1.time_ < var_175_10 + var_175_18 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play305042043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 305042043
		arg_176_1.duration_ = 4.4

		local var_176_0 = {
			zh = 4.4,
			ja = 1.333
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play305042044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0.55

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_1 = arg_176_1:GetWordFromCfg(305042043)
				local var_179_2 = arg_176_1:FormatText(var_179_1.content)

				arg_176_1.text_.text = var_179_2

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_4 = 22 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_2) / 22)

				if (22 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_2) / 22)) > 0 and var_179_0 < var_179_4 then
					arg_176_1.talkMaxDuration = var_179_4

					if var_179_4 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_4 + 0
					end
				end

				arg_176_1.text_.text = var_179_2
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042043", "story_v_out_305042.awb") ~= 0 then
					local var_179_5 = manager.audio:GetVoiceLength("story_v_out_305042", "305042043", "story_v_out_305042.awb") / 1000

					if var_179_5 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_5 + 0
					end

					if var_179_1.prefab_name ~= "" and arg_176_1.actors_[var_179_1.prefab_name] ~= nil then
						local var_179_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_1.prefab_name].transform, "story_v_out_305042", "305042043", "story_v_out_305042.awb")

						arg_176_1:RecordAudio("305042043", var_179_6)
						arg_176_1:RecordAudio("305042043", var_179_6)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_305042", "305042043", "story_v_out_305042.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_305042", "305042043", "story_v_out_305042.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_7 = math.max(var_179_0, arg_176_1.talkMaxDuration)

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_7 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - 0) / var_179_7

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= 0 + var_179_7 and arg_176_1.time_ < 0 + var_179_7 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play305042044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 305042044
		arg_180_1.duration_ = 6.73

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play305042045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_9002
			local var_183_9001
			local var_183_9000

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos1037ui_story = arg_180_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_183_0 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 then
				arg_180_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_180_1.time_ - 0) / var_183_0)
				arg_180_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1037ui_story"].transform.position).z)
				arg_180_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["1037ui_story"].transform.localEulerAngles = arg_180_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 then
				arg_180_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_180_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1037ui_story"].transform.position).z)
				arg_180_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["1037ui_story"].transform.localEulerAngles = arg_180_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_183_1 = arg_180_1.actors_["1037ui_story"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_1) and arg_180_1.var_.characterEffect1037ui_story == nil then
				arg_180_1.var_.characterEffect1037ui_story = var_183_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.200000002980232

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_2 and not isNil(var_183_1) then
				if arg_180_1.var_.characterEffect1037ui_story and not isNil(var_183_1) then
					arg_180_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_180_1.time_ - 0) / var_183_2)
				end
			end

			if arg_180_1.time_ >= 0 + var_183_2 and arg_180_1.time_ < 0 + var_183_2 + arg_183_0 and not isNil(var_183_1) and arg_180_1.var_.characterEffect1037ui_story then
				arg_180_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			if 0.831700532541921 < arg_180_1.time_ and arg_180_1.time_ <= 0.831700532541921 + arg_183_0 then
				local var_183_3 = arg_180_1.var_.effect23332111

				if not arg_180_1.var_.effect23332111 then
					var_183_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_posui"), manager.ui.mainCamera.transform)
					var_183_3.name = "23332111"
					arg_180_1.var_.effect23332111 = var_183_3
				else
					var_183_3.transform:SetParent(var_183_9002)
				end

				var_183_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_183_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 3.16503386587525 < arg_180_1.time_ and arg_180_1.time_ <= 3.16503386587525 + arg_183_0 then
				if arg_180_1.var_.effect23332111 then
					Object.Destroy(arg_180_1.var_.effect23332111)

					arg_180_1.var_.effect23332111 = nil
				end
			end

			if 1 < arg_180_1.time_ and arg_180_1.time_ <= 1 + arg_183_0 then
				local var_183_6 = arg_180_1.var_.effect2131

				if not arg_180_1.var_.effect2131 then
					var_183_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), manager.ui.mainCamera.transform)
					var_183_6.name = "2131"
					arg_180_1.var_.effect2131 = var_183_6
				else
					var_183_6.transform:SetParent(var_183_9001)
				end

				var_183_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_183_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_183_6.transform.localScale = Vector3.New(var_183_6.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_183_6.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_183_6.transform.localScale.z)
			end

			if 2.86666666666667 < arg_180_1.time_ and arg_180_1.time_ <= 2.86666666666667 + arg_183_0 then
				if arg_180_1.var_.effect2131 then
					Object.Destroy(arg_180_1.var_.effect2131)

					arg_180_1.var_.effect2131 = nil
				end
			end

			local var_183_9 = 0

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_9 + arg_183_0 then
				arg_180_1.allBtn_.enabled = false
			end

			if arg_180_1.time_ >= var_183_9 + 1 and arg_180_1.time_ < var_183_9 + 1 + arg_183_0 then
				arg_180_1.allBtn_.enabled = true
			end

			if 0.498367199208587 < arg_180_1.time_ and arg_180_1.time_ <= 0.498367199208587 + arg_183_0 then
				local var_183_10 = arg_180_1.var_.effect神鼎飞丹砂

				if not arg_180_1.var_.effect神鼎飞丹砂 then
					var_183_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redtwister_out"), manager.ui.mainCamera.transform)
					var_183_10.name = "神鼎飞丹砂"
					arg_180_1.var_.effect神鼎飞丹砂 = var_183_10
				else
					var_183_10.transform:SetParent(var_183_9000)
				end

				var_183_10.transform.localPosition = Vector3.New(0, 0, 0)
				var_183_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_183_10.transform.localScale = Vector3.New(var_183_10.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_183_10.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_183_10.transform.localScale.z)
			end

			if 3.5 < arg_180_1.time_ and arg_180_1.time_ <= 3.5 + arg_183_0 then
				if arg_180_1.var_.effect神鼎飞丹砂 then
					Object.Destroy(arg_180_1.var_.effect神鼎飞丹砂)

					arg_180_1.var_.effect神鼎飞丹砂 = nil
				end
			end

			if 0.5 < arg_180_1.time_ and arg_180_1.time_ <= 0.5 + arg_183_0 then
				arg_180_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_explosion", "")
			end

			if arg_180_1.frameCnt_ <= 1 then
				arg_180_1.dialog_:SetActive(false)
			end

			local var_183_14 = 1.73333333333333
			local var_183_15 = 1.65

			if 1.73333333333333 < arg_180_1.time_ and arg_180_1.time_ <= var_183_14 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0

				arg_180_1.dialog_:SetActive(true)

				arg_180_1.dialogCg_.alpha = 0

				local var_183_16 = LeanTween.value(arg_180_1.dialog_, 0, 1, 0.3)

				var_183_16:setOnUpdate(LuaHelper.FloatAction(function(arg_184_0)
					arg_180_1.dialogCg_.alpha = arg_184_0
				end))
				var_183_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_180_1.dialog_)
					var_183_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_180_1.duration_ = arg_180_1.duration_ + 0.3

				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_17 = arg_180_1:FormatText(arg_180_1:GetWordFromCfg(305042044).content)

				arg_180_1.text_.text = var_183_17

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_19 = 66 <= 0 and var_183_15 or var_183_15 * (utf8.len(var_183_17) / 66)

				if (66 <= 0 and var_183_15 or var_183_15 * (utf8.len(var_183_17) / 66)) > 0 and var_183_15 < var_183_19 then
					arg_180_1.talkMaxDuration = var_183_19
					var_183_14 = var_183_14 + 0.3

					if var_183_19 + var_183_14 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_19 + var_183_14
					end
				end

				arg_180_1.text_.text = var_183_17
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_20 = var_183_14 + 0.3
			local var_183_21 = math.max(var_183_15, arg_180_1.talkMaxDuration)

			if var_183_14 + 0.3 <= arg_180_1.time_ and arg_180_1.time_ < var_183_20 + var_183_21 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_20) / var_183_21

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_20 + var_183_21 and arg_180_1.time_ < var_183_20 + var_183_21 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 4,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 1.26666666666667,
				amplitudeGain = 0.6,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play305042045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 305042045
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play305042046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0.375

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_1 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(305042045).content)

				arg_186_1.text_.text = var_189_1

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_3 = 15 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_1) / 15)

				if (15 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_1) / 15)) > 0 and var_189_0 < var_189_3 then
					arg_186_1.talkMaxDuration = var_189_3

					if var_189_3 + 0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_3 + 0
					end
				end

				arg_186_1.text_.text = var_189_1
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_4 = math.max(var_189_0, arg_186_1.talkMaxDuration)

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_4 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - 0) / var_189_4

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= 0 + var_189_4 and arg_186_1.time_ < 0 + var_189_4 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play305042046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 305042046
		arg_190_1.duration_ = 4.97

		local var_190_0 = {
			zh = 4.4,
			ja = 4.966
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play305042047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos1148ui_story = arg_190_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_193_0 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 then
				arg_190_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1148ui_story, Vector3.New(-0.7, -0.8, -6.2), (arg_190_1.time_ - 0) / var_193_0)
				arg_190_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1148ui_story"].transform.position).z)
				arg_190_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1148ui_story"].transform.localEulerAngles = arg_190_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 then
				arg_190_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.8, -6.2)
				arg_190_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1148ui_story"].transform.position).z)
				arg_190_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1148ui_story"].transform.localEulerAngles = arg_190_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_193_1 = arg_190_1.actors_["1148ui_story"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1148ui_story == nil then
				arg_190_1.var_.characterEffect1148ui_story = var_193_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_2 and not isNil(var_193_1) then
				if arg_190_1.var_.characterEffect1148ui_story and not isNil(var_193_1) then
					arg_190_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= 0 + var_193_2 and arg_190_1.time_ < 0 + var_193_2 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1148ui_story then
				arg_190_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_193_4 = 0
			local var_193_5 = 0.55

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_4 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_6 = arg_190_1:GetWordFromCfg(305042046)
				local var_193_7 = arg_190_1:FormatText(var_193_6.content)

				arg_190_1.text_.text = var_193_7

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_9 = 22 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 22)

				if (22 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 22)) > 0 and var_193_5 < var_193_9 then
					arg_190_1.talkMaxDuration = var_193_9

					if var_193_9 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_9 + var_193_4
					end
				end

				arg_190_1.text_.text = var_193_7
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042046", "story_v_out_305042.awb") ~= 0 then
					local var_193_10 = manager.audio:GetVoiceLength("story_v_out_305042", "305042046", "story_v_out_305042.awb") / 1000

					if var_193_10 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_10 + var_193_4
					end

					if var_193_6.prefab_name ~= "" and arg_190_1.actors_[var_193_6.prefab_name] ~= nil then
						local var_193_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_6.prefab_name].transform, "story_v_out_305042", "305042046", "story_v_out_305042.awb")

						arg_190_1:RecordAudio("305042046", var_193_11)
						arg_190_1:RecordAudio("305042046", var_193_11)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_305042", "305042046", "story_v_out_305042.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_305042", "305042046", "story_v_out_305042.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_12 = math.max(var_193_5, arg_190_1.talkMaxDuration)

			if var_193_4 <= arg_190_1.time_ and arg_190_1.time_ < var_193_4 + var_193_12 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_4) / var_193_12

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_4 + var_193_12 and arg_190_1.time_ < var_193_4 + var_193_12 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play305042047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 305042047
		arg_194_1.duration_ = 10.57

		local var_194_0 = {
			zh = 7.9,
			ja = 10.566
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play305042048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if arg_194_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_197_0 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_194_1.stage_.transform)

				var_197_0.name = "1059ui_story"
				var_197_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_194_1.actors_["1059ui_story"] = var_197_0

				local var_197_1 = var_197_0:GetComponentInChildren(typeof(CharacterEffect))

				var_197_1.enabled = true

				local var_197_2 = GameObjectTools.GetOrAddComponent(var_197_0, typeof(DynamicBoneHelper))

				if var_197_2 then
					var_197_2:EnableDynamicBone(false)
				end

				arg_194_1:ShowWeapon(var_197_1.transform, false)

				arg_194_1.var_["1059ui_story" .. "Animator"] = var_197_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_194_1.var_["1059ui_story" .. "Animator"].applyRootMotion = true
				arg_194_1.var_["1059ui_story" .. "LipSync"] = var_197_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_197_3 = arg_194_1.actors_["1059ui_story"].transform

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos1059ui_story = var_197_3.localPosition
			end

			local var_197_4 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_4 then
				var_197_3.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1059ui_story, Vector3.New(0.7, -1.05, -6), (arg_194_1.time_ - 0) / var_197_4)
				var_197_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_3.position).x, (manager.ui.mainCamera.transform.position - var_197_3.position).y, (manager.ui.mainCamera.transform.position - var_197_3.position).z)
				var_197_3.localEulerAngles.z = 0
				var_197_3.localEulerAngles.x = 0
				var_197_3.localEulerAngles = var_197_3.localEulerAngles
			end

			if arg_194_1.time_ >= 0 + var_197_4 and arg_194_1.time_ < 0 + var_197_4 + arg_197_0 then
				var_197_3.localPosition = Vector3.New(0.7, -1.05, -6)
				var_197_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_3.position).x, (manager.ui.mainCamera.transform.position - var_197_3.position).y, (manager.ui.mainCamera.transform.position - var_197_3.position).z)
				var_197_3.localEulerAngles.z = 0
				var_197_3.localEulerAngles.x = 0
				var_197_3.localEulerAngles = var_197_3.localEulerAngles
			end

			local var_197_5 = arg_194_1.actors_["1059ui_story"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_5) and arg_194_1.var_.characterEffect1059ui_story == nil then
				arg_194_1.var_.characterEffect1059ui_story = var_197_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_6 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_6 and not isNil(var_197_5) then
				if arg_194_1.var_.characterEffect1059ui_story and not isNil(var_197_5) then
					arg_194_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= 0 + var_197_6 and arg_194_1.time_ < 0 + var_197_6 + arg_197_0 and not isNil(var_197_5) and arg_194_1.var_.characterEffect1059ui_story then
				arg_194_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_197_8 = arg_194_1.actors_["1148ui_story"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_8) and arg_194_1.var_.characterEffect1148ui_story == nil then
				arg_194_1.var_.characterEffect1148ui_story = var_197_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_9 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_9 and not isNil(var_197_8) then
				if arg_194_1.var_.characterEffect1148ui_story and not isNil(var_197_8) then
					arg_194_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_194_1.time_ - 0) / var_197_9)
				end
			end

			if arg_194_1.time_ >= 0 + var_197_9 and arg_194_1.time_ < 0 + var_197_9 + arg_197_0 and not isNil(var_197_8) and arg_194_1.var_.characterEffect1148ui_story then
				arg_194_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action5_1")
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_197_10 = 0
			local var_197_11 = 0.925

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_10 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_12 = arg_194_1:GetWordFromCfg(305042047)
				local var_197_13 = arg_194_1:FormatText(var_197_12.content)

				arg_194_1.text_.text = var_197_13

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_15 = 37 <= 0 and var_197_11 or var_197_11 * (utf8.len(var_197_13) / 37)

				if (37 <= 0 and var_197_11 or var_197_11 * (utf8.len(var_197_13) / 37)) > 0 and var_197_11 < var_197_15 then
					arg_194_1.talkMaxDuration = var_197_15

					if var_197_15 + var_197_10 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_15 + var_197_10
					end
				end

				arg_194_1.text_.text = var_197_13
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042047", "story_v_out_305042.awb") ~= 0 then
					local var_197_16 = manager.audio:GetVoiceLength("story_v_out_305042", "305042047", "story_v_out_305042.awb") / 1000

					if var_197_16 + var_197_10 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_16 + var_197_10
					end

					if var_197_12.prefab_name ~= "" and arg_194_1.actors_[var_197_12.prefab_name] ~= nil then
						local var_197_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_12.prefab_name].transform, "story_v_out_305042", "305042047", "story_v_out_305042.awb")

						arg_194_1:RecordAudio("305042047", var_197_17)
						arg_194_1:RecordAudio("305042047", var_197_17)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_305042", "305042047", "story_v_out_305042.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_305042", "305042047", "story_v_out_305042.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_18 = math.max(var_197_11, arg_194_1.talkMaxDuration)

			if var_197_10 <= arg_194_1.time_ and arg_194_1.time_ < var_197_10 + var_197_18 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_10) / var_197_18

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_10 + var_197_18 and arg_194_1.time_ < var_197_10 + var_197_18 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play305042048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 305042048
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play305042049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["1059ui_story"]) and arg_198_1.var_.characterEffect1059ui_story == nil then
				arg_198_1.var_.characterEffect1059ui_story = arg_198_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_0 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["1059ui_story"]) then
				if arg_198_1.var_.characterEffect1059ui_story and not isNil(arg_198_1.actors_["1059ui_story"]) then
					arg_198_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_198_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_198_1.time_ - 0) / var_201_0)
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["1059ui_story"]) and arg_198_1.var_.characterEffect1059ui_story then
				arg_198_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_198_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_201_1 = 0
			local var_201_2 = 0.15

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, true)
				arg_198_1.iconController_:SetSelectedState("hero")

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_3 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(305042048).content)

				arg_198_1.text_.text = var_201_3

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_5 = 6 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_3) / 6)

				if (6 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_3) / 6)) > 0 and var_201_2 < var_201_5 then
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

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play305042049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 305042049
		arg_202_1.duration_ = 3.37

		local var_202_0 = {
			zh = 2.566,
			ja = 3.366
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play305042050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["1059ui_story"]) and arg_202_1.var_.characterEffect1059ui_story == nil then
				arg_202_1.var_.characterEffect1059ui_story = arg_202_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_0 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["1059ui_story"]) then
				if arg_202_1.var_.characterEffect1059ui_story and not isNil(arg_202_1.actors_["1059ui_story"]) then
					arg_202_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["1059ui_story"]) and arg_202_1.var_.characterEffect1059ui_story then
				arg_202_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_205_2 = 0
			local var_205_3 = 0.175

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_2 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_4 = arg_202_1:GetWordFromCfg(305042049)
				local var_205_5 = arg_202_1:FormatText(var_205_4.content)

				arg_202_1.text_.text = var_205_5

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_7 = 7 <= 0 and var_205_3 or var_205_3 * (utf8.len(var_205_5) / 7)

				if (7 <= 0 and var_205_3 or var_205_3 * (utf8.len(var_205_5) / 7)) > 0 and var_205_3 < var_205_7 then
					arg_202_1.talkMaxDuration = var_205_7

					if var_205_7 + var_205_2 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_7 + var_205_2
					end
				end

				arg_202_1.text_.text = var_205_5
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042049", "story_v_out_305042.awb") ~= 0 then
					local var_205_8 = manager.audio:GetVoiceLength("story_v_out_305042", "305042049", "story_v_out_305042.awb") / 1000

					if var_205_8 + var_205_2 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_8 + var_205_2
					end

					if var_205_4.prefab_name ~= "" and arg_202_1.actors_[var_205_4.prefab_name] ~= nil then
						local var_205_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_4.prefab_name].transform, "story_v_out_305042", "305042049", "story_v_out_305042.awb")

						arg_202_1:RecordAudio("305042049", var_205_9)
						arg_202_1:RecordAudio("305042049", var_205_9)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_305042", "305042049", "story_v_out_305042.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_305042", "305042049", "story_v_out_305042.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_10 = math.max(var_205_3, arg_202_1.talkMaxDuration)

			if var_205_2 <= arg_202_1.time_ and arg_202_1.time_ < var_205_2 + var_205_10 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_2) / var_205_10

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_2 + var_205_10 and arg_202_1.time_ < var_205_2 + var_205_10 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play305042050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 305042050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play305042051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1148ui_story = arg_206_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_209_0 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 then
				arg_206_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_206_1.time_ - 0) / var_209_0)
				arg_206_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1148ui_story"].transform.position).z)
				arg_206_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["1148ui_story"].transform.localEulerAngles = arg_206_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 then
				arg_206_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_206_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1148ui_story"].transform.position).z)
				arg_206_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["1148ui_story"].transform.localEulerAngles = arg_206_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_209_1 = arg_206_1.actors_["1059ui_story"].transform

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1059ui_story = var_209_1.localPosition
			end

			local var_209_2 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_2 then
				var_209_1.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_206_1.time_ - 0) / var_209_2)
				var_209_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_209_1.position).x, (manager.ui.mainCamera.transform.position - var_209_1.position).y, (manager.ui.mainCamera.transform.position - var_209_1.position).z)
				var_209_1.localEulerAngles.z = 0
				var_209_1.localEulerAngles.x = 0
				var_209_1.localEulerAngles = var_209_1.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_2 and arg_206_1.time_ < 0 + var_209_2 + arg_209_0 then
				var_209_1.localPosition = Vector3.New(0, 100, 0)
				var_209_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_209_1.position).x, (manager.ui.mainCamera.transform.position - var_209_1.position).y, (manager.ui.mainCamera.transform.position - var_209_1.position).z)
				var_209_1.localEulerAngles.z = 0
				var_209_1.localEulerAngles.x = 0
				var_209_1.localEulerAngles = var_209_1.localEulerAngles
			end

			local var_209_3 = arg_206_1.actors_["1059ui_story"]

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(var_209_3) and arg_206_1.var_.characterEffect1059ui_story == nil then
				arg_206_1.var_.characterEffect1059ui_story = var_209_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_4 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_4 and not isNil(var_209_3) then
				if arg_206_1.var_.characterEffect1059ui_story and not isNil(var_209_3) then
					arg_206_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_206_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_206_1.time_ - 0) / var_209_4)
				end
			end

			if arg_206_1.time_ >= 0 + var_209_4 and arg_206_1.time_ < 0 + var_209_4 + arg_209_0 and not isNil(var_209_3) and arg_206_1.var_.characterEffect1059ui_story then
				arg_206_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_206_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_209_5 = 0
			local var_209_6 = 1.45

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_5 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_7 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(305042050).content)

				arg_206_1.text_.text = var_209_7

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_9 = 58 <= 0 and var_209_6 or var_209_6 * (utf8.len(var_209_7) / 58)

				if (58 <= 0 and var_209_6 or var_209_6 * (utf8.len(var_209_7) / 58)) > 0 and var_209_6 < var_209_9 then
					arg_206_1.talkMaxDuration = var_209_9

					if var_209_9 + var_209_5 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_9 + var_209_5
					end
				end

				arg_206_1.text_.text = var_209_7
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_10 = math.max(var_209_6, arg_206_1.talkMaxDuration)

			if var_209_5 <= arg_206_1.time_ and arg_206_1.time_ < var_209_5 + var_209_10 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_5) / var_209_10

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_5 + var_209_10 and arg_206_1.time_ < var_209_5 + var_209_10 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play305042051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 305042051
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play305042052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0.4 < arg_210_1.time_ and arg_210_1.time_ <= 0.4 + arg_213_0 then
				arg_210_1:AudioAction("play", "effect", "se_story_145", "se_story_145_1032206shake", "")
			end

			local var_213_1 = 0
			local var_213_2 = 1.625

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_3 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(305042051).content)

				arg_210_1.text_.text = var_213_3

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_5 = 65 <= 0 and var_213_2 or var_213_2 * (utf8.len(var_213_3) / 65)

				if (65 <= 0 and var_213_2 or var_213_2 * (utf8.len(var_213_3) / 65)) > 0 and var_213_2 < var_213_5 then
					arg_210_1.talkMaxDuration = var_213_5

					if var_213_5 + var_213_1 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_5 + var_213_1
					end
				end

				arg_210_1.text_.text = var_213_3
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_6 = math.max(var_213_2, arg_210_1.talkMaxDuration)

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_6 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_1) / var_213_6

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_1 + var_213_6 and arg_210_1.time_ < var_213_1 + var_213_6 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play305042052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 305042052
		arg_214_1.duration_ = 5.33

		local var_214_0 = {
			zh = 3.766,
			ja = 5.333
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play305042053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0.25

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10001")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_1 = arg_214_1:GetWordFromCfg(305042052)
				local var_217_2 = arg_214_1:FormatText(var_217_1.content)

				arg_214_1.text_.text = var_217_2

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_4 = 10 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_2) / 10)

				if (10 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_2) / 10)) > 0 and var_217_0 < var_217_4 then
					arg_214_1.talkMaxDuration = var_217_4

					if var_217_4 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_4 + 0
					end
				end

				arg_214_1.text_.text = var_217_2
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042052", "story_v_out_305042.awb") ~= 0 then
					local var_217_5 = manager.audio:GetVoiceLength("story_v_out_305042", "305042052", "story_v_out_305042.awb") / 1000

					if var_217_5 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_5 + 0
					end

					if var_217_1.prefab_name ~= "" and arg_214_1.actors_[var_217_1.prefab_name] ~= nil then
						local var_217_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_1.prefab_name].transform, "story_v_out_305042", "305042052", "story_v_out_305042.awb")

						arg_214_1:RecordAudio("305042052", var_217_6)
						arg_214_1:RecordAudio("305042052", var_217_6)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_305042", "305042052", "story_v_out_305042.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_305042", "305042052", "story_v_out_305042.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_7 = math.max(var_217_0, arg_214_1.talkMaxDuration)

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_7 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - 0) / var_217_7

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= 0 + var_217_7 and arg_214_1.time_ < 0 + var_217_7 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play305042053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 305042053
		arg_218_1.duration_ = 9.93

		local var_218_0 = {
			zh = 4.633,
			ja = 9.933
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play305042054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0.525

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10001")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_1 = arg_218_1:GetWordFromCfg(305042053)
				local var_221_2 = arg_218_1:FormatText(var_221_1.content)

				arg_218_1.text_.text = var_221_2

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_4 = 21 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_2) / 21)

				if (21 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_2) / 21)) > 0 and var_221_0 < var_221_4 then
					arg_218_1.talkMaxDuration = var_221_4

					if var_221_4 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_4 + 0
					end
				end

				arg_218_1.text_.text = var_221_2
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042053", "story_v_out_305042.awb") ~= 0 then
					local var_221_5 = manager.audio:GetVoiceLength("story_v_out_305042", "305042053", "story_v_out_305042.awb") / 1000

					if var_221_5 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_5 + 0
					end

					if var_221_1.prefab_name ~= "" and arg_218_1.actors_[var_221_1.prefab_name] ~= nil then
						local var_221_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_1.prefab_name].transform, "story_v_out_305042", "305042053", "story_v_out_305042.awb")

						arg_218_1:RecordAudio("305042053", var_221_6)
						arg_218_1:RecordAudio("305042053", var_221_6)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_305042", "305042053", "story_v_out_305042.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_305042", "305042053", "story_v_out_305042.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_7 = math.max(var_221_0, arg_218_1.talkMaxDuration)

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_7 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - 0) / var_221_7

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= 0 + var_221_7 and arg_218_1.time_ < 0 + var_221_7 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play305042054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 305042054
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play305042055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0.075

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_1 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(305042054).content)

				arg_222_1.text_.text = var_225_1

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_3 = 3 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_1) / 3)

				if (3 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_1) / 3)) > 0 and var_225_0 < var_225_3 then
					arg_222_1.talkMaxDuration = var_225_3

					if var_225_3 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_3 + 0
					end
				end

				arg_222_1.text_.text = var_225_1
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_4 = math.max(var_225_0, arg_222_1.talkMaxDuration)

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_4 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - 0) / var_225_4

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= 0 + var_225_4 and arg_222_1.time_ < 0 + var_225_4 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play305042055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 305042055
		arg_226_1.duration_ = 4.5

		local var_226_0 = {
			zh = 4.5,
			ja = 3.9
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play305042056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos1148ui_story = arg_226_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_229_0 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 then
				arg_226_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_226_1.time_ - 0) / var_229_0)
				arg_226_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_226_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1148ui_story"].transform.position).z)
				arg_226_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_226_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_226_1.actors_["1148ui_story"].transform.localEulerAngles = arg_226_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 then
				arg_226_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_226_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_226_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1148ui_story"].transform.position).z)
				arg_226_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_226_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_226_1.actors_["1148ui_story"].transform.localEulerAngles = arg_226_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_229_1 = arg_226_1.actors_["1148ui_story"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_1) and arg_226_1.var_.characterEffect1148ui_story == nil then
				arg_226_1.var_.characterEffect1148ui_story = var_229_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_2 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_2 and not isNil(var_229_1) then
				if arg_226_1.var_.characterEffect1148ui_story and not isNil(var_229_1) then
					arg_226_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= 0 + var_229_2 and arg_226_1.time_ < 0 + var_229_2 + arg_229_0 and not isNil(var_229_1) and arg_226_1.var_.characterEffect1148ui_story then
				arg_226_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_2")
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_229_4 = 0
			local var_229_5 = 0.5

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_4 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_6 = arg_226_1:GetWordFromCfg(305042055)
				local var_229_7 = arg_226_1:FormatText(var_229_6.content)

				arg_226_1.text_.text = var_229_7

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_9 = 20 <= 0 and var_229_5 or var_229_5 * (utf8.len(var_229_7) / 20)

				if (20 <= 0 and var_229_5 or var_229_5 * (utf8.len(var_229_7) / 20)) > 0 and var_229_5 < var_229_9 then
					arg_226_1.talkMaxDuration = var_229_9

					if var_229_9 + var_229_4 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_9 + var_229_4
					end
				end

				arg_226_1.text_.text = var_229_7
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042055", "story_v_out_305042.awb") ~= 0 then
					local var_229_10 = manager.audio:GetVoiceLength("story_v_out_305042", "305042055", "story_v_out_305042.awb") / 1000

					if var_229_10 + var_229_4 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_10 + var_229_4
					end

					if var_229_6.prefab_name ~= "" and arg_226_1.actors_[var_229_6.prefab_name] ~= nil then
						local var_229_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_6.prefab_name].transform, "story_v_out_305042", "305042055", "story_v_out_305042.awb")

						arg_226_1:RecordAudio("305042055", var_229_11)
						arg_226_1:RecordAudio("305042055", var_229_11)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_305042", "305042055", "story_v_out_305042.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_305042", "305042055", "story_v_out_305042.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_12 = math.max(var_229_5, arg_226_1.talkMaxDuration)

			if var_229_4 <= arg_226_1.time_ and arg_226_1.time_ < var_229_4 + var_229_12 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_4) / var_229_12

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_4 + var_229_12 and arg_226_1.time_ < var_229_4 + var_229_12 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play305042056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 305042056
		arg_230_1.duration_ = 6.9

		local var_230_0 = {
			zh = 5.233,
			ja = 6.9
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play305042057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0.65

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_1 = arg_230_1:GetWordFromCfg(305042056)
				local var_233_2 = arg_230_1:FormatText(var_233_1.content)

				arg_230_1.text_.text = var_233_2

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_4 = 26 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_2) / 26)

				if (26 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_2) / 26)) > 0 and var_233_0 < var_233_4 then
					arg_230_1.talkMaxDuration = var_233_4

					if var_233_4 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_4 + 0
					end
				end

				arg_230_1.text_.text = var_233_2
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042056", "story_v_out_305042.awb") ~= 0 then
					local var_233_5 = manager.audio:GetVoiceLength("story_v_out_305042", "305042056", "story_v_out_305042.awb") / 1000

					if var_233_5 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_5 + 0
					end

					if var_233_1.prefab_name ~= "" and arg_230_1.actors_[var_233_1.prefab_name] ~= nil then
						local var_233_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_1.prefab_name].transform, "story_v_out_305042", "305042056", "story_v_out_305042.awb")

						arg_230_1:RecordAudio("305042056", var_233_6)
						arg_230_1:RecordAudio("305042056", var_233_6)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_305042", "305042056", "story_v_out_305042.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_305042", "305042056", "story_v_out_305042.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_7 = math.max(var_233_0, arg_230_1.talkMaxDuration)

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_7 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - 0) / var_233_7

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= 0 + var_233_7 and arg_230_1.time_ < 0 + var_233_7 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play305042057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 305042057
		arg_234_1.duration_ = 9.7

		local var_234_0 = {
			zh = 8.933,
			ja = 9.7
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play305042058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if arg_234_1.actors_["10001_tpose"] == nil and not isNil((Asset.Load("Char/" .. "10001_tpose"))) then
				local var_237_0 = Object.Instantiate(Asset.Load("Char/" .. "10001_tpose"), arg_234_1.stage_.transform)

				var_237_0.name = "10001_tpose"
				var_237_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_234_1.actors_["10001_tpose"] = var_237_0

				local var_237_1 = var_237_0:GetComponentInChildren(typeof(CharacterEffect))

				var_237_1.enabled = true

				local var_237_2 = GameObjectTools.GetOrAddComponent(var_237_0, typeof(DynamicBoneHelper))

				if var_237_2 then
					var_237_2:EnableDynamicBone(false)
				end

				arg_234_1:ShowWeapon(var_237_1.transform, false)

				arg_234_1.var_["10001_tpose" .. "Animator"] = var_237_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_234_1.var_["10001_tpose" .. "Animator"].applyRootMotion = true
				arg_234_1.var_["10001_tpose" .. "LipSync"] = var_237_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_237_3 = arg_234_1.actors_["10001_tpose"].transform

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos10001_tpose = var_237_3.localPosition

				local var_237_4 = GameObjectTools.GetOrAddComponent(var_237_3.gameObject, typeof(DynamicBoneHelper))

				if var_237_4 then
					var_237_4:EnableDynamicBone(false)
				end
			end

			local var_237_5 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_5 then
				var_237_3.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10001_tpose, Vector3.New(0, -1.23, -5.8), (arg_234_1.time_ - 0) / var_237_5)
				var_237_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_237_3.position).x, (manager.ui.mainCamera.transform.position - var_237_3.position).y, (manager.ui.mainCamera.transform.position - var_237_3.position).z)
				var_237_3.localEulerAngles.z = 0
				var_237_3.localEulerAngles.x = 0
				var_237_3.localEulerAngles = var_237_3.localEulerAngles
			end

			if arg_234_1.time_ >= 0 + var_237_5 and arg_234_1.time_ < 0 + var_237_5 + arg_237_0 then
				var_237_3.localPosition = Vector3.New(0, -1.23, -5.8)
				var_237_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_237_3.position).x, (manager.ui.mainCamera.transform.position - var_237_3.position).y, (manager.ui.mainCamera.transform.position - var_237_3.position).z)
				var_237_3.localEulerAngles.z = 0
				var_237_3.localEulerAngles.x = 0
				var_237_3.localEulerAngles = var_237_3.localEulerAngles

				local var_237_6 = GameObjectTools.GetOrAddComponent(var_237_3.gameObject, typeof(DynamicBoneHelper))

				if var_237_6 then
					var_237_6:EnableDynamicBone(true)
				end
			end

			local var_237_7 = arg_234_1.actors_["1148ui_story"].transform

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos1148ui_story = var_237_7.localPosition
			end

			local var_237_8 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_8 then
				var_237_7.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_234_1.time_ - 0) / var_237_8)
				var_237_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_237_7.position).x, (manager.ui.mainCamera.transform.position - var_237_7.position).y, (manager.ui.mainCamera.transform.position - var_237_7.position).z)
				var_237_7.localEulerAngles.z = 0
				var_237_7.localEulerAngles.x = 0
				var_237_7.localEulerAngles = var_237_7.localEulerAngles
			end

			if arg_234_1.time_ >= 0 + var_237_8 and arg_234_1.time_ < 0 + var_237_8 + arg_237_0 then
				var_237_7.localPosition = Vector3.New(0, 100, 0)
				var_237_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_237_7.position).x, (manager.ui.mainCamera.transform.position - var_237_7.position).y, (manager.ui.mainCamera.transform.position - var_237_7.position).z)
				var_237_7.localEulerAngles.z = 0
				var_237_7.localEulerAngles.x = 0
				var_237_7.localEulerAngles = var_237_7.localEulerAngles
			end

			local var_237_9 = arg_234_1.actors_["10001_tpose"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_9) and arg_234_1.var_.characterEffect10001_tpose == nil then
				arg_234_1.var_.characterEffect10001_tpose = var_237_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_10 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_10 and not isNil(var_237_9) then
				if arg_234_1.var_.characterEffect10001_tpose and not isNil(var_237_9) then
					arg_234_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_234_1.time_ >= 0 + var_237_10 and arg_234_1.time_ < 0 + var_237_10 + arg_237_0 and not isNil(var_237_9) and arg_234_1.var_.characterEffect10001_tpose then
				arg_234_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_237_12 = arg_234_1.actors_["1148ui_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_12) and arg_234_1.var_.characterEffect1148ui_story == nil then
				arg_234_1.var_.characterEffect1148ui_story = var_237_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_13 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_13 and not isNil(var_237_12) then
				if arg_234_1.var_.characterEffect1148ui_story and not isNil(var_237_12) then
					arg_234_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_234_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_234_1.time_ - 0) / var_237_13)
				end
			end

			if arg_234_1.time_ >= 0 + var_237_13 and arg_234_1.time_ < 0 + var_237_13 + arg_237_0 and not isNil(var_237_12) and arg_234_1.var_.characterEffect1148ui_story then
				arg_234_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_234_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action3_1")
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_237_14 = 0
			local var_237_15 = 0.875

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_14 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_16 = arg_234_1:GetWordFromCfg(305042057)
				local var_237_17 = arg_234_1:FormatText(var_237_16.content)

				arg_234_1.text_.text = var_237_17

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_19 = 35 <= 0 and var_237_15 or var_237_15 * (utf8.len(var_237_17) / 35)

				if (35 <= 0 and var_237_15 or var_237_15 * (utf8.len(var_237_17) / 35)) > 0 and var_237_15 < var_237_19 then
					arg_234_1.talkMaxDuration = var_237_19

					if var_237_19 + var_237_14 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_19 + var_237_14
					end
				end

				arg_234_1.text_.text = var_237_17
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042057", "story_v_out_305042.awb") ~= 0 then
					local var_237_20 = manager.audio:GetVoiceLength("story_v_out_305042", "305042057", "story_v_out_305042.awb") / 1000

					if var_237_20 + var_237_14 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_20 + var_237_14
					end

					if var_237_16.prefab_name ~= "" and arg_234_1.actors_[var_237_16.prefab_name] ~= nil then
						local var_237_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_16.prefab_name].transform, "story_v_out_305042", "305042057", "story_v_out_305042.awb")

						arg_234_1:RecordAudio("305042057", var_237_21)
						arg_234_1:RecordAudio("305042057", var_237_21)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_305042", "305042057", "story_v_out_305042.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_305042", "305042057", "story_v_out_305042.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_22 = math.max(var_237_15, arg_234_1.talkMaxDuration)

			if var_237_14 <= arg_234_1.time_ and arg_234_1.time_ < var_237_14 + var_237_22 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_14) / var_237_22

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_14 + var_237_22 and arg_234_1.time_ < var_237_14 + var_237_22 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play305042058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 305042058
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play305042059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["10001_tpose"]) and arg_238_1.var_.characterEffect10001_tpose == nil then
				arg_238_1.var_.characterEffect10001_tpose = arg_238_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_0 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["10001_tpose"]) then
				if arg_238_1.var_.characterEffect10001_tpose and not isNil(arg_238_1.actors_["10001_tpose"]) then
					arg_238_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_238_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_238_1.time_ - 0) / var_241_0)
				end
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["10001_tpose"]) and arg_238_1.var_.characterEffect10001_tpose then
				arg_238_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_238_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_241_1 = 0
			local var_241_2 = 1.05

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_3 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(305042058).content)

				arg_238_1.text_.text = var_241_3

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_5 = 42 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_3) / 42)

				if (42 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_3) / 42)) > 0 and var_241_2 < var_241_5 then
					arg_238_1.talkMaxDuration = var_241_5

					if var_241_5 + var_241_1 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_5 + var_241_1
					end
				end

				arg_238_1.text_.text = var_241_3
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_6 = math.max(var_241_2, arg_238_1.talkMaxDuration)

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_6 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_1) / var_241_6

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_1 + var_241_6 and arg_238_1.time_ < var_241_1 + var_241_6 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play305042059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 305042059
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play305042060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 0.25

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, true)
				arg_242_1.iconController_:SetSelectedState("hero")

				arg_242_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_242_1.callingController_:SetSelectedState("normal")

				arg_242_1.keyicon_.color = Color.New(1, 1, 1)
				arg_242_1.icon_.color = Color.New(1, 1, 1)

				local var_245_1 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(305042059).content)

				arg_242_1.text_.text = var_245_1

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_3 = 10 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_1) / 10)

				if (10 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_1) / 10)) > 0 and var_245_0 < var_245_3 then
					arg_242_1.talkMaxDuration = var_245_3

					if var_245_3 + 0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_3 + 0
					end
				end

				arg_242_1.text_.text = var_245_1
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_4 = math.max(var_245_0, arg_242_1.talkMaxDuration)

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_4 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - 0) / var_245_4

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= 0 + var_245_4 and arg_242_1.time_ < 0 + var_245_4 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play305042060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 305042060
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play305042061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.var_.moveOldPos10001_tpose = arg_246_1.actors_["10001_tpose"].transform.localPosition

				local var_249_0 = GameObjectTools.GetOrAddComponent(arg_246_1.actors_["10001_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_249_0 then
					var_249_0:EnableDynamicBone(false)
				end
			end

			local var_249_1 = 0.001

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_1 then
				arg_246_1.actors_["10001_tpose"].transform.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos10001_tpose, Vector3.New(0, 100, 0), (arg_246_1.time_ - 0) / var_249_1)
				arg_246_1.actors_["10001_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_246_1.actors_["10001_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["10001_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["10001_tpose"].transform.position).z)
				arg_246_1.actors_["10001_tpose"].transform.localEulerAngles.z = 0
				arg_246_1.actors_["10001_tpose"].transform.localEulerAngles.x = 0
				arg_246_1.actors_["10001_tpose"].transform.localEulerAngles = arg_246_1.actors_["10001_tpose"].transform.localEulerAngles
			end

			if arg_246_1.time_ >= 0 + var_249_1 and arg_246_1.time_ < 0 + var_249_1 + arg_249_0 then
				arg_246_1.actors_["10001_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_246_1.actors_["10001_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_246_1.actors_["10001_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["10001_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["10001_tpose"].transform.position).z)
				arg_246_1.actors_["10001_tpose"].transform.localEulerAngles.z = 0
				arg_246_1.actors_["10001_tpose"].transform.localEulerAngles.x = 0
				arg_246_1.actors_["10001_tpose"].transform.localEulerAngles = arg_246_1.actors_["10001_tpose"].transform.localEulerAngles

				local var_249_2 = GameObjectTools.GetOrAddComponent(arg_246_1.actors_["10001_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_249_2 then
					var_249_2:EnableDynamicBone(true)
				end
			end

			local var_249_3 = 0
			local var_249_4 = 1.675

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_3 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_5 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(305042060).content)

				arg_246_1.text_.text = var_249_5

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_7 = 67 <= 0 and var_249_4 or var_249_4 * (utf8.len(var_249_5) / 67)

				if (67 <= 0 and var_249_4 or var_249_4 * (utf8.len(var_249_5) / 67)) > 0 and var_249_4 < var_249_7 then
					arg_246_1.talkMaxDuration = var_249_7

					if var_249_7 + var_249_3 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_7 + var_249_3
					end
				end

				arg_246_1.text_.text = var_249_5
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_8 = math.max(var_249_4, arg_246_1.talkMaxDuration)

			if var_249_3 <= arg_246_1.time_ and arg_246_1.time_ < var_249_3 + var_249_8 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_3) / var_249_8

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_3 + var_249_8 and arg_246_1.time_ < var_249_3 + var_249_8 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play305042061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 305042061
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play305042062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0.75

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_1 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(305042061).content)

				arg_250_1.text_.text = var_253_1

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_3 = 30 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_1) / 30)

				if (30 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_1) / 30)) > 0 and var_253_0 < var_253_3 then
					arg_250_1.talkMaxDuration = var_253_3

					if var_253_3 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_3 + 0
					end
				end

				arg_250_1.text_.text = var_253_1
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_4 = math.max(var_253_0, arg_250_1.talkMaxDuration)

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_4 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - 0) / var_253_4

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= 0 + var_253_4 and arg_250_1.time_ < 0 + var_253_4 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play305042062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 305042062
		arg_254_1.duration_ = 7.17

		local var_254_0 = {
			zh = 7.166,
			ja = 7
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play305042063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0.625

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, true)
				arg_254_1.iconController_:SetSelectedState("hero")

				arg_254_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10001")

				arg_254_1.callingController_:SetSelectedState("normal")

				arg_254_1.keyicon_.color = Color.New(1, 1, 1)
				arg_254_1.icon_.color = Color.New(1, 1, 1)

				local var_257_1 = arg_254_1:GetWordFromCfg(305042062)
				local var_257_2 = arg_254_1:FormatText(var_257_1.content)

				arg_254_1.text_.text = var_257_2

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_4 = 25 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_2) / 25)

				if (25 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_2) / 25)) > 0 and var_257_0 < var_257_4 then
					arg_254_1.talkMaxDuration = var_257_4

					if var_257_4 + 0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_4 + 0
					end
				end

				arg_254_1.text_.text = var_257_2
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042062", "story_v_out_305042.awb") ~= 0 then
					local var_257_5 = manager.audio:GetVoiceLength("story_v_out_305042", "305042062", "story_v_out_305042.awb") / 1000

					if var_257_5 + 0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_5 + 0
					end

					if var_257_1.prefab_name ~= "" and arg_254_1.actors_[var_257_1.prefab_name] ~= nil then
						local var_257_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_1.prefab_name].transform, "story_v_out_305042", "305042062", "story_v_out_305042.awb")

						arg_254_1:RecordAudio("305042062", var_257_6)
						arg_254_1:RecordAudio("305042062", var_257_6)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_305042", "305042062", "story_v_out_305042.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_305042", "305042062", "story_v_out_305042.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_7 = math.max(var_257_0, arg_254_1.talkMaxDuration)

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_7 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - 0) / var_257_7

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= 0 + var_257_7 and arg_254_1.time_ < 0 + var_257_7 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play305042063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 305042063
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play305042064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0.625

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_1 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(305042063).content)

				arg_258_1.text_.text = var_261_1

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_3 = 25 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 25)

				if (25 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 25)) > 0 and var_261_0 < var_261_3 then
					arg_258_1.talkMaxDuration = var_261_3

					if var_261_3 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_3 + 0
					end
				end

				arg_258_1.text_.text = var_261_1
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_4 = math.max(var_261_0, arg_258_1.talkMaxDuration)

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_4 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - 0) / var_261_4

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= 0 + var_261_4 and arg_258_1.time_ < 0 + var_261_4 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play305042064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 305042064
		arg_262_1.duration_ = 9.5

		local var_262_0 = {
			zh = 5.7,
			ja = 9.5
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play305042065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0.725

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10001")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_1 = arg_262_1:GetWordFromCfg(305042064)
				local var_265_2 = arg_262_1:FormatText(var_265_1.content)

				arg_262_1.text_.text = var_265_2

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_4 = 29 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_2) / 29)

				if (29 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_2) / 29)) > 0 and var_265_0 < var_265_4 then
					arg_262_1.talkMaxDuration = var_265_4

					if var_265_4 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_4 + 0
					end
				end

				arg_262_1.text_.text = var_265_2
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042064", "story_v_out_305042.awb") ~= 0 then
					local var_265_5 = manager.audio:GetVoiceLength("story_v_out_305042", "305042064", "story_v_out_305042.awb") / 1000

					if var_265_5 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_5 + 0
					end

					if var_265_1.prefab_name ~= "" and arg_262_1.actors_[var_265_1.prefab_name] ~= nil then
						local var_265_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_1.prefab_name].transform, "story_v_out_305042", "305042064", "story_v_out_305042.awb")

						arg_262_1:RecordAudio("305042064", var_265_6)
						arg_262_1:RecordAudio("305042064", var_265_6)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_305042", "305042064", "story_v_out_305042.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_305042", "305042064", "story_v_out_305042.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_7 = math.max(var_265_0, arg_262_1.talkMaxDuration)

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_7 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - 0) / var_265_7

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= 0 + var_265_7 and arg_262_1.time_ < 0 + var_265_7 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play305042065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 305042065
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play305042066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0.05

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_1 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(305042065).content)

				arg_266_1.text_.text = var_269_1

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_3 = 2 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_1) / 2)

				if (2 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_1) / 2)) > 0 and var_269_0 < var_269_3 then
					arg_266_1.talkMaxDuration = var_269_3

					if var_269_3 + 0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_3 + 0
					end
				end

				arg_266_1.text_.text = var_269_1
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_4 = math.max(var_269_0, arg_266_1.talkMaxDuration)

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_4 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - 0) / var_269_4

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= 0 + var_269_4 and arg_266_1.time_ < 0 + var_269_4 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play305042066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 305042066
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play305042067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 1.45

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_1 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(305042066).content)

				arg_270_1.text_.text = var_273_1

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_3 = 58 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_1) / 58)

				if (58 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_1) / 58)) > 0 and var_273_0 < var_273_3 then
					arg_270_1.talkMaxDuration = var_273_3

					if var_273_3 + 0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_3 + 0
					end
				end

				arg_270_1.text_.text = var_273_1
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_4 = math.max(var_273_0, arg_270_1.talkMaxDuration)

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_4 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - 0) / var_273_4

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= 0 + var_273_4 and arg_270_1.time_ < 0 + var_273_4 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play305042067 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 305042067
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play305042068(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0.725

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_1 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(305042067).content)

				arg_274_1.text_.text = var_277_1

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_3 = 29 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_1) / 29)

				if (29 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_1) / 29)) > 0 and var_277_0 < var_277_3 then
					arg_274_1.talkMaxDuration = var_277_3

					if var_277_3 + 0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_3 + 0
					end
				end

				arg_274_1.text_.text = var_277_1
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_4 = math.max(var_277_0, arg_274_1.talkMaxDuration)

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_4 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - 0) / var_277_4

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= 0 + var_277_4 and arg_274_1.time_ < 0 + var_277_4 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play305042068 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 305042068
		arg_278_1.duration_ = 6.93

		local var_278_0 = {
			zh = 6.933,
			ja = 5.666
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play305042069(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0.875

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10001")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_1 = arg_278_1:GetWordFromCfg(305042068)
				local var_281_2 = arg_278_1:FormatText(var_281_1.content)

				arg_278_1.text_.text = var_281_2

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_4 = 35 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_2) / 35)

				if (35 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_2) / 35)) > 0 and var_281_0 < var_281_4 then
					arg_278_1.talkMaxDuration = var_281_4

					if var_281_4 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_4 + 0
					end
				end

				arg_278_1.text_.text = var_281_2
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305042", "305042068", "story_v_out_305042.awb") ~= 0 then
					local var_281_5 = manager.audio:GetVoiceLength("story_v_out_305042", "305042068", "story_v_out_305042.awb") / 1000

					if var_281_5 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_5 + 0
					end

					if var_281_1.prefab_name ~= "" and arg_278_1.actors_[var_281_1.prefab_name] ~= nil then
						local var_281_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_1.prefab_name].transform, "story_v_out_305042", "305042068", "story_v_out_305042.awb")

						arg_278_1:RecordAudio("305042068", var_281_6)
						arg_278_1:RecordAudio("305042068", var_281_6)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_305042", "305042068", "story_v_out_305042.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_305042", "305042068", "story_v_out_305042.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_7 = math.max(var_281_0, arg_278_1.talkMaxDuration)

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_7 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - 0) / var_281_7

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= 0 + var_281_7 and arg_278_1.time_ < 0 + var_281_7 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play305042069 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 305042069
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play305042070(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0.325

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_1 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(305042069).content)

				arg_282_1.text_.text = var_285_1

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_3 = 13 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_1) / 13)

				if (13 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_1) / 13)) > 0 and var_285_0 < var_285_3 then
					arg_282_1.talkMaxDuration = var_285_3

					if var_285_3 + 0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_3 + 0
					end
				end

				arg_282_1.text_.text = var_285_1
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_4 = math.max(var_285_0, arg_282_1.talkMaxDuration)

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_4 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - 0) / var_285_4

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= 0 + var_285_4 and arg_282_1.time_ < 0 + var_285_4 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play305042070 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 305042070
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play305042071(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0.775

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, false)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_1 = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(305042070).content)

				arg_286_1.text_.text = var_289_1

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_3 = 31 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_1) / 31)

				if (31 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_1) / 31)) > 0 and var_289_0 < var_289_3 then
					arg_286_1.talkMaxDuration = var_289_3

					if var_289_3 + 0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_3 + 0
					end
				end

				arg_286_1.text_.text = var_289_1
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_4 = math.max(var_289_0, arg_286_1.talkMaxDuration)

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_4 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - 0) / var_289_4

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= 0 + var_289_4 and arg_286_1.time_ < 0 + var_289_4 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play305042071 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 305042071
		arg_290_1.duration_ = 6

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play305042072(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.var_.moveOldPosB06a = arg_290_1.bgs_.B06a.transform.localPosition
			end

			local var_293_0 = 2

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 then
				arg_290_1.bgs_.B06a.transform.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPosB06a, Vector3.New(0, 0.56, 8), (arg_290_1.time_ - 0) / var_293_0)
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 then
				arg_290_1.bgs_.B06a.transform.localPosition = Vector3.New(0, 0.56, 8)
			end

			local var_293_1 = 0

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 then
				arg_290_1.allBtn_.enabled = false
			end

			if arg_290_1.time_ >= var_293_1 + 1.36666666666667 and arg_290_1.time_ < var_293_1 + 1.36666666666667 + arg_293_0 then
				arg_290_1.allBtn_.enabled = true
			end

			if arg_290_1.frameCnt_ <= 1 then
				arg_290_1.dialog_:SetActive(false)
			end

			local var_293_2 = 1
			local var_293_3 = 1.025

			if 1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_2 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0

				arg_290_1.dialog_:SetActive(true)

				arg_290_1.dialogCg_.alpha = 0

				local var_293_4 = LeanTween.value(arg_290_1.dialog_, 0, 1, 0.3)

				var_293_4:setOnUpdate(LuaHelper.FloatAction(function(arg_294_0)
					arg_290_1.dialogCg_.alpha = arg_294_0
				end))
				var_293_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_290_1.dialog_)
					var_293_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_290_1.duration_ = arg_290_1.duration_ + 0.3

				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_5 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(305042071).content)

				arg_290_1.text_.text = var_293_5

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_7 = 41 <= 0 and var_293_3 or var_293_3 * (utf8.len(var_293_5) / 41)

				if (41 <= 0 and var_293_3 or var_293_3 * (utf8.len(var_293_5) / 41)) > 0 and var_293_3 < var_293_7 then
					arg_290_1.talkMaxDuration = var_293_7
					var_293_2 = var_293_2 + 0.3

					if var_293_7 + var_293_2 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_7 + var_293_2
					end
				end

				arg_290_1.text_.text = var_293_5
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_8 = var_293_2 + 0.3
			local var_293_9 = math.max(var_293_3, arg_290_1.talkMaxDuration)

			if var_293_2 + 0.3 <= arg_290_1.time_ and arg_290_1.time_ < var_293_8 + var_293_9 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_8) / var_293_9

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_8 + var_293_9 and arg_290_1.time_ < var_293_8 + var_293_9 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "B06a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 0.56, 8),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_290_1:InitPlayNodeList()
	end,
	Play305042072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 305042072
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play305042073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = 1.975

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_1 = arg_296_1:FormatText(arg_296_1:GetWordFromCfg(305042072).content)

				arg_296_1.text_.text = var_299_1

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_3 = 79 <= 0 and var_299_0 or var_299_0 * (utf8.len(var_299_1) / 79)

				if (79 <= 0 and var_299_0 or var_299_0 * (utf8.len(var_299_1) / 79)) > 0 and var_299_0 < var_299_3 then
					arg_296_1.talkMaxDuration = var_299_3

					if var_299_3 + 0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_3 + 0
					end
				end

				arg_296_1.text_.text = var_299_1
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_4 = math.max(var_299_0, arg_296_1.talkMaxDuration)

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_4 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - 0) / var_299_4

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= 0 + var_299_4 and arg_296_1.time_ < 0 + var_299_4 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play305042073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 305042073
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
			arg_300_1.auto_ = false
		end

		function arg_300_1.playNext_(arg_302_0)
			arg_300_1.onStoryFinished_()
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0.3

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_1 = arg_300_1:FormatText(arg_300_1:GetWordFromCfg(305042073).content)

				arg_300_1.text_.text = var_303_1

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_3 = 12 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_1) / 12)

				if (12 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_1) / 12)) > 0 and var_303_0 < var_303_3 then
					arg_300_1.talkMaxDuration = var_303_3

					if var_303_3 + 0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_3 + 0
					end
				end

				arg_300_1.text_.text = var_303_1
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_4 = math.max(var_303_0, arg_300_1.talkMaxDuration)

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_4 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - 0) / var_303_4

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= 0 + var_303_4 and arg_300_1.time_ < 0 + var_303_4 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B04g",
		"TextureConfig/Background/B06a"
	},
	voices = {
		"story_v_out_305042.awb"
	}
}
