return {
	Play321091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321091001
		arg_1_1.duration_ = 5.4

		local var_1_0 = {
			zh = 3.9,
			ja = 5.4
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
				arg_1_0:Play321091002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST73 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST73")
				var_4_0.name = "ST73"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST73 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST73

				arg_1_1.bgs_.ST73.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST73" then
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

			local var_4_9 = arg_1_1.actors_.ui_story

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_9) and arg_1_1.var_.characterEffectui_story == nil then
				arg_1_1.var_.characterEffectui_story = var_4_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_10 = 0.200000002980232

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_10 and not isNil(var_4_9) then
				if arg_1_1.var_.characterEffectui_story and not isNil(var_4_9) then
					arg_1_1.var_.characterEffectui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_10 and arg_1_1.time_ < 0 + var_4_10 + arg_4_0 and not isNil(var_4_9) and arg_1_1.var_.characterEffectui_story then
				arg_1_1.var_.characterEffectui_story.fillFlat = false
			end

			local var_4_12 = 0

			arg_1_1.isInRecall_ = false

			if var_4_12 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				arg_1_1.screenFilterGo_:SetActive(true)

				arg_1_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_4_2, iter_4_3 in pairs(arg_1_1.actors_) do
					for iter_4_4, iter_4_5 in ipairs((iter_4_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_4_5.color = iter_4_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_4_13 = 0.0666666666666667

			if var_4_12 <= arg_1_1.time_ and arg_1_1.time_ < var_4_12 + var_4_13 then
				arg_1_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_12) / var_4_13)
			end

			if arg_1_1.time_ >= var_4_12 + var_4_13 and arg_1_1.time_ < var_4_12 + var_4_13 + arg_4_0 then
				arg_1_1.screenFilterEffect_.weight = 1
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled.awb")

				local var_4_19 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_20 = 2
			local var_4_21 = 0.2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_22 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_22:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[546].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_1_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_4_23 = arg_1_1:GetWordFromCfg(321091001)
				local var_4_24 = arg_1_1:FormatText(var_4_23.content)

				arg_1_1.text_.text = var_4_24

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_26 = 8 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_24) / 8)

				if (8 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_24) / 8)) > 0 and var_4_21 < var_4_26 then
					arg_1_1.talkMaxDuration = var_4_26
					var_4_20 = var_4_20 + 0.3

					if var_4_26 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_26 + var_4_20
					end
				end

				arg_1_1.text_.text = var_4_24
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091001", "story_v_out_321091.awb") ~= 0 then
					local var_4_27 = manager.audio:GetVoiceLength("story_v_out_321091", "321091001", "story_v_out_321091.awb") / 1000

					if var_4_27 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_20
					end

					if var_4_23.prefab_name ~= "" and arg_1_1.actors_[var_4_23.prefab_name] ~= nil then
						local var_4_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_23.prefab_name].transform, "story_v_out_321091", "321091001", "story_v_out_321091.awb")

						arg_1_1:RecordAudio("321091001", var_4_28)
						arg_1_1:RecordAudio("321091001", var_4_28)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_321091", "321091001", "story_v_out_321091.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_321091", "321091001", "story_v_out_321091.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_29 = var_4_20 + 0.3
			local var_4_30 = math.max(var_4_21, arg_1_1.talkMaxDuration)

			if var_4_20 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_29) / var_4_30

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play321091002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 321091002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play321091003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.975

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(321091002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 39 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 39)

				if (39 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 39)) > 0 and var_12_0 < var_12_3 then
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
	Play321091003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 321091003
		arg_13_1.duration_ = 5.33

		local var_13_0 = {
			zh = 3.6,
			ja = 5.333
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
				arg_13_0:Play321091004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["10104ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10104ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "10104ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["10104ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["10104ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["10104ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["10104ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["10104ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10104ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0.02, -1.12, -5.99)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["10104ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect10104ui_story == nil then
				arg_13_1.var_.characterEffect10104ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect10104ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect10104ui_story then
				arg_13_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_16_8 = 0
			local var_16_9 = 0.5

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(321091003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 20 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 20)

				if (20 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 20)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091003", "story_v_out_321091.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_321091", "321091003", "story_v_out_321091.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_321091", "321091003", "story_v_out_321091.awb")

						arg_13_1:RecordAudio("321091003", var_16_15)
						arg_13_1:RecordAudio("321091003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_321091", "321091003", "story_v_out_321091.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_321091", "321091003", "story_v_out_321091.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_16 and arg_13_1.time_ < var_16_8 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play321091004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 321091004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play321091005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["10104ui_story"]) and arg_17_1.var_.characterEffect10104ui_story == nil then
				arg_17_1.var_.characterEffect10104ui_story = arg_17_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["10104ui_story"]) then
				if arg_17_1.var_.characterEffect10104ui_story and not isNil(arg_17_1.actors_["10104ui_story"]) then
					arg_17_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["10104ui_story"]) and arg_17_1.var_.characterEffect10104ui_story then
				arg_17_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 1.25

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_3 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(321091004).content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 50 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 50)

				if (50 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 50)) > 0 and var_20_2 < var_20_5 then
					arg_17_1.talkMaxDuration = var_20_5

					if var_20_5 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_6 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_6 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_6

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_6 and arg_17_1.time_ < var_20_1 + var_20_6 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play321091005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 321091005
		arg_21_1.duration_ = 6.07

		local var_21_0 = {
			zh = 4.466,
			ja = 6.066
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
				arg_21_0:Play321091006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10104ui_story"]) and arg_21_1.var_.characterEffect10104ui_story == nil then
				arg_21_1.var_.characterEffect10104ui_story = arg_21_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["10104ui_story"]) then
				if arg_21_1.var_.characterEffect10104ui_story and not isNil(arg_21_1.actors_["10104ui_story"]) then
					arg_21_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["10104ui_story"]) and arg_21_1.var_.characterEffect10104ui_story then
				arg_21_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_24_2 = 0
			local var_24_3 = 0.5

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:GetWordFromCfg(321091005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 20 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 20)

				if (20 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 20)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091005", "story_v_out_321091.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091005", "story_v_out_321091.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_321091", "321091005", "story_v_out_321091.awb")

						arg_21_1:RecordAudio("321091005", var_24_9)
						arg_21_1:RecordAudio("321091005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_321091", "321091005", "story_v_out_321091.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_321091", "321091005", "story_v_out_321091.awb")
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
	Play321091006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 321091006
		arg_25_1.duration_ = 14.77

		local var_25_0 = {
			zh = 11.033,
			ja = 14.766
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play321091007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10104ui_story = arg_25_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10104ui_story"].transform.position).z)
				arg_25_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["10104ui_story"].transform.localEulerAngles = arg_25_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_25_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10104ui_story"].transform.position).z)
				arg_25_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["10104ui_story"].transform.localEulerAngles = arg_25_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_28_1 = 0
			local var_28_2 = 1.375

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:GetWordFromCfg(321091006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_6 = 55 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_4) / 55)

				if (55 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_4) / 55)) > 0 and var_28_2 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091006", "story_v_out_321091.awb") ~= 0 then
					local var_28_7 = manager.audio:GetVoiceLength("story_v_out_321091", "321091006", "story_v_out_321091.awb") / 1000

					if var_28_7 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_1
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_321091", "321091006", "story_v_out_321091.awb")

						arg_25_1:RecordAudio("321091006", var_28_8)
						arg_25_1:RecordAudio("321091006", var_28_8)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_321091", "321091006", "story_v_out_321091.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_321091", "321091006", "story_v_out_321091.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_9 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_9 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_9

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_9 and arg_25_1.time_ < var_28_1 + var_28_9 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play321091007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 321091007
		arg_29_1.duration_ = 10.7

		local var_29_0 = {
			zh = 7.833,
			ja = 10.7
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
				arg_29_0:Play321091008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.875

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:GetWordFromCfg(321091007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 35 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 35)

				if (35 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 35)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091007", "story_v_out_321091.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_321091", "321091007", "story_v_out_321091.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_321091", "321091007", "story_v_out_321091.awb")

						arg_29_1:RecordAudio("321091007", var_32_6)
						arg_29_1:RecordAudio("321091007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_321091", "321091007", "story_v_out_321091.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_321091", "321091007", "story_v_out_321091.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play321091008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 321091008
		arg_33_1.duration_ = 6.67

		local var_33_0 = {
			zh = 5.1,
			ja = 6.666
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
				arg_33_0:Play321091009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10104ui_story"]) and arg_33_1.var_.characterEffect10104ui_story == nil then
				arg_33_1.var_.characterEffect10104ui_story = arg_33_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["10104ui_story"]) then
				if arg_33_1.var_.characterEffect10104ui_story and not isNil(arg_33_1.actors_["10104ui_story"]) then
					arg_33_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["10104ui_story"]) and arg_33_1.var_.characterEffect10104ui_story then
				arg_33_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.625

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[546].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_33_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_36_3 = arg_33_1:GetWordFromCfg(321091008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 25 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 25)

				if (25 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 25)) > 0 and var_36_2 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091008", "story_v_out_321091.awb") ~= 0 then
					local var_36_7 = manager.audio:GetVoiceLength("story_v_out_321091", "321091008", "story_v_out_321091.awb") / 1000

					if var_36_7 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_1
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_321091", "321091008", "story_v_out_321091.awb")

						arg_33_1:RecordAudio("321091008", var_36_8)
						arg_33_1:RecordAudio("321091008", var_36_8)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_321091", "321091008", "story_v_out_321091.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_321091", "321091008", "story_v_out_321091.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_9 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_9 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_9

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_9 and arg_33_1.time_ < var_36_1 + var_36_9 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play321091009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 321091009
		arg_37_1.duration_ = 4.83

		local var_37_0 = {
			zh = 3.233,
			ja = 4.833
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
				arg_37_0:Play321091010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["10104ui_story"]) and arg_37_1.var_.characterEffect10104ui_story == nil then
				arg_37_1.var_.characterEffect10104ui_story = arg_37_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["10104ui_story"]) then
				if arg_37_1.var_.characterEffect10104ui_story and not isNil(arg_37_1.actors_["10104ui_story"]) then
					arg_37_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["10104ui_story"]) and arg_37_1.var_.characterEffect10104ui_story then
				arg_37_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_40_2 = 0
			local var_40_3 = 0.375

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_4 = arg_37_1:GetWordFromCfg(321091009)
				local var_40_5 = arg_37_1:FormatText(var_40_4.content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 15 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 15)

				if (15 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 15)) > 0 and var_40_3 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_2
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091009", "story_v_out_321091.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091009", "story_v_out_321091.awb") / 1000

					if var_40_8 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_2
					end

					if var_40_4.prefab_name ~= "" and arg_37_1.actors_[var_40_4.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_4.prefab_name].transform, "story_v_out_321091", "321091009", "story_v_out_321091.awb")

						arg_37_1:RecordAudio("321091009", var_40_9)
						arg_37_1:RecordAudio("321091009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_321091", "321091009", "story_v_out_321091.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_321091", "321091009", "story_v_out_321091.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_3, arg_37_1.talkMaxDuration)

			if var_40_2 <= arg_37_1.time_ and arg_37_1.time_ < var_40_2 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_2) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_2 + var_40_10 and arg_37_1.time_ < var_40_2 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play321091010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 321091010
		arg_41_1.duration_ = 17.93

		local var_41_0 = {
			zh = 10.833,
			ja = 17.933
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
				arg_41_0:Play321091011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10104ui_story = arg_41_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10104ui_story"].transform.position).z)
				arg_41_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["10104ui_story"].transform.localEulerAngles = arg_41_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_41_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10104ui_story"].transform.position).z)
				arg_41_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["10104ui_story"].transform.localEulerAngles = arg_41_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_2")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_44_1 = 0
			local var_44_2 = 1.225

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_3 = arg_41_1:GetWordFromCfg(321091010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_6 = 49 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_4) / 49)

				if (49 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_4) / 49)) > 0 and var_44_2 < var_44_6 then
					arg_41_1.talkMaxDuration = var_44_6

					if var_44_6 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_1
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091010", "story_v_out_321091.awb") ~= 0 then
					local var_44_7 = manager.audio:GetVoiceLength("story_v_out_321091", "321091010", "story_v_out_321091.awb") / 1000

					if var_44_7 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_1
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_321091", "321091010", "story_v_out_321091.awb")

						arg_41_1:RecordAudio("321091010", var_44_8)
						arg_41_1:RecordAudio("321091010", var_44_8)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_321091", "321091010", "story_v_out_321091.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_321091", "321091010", "story_v_out_321091.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_9 = math.max(var_44_2, arg_41_1.talkMaxDuration)

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_9 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_1) / var_44_9

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_1 + var_44_9 and arg_41_1.time_ < var_44_1 + var_44_9 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play321091011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 321091011
		arg_45_1.duration_ = 2.87

		local var_45_0 = {
			zh = 2.866,
			ja = 2.766
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
				arg_45_0:Play321091012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["10104ui_story"]) and arg_45_1.var_.characterEffect10104ui_story == nil then
				arg_45_1.var_.characterEffect10104ui_story = arg_45_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["10104ui_story"]) then
				if arg_45_1.var_.characterEffect10104ui_story and not isNil(arg_45_1.actors_["10104ui_story"]) then
					arg_45_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["10104ui_story"]) and arg_45_1.var_.characterEffect10104ui_story then
				arg_45_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.225

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[546].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_45_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_48_3 = arg_45_1:GetWordFromCfg(321091011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_6 = 9 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_4) / 9)

				if (9 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_4) / 9)) > 0 and var_48_2 < var_48_6 then
					arg_45_1.talkMaxDuration = var_48_6

					if var_48_6 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091011", "story_v_out_321091.awb") ~= 0 then
					local var_48_7 = manager.audio:GetVoiceLength("story_v_out_321091", "321091011", "story_v_out_321091.awb") / 1000

					if var_48_7 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_1
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_321091", "321091011", "story_v_out_321091.awb")

						arg_45_1:RecordAudio("321091011", var_48_8)
						arg_45_1:RecordAudio("321091011", var_48_8)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_321091", "321091011", "story_v_out_321091.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_321091", "321091011", "story_v_out_321091.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_9 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_9 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_9

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_9 and arg_45_1.time_ < var_48_1 + var_48_9 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play321091012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 321091012
		arg_49_1.duration_ = 7.7

		local var_49_0 = {
			zh = 6.5,
			ja = 7.7
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
				arg_49_0:Play321091013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10104ui_story = arg_49_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10104ui_story"].transform.position).z)
				arg_49_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["10104ui_story"].transform.localEulerAngles = arg_49_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_49_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10104ui_story"].transform.position).z)
				arg_49_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["10104ui_story"].transform.localEulerAngles = arg_49_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["10104ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect10104ui_story == nil then
				arg_49_1.var_.characterEffect10104ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect10104ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect10104ui_story then
				arg_49_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_52_4 = 0
			local var_52_5 = 0.875

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(321091012)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 35 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 35)

				if (35 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 35)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091012", "story_v_out_321091.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_out_321091", "321091012", "story_v_out_321091.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_out_321091", "321091012", "story_v_out_321091.awb")

						arg_49_1:RecordAudio("321091012", var_52_11)
						arg_49_1:RecordAudio("321091012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_321091", "321091012", "story_v_out_321091.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_321091", "321091012", "story_v_out_321091.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_12 = math.max(var_52_5, arg_49_1.talkMaxDuration)

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_12 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_4) / var_52_12

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_4 + var_52_12 and arg_49_1.time_ < var_52_4 + var_52_12 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play321091013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 321091013
		arg_53_1.duration_ = 17.7

		local var_53_0 = {
			zh = 10.5,
			ja = 17.7
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
				arg_53_0:Play321091014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_1")
			end

			local var_56_0 = 0
			local var_56_1 = 1.2

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_2 = arg_53_1:GetWordFromCfg(321091013)
				local var_56_3 = arg_53_1:FormatText(var_56_2.content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 48 <= 0 and var_56_1 or var_56_1 * (utf8.len(var_56_3) / 48)

				if (48 <= 0 and var_56_1 or var_56_1 * (utf8.len(var_56_3) / 48)) > 0 and var_56_1 < var_56_5 then
					arg_53_1.talkMaxDuration = var_56_5

					if var_56_5 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091013", "story_v_out_321091.awb") ~= 0 then
					local var_56_6 = manager.audio:GetVoiceLength("story_v_out_321091", "321091013", "story_v_out_321091.awb") / 1000

					if var_56_6 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_0
					end

					if var_56_2.prefab_name ~= "" and arg_53_1.actors_[var_56_2.prefab_name] ~= nil then
						local var_56_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_2.prefab_name].transform, "story_v_out_321091", "321091013", "story_v_out_321091.awb")

						arg_53_1:RecordAudio("321091013", var_56_7)
						arg_53_1:RecordAudio("321091013", var_56_7)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_321091", "321091013", "story_v_out_321091.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_321091", "321091013", "story_v_out_321091.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_8 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_8 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_8

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_8 and arg_53_1.time_ < var_56_0 + var_56_8 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play321091014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 321091014
		arg_57_1.duration_ = 20.07

		local var_57_0 = {
			zh = 11.533,
			ja = 20.066
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
				arg_57_0:Play321091015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 1.375

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:GetWordFromCfg(321091014)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 55 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 55)

				if (55 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 55)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091014", "story_v_out_321091.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_321091", "321091014", "story_v_out_321091.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_321091", "321091014", "story_v_out_321091.awb")

						arg_57_1:RecordAudio("321091014", var_60_6)
						arg_57_1:RecordAudio("321091014", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_321091", "321091014", "story_v_out_321091.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_321091", "321091014", "story_v_out_321091.awb")
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
	Play321091015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 321091015
		arg_61_1.duration_ = 12.63

		local var_61_0 = {
			zh = 7.5,
			ja = 12.633
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
				arg_61_0:Play321091016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10104ui_story = arg_61_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10104ui_story"].transform.position).z)
				arg_61_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["10104ui_story"].transform.localEulerAngles = arg_61_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_61_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10104ui_story"].transform.position).z)
				arg_61_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["10104ui_story"].transform.localEulerAngles = arg_61_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_64_1 = 0
			local var_64_2 = 1

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:GetWordFromCfg(321091015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 40 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 40)

				if (40 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 40)) > 0 and var_64_2 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091015", "story_v_out_321091.awb") ~= 0 then
					local var_64_7 = manager.audio:GetVoiceLength("story_v_out_321091", "321091015", "story_v_out_321091.awb") / 1000

					if var_64_7 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_1
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_321091", "321091015", "story_v_out_321091.awb")

						arg_61_1:RecordAudio("321091015", var_64_8)
						arg_61_1:RecordAudio("321091015", var_64_8)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_321091", "321091015", "story_v_out_321091.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_321091", "321091015", "story_v_out_321091.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_9 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_9 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_9

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_9 and arg_61_1.time_ < var_64_1 + var_64_9 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play321091016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 321091016
		arg_65_1.duration_ = 10.83

		local var_65_0 = {
			zh = 7.133,
			ja = 10.833
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
				arg_65_0:Play321091017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.875

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_1 = arg_65_1:GetWordFromCfg(321091016)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 35 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 35)

				if (35 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 35)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091016", "story_v_out_321091.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_321091", "321091016", "story_v_out_321091.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_321091", "321091016", "story_v_out_321091.awb")

						arg_65_1:RecordAudio("321091016", var_68_6)
						arg_65_1:RecordAudio("321091016", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_321091", "321091016", "story_v_out_321091.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_321091", "321091016", "story_v_out_321091.awb")
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
	Play321091017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 321091017
		arg_69_1.duration_ = 15.9

		local var_69_0 = {
			zh = 9.8,
			ja = 15.9
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
				arg_69_0:Play321091018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10104ui_story = arg_69_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10104ui_story"].transform.position).z)
				arg_69_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["10104ui_story"].transform.localEulerAngles = arg_69_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_69_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10104ui_story"].transform.position).z)
				arg_69_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["10104ui_story"].transform.localEulerAngles = arg_69_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_2")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_72_1 = 0
			local var_72_2 = 1

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:GetWordFromCfg(321091017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_6 = 40 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_4) / 40)

				if (40 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_4) / 40)) > 0 and var_72_2 < var_72_6 then
					arg_69_1.talkMaxDuration = var_72_6

					if var_72_6 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091017", "story_v_out_321091.awb") ~= 0 then
					local var_72_7 = manager.audio:GetVoiceLength("story_v_out_321091", "321091017", "story_v_out_321091.awb") / 1000

					if var_72_7 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_1
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_321091", "321091017", "story_v_out_321091.awb")

						arg_69_1:RecordAudio("321091017", var_72_8)
						arg_69_1:RecordAudio("321091017", var_72_8)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_321091", "321091017", "story_v_out_321091.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_321091", "321091017", "story_v_out_321091.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_9 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_9 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_9

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_9 and arg_69_1.time_ < var_72_1 + var_72_9 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play321091018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 321091018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play321091019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["10104ui_story"]) and arg_73_1.var_.characterEffect10104ui_story == nil then
				arg_73_1.var_.characterEffect10104ui_story = arg_73_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["10104ui_story"]) then
				if arg_73_1.var_.characterEffect10104ui_story and not isNil(arg_73_1.actors_["10104ui_story"]) then
					arg_73_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["10104ui_story"]) and arg_73_1.var_.characterEffect10104ui_story then
				arg_73_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_76_1 = arg_73_1.actors_["10104ui_story"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10104ui_story = var_76_1.localPosition
			end

			local var_76_2 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 then
				var_76_1.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_73_1.time_ - 0) / var_76_2)
				var_76_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_1.position).x, (manager.ui.mainCamera.transform.position - var_76_1.position).y, (manager.ui.mainCamera.transform.position - var_76_1.position).z)
				var_76_1.localEulerAngles.z = 0
				var_76_1.localEulerAngles.x = 0
				var_76_1.localEulerAngles = var_76_1.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 then
				var_76_1.localPosition = Vector3.New(0, 100, 0)
				var_76_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_1.position).x, (manager.ui.mainCamera.transform.position - var_76_1.position).y, (manager.ui.mainCamera.transform.position - var_76_1.position).z)
				var_76_1.localEulerAngles.z = 0
				var_76_1.localEulerAngles.x = 0
				var_76_1.localEulerAngles = var_76_1.localEulerAngles
			end

			local var_76_3 = 0
			local var_76_4 = 1.1

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_3 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_5 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(321091018).content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 44 <= 0 and var_76_4 or var_76_4 * (utf8.len(var_76_5) / 44)

				if (44 <= 0 and var_76_4 or var_76_4 * (utf8.len(var_76_5) / 44)) > 0 and var_76_4 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_3 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_3
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_8 = math.max(var_76_4, arg_73_1.talkMaxDuration)

			if var_76_3 <= arg_73_1.time_ and arg_73_1.time_ < var_76_3 + var_76_8 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_3) / var_76_8

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_3 + var_76_8 and arg_73_1.time_ < var_76_3 + var_76_8 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play321091019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 321091019
		arg_77_1.duration_ = 13.23

		local var_77_0 = {
			zh = 7.833,
			ja = 13.233
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
				arg_77_0:Play321091020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 1.15

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[546].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_77_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_80_1 = arg_77_1:GetWordFromCfg(321091019)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 46 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 46)

				if (46 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 46)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091019", "story_v_out_321091.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_321091", "321091019", "story_v_out_321091.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_321091", "321091019", "story_v_out_321091.awb")

						arg_77_1:RecordAudio("321091019", var_80_6)
						arg_77_1:RecordAudio("321091019", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_321091", "321091019", "story_v_out_321091.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_321091", "321091019", "story_v_out_321091.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play321091020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 321091020
		arg_81_1.duration_ = 8.03

		local var_81_0 = {
			zh = 8.033,
			ja = 7.333
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
				arg_81_0:Play321091021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.825

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[546].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_81_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_84_1 = arg_81_1:GetWordFromCfg(321091020)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 33 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 33)

				if (33 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 33)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091020", "story_v_out_321091.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_321091", "321091020", "story_v_out_321091.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_321091", "321091020", "story_v_out_321091.awb")

						arg_81_1:RecordAudio("321091020", var_84_6)
						arg_81_1:RecordAudio("321091020", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_321091", "321091020", "story_v_out_321091.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_321091", "321091020", "story_v_out_321091.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play321091021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 321091021
		arg_85_1.duration_ = 4.77

		local var_85_0 = {
			zh = 3.266,
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
				arg_85_0:Play321091022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10104ui_story = arg_85_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10104ui_story"].transform.position).z)
				arg_85_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["10104ui_story"].transform.localEulerAngles = arg_85_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10104ui_story"].transform.position).z)
				arg_85_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["10104ui_story"].transform.localEulerAngles = arg_85_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_88_1 = 0
			local var_88_2 = 0.3

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[546].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_85_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_88_3 = arg_85_1:GetWordFromCfg(321091021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_6 = 12 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 12)

				if (12 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 12)) > 0 and var_88_2 < var_88_6 then
					arg_85_1.talkMaxDuration = var_88_6

					if var_88_6 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091021", "story_v_out_321091.awb") ~= 0 then
					local var_88_7 = manager.audio:GetVoiceLength("story_v_out_321091", "321091021", "story_v_out_321091.awb") / 1000

					if var_88_7 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_1
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_321091", "321091021", "story_v_out_321091.awb")

						arg_85_1:RecordAudio("321091021", var_88_8)
						arg_85_1:RecordAudio("321091021", var_88_8)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_321091", "321091021", "story_v_out_321091.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_321091", "321091021", "story_v_out_321091.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_9 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_9 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_9

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_9 and arg_85_1.time_ < var_88_1 + var_88_9 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play321091022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 321091022
		arg_89_1.duration_ = 4.97

		local var_89_0 = {
			zh = 4.86666666666667,
			ja = 4.96666666666667
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
				arg_89_0:Play321091023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if arg_89_1.bgs_.MS2103a == nil then
				local var_92_0 = Object.Instantiate(arg_89_1.paintGo_)

				var_92_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS2103a")
				var_92_0.name = "MS2103a"
				var_92_0.transform.parent = arg_89_1.stage_.transform
				var_92_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.bgs_.MS2103a = var_92_0
			end

			if 2 < arg_89_1.time_ and arg_89_1.time_ <= 2 + arg_92_0 then
				local var_92_1 = arg_89_1.bgs_.MS2103a

				arg_89_1.bgs_.MS2103a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_92_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_92_2 = var_92_1:GetComponent("SpriteRenderer")

				if var_92_2 and var_92_2.sprite then
					local var_92_3 = 2 * (var_92_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_92_1.transform.localScale = Vector3.New(var_92_3 / var_92_2.sprite.bounds.size.y < var_92_3 * manager.ui.mainCameraCom_.aspect / var_92_2.sprite.bounds.size.x and var_92_3 * manager.ui.mainCameraCom_.aspect / var_92_2.sprite.bounds.size.x or var_92_3 / var_92_2.sprite.bounds.size.y, var_92_3 / var_92_2.sprite.bounds.size.y < var_92_3 * manager.ui.mainCameraCom_.aspect / var_92_2.sprite.bounds.size.x and var_92_3 * manager.ui.mainCameraCom_.aspect / var_92_2.sprite.bounds.size.x or var_92_3 / var_92_2.sprite.bounds.size.y, 0)
				end

				for iter_92_0, iter_92_1 in pairs(arg_89_1.bgs_) do
					if iter_92_0 ~= "MS2103a" then
						iter_92_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_92_4 = 0

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.allBtn_.enabled = false
			end

			if arg_89_1.time_ >= var_92_4 + 0.3 and arg_89_1.time_ < var_92_4 + 0.3 + arg_92_0 then
				arg_89_1.allBtn_.enabled = true
			end

			local var_92_5 = 0

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_5 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_6 = 2

			if var_92_5 <= arg_89_1.time_ and arg_89_1.time_ < var_92_5 + var_92_6 then
				local var_92_7 = Color.New(0, 0, 0)

				var_92_7.a = Mathf.Lerp(0, 1, (arg_89_1.time_ - var_92_5) / var_92_6)
				arg_89_1.mask_.color = var_92_7
			end

			if arg_89_1.time_ >= var_92_5 + var_92_6 and arg_89_1.time_ < var_92_5 + var_92_6 + arg_92_0 then
				local var_92_8 = Color.New(0, 0, 0)

				var_92_8.a = 1
				arg_89_1.mask_.color = var_92_8
			end

			local var_92_9 = 2

			if 2 < arg_89_1.time_ and arg_89_1.time_ <= var_92_9 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_10 = 2

			if var_92_9 <= arg_89_1.time_ and arg_89_1.time_ < var_92_9 + var_92_10 then
				local var_92_11 = Color.New(0, 0, 0)

				var_92_11.a = Mathf.Lerp(1, 0, (arg_89_1.time_ - var_92_9) / var_92_10)
				arg_89_1.mask_.color = var_92_11
			end

			if arg_89_1.time_ >= var_92_9 + var_92_10 and arg_89_1.time_ < var_92_9 + var_92_10 + arg_92_0 then
				local var_92_12 = Color.New(0, 0, 0)

				arg_89_1.mask_.enabled = false
				var_92_12.a = 0
				arg_89_1.mask_.color = var_92_12
			end

			local var_92_13 = arg_89_1.actors_["10104ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_13) and arg_89_1.var_.characterEffect10104ui_story == nil then
				arg_89_1.var_.characterEffect10104ui_story = var_92_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_14 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_14 and not isNil(var_92_13) then
				if arg_89_1.var_.characterEffect10104ui_story and not isNil(var_92_13) then
					arg_89_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_14 and arg_89_1.time_ < 0 + var_92_14 + arg_92_0 and not isNil(var_92_13) and arg_89_1.var_.characterEffect10104ui_story then
				arg_89_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_92_16 = 2

			arg_89_1.isInRecall_ = false

			if var_92_16 < arg_89_1.time_ and arg_89_1.time_ <= var_92_16 + arg_92_0 then
				arg_89_1.screenFilterGo_:SetActive(false)

				for iter_92_2, iter_92_3 in pairs(arg_89_1.actors_) do
					for iter_92_4, iter_92_5 in ipairs((iter_92_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_92_5.color = iter_92_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_92_17 = 0.0333333333333332

			if var_92_16 <= arg_89_1.time_ and arg_89_1.time_ < var_92_16 + var_92_17 then
				arg_89_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_89_1.time_ - var_92_16) / var_92_17)
			end

			if arg_89_1.time_ >= var_92_16 + var_92_17 and arg_89_1.time_ < var_92_16 + var_92_17 + arg_92_0 then
				arg_89_1.screenFilterEffect_.weight = 0
			end

			if arg_89_1.frameCnt_ <= 1 then
				arg_89_1.dialog_:SetActive(false)
			end

			local var_92_18 = 3.86666666666667
			local var_92_19 = 0.133333333333333

			if 3.86666666666667 < arg_89_1.time_ and arg_89_1.time_ <= var_92_18 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0

				arg_89_1.dialog_:SetActive(true)

				arg_89_1.dialogCg_.alpha = 0

				local var_92_20 = LeanTween.value(arg_89_1.dialog_, 0, 1, 0.3)

				var_92_20:setOnUpdate(LuaHelper.FloatAction(function(arg_93_0)
					arg_89_1.dialogCg_.alpha = arg_93_0
				end))
				var_92_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_89_1.dialog_)
					var_92_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_89_1.duration_ = arg_89_1.duration_ + 0.3

				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_21 = arg_89_1:GetWordFromCfg(321091022)
				local var_92_22 = arg_89_1:FormatText(var_92_21.content)

				arg_89_1.text_.text = var_92_22

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_24 = 2 <= 0 and var_92_19 or var_92_19 * (utf8.len(var_92_22) / 2)

				if (2 <= 0 and var_92_19 or var_92_19 * (utf8.len(var_92_22) / 2)) > 0 and var_92_19 < var_92_24 then
					arg_89_1.talkMaxDuration = var_92_24
					var_92_18 = var_92_18 + 0.3

					if var_92_24 + var_92_18 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_24 + var_92_18
					end
				end

				arg_89_1.text_.text = var_92_22
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091022", "story_v_out_321091.awb") ~= 0 then
					local var_92_25 = manager.audio:GetVoiceLength("story_v_out_321091", "321091022", "story_v_out_321091.awb") / 1000

					if var_92_25 + var_92_18 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_25 + var_92_18
					end

					if var_92_21.prefab_name ~= "" and arg_89_1.actors_[var_92_21.prefab_name] ~= nil then
						local var_92_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_21.prefab_name].transform, "story_v_out_321091", "321091022", "story_v_out_321091.awb")

						arg_89_1:RecordAudio("321091022", var_92_26)
						arg_89_1:RecordAudio("321091022", var_92_26)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_321091", "321091022", "story_v_out_321091.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_321091", "321091022", "story_v_out_321091.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_27 = var_92_18 + 0.3
			local var_92_28 = math.max(var_92_19, arg_89_1.talkMaxDuration)

			if var_92_18 + 0.3 <= arg_89_1.time_ and arg_89_1.time_ < var_92_27 + var_92_28 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_27) / var_92_28

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_27 + var_92_28 and arg_89_1.time_ < var_92_27 + var_92_28 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play321091023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 321091023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play321091024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["10104ui_story"]) and arg_95_1.var_.characterEffect10104ui_story == nil then
				arg_95_1.var_.characterEffect10104ui_story = arg_95_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_0 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["10104ui_story"]) then
				if arg_95_1.var_.characterEffect10104ui_story and not isNil(arg_95_1.actors_["10104ui_story"]) then
					arg_95_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_95_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_0)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["10104ui_story"]) and arg_95_1.var_.characterEffect10104ui_story then
				arg_95_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_95_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0.05 < arg_95_1.time_ and arg_95_1.time_ <= 0.05 + arg_98_0 then
				arg_95_1:AudioAction("play", "effect", "se_story_16", "se_story_16_chain", "")
			end

			local var_98_2 = 0
			local var_98_3 = 1.475

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_2 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_4 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(321091023).content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_6 = 59 <= 0 and var_98_3 or var_98_3 * (utf8.len(var_98_4) / 59)

				if (59 <= 0 and var_98_3 or var_98_3 * (utf8.len(var_98_4) / 59)) > 0 and var_98_3 < var_98_6 then
					arg_95_1.talkMaxDuration = var_98_6

					if var_98_6 + var_98_2 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_6 + var_98_2
					end
				end

				arg_95_1.text_.text = var_98_4
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_3, arg_95_1.talkMaxDuration)

			if var_98_2 <= arg_95_1.time_ and arg_95_1.time_ < var_98_2 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_2) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_2 + var_98_7 and arg_95_1.time_ < var_98_2 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play321091024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 321091024
		arg_99_1.duration_ = 11.73

		local var_99_0 = {
			zh = 6.9,
			ja = 11.733
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
				arg_99_0:Play321091025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.6

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:GetWordFromCfg(321091024)
				local var_102_2 = arg_99_1:FormatText(var_102_1.content)

				arg_99_1.text_.text = var_102_2

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 24 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 24)

				if (24 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 24)) > 0 and var_102_0 < var_102_4 then
					arg_99_1.talkMaxDuration = var_102_4

					if var_102_4 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_4 + 0
					end
				end

				arg_99_1.text_.text = var_102_2
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091024", "story_v_out_321091.awb") ~= 0 then
					local var_102_5 = manager.audio:GetVoiceLength("story_v_out_321091", "321091024", "story_v_out_321091.awb") / 1000

					if var_102_5 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + 0
					end

					if var_102_1.prefab_name ~= "" and arg_99_1.actors_[var_102_1.prefab_name] ~= nil then
						local var_102_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_1.prefab_name].transform, "story_v_out_321091", "321091024", "story_v_out_321091.awb")

						arg_99_1:RecordAudio("321091024", var_102_6)
						arg_99_1:RecordAudio("321091024", var_102_6)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_321091", "321091024", "story_v_out_321091.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_321091", "321091024", "story_v_out_321091.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_7 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_7 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_7

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_7 and arg_99_1.time_ < 0 + var_102_7 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play321091025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 321091025
		arg_103_1.duration_ = 5.73

		local var_103_0 = {
			zh = 4.366,
			ja = 5.733
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
				arg_103_0:Play321091026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["10104ui_story"]) and arg_103_1.var_.characterEffect10104ui_story == nil then
				arg_103_1.var_.characterEffect10104ui_story = arg_103_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_0 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["10104ui_story"]) then
				if arg_103_1.var_.characterEffect10104ui_story and not isNil(arg_103_1.actors_["10104ui_story"]) then
					arg_103_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["10104ui_story"]) and arg_103_1.var_.characterEffect10104ui_story then
				arg_103_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_106_2 = 0
			local var_106_3 = 0.5

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_2 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_4 = arg_103_1:GetWordFromCfg(321091025)
				local var_106_5 = arg_103_1:FormatText(var_106_4.content)

				arg_103_1.text_.text = var_106_5

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_7 = 20 <= 0 and var_106_3 or var_106_3 * (utf8.len(var_106_5) / 20)

				if (20 <= 0 and var_106_3 or var_106_3 * (utf8.len(var_106_5) / 20)) > 0 and var_106_3 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_2 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_2
					end
				end

				arg_103_1.text_.text = var_106_5
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091025", "story_v_out_321091.awb") ~= 0 then
					local var_106_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091025", "story_v_out_321091.awb") / 1000

					if var_106_8 + var_106_2 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_2
					end

					if var_106_4.prefab_name ~= "" and arg_103_1.actors_[var_106_4.prefab_name] ~= nil then
						local var_106_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_4.prefab_name].transform, "story_v_out_321091", "321091025", "story_v_out_321091.awb")

						arg_103_1:RecordAudio("321091025", var_106_9)
						arg_103_1:RecordAudio("321091025", var_106_9)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_321091", "321091025", "story_v_out_321091.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_321091", "321091025", "story_v_out_321091.awb")
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
	Play321091026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 321091026
		arg_107_1.duration_ = 12.97

		local var_107_0 = {
			zh = 8.7,
			ja = 12.966
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
				arg_107_0:Play321091027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 1.05

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_1 = arg_107_1:GetWordFromCfg(321091026)
				local var_110_2 = arg_107_1:FormatText(var_110_1.content)

				arg_107_1.text_.text = var_110_2

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_4 = 42 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_2) / 42)

				if (42 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_2) / 42)) > 0 and var_110_0 < var_110_4 then
					arg_107_1.talkMaxDuration = var_110_4

					if var_110_4 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_4 + 0
					end
				end

				arg_107_1.text_.text = var_110_2
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091026", "story_v_out_321091.awb") ~= 0 then
					local var_110_5 = manager.audio:GetVoiceLength("story_v_out_321091", "321091026", "story_v_out_321091.awb") / 1000

					if var_110_5 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + 0
					end

					if var_110_1.prefab_name ~= "" and arg_107_1.actors_[var_110_1.prefab_name] ~= nil then
						local var_110_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_1.prefab_name].transform, "story_v_out_321091", "321091026", "story_v_out_321091.awb")

						arg_107_1:RecordAudio("321091026", var_110_6)
						arg_107_1:RecordAudio("321091026", var_110_6)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_321091", "321091026", "story_v_out_321091.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_321091", "321091026", "story_v_out_321091.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_7 = math.max(var_110_0, arg_107_1.talkMaxDuration)

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_7 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - 0) / var_110_7

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= 0 + var_110_7 and arg_107_1.time_ < 0 + var_110_7 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play321091027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 321091027
		arg_111_1.duration_ = 1

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"

			SetActive(arg_111_1.choicesGo_, true)

			for iter_112_0, iter_112_1 in ipairs(arg_111_1.choices_) do
				SetActive(iter_112_1.go, iter_112_0 <= 1)
			end

			arg_111_1.choices_[1].txt.text = arg_111_1:FormatText(StoryChoiceCfg[1265].name)
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play321091028(arg_111_1)
			end

			arg_111_1:RecordChoiceLog(321091027, 1265)
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["10104ui_story"]) and arg_111_1.var_.characterEffect10104ui_story == nil then
				arg_111_1.var_.characterEffect10104ui_story = arg_111_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["10104ui_story"]) then
				if arg_111_1.var_.characterEffect10104ui_story and not isNil(arg_111_1.actors_["10104ui_story"]) then
					arg_111_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_111_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_0)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["10104ui_story"]) and arg_111_1.var_.characterEffect10104ui_story then
				arg_111_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_111_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play321091028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 321091028
		arg_115_1.duration_ = 6.57

		local var_115_0 = {
			zh = 4,
			ja = 6.566
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
				arg_115_0:Play321091029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0.275

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_1 = arg_115_1:GetWordFromCfg(321091028)
				local var_118_2 = arg_115_1:FormatText(var_118_1.content)

				arg_115_1.text_.text = var_118_2

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_4 = 11 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 11)

				if (11 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 11)) > 0 and var_118_0 < var_118_4 then
					arg_115_1.talkMaxDuration = var_118_4

					if var_118_4 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_4 + 0
					end
				end

				arg_115_1.text_.text = var_118_2
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091028", "story_v_out_321091.awb") ~= 0 then
					local var_118_5 = manager.audio:GetVoiceLength("story_v_out_321091", "321091028", "story_v_out_321091.awb") / 1000

					if var_118_5 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + 0
					end

					if var_118_1.prefab_name ~= "" and arg_115_1.actors_[var_118_1.prefab_name] ~= nil then
						local var_118_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_1.prefab_name].transform, "story_v_out_321091", "321091028", "story_v_out_321091.awb")

						arg_115_1:RecordAudio("321091028", var_118_6)
						arg_115_1:RecordAudio("321091028", var_118_6)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_321091", "321091028", "story_v_out_321091.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_321091", "321091028", "story_v_out_321091.awb")
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
	Play321091029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 321091029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play321091030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.925

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_1 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(321091029).content)

				arg_119_1.text_.text = var_122_1

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_3 = 37 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 37)

				if (37 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 37)) > 0 and var_122_0 < var_122_3 then
					arg_119_1.talkMaxDuration = var_122_3

					if var_122_3 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_3 + 0
					end
				end

				arg_119_1.text_.text = var_122_1
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_4 = math.max(var_122_0, arg_119_1.talkMaxDuration)

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_4 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - 0) / var_122_4

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= 0 + var_122_4 and arg_119_1.time_ < 0 + var_122_4 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play321091030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 321091030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play321091031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 1.4

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_1 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(321091030).content)

				arg_123_1.text_.text = var_126_1

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_3 = 56 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 56)

				if (56 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 56)) > 0 and var_126_0 < var_126_3 then
					arg_123_1.talkMaxDuration = var_126_3

					if var_126_3 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_3 + 0
					end
				end

				arg_123_1.text_.text = var_126_1
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_4 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_4

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play321091031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 321091031
		arg_127_1.duration_ = 18.47

		local var_127_0 = {
			zh = 10.3,
			ja = 18.466
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
				arg_127_0:Play321091032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.725

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_1 = arg_127_1:GetWordFromCfg(321091031)
				local var_130_2 = arg_127_1:FormatText(var_130_1.content)

				arg_127_1.text_.text = var_130_2

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 29 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 29)

				if (29 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 29)) > 0 and var_130_0 < var_130_4 then
					arg_127_1.talkMaxDuration = var_130_4

					if var_130_4 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_4 + 0
					end
				end

				arg_127_1.text_.text = var_130_2
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091031", "story_v_out_321091.awb") ~= 0 then
					local var_130_5 = manager.audio:GetVoiceLength("story_v_out_321091", "321091031", "story_v_out_321091.awb") / 1000

					if var_130_5 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + 0
					end

					if var_130_1.prefab_name ~= "" and arg_127_1.actors_[var_130_1.prefab_name] ~= nil then
						local var_130_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_1.prefab_name].transform, "story_v_out_321091", "321091031", "story_v_out_321091.awb")

						arg_127_1:RecordAudio("321091031", var_130_6)
						arg_127_1:RecordAudio("321091031", var_130_6)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_321091", "321091031", "story_v_out_321091.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_321091", "321091031", "story_v_out_321091.awb")
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
	Play321091032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 321091032
		arg_131_1.duration_ = 6.73

		local var_131_0 = {
			zh = 3.8,
			ja = 6.733
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
				arg_131_0:Play321091033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if arg_131_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_134_0 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_131_1.stage_.transform)

				var_134_0.name = "10102ui_story"
				var_134_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_131_1.actors_["10102ui_story"] = var_134_0

				local var_134_1 = var_134_0:GetComponentInChildren(typeof(CharacterEffect))

				var_134_1.enabled = true

				local var_134_2 = GameObjectTools.GetOrAddComponent(var_134_0, typeof(DynamicBoneHelper))

				if var_134_2 then
					var_134_2:EnableDynamicBone(false)
				end

				arg_131_1:ShowWeapon(var_134_1.transform, false)

				arg_131_1.var_["10102ui_story" .. "Animator"] = var_134_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_131_1.var_["10102ui_story" .. "Animator"].applyRootMotion = true
				arg_131_1.var_["10102ui_story" .. "LipSync"] = var_134_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_134_3 = arg_131_1.actors_["10102ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_3) and arg_131_1.var_.characterEffect10102ui_story == nil then
				arg_131_1.var_.characterEffect10102ui_story = var_134_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_4 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 and not isNil(var_134_3) then
				if arg_131_1.var_.characterEffect10102ui_story and not isNil(var_134_3) then
					arg_131_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 and not isNil(var_134_3) and arg_131_1.var_.characterEffect10102ui_story then
				arg_131_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_134_6 = 0
			local var_134_7 = 0.575

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_8 = arg_131_1:GetWordFromCfg(321091032)
				local var_134_9 = arg_131_1:FormatText(var_134_8.content)

				arg_131_1.text_.text = var_134_9

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_11 = 23 <= 0 and var_134_7 or var_134_7 * (utf8.len(var_134_9) / 23)

				if (23 <= 0 and var_134_7 or var_134_7 * (utf8.len(var_134_9) / 23)) > 0 and var_134_7 < var_134_11 then
					arg_131_1.talkMaxDuration = var_134_11

					if var_134_11 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_11 + var_134_6
					end
				end

				arg_131_1.text_.text = var_134_9
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091032", "story_v_out_321091.awb") ~= 0 then
					local var_134_12 = manager.audio:GetVoiceLength("story_v_out_321091", "321091032", "story_v_out_321091.awb") / 1000

					if var_134_12 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_12 + var_134_6
					end

					if var_134_8.prefab_name ~= "" and arg_131_1.actors_[var_134_8.prefab_name] ~= nil then
						local var_134_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_8.prefab_name].transform, "story_v_out_321091", "321091032", "story_v_out_321091.awb")

						arg_131_1:RecordAudio("321091032", var_134_13)
						arg_131_1:RecordAudio("321091032", var_134_13)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_321091", "321091032", "story_v_out_321091.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_321091", "321091032", "story_v_out_321091.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_14 = math.max(var_134_7, arg_131_1.talkMaxDuration)

			if var_134_6 <= arg_131_1.time_ and arg_131_1.time_ < var_134_6 + var_134_14 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_6) / var_134_14

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_6 + var_134_14 and arg_131_1.time_ < var_134_6 + var_134_14 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play321091033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 321091033
		arg_135_1.duration_ = 15.43

		local var_135_0 = {
			zh = 5.7,
			ja = 15.433
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play321091034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["10102ui_story"]) and arg_135_1.var_.characterEffect10102ui_story == nil then
				arg_135_1.var_.characterEffect10102ui_story = arg_135_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["10102ui_story"]) then
				if arg_135_1.var_.characterEffect10102ui_story and not isNil(arg_135_1.actors_["10102ui_story"]) then
					arg_135_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_135_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_0)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["10102ui_story"]) and arg_135_1.var_.characterEffect10102ui_story then
				arg_135_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_135_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_138_1 = 0
			local var_138_2 = 0.4

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_3 = arg_135_1:GetWordFromCfg(321091033)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_6 = 16 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_4) / 16)

				if (16 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_4) / 16)) > 0 and var_138_2 < var_138_6 then
					arg_135_1.talkMaxDuration = var_138_6

					if var_138_6 + var_138_1 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_6 + var_138_1
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091033", "story_v_out_321091.awb") ~= 0 then
					local var_138_7 = manager.audio:GetVoiceLength("story_v_out_321091", "321091033", "story_v_out_321091.awb") / 1000

					if var_138_7 + var_138_1 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_1
					end

					if var_138_3.prefab_name ~= "" and arg_135_1.actors_[var_138_3.prefab_name] ~= nil then
						local var_138_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_3.prefab_name].transform, "story_v_out_321091", "321091033", "story_v_out_321091.awb")

						arg_135_1:RecordAudio("321091033", var_138_8)
						arg_135_1:RecordAudio("321091033", var_138_8)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_321091", "321091033", "story_v_out_321091.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_321091", "321091033", "story_v_out_321091.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_9 = math.max(var_138_2, arg_135_1.talkMaxDuration)

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_9 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_1) / var_138_9

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_1 + var_138_9 and arg_135_1.time_ < var_138_1 + var_138_9 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play321091034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 321091034
		arg_139_1.duration_ = 16.07

		local var_139_0 = {
			zh = 7.1,
			ja = 16.066
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play321091035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 1.4 < arg_139_1.time_ and arg_139_1.time_ <= 1.4 + arg_142_0 then
				local var_142_0 = arg_139_1.var_.effect777

				if not arg_139_1.var_.effect777 then
					var_142_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_142_0.name = "777"
					arg_139_1.var_.effect777 = var_142_0
				else
					var_142_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_142_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_142_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_142_2 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_142_3 = var_142_0.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_142_0, iter_142_1 in ipairs((var_142_3:ToTable())) do
					iter_142_1.transform.localScale = Vector3.New(iter_142_1.transform.localScale.x / var_142_2 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_142_3 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_142_1.transform.localScale.y / var_142_2, iter_142_1.transform.localScale.z)
				end
			end

			if 2.08333333333333 < arg_139_1.time_ and arg_139_1.time_ <= 2.08333333333333 + arg_142_0 then
				if arg_139_1.var_.effect777 then
					Object.Destroy(arg_139_1.var_.effect777)

					arg_139_1.var_.effect777 = nil
				end
			end

			local var_142_6 = 0

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.allBtn_.enabled = false
			end

			if arg_139_1.time_ >= var_142_6 + 1.88333333333333 and arg_139_1.time_ < var_142_6 + 1.88333333333333 + arg_142_0 then
				arg_139_1.allBtn_.enabled = true
			end

			if 1.3 < arg_139_1.time_ and arg_139_1.time_ <= 1.3 + arg_142_0 then
				arg_139_1:AudioAction("play", "effect", "se_story_140", "se_story_140_tear", "")
			end

			local var_142_8 = 0
			local var_142_9 = 0.5

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_10 = arg_139_1:GetWordFromCfg(321091034)
				local var_142_11 = arg_139_1:FormatText(var_142_10.content)

				arg_139_1.text_.text = var_142_11

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_13 = 20 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 20)

				if (20 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 20)) > 0 and var_142_9 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_8
					end
				end

				arg_139_1.text_.text = var_142_11
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091034", "story_v_out_321091.awb") ~= 0 then
					local var_142_14 = manager.audio:GetVoiceLength("story_v_out_321091", "321091034", "story_v_out_321091.awb") / 1000

					if var_142_14 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_8
					end

					if var_142_10.prefab_name ~= "" and arg_139_1.actors_[var_142_10.prefab_name] ~= nil then
						local var_142_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_10.prefab_name].transform, "story_v_out_321091", "321091034", "story_v_out_321091.awb")

						arg_139_1:RecordAudio("321091034", var_142_15)
						arg_139_1:RecordAudio("321091034", var_142_15)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_321091", "321091034", "story_v_out_321091.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_321091", "321091034", "story_v_out_321091.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_16 = math.max(var_142_9, arg_139_1.talkMaxDuration)

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_16 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_8) / var_142_16

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_8 + var_142_16 and arg_139_1.time_ < var_142_8 + var_142_16 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play321091035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 321091035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play321091036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 1.375

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_1 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(321091035).content)

				arg_143_1.text_.text = var_146_1

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_3 = 55 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 55)

				if (55 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 55)) > 0 and var_146_0 < var_146_3 then
					arg_143_1.talkMaxDuration = var_146_3

					if var_146_3 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_3 + 0
					end
				end

				arg_143_1.text_.text = var_146_1
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_4 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_4 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_4

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_4 and arg_143_1.time_ < 0 + var_146_4 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play321091036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 321091036
		arg_147_1.duration_ = 5.57

		local var_147_0 = {
			zh = 3.566,
			ja = 5.566
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
				arg_147_0:Play321091037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["10104ui_story"]) and arg_147_1.var_.characterEffect10104ui_story == nil then
				arg_147_1.var_.characterEffect10104ui_story = arg_147_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["10104ui_story"]) then
				if arg_147_1.var_.characterEffect10104ui_story and not isNil(arg_147_1.actors_["10104ui_story"]) then
					arg_147_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["10104ui_story"]) and arg_147_1.var_.characterEffect10104ui_story then
				arg_147_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_150_2 = 0
			local var_150_3 = 0.425

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_2 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_4 = arg_147_1:GetWordFromCfg(321091036)
				local var_150_5 = arg_147_1:FormatText(var_150_4.content)

				arg_147_1.text_.text = var_150_5

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_7 = 17 <= 0 and var_150_3 or var_150_3 * (utf8.len(var_150_5) / 17)

				if (17 <= 0 and var_150_3 or var_150_3 * (utf8.len(var_150_5) / 17)) > 0 and var_150_3 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_2 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_2
					end
				end

				arg_147_1.text_.text = var_150_5
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091036", "story_v_out_321091.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091036", "story_v_out_321091.awb") / 1000

					if var_150_8 + var_150_2 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_2
					end

					if var_150_4.prefab_name ~= "" and arg_147_1.actors_[var_150_4.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_4.prefab_name].transform, "story_v_out_321091", "321091036", "story_v_out_321091.awb")

						arg_147_1:RecordAudio("321091036", var_150_9)
						arg_147_1:RecordAudio("321091036", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_321091", "321091036", "story_v_out_321091.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_321091", "321091036", "story_v_out_321091.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_10 = math.max(var_150_3, arg_147_1.talkMaxDuration)

			if var_150_2 <= arg_147_1.time_ and arg_147_1.time_ < var_150_2 + var_150_10 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_2) / var_150_10

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_2 + var_150_10 and arg_147_1.time_ < var_150_2 + var_150_10 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play321091037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 321091037
		arg_151_1.duration_ = 6.26

		local var_151_0 = {
			zh = 5.724999999999,
			ja = 6.257999999999
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play321091038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if arg_151_1.bgs_.ST0507 == nil then
				local var_154_0 = Object.Instantiate(arg_151_1.paintGo_)

				var_154_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0507")
				var_154_0.name = "ST0507"
				var_154_0.transform.parent = arg_151_1.stage_.transform
				var_154_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_151_1.bgs_.ST0507 = var_154_0
			end

			if 1.43333333333333 < arg_151_1.time_ and arg_151_1.time_ <= 1.43333333333333 + arg_154_0 then
				local var_154_1 = arg_151_1.bgs_.ST0507

				arg_151_1.bgs_.ST0507.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_154_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_154_2 = var_154_1:GetComponent("SpriteRenderer")

				if var_154_2 and var_154_2.sprite then
					local var_154_3 = 2 * (var_154_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_154_1.transform.localScale = Vector3.New(var_154_3 / var_154_2.sprite.bounds.size.y < var_154_3 * manager.ui.mainCameraCom_.aspect / var_154_2.sprite.bounds.size.x and var_154_3 * manager.ui.mainCameraCom_.aspect / var_154_2.sprite.bounds.size.x or var_154_3 / var_154_2.sprite.bounds.size.y, var_154_3 / var_154_2.sprite.bounds.size.y < var_154_3 * manager.ui.mainCameraCom_.aspect / var_154_2.sprite.bounds.size.x and var_154_3 * manager.ui.mainCameraCom_.aspect / var_154_2.sprite.bounds.size.x or var_154_3 / var_154_2.sprite.bounds.size.y, 0)
				end

				for iter_154_0, iter_154_1 in pairs(arg_151_1.bgs_) do
					if iter_154_0 ~= "ST0507" then
						iter_154_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_154_4 = 0

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.allBtn_.enabled = false
			end

			if arg_151_1.time_ >= var_154_4 + 0.3 and arg_151_1.time_ < var_154_4 + 0.3 + arg_154_0 then
				arg_151_1.allBtn_.enabled = true
			end

			local var_154_5 = 0

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1.mask_.enabled = true
				arg_151_1.mask_.raycastTarget = true

				arg_151_1:SetGaussion(false)
			end

			local var_154_6 = 1.43333333333333

			if var_154_5 <= arg_151_1.time_ and arg_151_1.time_ < var_154_5 + var_154_6 then
				local var_154_7 = Color.New(0, 0, 0)

				var_154_7.a = Mathf.Lerp(0, 1, (arg_151_1.time_ - var_154_5) / var_154_6)
				arg_151_1.mask_.color = var_154_7
			end

			if arg_151_1.time_ >= var_154_5 + var_154_6 and arg_151_1.time_ < var_154_5 + var_154_6 + arg_154_0 then
				local var_154_8 = Color.New(0, 0, 0)

				var_154_8.a = 1
				arg_151_1.mask_.color = var_154_8
			end

			local var_154_9 = 1.43333333333333

			if 1.43333333333333 < arg_151_1.time_ and arg_151_1.time_ <= var_154_9 + arg_154_0 then
				arg_151_1.mask_.enabled = true
				arg_151_1.mask_.raycastTarget = true

				arg_151_1:SetGaussion(false)
			end

			local var_154_10 = 2

			if var_154_9 <= arg_151_1.time_ and arg_151_1.time_ < var_154_9 + var_154_10 then
				local var_154_11 = Color.New(0, 0, 0)

				var_154_11.a = Mathf.Lerp(1, 0, (arg_151_1.time_ - var_154_9) / var_154_10)
				arg_151_1.mask_.color = var_154_11
			end

			if arg_151_1.time_ >= var_154_9 + var_154_10 and arg_151_1.time_ < var_154_9 + var_154_10 + arg_154_0 then
				local var_154_12 = Color.New(0, 0, 0)

				arg_151_1.mask_.enabled = false
				var_154_12.a = 0
				arg_151_1.mask_.color = var_154_12
			end

			local var_154_13 = arg_151_1.actors_["10104ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_13) and arg_151_1.var_.characterEffect10104ui_story == nil then
				arg_151_1.var_.characterEffect10104ui_story = var_154_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_14 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_14 and not isNil(var_154_13) then
				if arg_151_1.var_.characterEffect10104ui_story and not isNil(var_154_13) then
					arg_151_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_151_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_14)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_14 and arg_151_1.time_ < 0 + var_154_14 + arg_154_0 and not isNil(var_154_13) and arg_151_1.var_.characterEffect10104ui_story then
				arg_151_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_151_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 1.43333333333333 < arg_151_1.time_ and arg_151_1.time_ <= 1.43333333333333 + arg_154_0 then
				arg_151_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lfe", "")
			end

			if 1.43333333333333 < arg_151_1.time_ and arg_151_1.time_ <= 1.43333333333333 + arg_154_0 then
				arg_151_1:AudioAction("play", "effect", "se_story_140", "se_story_140_music_quake_down", "")
			end

			if arg_151_1.frameCnt_ <= 1 then
				arg_151_1.dialog_:SetActive(false)
			end

			local var_154_17 = 3.924999999999
			local var_154_18 = 0.075

			if 3.924999999999 < arg_151_1.time_ and arg_151_1.time_ <= var_154_17 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0

				arg_151_1.dialog_:SetActive(true)

				arg_151_1.dialogCg_.alpha = 0

				local var_154_19 = LeanTween.value(arg_151_1.dialog_, 0, 1, 0.3)

				var_154_19:setOnUpdate(LuaHelper.FloatAction(function(arg_155_0)
					arg_151_1.dialogCg_.alpha = arg_155_0
				end))
				var_154_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_151_1.dialog_)
					var_154_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_151_1.duration_ = arg_151_1.duration_ + 0.3

				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_20 = arg_151_1:GetWordFromCfg(321091037)
				local var_154_21 = arg_151_1:FormatText(var_154_20.content)

				arg_151_1.text_.text = var_154_21

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_23 = 3 <= 0 and var_154_18 or var_154_18 * (utf8.len(var_154_21) / 3)

				if (3 <= 0 and var_154_18 or var_154_18 * (utf8.len(var_154_21) / 3)) > 0 and var_154_18 < var_154_23 then
					arg_151_1.talkMaxDuration = var_154_23
					var_154_17 = var_154_17 + 0.3

					if var_154_23 + var_154_17 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_23 + var_154_17
					end
				end

				arg_151_1.text_.text = var_154_21
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091037", "story_v_out_321091.awb") ~= 0 then
					local var_154_24 = manager.audio:GetVoiceLength("story_v_out_321091", "321091037", "story_v_out_321091.awb") / 1000

					if var_154_24 + var_154_17 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_24 + var_154_17
					end

					if var_154_20.prefab_name ~= "" and arg_151_1.actors_[var_154_20.prefab_name] ~= nil then
						local var_154_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_20.prefab_name].transform, "story_v_out_321091", "321091037", "story_v_out_321091.awb")

						arg_151_1:RecordAudio("321091037", var_154_25)
						arg_151_1:RecordAudio("321091037", var_154_25)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_321091", "321091037", "story_v_out_321091.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_321091", "321091037", "story_v_out_321091.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_26 = var_154_17 + 0.3
			local var_154_27 = math.max(var_154_18, arg_151_1.talkMaxDuration)

			if var_154_17 + 0.3 <= arg_151_1.time_ and arg_151_1.time_ < var_154_26 + var_154_27 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_26) / var_154_27

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_26 + var_154_27 and arg_151_1.time_ < var_154_26 + var_154_27 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play321091038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 321091038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play321091039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0.05 < arg_157_1.time_ and arg_157_1.time_ <= 0.05 + arg_160_0 then
				arg_157_1:AudioAction("play", "effect", "se_story_140", "se_story_140_hit03", "")
			end

			local var_160_1 = 0
			local var_160_2 = 1.1

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_3 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(321091038).content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 44 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 44)

				if (44 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 44)) > 0 and var_160_2 < var_160_5 then
					arg_157_1.talkMaxDuration = var_160_5

					if var_160_5 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + var_160_1
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_6 = math.max(var_160_2, arg_157_1.talkMaxDuration)

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_6 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_1) / var_160_6

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_1 + var_160_6 and arg_157_1.time_ < var_160_1 + var_160_6 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play321091039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 321091039
		arg_161_1.duration_ = 6.87

		local var_161_0 = {
			zh = 3.833,
			ja = 6.866
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
				arg_161_0:Play321091040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.4

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_1 = arg_161_1:GetWordFromCfg(321091039)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 16 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 16)

				if (16 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 16)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091039", "story_v_out_321091.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_321091", "321091039", "story_v_out_321091.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_321091", "321091039", "story_v_out_321091.awb")

						arg_161_1:RecordAudio("321091039", var_164_6)
						arg_161_1:RecordAudio("321091039", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_321091", "321091039", "story_v_out_321091.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_321091", "321091039", "story_v_out_321091.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play321091040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 321091040
		arg_165_1.duration_ = 11.5

		local var_165_0 = {
			zh = 9.166,
			ja = 11.5
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
				arg_165_0:Play321091041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.85

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_1 = arg_165_1:GetWordFromCfg(321091040)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 34 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 34)

				if (34 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 34)) > 0 and var_168_0 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + 0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091040", "story_v_out_321091.awb") ~= 0 then
					local var_168_5 = manager.audio:GetVoiceLength("story_v_out_321091", "321091040", "story_v_out_321091.awb") / 1000

					if var_168_5 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + 0
					end

					if var_168_1.prefab_name ~= "" and arg_165_1.actors_[var_168_1.prefab_name] ~= nil then
						local var_168_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_1.prefab_name].transform, "story_v_out_321091", "321091040", "story_v_out_321091.awb")

						arg_165_1:RecordAudio("321091040", var_168_6)
						arg_165_1:RecordAudio("321091040", var_168_6)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_321091", "321091040", "story_v_out_321091.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_321091", "321091040", "story_v_out_321091.awb")
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
	Play321091041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 321091041
		arg_169_1.duration_ = 8.1

		local var_169_0 = {
			zh = 6.033,
			ja = 8.1
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
				arg_169_0:Play321091042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.7

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[224].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_1 = arg_169_1:GetWordFromCfg(321091041)
				local var_172_2 = arg_169_1:FormatText(var_172_1.content)

				arg_169_1.text_.text = var_172_2

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 28 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 28)

				if (28 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 28)) > 0 and var_172_0 < var_172_4 then
					arg_169_1.talkMaxDuration = var_172_4

					if var_172_4 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_4 + 0
					end
				end

				arg_169_1.text_.text = var_172_2
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091041", "story_v_out_321091.awb") ~= 0 then
					local var_172_5 = manager.audio:GetVoiceLength("story_v_out_321091", "321091041", "story_v_out_321091.awb") / 1000

					if var_172_5 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + 0
					end

					if var_172_1.prefab_name ~= "" and arg_169_1.actors_[var_172_1.prefab_name] ~= nil then
						local var_172_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_1.prefab_name].transform, "story_v_out_321091", "321091041", "story_v_out_321091.awb")

						arg_169_1:RecordAudio("321091041", var_172_6)
						arg_169_1:RecordAudio("321091041", var_172_6)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_321091", "321091041", "story_v_out_321091.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_321091", "321091041", "story_v_out_321091.awb")
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
	Play321091042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 321091042
		arg_173_1.duration_ = 5.83

		local var_173_0 = {
			zh = 3.433,
			ja = 5.833
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
				arg_173_0:Play321091043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.25

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_1 = arg_173_1:GetWordFromCfg(321091042)
				local var_176_2 = arg_173_1:FormatText(var_176_1.content)

				arg_173_1.text_.text = var_176_2

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 10 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 10)

				if (10 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 10)) > 0 and var_176_0 < var_176_4 then
					arg_173_1.talkMaxDuration = var_176_4

					if var_176_4 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_4 + 0
					end
				end

				arg_173_1.text_.text = var_176_2
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091042", "story_v_out_321091.awb") ~= 0 then
					local var_176_5 = manager.audio:GetVoiceLength("story_v_out_321091", "321091042", "story_v_out_321091.awb") / 1000

					if var_176_5 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + 0
					end

					if var_176_1.prefab_name ~= "" and arg_173_1.actors_[var_176_1.prefab_name] ~= nil then
						local var_176_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_1.prefab_name].transform, "story_v_out_321091", "321091042", "story_v_out_321091.awb")

						arg_173_1:RecordAudio("321091042", var_176_6)
						arg_173_1:RecordAudio("321091042", var_176_6)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_321091", "321091042", "story_v_out_321091.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_321091", "321091042", "story_v_out_321091.awb")
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
	Play321091043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 321091043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play321091044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0.9 < arg_177_1.time_ and arg_177_1.time_ <= 0.9 + arg_180_0 then
				arg_177_1:AudioAction("play", "effect", "se_story_128", "se_story_128_fall", "")
			end

			local var_180_1 = 0
			local var_180_2 = 0.9

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_3 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(321091043).content)

				arg_177_1.text_.text = var_180_3

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 36 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 36)

				if (36 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 36)) > 0 and var_180_2 < var_180_5 then
					arg_177_1.talkMaxDuration = var_180_5

					if var_180_5 + var_180_1 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + var_180_1
					end
				end

				arg_177_1.text_.text = var_180_3
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_6 = math.max(var_180_2, arg_177_1.talkMaxDuration)

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_6 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_1) / var_180_6

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_1 + var_180_6 and arg_177_1.time_ < var_180_1 + var_180_6 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play321091044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 321091044
		arg_181_1.duration_ = 8.9

		local var_181_0 = {
			zh = 6.233,
			ja = 8.9
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
				arg_181_0:Play321091045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.5

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_1 = arg_181_1:GetWordFromCfg(321091044)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.text_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 20 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 20)

				if (20 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 20)) > 0 and var_184_0 < var_184_4 then
					arg_181_1.talkMaxDuration = var_184_4

					if var_184_4 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_4 + 0
					end
				end

				arg_181_1.text_.text = var_184_2
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091044", "story_v_out_321091.awb") ~= 0 then
					local var_184_5 = manager.audio:GetVoiceLength("story_v_out_321091", "321091044", "story_v_out_321091.awb") / 1000

					if var_184_5 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + 0
					end

					if var_184_1.prefab_name ~= "" and arg_181_1.actors_[var_184_1.prefab_name] ~= nil then
						local var_184_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_1.prefab_name].transform, "story_v_out_321091", "321091044", "story_v_out_321091.awb")

						arg_181_1:RecordAudio("321091044", var_184_6)
						arg_181_1:RecordAudio("321091044", var_184_6)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_321091", "321091044", "story_v_out_321091.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_321091", "321091044", "story_v_out_321091.awb")
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
	Play321091045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 321091045
		arg_185_1.duration_ = 11.7

		local var_185_0 = {
			zh = 11.4,
			ja = 11.7
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
				arg_185_0:Play321091046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 1.025

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_1 = arg_185_1:GetWordFromCfg(321091045)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 41 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 41)

				if (41 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 41)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091045", "story_v_out_321091.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_out_321091", "321091045", "story_v_out_321091.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_out_321091", "321091045", "story_v_out_321091.awb")

						arg_185_1:RecordAudio("321091045", var_188_6)
						arg_185_1:RecordAudio("321091045", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_321091", "321091045", "story_v_out_321091.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_321091", "321091045", "story_v_out_321091.awb")
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
	Play321091046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 321091046
		arg_189_1.duration_ = 5.43

		local var_189_0 = {
			zh = 3.466,
			ja = 5.433
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
				arg_189_0:Play321091047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.3

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_1 = arg_189_1:GetWordFromCfg(321091046)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 12 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 12)

				if (12 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 12)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091046", "story_v_out_321091.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_out_321091", "321091046", "story_v_out_321091.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_out_321091", "321091046", "story_v_out_321091.awb")

						arg_189_1:RecordAudio("321091046", var_192_6)
						arg_189_1:RecordAudio("321091046", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_321091", "321091046", "story_v_out_321091.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_321091", "321091046", "story_v_out_321091.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_7 and arg_189_1.time_ < 0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play321091047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 321091047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play321091048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 1.025

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_1 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(321091047).content)

				arg_193_1.text_.text = var_196_1

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_3 = 41 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 41)

				if (41 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 41)) > 0 and var_196_0 < var_196_3 then
					arg_193_1.talkMaxDuration = var_196_3

					if var_196_3 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_3 + 0
					end
				end

				arg_193_1.text_.text = var_196_1
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_4 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_4

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play321091048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 321091048
		arg_197_1.duration_ = 15.47

		local var_197_0 = {
			zh = 6.933,
			ja = 15.466
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play321091049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.725

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_1 = arg_197_1:GetWordFromCfg(321091048)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 29 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 29)

				if (29 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 29)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091048", "story_v_out_321091.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_out_321091", "321091048", "story_v_out_321091.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_out_321091", "321091048", "story_v_out_321091.awb")

						arg_197_1:RecordAudio("321091048", var_200_6)
						arg_197_1:RecordAudio("321091048", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_321091", "321091048", "story_v_out_321091.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_321091", "321091048", "story_v_out_321091.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_7 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_7 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_7

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_7 and arg_197_1.time_ < 0 + var_200_7 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play321091049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 321091049
		arg_201_1.duration_ = 17.37

		local var_201_0 = {
			zh = 9.633,
			ja = 17.366
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play321091050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 1.075

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_1 = arg_201_1:GetWordFromCfg(321091049)
				local var_204_2 = arg_201_1:FormatText(var_204_1.content)

				arg_201_1.text_.text = var_204_2

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 43 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 43)

				if (43 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 43)) > 0 and var_204_0 < var_204_4 then
					arg_201_1.talkMaxDuration = var_204_4

					if var_204_4 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_4 + 0
					end
				end

				arg_201_1.text_.text = var_204_2
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091049", "story_v_out_321091.awb") ~= 0 then
					local var_204_5 = manager.audio:GetVoiceLength("story_v_out_321091", "321091049", "story_v_out_321091.awb") / 1000

					if var_204_5 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + 0
					end

					if var_204_1.prefab_name ~= "" and arg_201_1.actors_[var_204_1.prefab_name] ~= nil then
						local var_204_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_1.prefab_name].transform, "story_v_out_321091", "321091049", "story_v_out_321091.awb")

						arg_201_1:RecordAudio("321091049", var_204_6)
						arg_201_1:RecordAudio("321091049", var_204_6)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_321091", "321091049", "story_v_out_321091.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_321091", "321091049", "story_v_out_321091.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_7 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_7 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_7

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_7 and arg_201_1.time_ < 0 + var_204_7 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play321091050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 321091050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play321091051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 1.3

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(321091050).content)

				arg_205_1.text_.text = var_208_1

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_3 = 52 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 52)

				if (52 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 52)) > 0 and var_208_0 < var_208_3 then
					arg_205_1.talkMaxDuration = var_208_3

					if var_208_3 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_3 + 0
					end
				end

				arg_205_1.text_.text = var_208_1
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_4 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_4

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play321091051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 321091051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play321091052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 1.325

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_1 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(321091051).content)

				arg_209_1.text_.text = var_212_1

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_3 = 53 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 53)

				if (53 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 53)) > 0 and var_212_0 < var_212_3 then
					arg_209_1.talkMaxDuration = var_212_3

					if var_212_3 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_3 + 0
					end
				end

				arg_209_1.text_.text = var_212_1
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_4 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_4

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play321091052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 321091052
		arg_213_1.duration_ = 9.2

		local var_213_0 = {
			zh = 6.4,
			ja = 9.2
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
				arg_213_0:Play321091053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.575

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_1 = arg_213_1:GetWordFromCfg(321091052)
				local var_216_2 = arg_213_1:FormatText(var_216_1.content)

				arg_213_1.text_.text = var_216_2

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 23 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 23)

				if (23 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 23)) > 0 and var_216_0 < var_216_4 then
					arg_213_1.talkMaxDuration = var_216_4

					if var_216_4 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_4 + 0
					end
				end

				arg_213_1.text_.text = var_216_2
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091052", "story_v_out_321091.awb") ~= 0 then
					local var_216_5 = manager.audio:GetVoiceLength("story_v_out_321091", "321091052", "story_v_out_321091.awb") / 1000

					if var_216_5 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + 0
					end

					if var_216_1.prefab_name ~= "" and arg_213_1.actors_[var_216_1.prefab_name] ~= nil then
						local var_216_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_1.prefab_name].transform, "story_v_out_321091", "321091052", "story_v_out_321091.awb")

						arg_213_1:RecordAudio("321091052", var_216_6)
						arg_213_1:RecordAudio("321091052", var_216_6)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_321091", "321091052", "story_v_out_321091.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_321091", "321091052", "story_v_out_321091.awb")
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
	Play321091053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 321091053
		arg_217_1.duration_ = 17.83

		local var_217_0 = {
			zh = 12.6,
			ja = 17.833
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
				arg_217_0:Play321091054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 1.25

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_1 = arg_217_1:GetWordFromCfg(321091053)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.text_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 50 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 50)

				if (50 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 50)) > 0 and var_220_0 < var_220_4 then
					arg_217_1.talkMaxDuration = var_220_4

					if var_220_4 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_4 + 0
					end
				end

				arg_217_1.text_.text = var_220_2
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091053", "story_v_out_321091.awb") ~= 0 then
					local var_220_5 = manager.audio:GetVoiceLength("story_v_out_321091", "321091053", "story_v_out_321091.awb") / 1000

					if var_220_5 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + 0
					end

					if var_220_1.prefab_name ~= "" and arg_217_1.actors_[var_220_1.prefab_name] ~= nil then
						local var_220_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_1.prefab_name].transform, "story_v_out_321091", "321091053", "story_v_out_321091.awb")

						arg_217_1:RecordAudio("321091053", var_220_6)
						arg_217_1:RecordAudio("321091053", var_220_6)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_321091", "321091053", "story_v_out_321091.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_321091", "321091053", "story_v_out_321091.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_7 and arg_217_1.time_ < 0 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play321091054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 321091054
		arg_221_1.duration_ = 23.6

		local var_221_0 = {
			zh = 10.066,
			ja = 23.6
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play321091055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 1

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_1 = arg_221_1:GetWordFromCfg(321091054)
				local var_224_2 = arg_221_1:FormatText(var_224_1.content)

				arg_221_1.text_.text = var_224_2

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 40 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 40)

				if (40 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 40)) > 0 and var_224_0 < var_224_4 then
					arg_221_1.talkMaxDuration = var_224_4

					if var_224_4 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_4 + 0
					end
				end

				arg_221_1.text_.text = var_224_2
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091054", "story_v_out_321091.awb") ~= 0 then
					local var_224_5 = manager.audio:GetVoiceLength("story_v_out_321091", "321091054", "story_v_out_321091.awb") / 1000

					if var_224_5 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + 0
					end

					if var_224_1.prefab_name ~= "" and arg_221_1.actors_[var_224_1.prefab_name] ~= nil then
						local var_224_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_1.prefab_name].transform, "story_v_out_321091", "321091054", "story_v_out_321091.awb")

						arg_221_1:RecordAudio("321091054", var_224_6)
						arg_221_1:RecordAudio("321091054", var_224_6)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_321091", "321091054", "story_v_out_321091.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_321091", "321091054", "story_v_out_321091.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_7 and arg_221_1.time_ < 0 + var_224_7 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play321091055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 321091055
		arg_225_1.duration_ = 11.53

		local var_225_0 = {
			zh = 7.866,
			ja = 11.533
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play321091056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.75

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_1 = arg_225_1:GetWordFromCfg(321091055)
				local var_228_2 = arg_225_1:FormatText(var_228_1.content)

				arg_225_1.text_.text = var_228_2

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 30 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 30)

				if (30 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 30)) > 0 and var_228_0 < var_228_4 then
					arg_225_1.talkMaxDuration = var_228_4

					if var_228_4 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_4 + 0
					end
				end

				arg_225_1.text_.text = var_228_2
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091055", "story_v_out_321091.awb") ~= 0 then
					local var_228_5 = manager.audio:GetVoiceLength("story_v_out_321091", "321091055", "story_v_out_321091.awb") / 1000

					if var_228_5 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + 0
					end

					if var_228_1.prefab_name ~= "" and arg_225_1.actors_[var_228_1.prefab_name] ~= nil then
						local var_228_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_1.prefab_name].transform, "story_v_out_321091", "321091055", "story_v_out_321091.awb")

						arg_225_1:RecordAudio("321091055", var_228_6)
						arg_225_1:RecordAudio("321091055", var_228_6)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_321091", "321091055", "story_v_out_321091.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_321091", "321091055", "story_v_out_321091.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_7 and arg_225_1.time_ < 0 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play321091056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 321091056
		arg_229_1.duration_ = 12.1

		local var_229_0 = {
			zh = 5.033,
			ja = 12.1
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play321091057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.375

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_1 = arg_229_1:GetWordFromCfg(321091056)
				local var_232_2 = arg_229_1:FormatText(var_232_1.content)

				arg_229_1.text_.text = var_232_2

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 15 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 15)

				if (15 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 15)) > 0 and var_232_0 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end

				arg_229_1.text_.text = var_232_2
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091056", "story_v_out_321091.awb") ~= 0 then
					local var_232_5 = manager.audio:GetVoiceLength("story_v_out_321091", "321091056", "story_v_out_321091.awb") / 1000

					if var_232_5 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + 0
					end

					if var_232_1.prefab_name ~= "" and arg_229_1.actors_[var_232_1.prefab_name] ~= nil then
						local var_232_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_1.prefab_name].transform, "story_v_out_321091", "321091056", "story_v_out_321091.awb")

						arg_229_1:RecordAudio("321091056", var_232_6)
						arg_229_1:RecordAudio("321091056", var_232_6)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_321091", "321091056", "story_v_out_321091.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_321091", "321091056", "story_v_out_321091.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_7 and arg_229_1.time_ < 0 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play321091057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 321091057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play321091058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0.7 < arg_233_1.time_ and arg_233_1.time_ <= 0.7 + arg_236_0 then
				arg_233_1:AudioAction("play", "effect", "se_story_11", "se_story_11_microphone", "")
			end

			local var_236_1 = 0
			local var_236_2 = 1.1

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_3 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(321091057).content)

				arg_233_1.text_.text = var_236_3

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 44 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 44)

				if (44 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 44)) > 0 and var_236_2 < var_236_5 then
					arg_233_1.talkMaxDuration = var_236_5

					if var_236_5 + var_236_1 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_5 + var_236_1
					end
				end

				arg_233_1.text_.text = var_236_3
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_6 = math.max(var_236_2, arg_233_1.talkMaxDuration)

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_6 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_1) / var_236_6

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_1 + var_236_6 and arg_233_1.time_ < var_236_1 + var_236_6 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play321091058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 321091058
		arg_237_1.duration_ = 3.4

		local var_237_0 = {
			zh = 2.2,
			ja = 3.4
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
				arg_237_0:Play321091059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if arg_237_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_240_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_237_1.stage_.transform)

				var_240_0.name = "1011ui_story"
				var_240_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_237_1.actors_["1011ui_story"] = var_240_0

				local var_240_1 = var_240_0:GetComponentInChildren(typeof(CharacterEffect))

				var_240_1.enabled = true

				local var_240_2 = GameObjectTools.GetOrAddComponent(var_240_0, typeof(DynamicBoneHelper))

				if var_240_2 then
					var_240_2:EnableDynamicBone(false)
				end

				arg_237_1:ShowWeapon(var_240_1.transform, false)

				arg_237_1.var_["1011ui_story" .. "Animator"] = var_240_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_237_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_237_1.var_["1011ui_story" .. "LipSync"] = var_240_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_240_3 = arg_237_1.actors_["1011ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_3) and arg_237_1.var_.characterEffect1011ui_story == nil then
				arg_237_1.var_.characterEffect1011ui_story = var_240_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_4 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_4 and not isNil(var_240_3) then
				if arg_237_1.var_.characterEffect1011ui_story and not isNil(var_240_3) then
					arg_237_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_4 and arg_237_1.time_ < 0 + var_240_4 + arg_240_0 and not isNil(var_240_3) and arg_237_1.var_.characterEffect1011ui_story then
				arg_237_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_240_6 = arg_237_1.actors_["1011ui_story"].transform

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1011ui_story = var_240_6.localPosition
			end

			local var_240_7 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_7 then
				var_240_6.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_237_1.time_ - 0) / var_240_7)
				var_240_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_6.position).x, (manager.ui.mainCamera.transform.position - var_240_6.position).y, (manager.ui.mainCamera.transform.position - var_240_6.position).z)
				var_240_6.localEulerAngles.z = 0
				var_240_6.localEulerAngles.x = 0
				var_240_6.localEulerAngles = var_240_6.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_7 and arg_237_1.time_ < 0 + var_240_7 + arg_240_0 then
				var_240_6.localPosition = Vector3.New(0, -0.71, -6)
				var_240_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_6.position).x, (manager.ui.mainCamera.transform.position - var_240_6.position).y, (manager.ui.mainCamera.transform.position - var_240_6.position).z)
				var_240_6.localEulerAngles.z = 0
				var_240_6.localEulerAngles.x = 0
				var_240_6.localEulerAngles = var_240_6.localEulerAngles
			end

			local var_240_8 = 0
			local var_240_9 = 0.275

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_10 = arg_237_1:GetWordFromCfg(321091058)
				local var_240_11 = arg_237_1:FormatText(var_240_10.content)

				arg_237_1.text_.text = var_240_11

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_13 = 11 <= 0 and var_240_9 or var_240_9 * (utf8.len(var_240_11) / 11)

				if (11 <= 0 and var_240_9 or var_240_9 * (utf8.len(var_240_11) / 11)) > 0 and var_240_9 < var_240_13 then
					arg_237_1.talkMaxDuration = var_240_13

					if var_240_13 + var_240_8 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_13 + var_240_8
					end
				end

				arg_237_1.text_.text = var_240_11
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091058", "story_v_out_321091.awb") ~= 0 then
					local var_240_14 = manager.audio:GetVoiceLength("story_v_out_321091", "321091058", "story_v_out_321091.awb") / 1000

					if var_240_14 + var_240_8 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_14 + var_240_8
					end

					if var_240_10.prefab_name ~= "" and arg_237_1.actors_[var_240_10.prefab_name] ~= nil then
						local var_240_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_10.prefab_name].transform, "story_v_out_321091", "321091058", "story_v_out_321091.awb")

						arg_237_1:RecordAudio("321091058", var_240_15)
						arg_237_1:RecordAudio("321091058", var_240_15)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_321091", "321091058", "story_v_out_321091.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_321091", "321091058", "story_v_out_321091.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_16 = math.max(var_240_9, arg_237_1.talkMaxDuration)

			if var_240_8 <= arg_237_1.time_ and arg_237_1.time_ < var_240_8 + var_240_16 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_8) / var_240_16

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_8 + var_240_16 and arg_237_1.time_ < var_240_8 + var_240_16 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
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

		arg_237_1:InitPlayNodeList()
	end,
	Play321091059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 321091059
		arg_241_1.duration_ = 9.67

		local var_241_0 = {
			zh = 6.533,
			ja = 9.666
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play321091060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if arg_241_1.actors_["1056ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1056ui_story"))) then
				local var_244_0 = Object.Instantiate(Asset.Load("Char/" .. "1056ui_story"), arg_241_1.stage_.transform)

				var_244_0.name = "1056ui_story"
				var_244_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_241_1.actors_["1056ui_story"] = var_244_0

				local var_244_1 = var_244_0:GetComponentInChildren(typeof(CharacterEffect))

				var_244_1.enabled = true

				local var_244_2 = GameObjectTools.GetOrAddComponent(var_244_0, typeof(DynamicBoneHelper))

				if var_244_2 then
					var_244_2:EnableDynamicBone(false)
				end

				arg_241_1:ShowWeapon(var_244_1.transform, false)

				arg_241_1.var_["1056ui_story" .. "Animator"] = var_244_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_241_1.var_["1056ui_story" .. "Animator"].applyRootMotion = true
				arg_241_1.var_["1056ui_story" .. "LipSync"] = var_244_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_244_3 = arg_241_1.actors_["1056ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_3) and arg_241_1.var_.characterEffect1056ui_story == nil then
				arg_241_1.var_.characterEffect1056ui_story = var_244_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_4 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_4 and not isNil(var_244_3) then
				if arg_241_1.var_.characterEffect1056ui_story and not isNil(var_244_3) then
					arg_241_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_4 and arg_241_1.time_ < 0 + var_244_4 + arg_244_0 and not isNil(var_244_3) and arg_241_1.var_.characterEffect1056ui_story then
				arg_241_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_244_6 = arg_241_1.actors_["1011ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_6) and arg_241_1.var_.characterEffect1011ui_story == nil then
				arg_241_1.var_.characterEffect1011ui_story = var_244_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_7 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_7 and not isNil(var_244_6) then
				if arg_241_1.var_.characterEffect1011ui_story and not isNil(var_244_6) then
					arg_241_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_7)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_7 and arg_241_1.time_ < 0 + var_244_7 + arg_244_0 and not isNil(var_244_6) and arg_241_1.var_.characterEffect1011ui_story then
				arg_241_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_244_8 = 0
			local var_244_9 = 0.975

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_8 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1056")

				arg_241_1.callingController_:SetSelectedState("calling")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_10 = arg_241_1:GetWordFromCfg(321091059)
				local var_244_11 = arg_241_1:FormatText(var_244_10.content)

				arg_241_1.text_.text = var_244_11

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_13 = 39 <= 0 and var_244_9 or var_244_9 * (utf8.len(var_244_11) / 39)

				if (39 <= 0 and var_244_9 or var_244_9 * (utf8.len(var_244_11) / 39)) > 0 and var_244_9 < var_244_13 then
					arg_241_1.talkMaxDuration = var_244_13

					if var_244_13 + var_244_8 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_13 + var_244_8
					end
				end

				arg_241_1.text_.text = var_244_11
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091059", "story_v_out_321091.awb") ~= 0 then
					local var_244_14 = manager.audio:GetVoiceLength("story_v_out_321091", "321091059", "story_v_out_321091.awb") / 1000

					if var_244_14 + var_244_8 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_14 + var_244_8
					end

					if var_244_10.prefab_name ~= "" and arg_241_1.actors_[var_244_10.prefab_name] ~= nil then
						local var_244_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_10.prefab_name].transform, "story_v_out_321091", "321091059", "story_v_out_321091.awb")

						arg_241_1:RecordAudio("321091059", var_244_15)
						arg_241_1:RecordAudio("321091059", var_244_15)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_321091", "321091059", "story_v_out_321091.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_321091", "321091059", "story_v_out_321091.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_16 = math.max(var_244_9, arg_241_1.talkMaxDuration)

			if var_244_8 <= arg_241_1.time_ and arg_241_1.time_ < var_244_8 + var_244_16 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_8) / var_244_16

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_8 + var_244_16 and arg_241_1.time_ < var_244_8 + var_244_16 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play321091060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 321091060
		arg_245_1.duration_ = 4.53

		local var_245_0 = {
			zh = 4.166,
			ja = 4.533
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play321091061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.425

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1056")

				arg_245_1.callingController_:SetSelectedState("calling")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_1 = arg_245_1:GetWordFromCfg(321091060)
				local var_248_2 = arg_245_1:FormatText(var_248_1.content)

				arg_245_1.text_.text = var_248_2

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_4 = 17 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 17)

				if (17 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 17)) > 0 and var_248_0 < var_248_4 then
					arg_245_1.talkMaxDuration = var_248_4

					if var_248_4 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_4 + 0
					end
				end

				arg_245_1.text_.text = var_248_2
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091060", "story_v_out_321091.awb") ~= 0 then
					local var_248_5 = manager.audio:GetVoiceLength("story_v_out_321091", "321091060", "story_v_out_321091.awb") / 1000

					if var_248_5 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + 0
					end

					if var_248_1.prefab_name ~= "" and arg_245_1.actors_[var_248_1.prefab_name] ~= nil then
						local var_248_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_1.prefab_name].transform, "story_v_out_321091", "321091060", "story_v_out_321091.awb")

						arg_245_1:RecordAudio("321091060", var_248_6)
						arg_245_1:RecordAudio("321091060", var_248_6)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_321091", "321091060", "story_v_out_321091.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_321091", "321091060", "story_v_out_321091.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_7 and arg_245_1.time_ < 0 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play321091061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 321091061
		arg_249_1.duration_ = 2.77

		local var_249_0 = {
			zh = 2.4,
			ja = 2.766
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play321091062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1011ui_story"]) and arg_249_1.var_.characterEffect1011ui_story == nil then
				arg_249_1.var_.characterEffect1011ui_story = arg_249_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1011ui_story"]) then
				if arg_249_1.var_.characterEffect1011ui_story and not isNil(arg_249_1.actors_["1011ui_story"]) then
					arg_249_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1011ui_story"]) and arg_249_1.var_.characterEffect1011ui_story then
				arg_249_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_252_2 = arg_249_1.actors_["1056ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_2) and arg_249_1.var_.characterEffect1056ui_story == nil then
				arg_249_1.var_.characterEffect1056ui_story = var_252_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_3 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_3 and not isNil(var_252_2) then
				if arg_249_1.var_.characterEffect1056ui_story and not isNil(var_252_2) then
					arg_249_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_3)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_3 and arg_249_1.time_ < 0 + var_252_3 + arg_252_0 and not isNil(var_252_2) and arg_249_1.var_.characterEffect1056ui_story then
				arg_249_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_2")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_249_1.time_ and arg_249_1.time_ <= 0.1 + arg_252_0 then
				arg_249_1:AudioAction("play", "effect", "se_story_140", "se_story_140_sand", "")
			end

			local var_252_5 = 0
			local var_252_6 = 0.25

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_5 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_7 = arg_249_1:GetWordFromCfg(321091061)
				local var_252_8 = arg_249_1:FormatText(var_252_7.content)

				arg_249_1.text_.text = var_252_8

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_10 = 10 <= 0 and var_252_6 or var_252_6 * (utf8.len(var_252_8) / 10)

				if (10 <= 0 and var_252_6 or var_252_6 * (utf8.len(var_252_8) / 10)) > 0 and var_252_6 < var_252_10 then
					arg_249_1.talkMaxDuration = var_252_10

					if var_252_10 + var_252_5 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_5
					end
				end

				arg_249_1.text_.text = var_252_8
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091061", "story_v_out_321091.awb") ~= 0 then
					local var_252_11 = manager.audio:GetVoiceLength("story_v_out_321091", "321091061", "story_v_out_321091.awb") / 1000

					if var_252_11 + var_252_5 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_11 + var_252_5
					end

					if var_252_7.prefab_name ~= "" and arg_249_1.actors_[var_252_7.prefab_name] ~= nil then
						local var_252_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_7.prefab_name].transform, "story_v_out_321091", "321091061", "story_v_out_321091.awb")

						arg_249_1:RecordAudio("321091061", var_252_12)
						arg_249_1:RecordAudio("321091061", var_252_12)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_321091", "321091061", "story_v_out_321091.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_321091", "321091061", "story_v_out_321091.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_13 = math.max(var_252_6, arg_249_1.talkMaxDuration)

			if var_252_5 <= arg_249_1.time_ and arg_249_1.time_ < var_252_5 + var_252_13 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_5) / var_252_13

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_5 + var_252_13 and arg_249_1.time_ < var_252_5 + var_252_13 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play321091062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 321091062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play321091063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["1011ui_story"]) and arg_253_1.var_.characterEffect1011ui_story == nil then
				arg_253_1.var_.characterEffect1011ui_story = arg_253_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["1011ui_story"]) then
				if arg_253_1.var_.characterEffect1011ui_story and not isNil(arg_253_1.actors_["1011ui_story"]) then
					arg_253_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_0)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["1011ui_story"]) and arg_253_1.var_.characterEffect1011ui_story then
				arg_253_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_256_1 = arg_253_1.actors_["1011ui_story"].transform

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1011ui_story = var_256_1.localPosition
			end

			local var_256_2 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 then
				var_256_1.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_253_1.time_ - 0) / var_256_2)
				var_256_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_1.position).x, (manager.ui.mainCamera.transform.position - var_256_1.position).y, (manager.ui.mainCamera.transform.position - var_256_1.position).z)
				var_256_1.localEulerAngles.z = 0
				var_256_1.localEulerAngles.x = 0
				var_256_1.localEulerAngles = var_256_1.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 then
				var_256_1.localPosition = Vector3.New(0, 100, 0)
				var_256_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_1.position).x, (manager.ui.mainCamera.transform.position - var_256_1.position).y, (manager.ui.mainCamera.transform.position - var_256_1.position).z)
				var_256_1.localEulerAngles.z = 0
				var_256_1.localEulerAngles.x = 0
				var_256_1.localEulerAngles = var_256_1.localEulerAngles
			end

			if 0.05 < arg_253_1.time_ and arg_253_1.time_ <= 0.05 + arg_256_0 then
				arg_253_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_ui", "")
			end

			local var_256_4 = 0
			local var_256_5 = 0.8

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_4 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_6 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(321091062).content)

				arg_253_1.text_.text = var_256_6

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_8 = 32 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_6) / 32)

				if (32 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_6) / 32)) > 0 and var_256_5 < var_256_8 then
					arg_253_1.talkMaxDuration = var_256_8

					if var_256_8 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_8 + var_256_4
					end
				end

				arg_253_1.text_.text = var_256_6
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_9 = math.max(var_256_5, arg_253_1.talkMaxDuration)

			if var_256_4 <= arg_253_1.time_ and arg_253_1.time_ < var_256_4 + var_256_9 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_4) / var_256_9

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_4 + var_256_9 and arg_253_1.time_ < var_256_4 + var_256_9 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
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

		arg_253_1:InitPlayNodeList()
	end,
	Play321091063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 321091063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play321091064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 1.5

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_1 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(321091063).content)

				arg_257_1.text_.text = var_260_1

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_3 = 60 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 60)

				if (60 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 60)) > 0 and var_260_0 < var_260_3 then
					arg_257_1.talkMaxDuration = var_260_3

					if var_260_3 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_3 + 0
					end
				end

				arg_257_1.text_.text = var_260_1
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_4 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_4

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play321091064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 321091064
		arg_261_1.duration_ = 6.8

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play321091065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_9000

			if 0.157419800758362 < arg_261_1.time_ and arg_261_1.time_ <= 0.157419800758362 + arg_264_0 then
				arg_261_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_264_0 = 0.642580199241638

			if 0.157419800758362 <= arg_261_1.time_ and arg_261_1.time_ < 0.157419800758362 + var_264_0 then
				local var_264_1, var_264_2 = math.modf((arg_261_1.time_ - 0.157419800758362) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_264_2 * 0.13, var_264_2 * 0.13, var_264_2 * 0.13) + arg_261_1.var_.shakeOldPos
			end

			if arg_261_1.time_ >= 0.157419800758362 + var_264_0 and arg_261_1.time_ < 0.157419800758362 + var_264_0 + arg_264_0 then
				manager.ui.mainCamera.transform.localPosition = arg_261_1.var_.shakeOldPos
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				local var_264_3 = arg_261_1.var_.effect811

				if not arg_261_1.var_.effect811 then
					var_264_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redlight_keep"), manager.ui.mainCamera.transform)
					var_264_3.name = "811"
					arg_261_1.var_.effect811 = var_264_3
				else
					var_264_3.transform:SetParent(var_264_9000)
				end

				var_264_3.transform.localPosition = Vector3.New(0, 0, -2)
				var_264_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_264_3.transform.localScale = Vector3.New(var_264_3.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_264_3.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_264_3.transform.localScale.z)
			end

			local var_264_5 = 0

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_5 + arg_264_0 then
				arg_261_1.allBtn_.enabled = false
			end

			if arg_261_1.time_ >= var_264_5 + 2.13333333333333 and arg_261_1.time_ < var_264_5 + 2.13333333333333 + arg_264_0 then
				arg_261_1.allBtn_.enabled = true
			end

			local var_264_6 = 0

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_6 + arg_264_0 then
				arg_261_1.mask_.enabled = true
				arg_261_1.mask_.raycastTarget = true

				arg_261_1:SetGaussion(false)
			end

			local var_264_7 = 0.433333333333333

			if var_264_6 <= arg_261_1.time_ and arg_261_1.time_ < var_264_6 + var_264_7 then
				local var_264_8 = Color.New(1, 1, 1)

				var_264_8.a = Mathf.Lerp(1, 0, (arg_261_1.time_ - var_264_6) / var_264_7)
				arg_261_1.mask_.color = var_264_8
			end

			if arg_261_1.time_ >= var_264_6 + var_264_7 and arg_261_1.time_ < var_264_6 + var_264_7 + arg_264_0 then
				local var_264_9 = Color.New(1, 1, 1)

				arg_261_1.mask_.enabled = false
				var_264_9.a = 0
				arg_261_1.mask_.color = var_264_9
			end

			if 1 < arg_261_1.time_ and arg_261_1.time_ <= 1 + arg_264_0 then
				arg_261_1:AudioAction("play", "effect", "ui_skip", "ui_reset", "")
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_lfe", "")
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_264_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_261_1.bgmTxt_.text ~= var_264_14 and arg_261_1.bgmTxt_.text ~= "" then
						if arg_261_1.bgmTxt2_.text ~= "" then
							arg_261_1.bgmTxt_.text = arg_261_1.bgmTxt2_.text
						end

						arg_261_1.bgmTxt2_.text = var_264_14

						arg_261_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_261_1.bgmTxt_.text = var_264_14
						arg_261_1.bgmTxt2_.text = var_264_14
					end

					if arg_261_1.bgmTimer then
						arg_261_1.bgmTimer:Stop()

						arg_261_1.bgmTimer = nil
					end

					if arg_261_1.settingData.show_music_name == 1 then
						arg_261_1.musicController:SetSelectedState("show")
						arg_261_1.musicAnimator_:Play("open", 0, 0)

						if arg_261_1.settingData.music_time ~= 0 then
							arg_261_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_261_1.settingData.music_time), function()
								if arg_261_1 == nil or isNil(arg_261_1.bgmTxt_) then
									return
								end

								arg_261_1.musicController:SetSelectedState("hide")
								arg_261_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.1 < arg_261_1.time_ and arg_261_1.time_ <= 0.1 + arg_264_0 then
				arg_261_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			if arg_261_1.frameCnt_ <= 1 then
				arg_261_1.dialog_:SetActive(false)
			end

			local var_264_16 = 1.8
			local var_264_17 = 1.225

			if 1.8 < arg_261_1.time_ and arg_261_1.time_ <= var_264_16 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0

				arg_261_1.dialog_:SetActive(true)

				arg_261_1.dialogCg_.alpha = 0

				local var_264_18 = LeanTween.value(arg_261_1.dialog_, 0, 1, 0.3)

				var_264_18:setOnUpdate(LuaHelper.FloatAction(function(arg_266_0)
					arg_261_1.dialogCg_.alpha = arg_266_0
				end))
				var_264_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_261_1.dialog_)
					var_264_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_261_1.duration_ = arg_261_1.duration_ + 0.3

				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_19 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(321091064).content)

				arg_261_1.text_.text = var_264_19

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_21 = 49 <= 0 and var_264_17 or var_264_17 * (utf8.len(var_264_19) / 49)

				if (49 <= 0 and var_264_17 or var_264_17 * (utf8.len(var_264_19) / 49)) > 0 and var_264_17 < var_264_21 then
					arg_261_1.talkMaxDuration = var_264_21
					var_264_16 = var_264_16 + 0.3

					if var_264_21 + var_264_16 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_21 + var_264_16
					end
				end

				arg_261_1.text_.text = var_264_19
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_22 = var_264_16 + 0.3
			local var_264_23 = math.max(var_264_17, arg_261_1.talkMaxDuration)

			if var_264_16 + 0.3 <= arg_261_1.time_ and arg_261_1.time_ < var_264_22 + var_264_23 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_22) / var_264_23

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_22 + var_264_23 and arg_261_1.time_ < var_264_22 + var_264_23 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play321091065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 321091065
		arg_268_1.duration_ = 6.06

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play321091066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				local var_271_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_271_0 then
					var_271_0.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_271_0.radialBlurScale = 0.854
					var_271_0.radialBlurGradient = 1
					var_271_0.radialBlurIntensity = 1

					if nil then
						var_271_0.radialBlurTarget = (nil).transform
					end
				end
			end

			local var_271_1 = 1.33333333333333

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_1 then
				local var_271_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_271_2 then
					var_271_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_271_2.radialBlurScale = Mathf.Lerp(0.854, 0.97, (arg_268_1.time_ - 0) / var_271_1)
					var_271_2.radialBlurGradient = Mathf.Lerp(1, 1, (arg_268_1.time_ - 0) / var_271_1)
					var_271_2.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_268_1.time_ - 0) / var_271_1)
				end
			end

			if arg_268_1.time_ >= 0 + var_271_1 and arg_268_1.time_ < 0 + var_271_1 + arg_271_0 then
				local var_271_3 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_271_3 then
					var_271_3.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_271_3.radialBlurScale = 0.97
					var_271_3.radialBlurGradient = 1
					var_271_3.radialBlurIntensity = 1
				end
			end

			local var_271_4 = 0

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_4 + arg_271_0 then
				arg_268_1.allBtn_.enabled = false
			end

			if arg_268_1.time_ >= var_271_4 + 1.56666666666667 and arg_268_1.time_ < var_271_4 + 1.56666666666667 + arg_271_0 then
				arg_268_1.allBtn_.enabled = true
			end

			if arg_268_1.frameCnt_ <= 1 then
				arg_268_1.dialog_:SetActive(false)
			end

			local var_271_5 = 1.05833333333333
			local var_271_6 = 1.075

			if 1.05833333333333 < arg_268_1.time_ and arg_268_1.time_ <= var_271_5 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0

				arg_268_1.dialog_:SetActive(true)

				arg_268_1.dialogCg_.alpha = 0

				local var_271_7 = LeanTween.value(arg_268_1.dialog_, 0, 1, 0.3)

				var_271_7:setOnUpdate(LuaHelper.FloatAction(function(arg_272_0)
					arg_268_1.dialogCg_.alpha = arg_272_0
				end))
				var_271_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_268_1.dialog_)
					var_271_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_268_1.duration_ = arg_268_1.duration_ + 0.3

				SetActive(arg_268_1.leftNameGo_, false)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_8 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(321091065).content)

				arg_268_1.text_.text = var_271_8

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_10 = 43 <= 0 and var_271_6 or var_271_6 * (utf8.len(var_271_8) / 43)

				if (43 <= 0 and var_271_6 or var_271_6 * (utf8.len(var_271_8) / 43)) > 0 and var_271_6 < var_271_10 then
					arg_268_1.talkMaxDuration = var_271_10
					var_271_5 = var_271_5 + 0.3

					if var_271_10 + var_271_5 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_10 + var_271_5
					end
				end

				arg_268_1.text_.text = var_271_8
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_11 = var_271_5 + 0.3
			local var_271_12 = math.max(var_271_6, arg_268_1.talkMaxDuration)

			if var_271_5 + 0.3 <= arg_268_1.time_ and arg_268_1.time_ < var_271_11 + var_271_12 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_11) / var_271_12

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_11 + var_271_12 and arg_268_1.time_ < var_271_11 + var_271_12 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play321091066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 321091066
		arg_274_1.duration_ = 2.5

		local var_274_0 = {
			zh = 2.5,
			ja = 1.333
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play321091067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(arg_274_1.actors_["1011ui_story"]) and arg_274_1.var_.characterEffect1011ui_story == nil then
				arg_274_1.var_.characterEffect1011ui_story = arg_274_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_0 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 and not isNil(arg_274_1.actors_["1011ui_story"]) then
				if arg_274_1.var_.characterEffect1011ui_story and not isNil(arg_274_1.actors_["1011ui_story"]) then
					arg_274_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 and not isNil(arg_274_1.actors_["1011ui_story"]) and arg_274_1.var_.characterEffect1011ui_story then
				arg_274_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_277_2 = 0
			local var_277_3 = 0.15

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_2 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_4 = arg_274_1:GetWordFromCfg(321091066)
				local var_277_5 = arg_274_1:FormatText(var_277_4.content)

				arg_274_1.text_.text = var_277_5

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_7 = 6 <= 0 and var_277_3 or var_277_3 * (utf8.len(var_277_5) / 6)

				if (6 <= 0 and var_277_3 or var_277_3 * (utf8.len(var_277_5) / 6)) > 0 and var_277_3 < var_277_7 then
					arg_274_1.talkMaxDuration = var_277_7

					if var_277_7 + var_277_2 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_7 + var_277_2
					end
				end

				arg_274_1.text_.text = var_277_5
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091066", "story_v_out_321091.awb") ~= 0 then
					local var_277_8 = manager.audio:GetVoiceLength("story_v_out_321091", "321091066", "story_v_out_321091.awb") / 1000

					if var_277_8 + var_277_2 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_8 + var_277_2
					end

					if var_277_4.prefab_name ~= "" and arg_274_1.actors_[var_277_4.prefab_name] ~= nil then
						local var_277_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_4.prefab_name].transform, "story_v_out_321091", "321091066", "story_v_out_321091.awb")

						arg_274_1:RecordAudio("321091066", var_277_9)
						arg_274_1:RecordAudio("321091066", var_277_9)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_321091", "321091066", "story_v_out_321091.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_321091", "321091066", "story_v_out_321091.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_10 = math.max(var_277_3, arg_274_1.talkMaxDuration)

			if var_277_2 <= arg_274_1.time_ and arg_274_1.time_ < var_277_2 + var_277_10 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_2) / var_277_10

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_2 + var_277_10 and arg_274_1.time_ < var_277_2 + var_277_10 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play321091067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 321091067
		arg_278_1.duration_ = 8.8

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play321091068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if arg_278_1.bgs_.ST0507a == nil then
				local var_281_0 = Object.Instantiate(arg_278_1.paintGo_)

				var_281_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0507a")
				var_281_0.name = "ST0507a"
				var_281_0.transform.parent = arg_278_1.stage_.transform
				var_281_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_278_1.bgs_.ST0507a = var_281_0
			end

			if 2 < arg_278_1.time_ and arg_278_1.time_ <= 2 + arg_281_0 then
				local var_281_1 = arg_278_1.bgs_.ST0507a

				arg_278_1.bgs_.ST0507a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_281_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_281_2 = var_281_1:GetComponent("SpriteRenderer")

				if var_281_2 and var_281_2.sprite then
					local var_281_3 = 2 * (var_281_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_281_1.transform.localScale = Vector3.New(var_281_3 / var_281_2.sprite.bounds.size.y < var_281_3 * manager.ui.mainCameraCom_.aspect / var_281_2.sprite.bounds.size.x and var_281_3 * manager.ui.mainCameraCom_.aspect / var_281_2.sprite.bounds.size.x or var_281_3 / var_281_2.sprite.bounds.size.y, var_281_3 / var_281_2.sprite.bounds.size.y < var_281_3 * manager.ui.mainCameraCom_.aspect / var_281_2.sprite.bounds.size.x and var_281_3 * manager.ui.mainCameraCom_.aspect / var_281_2.sprite.bounds.size.x or var_281_3 / var_281_2.sprite.bounds.size.y, 0)
				end

				for iter_281_0, iter_281_1 in pairs(arg_278_1.bgs_) do
					if iter_281_0 ~= "ST0507a" then
						iter_281_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_281_4 = 0

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_4 + arg_281_0 then
				arg_278_1.allBtn_.enabled = false
			end

			if arg_278_1.time_ >= var_281_4 + 0.3 and arg_278_1.time_ < var_281_4 + 0.3 + arg_281_0 then
				arg_278_1.allBtn_.enabled = true
			end

			local var_281_5 = 0

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_5 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_6 = 2

			if var_281_5 <= arg_278_1.time_ and arg_278_1.time_ < var_281_5 + var_281_6 then
				local var_281_7 = Color.New(0, 0, 0)

				var_281_7.a = Mathf.Lerp(0, 1, (arg_278_1.time_ - var_281_5) / var_281_6)
				arg_278_1.mask_.color = var_281_7
			end

			if arg_278_1.time_ >= var_281_5 + var_281_6 and arg_278_1.time_ < var_281_5 + var_281_6 + arg_281_0 then
				local var_281_8 = Color.New(0, 0, 0)

				var_281_8.a = 1
				arg_278_1.mask_.color = var_281_8
			end

			local var_281_9 = 2

			if 2 < arg_278_1.time_ and arg_278_1.time_ <= var_281_9 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_10 = 2

			if var_281_9 <= arg_278_1.time_ and arg_278_1.time_ < var_281_9 + var_281_10 then
				local var_281_11 = Color.New(0, 0, 0)

				var_281_11.a = Mathf.Lerp(1, 0, (arg_278_1.time_ - var_281_9) / var_281_10)
				arg_278_1.mask_.color = var_281_11
			end

			if arg_278_1.time_ >= var_281_9 + var_281_10 and arg_278_1.time_ < var_281_9 + var_281_10 + arg_281_0 then
				local var_281_12 = Color.New(0, 0, 0)

				arg_278_1.mask_.enabled = false
				var_281_12.a = 0
				arg_278_1.mask_.color = var_281_12
			end

			local var_281_13 = arg_278_1.actors_["1011ui_story"]

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(var_281_13) and arg_278_1.var_.characterEffect1011ui_story == nil then
				arg_278_1.var_.characterEffect1011ui_story = var_281_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_14 = 0.200000002980232

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_14 and not isNil(var_281_13) then
				if arg_278_1.var_.characterEffect1011ui_story and not isNil(var_281_13) then
					arg_278_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_278_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_278_1.time_ - 0) / var_281_14)
				end
			end

			if arg_278_1.time_ >= 0 + var_281_14 and arg_278_1.time_ < 0 + var_281_14 + arg_281_0 and not isNil(var_281_13) and arg_278_1.var_.characterEffect1011ui_story then
				arg_278_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_278_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 2 < arg_278_1.time_ and arg_278_1.time_ <= 2 + arg_281_0 then
				if arg_278_1.var_.effect811 then
					Object.Destroy(arg_278_1.var_.effect811)

					arg_278_1.var_.effect811 = nil
				end
			end

			if 0.4 < arg_278_1.time_ and arg_278_1.time_ <= 0.4 + arg_281_0 then
				arg_278_1:AudioAction("stop", "effect", "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			if arg_278_1.frameCnt_ <= 1 then
				arg_278_1.dialog_:SetActive(false)
			end

			local var_281_17 = 3.8
			local var_281_18 = 1.025

			if 3.8 < arg_278_1.time_ and arg_278_1.time_ <= var_281_17 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0

				arg_278_1.dialog_:SetActive(true)

				arg_278_1.dialogCg_.alpha = 0

				local var_281_19 = LeanTween.value(arg_278_1.dialog_, 0, 1, 0.3)

				var_281_19:setOnUpdate(LuaHelper.FloatAction(function(arg_282_0)
					arg_278_1.dialogCg_.alpha = arg_282_0
				end))
				var_281_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_278_1.dialog_)
					var_281_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_278_1.duration_ = arg_278_1.duration_ + 0.3

				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_20 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(321091067).content)

				arg_278_1.text_.text = var_281_20

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_22 = 41 <= 0 and var_281_18 or var_281_18 * (utf8.len(var_281_20) / 41)

				if (41 <= 0 and var_281_18 or var_281_18 * (utf8.len(var_281_20) / 41)) > 0 and var_281_18 < var_281_22 then
					arg_278_1.talkMaxDuration = var_281_22
					var_281_17 = var_281_17 + 0.3

					if var_281_22 + var_281_17 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_22 + var_281_17
					end
				end

				arg_278_1.text_.text = var_281_20
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_23 = var_281_17 + 0.3
			local var_281_24 = math.max(var_281_18, arg_278_1.talkMaxDuration)

			if var_281_17 + 0.3 <= arg_278_1.time_ and arg_278_1.time_ < var_281_23 + var_281_24 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_23) / var_281_24

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_23 + var_281_24 and arg_278_1.time_ < var_281_23 + var_281_24 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play321091068 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 321091068
		arg_284_1.duration_ = 5.43

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play321091069(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				local var_287_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_287_0 then
					var_287_0.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_287_0.radialBlurScale = 0
					var_287_0.radialBlurGradient = 1
					var_287_0.radialBlurIntensity = 1

					if nil then
						var_287_0.radialBlurTarget = (nil).transform
					end
				end
			end

			local var_287_1 = 1.33333333333333

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_1 then
				local var_287_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_287_2 then
					var_287_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_287_2.radialBlurScale = Mathf.Lerp(0, 0, (arg_284_1.time_ - 0) / var_287_1)
					var_287_2.radialBlurGradient = Mathf.Lerp(1, 1, (arg_284_1.time_ - 0) / var_287_1)
					var_287_2.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_284_1.time_ - 0) / var_287_1)
				end
			end

			if arg_284_1.time_ >= 0 + var_287_1 and arg_284_1.time_ < 0 + var_287_1 + arg_287_0 then
				local var_287_3 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_287_3 then
					var_287_3.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_287_3.radialBlurScale = 0
					var_287_3.radialBlurGradient = 1
					var_287_3.radialBlurIntensity = 1
				end
			end

			local var_287_4 = 0

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_4 + arg_287_0 then
				arg_284_1.mask_.enabled = true
				arg_284_1.mask_.raycastTarget = true

				arg_284_1:SetGaussion(false)
			end

			local var_287_5 = 0.3

			if var_287_4 <= arg_284_1.time_ and arg_284_1.time_ < var_287_4 + var_287_5 then
				local var_287_6 = Color.New(0, 0, 0)

				var_287_6.a = Mathf.Lerp(1, 0, (arg_284_1.time_ - var_287_4) / var_287_5)
				arg_284_1.mask_.color = var_287_6
			end

			if arg_284_1.time_ >= var_287_4 + var_287_5 and arg_284_1.time_ < var_287_4 + var_287_5 + arg_287_0 then
				local var_287_7 = Color.New(0, 0, 0)

				arg_284_1.mask_.enabled = false
				var_287_7.a = 0
				arg_284_1.mask_.color = var_287_7
			end

			if 0.3 < arg_284_1.time_ and arg_284_1.time_ <= 0.3 + arg_287_0 then
				arg_284_1:AudioAction("play", "effect", "se_story_140", "se_story_140_explosion01", "")
			end

			if 2.3 < arg_284_1.time_ and arg_284_1.time_ <= 2.3 + arg_287_0 then
				arg_284_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drone04", "")
			end

			local var_287_10 = manager.ui.mainCamera.transform

			if 0.1 < arg_284_1.time_ and arg_284_1.time_ <= 0.1 + arg_287_0 then
				arg_284_1.var_.shakeOldPos = var_287_10.localPosition
			end

			local var_287_11 = 0.633333333333333

			if 0.1 <= arg_284_1.time_ and arg_284_1.time_ < 0.1 + var_287_11 then
				local var_287_12, var_287_13 = math.modf((arg_284_1.time_ - 0.1) / 0.066)

				var_287_10.localPosition = Vector3.New(var_287_13 * 0.13, var_287_13 * 0.13, var_287_13 * 0.13) + arg_284_1.var_.shakeOldPos
			end

			if arg_284_1.time_ >= 0.1 + var_287_11 and arg_284_1.time_ < 0.1 + var_287_11 + arg_287_0 then
				var_287_10.localPosition = arg_284_1.var_.shakeOldPos
			end

			local var_287_14 = 0

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_14 + arg_287_0 then
				arg_284_1.allBtn_.enabled = false
			end

			if arg_284_1.time_ >= var_287_14 + 1.3 and arg_284_1.time_ < var_287_14 + 1.3 + arg_287_0 then
				arg_284_1.allBtn_.enabled = true
			end

			if arg_284_1.frameCnt_ <= 1 then
				arg_284_1.dialog_:SetActive(false)
			end

			local var_287_15 = 0.433333333333333
			local var_287_16 = 1.6

			if 0.433333333333333 < arg_284_1.time_ and arg_284_1.time_ <= var_287_15 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0

				arg_284_1.dialog_:SetActive(true)

				arg_284_1.dialogCg_.alpha = 0

				local var_287_17 = LeanTween.value(arg_284_1.dialog_, 0, 1, 0.3)

				var_287_17:setOnUpdate(LuaHelper.FloatAction(function(arg_288_0)
					arg_284_1.dialogCg_.alpha = arg_288_0
				end))
				var_287_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_284_1.dialog_)
					var_287_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_284_1.duration_ = arg_284_1.duration_ + 0.3

				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_18 = arg_284_1:FormatText(arg_284_1:GetWordFromCfg(321091068).content)

				arg_284_1.text_.text = var_287_18

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_20 = 64 <= 0 and var_287_16 or var_287_16 * (utf8.len(var_287_18) / 64)

				if (64 <= 0 and var_287_16 or var_287_16 * (utf8.len(var_287_18) / 64)) > 0 and var_287_16 < var_287_20 then
					arg_284_1.talkMaxDuration = var_287_20
					var_287_15 = var_287_15 + 0.3

					if var_287_20 + var_287_15 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_20 + var_287_15
					end
				end

				arg_284_1.text_.text = var_287_18
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_21 = var_287_15 + 0.3
			local var_287_22 = math.max(var_287_16, arg_284_1.talkMaxDuration)

			if var_287_15 + 0.3 <= arg_284_1.time_ and arg_284_1.time_ < var_287_21 + var_287_22 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_21) / var_287_22

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_21 + var_287_22 and arg_284_1.time_ < var_287_21 + var_287_22 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play321091069 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 321091069
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play321091070(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 1.125

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_1 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(321091069).content)

				arg_290_1.text_.text = var_293_1

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_3 = 45 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_1) / 45)

				if (45 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_1) / 45)) > 0 and var_293_0 < var_293_3 then
					arg_290_1.talkMaxDuration = var_293_3

					if var_293_3 + 0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_3 + 0
					end
				end

				arg_290_1.text_.text = var_293_1
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_4 = math.max(var_293_0, arg_290_1.talkMaxDuration)

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_4 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - 0) / var_293_4

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= 0 + var_293_4 and arg_290_1.time_ < 0 + var_293_4 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play321091070 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 321091070
		arg_294_1.duration_ = 8.57

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play321091071(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if arg_294_1.bgs_.L08g == nil then
				local var_297_0 = Object.Instantiate(arg_294_1.paintGo_)

				var_297_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L08g")
				var_297_0.name = "L08g"
				var_297_0.transform.parent = arg_294_1.stage_.transform
				var_297_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_294_1.bgs_.L08g = var_297_0
			end

			if 1.999999999999 < arg_294_1.time_ and arg_294_1.time_ <= 1.999999999999 + arg_297_0 then
				local var_297_1 = arg_294_1.bgs_.L08g

				arg_294_1.bgs_.L08g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_297_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_297_2 = var_297_1:GetComponent("SpriteRenderer")

				if var_297_2 and var_297_2.sprite then
					local var_297_3 = 2 * (var_297_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_297_1.transform.localScale = Vector3.New(var_297_3 / var_297_2.sprite.bounds.size.y < var_297_3 * manager.ui.mainCameraCom_.aspect / var_297_2.sprite.bounds.size.x and var_297_3 * manager.ui.mainCameraCom_.aspect / var_297_2.sprite.bounds.size.x or var_297_3 / var_297_2.sprite.bounds.size.y, var_297_3 / var_297_2.sprite.bounds.size.y < var_297_3 * manager.ui.mainCameraCom_.aspect / var_297_2.sprite.bounds.size.x and var_297_3 * manager.ui.mainCameraCom_.aspect / var_297_2.sprite.bounds.size.x or var_297_3 / var_297_2.sprite.bounds.size.y, 0)
				end

				for iter_297_0, iter_297_1 in pairs(arg_294_1.bgs_) do
					if iter_297_0 ~= "L08g" then
						iter_297_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_297_4 = 0

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_4 + arg_297_0 then
				arg_294_1.allBtn_.enabled = false
			end

			if arg_294_1.time_ >= var_297_4 + 0.3 and arg_294_1.time_ < var_297_4 + 0.3 + arg_297_0 then
				arg_294_1.allBtn_.enabled = true
			end

			local var_297_5 = 0

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_5 + arg_297_0 then
				arg_294_1.mask_.enabled = true
				arg_294_1.mask_.raycastTarget = true

				arg_294_1:SetGaussion(false)
			end

			local var_297_6 = 2

			if var_297_5 <= arg_294_1.time_ and arg_294_1.time_ < var_297_5 + var_297_6 then
				local var_297_7 = Color.New(0, 0, 0)

				var_297_7.a = Mathf.Lerp(0, 1, (arg_294_1.time_ - var_297_5) / var_297_6)
				arg_294_1.mask_.color = var_297_7
			end

			if arg_294_1.time_ >= var_297_5 + var_297_6 and arg_294_1.time_ < var_297_5 + var_297_6 + arg_297_0 then
				local var_297_8 = Color.New(0, 0, 0)

				var_297_8.a = 1
				arg_294_1.mask_.color = var_297_8
			end

			local var_297_9 = 2

			if 2 < arg_294_1.time_ and arg_294_1.time_ <= var_297_9 + arg_297_0 then
				arg_294_1.mask_.enabled = true
				arg_294_1.mask_.raycastTarget = true

				arg_294_1:SetGaussion(false)
			end

			local var_297_10 = 2

			if var_297_9 <= arg_294_1.time_ and arg_294_1.time_ < var_297_9 + var_297_10 then
				local var_297_11 = Color.New(0, 0, 0)

				var_297_11.a = Mathf.Lerp(1, 0, (arg_294_1.time_ - var_297_9) / var_297_10)
				arg_294_1.mask_.color = var_297_11
			end

			if arg_294_1.time_ >= var_297_9 + var_297_10 and arg_294_1.time_ < var_297_9 + var_297_10 + arg_297_0 then
				local var_297_12 = Color.New(0, 0, 0)

				arg_294_1.mask_.enabled = false
				var_297_12.a = 0
				arg_294_1.mask_.color = var_297_12
			end

			local var_297_13 = manager.ui.mainCamera.transform

			if 2 < arg_294_1.time_ and arg_294_1.time_ <= 2 + arg_297_0 then
				arg_294_1.var_.shakeOldPos = var_297_13.localPosition
			end

			local var_297_14 = 2.1

			if 2 <= arg_294_1.time_ and arg_294_1.time_ < 2 + var_297_14 then
				local var_297_15, var_297_16 = math.modf((arg_294_1.time_ - 2) / 0.066)

				var_297_13.localPosition = Vector3.New(var_297_16 * 0.13, var_297_16 * 0.13, var_297_16 * 0.13) + arg_294_1.var_.shakeOldPos
			end

			if arg_294_1.time_ >= 2 + var_297_14 and arg_294_1.time_ < 2 + var_297_14 + arg_297_0 then
				var_297_13.localPosition = arg_294_1.var_.shakeOldPos
			end

			if arg_294_1.frameCnt_ <= 1 then
				arg_294_1.dialog_:SetActive(false)
			end

			local var_297_17 = 3.56666666666667
			local var_297_18 = 0.25

			if 3.56666666666667 < arg_294_1.time_ and arg_294_1.time_ <= var_297_17 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0

				arg_294_1.dialog_:SetActive(true)

				arg_294_1.dialogCg_.alpha = 0

				local var_297_19 = LeanTween.value(arg_294_1.dialog_, 0, 1, 0.3)

				var_297_19:setOnUpdate(LuaHelper.FloatAction(function(arg_298_0)
					arg_294_1.dialogCg_.alpha = arg_298_0
				end))
				var_297_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_294_1.dialog_)
					var_297_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_294_1.duration_ = arg_294_1.duration_ + 0.3

				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_20 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(321091070).content)

				arg_294_1.text_.text = var_297_20

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_22 = 10 <= 0 and var_297_18 or var_297_18 * (utf8.len(var_297_20) / 10)

				if (10 <= 0 and var_297_18 or var_297_18 * (utf8.len(var_297_20) / 10)) > 0 and var_297_18 < var_297_22 then
					arg_294_1.talkMaxDuration = var_297_22
					var_297_17 = var_297_17 + 0.3

					if var_297_22 + var_297_17 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_22 + var_297_17
					end
				end

				arg_294_1.text_.text = var_297_20
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_23 = var_297_17 + 0.3
			local var_297_24 = math.max(var_297_18, arg_294_1.talkMaxDuration)

			if var_297_17 + 0.3 <= arg_294_1.time_ and arg_294_1.time_ < var_297_23 + var_297_24 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_23) / var_297_24

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_23 + var_297_24 and arg_294_1.time_ < var_297_23 + var_297_24 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play321091071 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 321091071
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play321091072(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 1.225

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_1 = arg_300_1:FormatText(arg_300_1:GetWordFromCfg(321091071).content)

				arg_300_1.text_.text = var_303_1

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_3 = 49 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_1) / 49)

				if (49 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_1) / 49)) > 0 and var_303_0 < var_303_3 then
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
	Play321091072 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 321091072
		arg_304_1.duration_ = 3.87

		local var_304_0 = {
			zh = 3.533,
			ja = 3.866
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play321091073(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(arg_304_1.actors_["10104ui_story"]) and arg_304_1.var_.characterEffect10104ui_story == nil then
				arg_304_1.var_.characterEffect10104ui_story = arg_304_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_0 = 0.200000002980232

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_0 and not isNil(arg_304_1.actors_["10104ui_story"]) then
				if arg_304_1.var_.characterEffect10104ui_story and not isNil(arg_304_1.actors_["10104ui_story"]) then
					arg_304_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_304_1.time_ >= 0 + var_307_0 and arg_304_1.time_ < 0 + var_307_0 + arg_307_0 and not isNil(arg_304_1.actors_["10104ui_story"]) and arg_304_1.var_.characterEffect10104ui_story then
				arg_304_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action7_1")
			end

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_307_2 = arg_304_1.actors_["10104ui_story"].transform

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.var_.moveOldPos10104ui_story = var_307_2.localPosition
			end

			local var_307_3 = 0.001

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_3 then
				var_307_2.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_304_1.time_ - 0) / var_307_3)
				var_307_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_307_2.position).x, (manager.ui.mainCamera.transform.position - var_307_2.position).y, (manager.ui.mainCamera.transform.position - var_307_2.position).z)
				var_307_2.localEulerAngles.z = 0
				var_307_2.localEulerAngles.x = 0
				var_307_2.localEulerAngles = var_307_2.localEulerAngles
			end

			if arg_304_1.time_ >= 0 + var_307_3 and arg_304_1.time_ < 0 + var_307_3 + arg_307_0 then
				var_307_2.localPosition = Vector3.New(0.02, -1.12, -5.99)
				var_307_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_307_2.position).x, (manager.ui.mainCamera.transform.position - var_307_2.position).y, (manager.ui.mainCamera.transform.position - var_307_2.position).z)
				var_307_2.localEulerAngles.z = 0
				var_307_2.localEulerAngles.x = 0
				var_307_2.localEulerAngles = var_307_2.localEulerAngles
			end

			local var_307_4 = 0
			local var_307_5 = 0.3

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_4 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_6 = arg_304_1:GetWordFromCfg(321091072)
				local var_307_7 = arg_304_1:FormatText(var_307_6.content)

				arg_304_1.text_.text = var_307_7

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_9 = 12 <= 0 and var_307_5 or var_307_5 * (utf8.len(var_307_7) / 12)

				if (12 <= 0 and var_307_5 or var_307_5 * (utf8.len(var_307_7) / 12)) > 0 and var_307_5 < var_307_9 then
					arg_304_1.talkMaxDuration = var_307_9

					if var_307_9 + var_307_4 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_9 + var_307_4
					end
				end

				arg_304_1.text_.text = var_307_7
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091072", "story_v_out_321091.awb") ~= 0 then
					local var_307_10 = manager.audio:GetVoiceLength("story_v_out_321091", "321091072", "story_v_out_321091.awb") / 1000

					if var_307_10 + var_307_4 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_10 + var_307_4
					end

					if var_307_6.prefab_name ~= "" and arg_304_1.actors_[var_307_6.prefab_name] ~= nil then
						local var_307_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_6.prefab_name].transform, "story_v_out_321091", "321091072", "story_v_out_321091.awb")

						arg_304_1:RecordAudio("321091072", var_307_11)
						arg_304_1:RecordAudio("321091072", var_307_11)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_321091", "321091072", "story_v_out_321091.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_321091", "321091072", "story_v_out_321091.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_12 = math.max(var_307_5, arg_304_1.talkMaxDuration)

			if var_307_4 <= arg_304_1.time_ and arg_304_1.time_ < var_307_4 + var_307_12 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_4) / var_307_12

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_4 + var_307_12 and arg_304_1.time_ < var_307_4 + var_307_12 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_304_1:InitPlayNodeList()
	end,
	Play321091073 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 321091073
		arg_308_1.duration_ = 2

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play321091074(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if arg_308_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_311_0 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_308_1.stage_.transform)

				var_311_0.name = "1284ui_story"
				var_311_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_308_1.actors_["1284ui_story"] = var_311_0

				local var_311_1 = var_311_0:GetComponentInChildren(typeof(CharacterEffect))

				var_311_1.enabled = true

				local var_311_2 = GameObjectTools.GetOrAddComponent(var_311_0, typeof(DynamicBoneHelper))

				if var_311_2 then
					var_311_2:EnableDynamicBone(false)
				end

				arg_308_1:ShowWeapon(var_311_1.transform, false)

				arg_308_1.var_["1284ui_story" .. "Animator"] = var_311_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_308_1.var_["1284ui_story" .. "Animator"].applyRootMotion = true
				arg_308_1.var_["1284ui_story" .. "LipSync"] = var_311_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_311_3 = arg_308_1.actors_["1284ui_story"].transform

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos1284ui_story = var_311_3.localPosition

				arg_308_1:ShowWeapon(arg_308_1.var_["1284ui_story" .. "Animator"].transform, false)
			end

			local var_311_4 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_4 then
				var_311_3.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_308_1.time_ - 0) / var_311_4)
				var_311_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_3.position).x, (manager.ui.mainCamera.transform.position - var_311_3.position).y, (manager.ui.mainCamera.transform.position - var_311_3.position).z)
				var_311_3.localEulerAngles.z = 0
				var_311_3.localEulerAngles.x = 0
				var_311_3.localEulerAngles = var_311_3.localEulerAngles
			end

			if arg_308_1.time_ >= 0 + var_311_4 and arg_308_1.time_ < 0 + var_311_4 + arg_311_0 then
				var_311_3.localPosition = Vector3.New(0, -0.985, -6.22)
				var_311_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_3.position).x, (manager.ui.mainCamera.transform.position - var_311_3.position).y, (manager.ui.mainCamera.transform.position - var_311_3.position).z)
				var_311_3.localEulerAngles.z = 0
				var_311_3.localEulerAngles.x = 0
				var_311_3.localEulerAngles = var_311_3.localEulerAngles
			end

			local var_311_5 = arg_308_1.actors_["1284ui_story"]

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(var_311_5) and arg_308_1.var_.characterEffect1284ui_story == nil then
				arg_308_1.var_.characterEffect1284ui_story = var_311_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_6 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_6 and not isNil(var_311_5) then
				if arg_308_1.var_.characterEffect1284ui_story and not isNil(var_311_5) then
					arg_308_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_308_1.time_ >= 0 + var_311_6 and arg_308_1.time_ < 0 + var_311_6 + arg_311_0 and not isNil(var_311_5) and arg_308_1.var_.characterEffect1284ui_story then
				arg_308_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_311_8 = arg_308_1.actors_["10104ui_story"]

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(var_311_8) and arg_308_1.var_.characterEffect10104ui_story == nil then
				arg_308_1.var_.characterEffect10104ui_story = var_311_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_9 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_9 and not isNil(var_311_8) then
				if arg_308_1.var_.characterEffect10104ui_story and not isNil(var_311_8) then
					arg_308_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_308_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_308_1.time_ - 0) / var_311_9)
				end
			end

			if arg_308_1.time_ >= 0 + var_311_9 and arg_308_1.time_ < 0 + var_311_9 + arg_311_0 and not isNil(var_311_8) and arg_308_1.var_.characterEffect10104ui_story then
				arg_308_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_308_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_311_10 = arg_308_1.actors_["10104ui_story"].transform

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos10104ui_story = var_311_10.localPosition
			end

			local var_311_11 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_11 then
				var_311_10.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_308_1.time_ - 0) / var_311_11)
				var_311_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_10.position).x, (manager.ui.mainCamera.transform.position - var_311_10.position).y, (manager.ui.mainCamera.transform.position - var_311_10.position).z)
				var_311_10.localEulerAngles.z = 0
				var_311_10.localEulerAngles.x = 0
				var_311_10.localEulerAngles = var_311_10.localEulerAngles
			end

			if arg_308_1.time_ >= 0 + var_311_11 and arg_308_1.time_ < 0 + var_311_11 + arg_311_0 then
				var_311_10.localPosition = Vector3.New(0, 100, 0)
				var_311_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_10.position).x, (manager.ui.mainCamera.transform.position - var_311_10.position).y, (manager.ui.mainCamera.transform.position - var_311_10.position).z)
				var_311_10.localEulerAngles.z = 0
				var_311_10.localEulerAngles.x = 0
				var_311_10.localEulerAngles = var_311_10.localEulerAngles
			end

			local var_311_12 = 0
			local var_311_13 = 0.125

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_12 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_14 = arg_308_1:GetWordFromCfg(321091073)
				local var_311_15 = arg_308_1:FormatText(var_311_14.content)

				arg_308_1.text_.text = var_311_15

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_17 = 5 <= 0 and var_311_13 or var_311_13 * (utf8.len(var_311_15) / 5)

				if (5 <= 0 and var_311_13 or var_311_13 * (utf8.len(var_311_15) / 5)) > 0 and var_311_13 < var_311_17 then
					arg_308_1.talkMaxDuration = var_311_17

					if var_311_17 + var_311_12 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_17 + var_311_12
					end
				end

				arg_308_1.text_.text = var_311_15
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091073", "story_v_out_321091.awb") ~= 0 then
					local var_311_18 = manager.audio:GetVoiceLength("story_v_out_321091", "321091073", "story_v_out_321091.awb") / 1000

					if var_311_18 + var_311_12 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_18 + var_311_12
					end

					if var_311_14.prefab_name ~= "" and arg_308_1.actors_[var_311_14.prefab_name] ~= nil then
						local var_311_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_14.prefab_name].transform, "story_v_out_321091", "321091073", "story_v_out_321091.awb")

						arg_308_1:RecordAudio("321091073", var_311_19)
						arg_308_1:RecordAudio("321091073", var_311_19)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_321091", "321091073", "story_v_out_321091.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_321091", "321091073", "story_v_out_321091.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_20 = math.max(var_311_13, arg_308_1.talkMaxDuration)

			if var_311_12 <= arg_308_1.time_ and arg_308_1.time_ < var_311_12 + var_311_20 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_12) / var_311_20

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_12 + var_311_20 and arg_308_1.time_ < var_311_12 + var_311_20 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play321091074 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 321091074
		arg_312_1.duration_ = 6.2

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play321091075(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_9000

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(arg_312_1.actors_["1284ui_story"]) and arg_312_1.var_.characterEffect1284ui_story == nil then
				arg_312_1.var_.characterEffect1284ui_story = arg_312_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_0 = 0.200000002980232

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_0 and not isNil(arg_312_1.actors_["1284ui_story"]) then
				if arg_312_1.var_.characterEffect1284ui_story and not isNil(arg_312_1.actors_["1284ui_story"]) then
					arg_312_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_312_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_312_1.time_ - 0) / var_315_0)
				end
			end

			if arg_312_1.time_ >= 0 + var_315_0 and arg_312_1.time_ < 0 + var_315_0 + arg_315_0 and not isNil(arg_312_1.actors_["1284ui_story"]) and arg_312_1.var_.characterEffect1284ui_story then
				arg_312_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_312_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_315_1 = arg_312_1.actors_["1284ui_story"].transform

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos1284ui_story = var_315_1.localPosition

				arg_312_1:ShowWeapon(arg_312_1.var_["1284ui_story" .. "Animator"].transform, false)
			end

			local var_315_2 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_2 then
				var_315_1.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_312_1.time_ - 0) / var_315_2)
				var_315_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_315_1.position).x, (manager.ui.mainCamera.transform.position - var_315_1.position).y, (manager.ui.mainCamera.transform.position - var_315_1.position).z)
				var_315_1.localEulerAngles.z = 0
				var_315_1.localEulerAngles.x = 0
				var_315_1.localEulerAngles = var_315_1.localEulerAngles
			end

			if arg_312_1.time_ >= 0 + var_315_2 and arg_312_1.time_ < 0 + var_315_2 + arg_315_0 then
				var_315_1.localPosition = Vector3.New(0, 100, 0)
				var_315_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_315_1.position).x, (manager.ui.mainCamera.transform.position - var_315_1.position).y, (manager.ui.mainCamera.transform.position - var_315_1.position).z)
				var_315_1.localEulerAngles.z = 0
				var_315_1.localEulerAngles.x = 0
				var_315_1.localEulerAngles = var_315_1.localEulerAngles
			end

			if 0.034000001847744 < arg_312_1.time_ and arg_312_1.time_ <= 0.034000001847744 + arg_315_0 then
				arg_312_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_rock1", "")
			end

			if 0.3 < arg_312_1.time_ and arg_312_1.time_ <= 0.3 + arg_315_0 then
				local var_315_4 = arg_312_1.var_.effect987

				if not arg_312_1.var_.effect987 then
					var_315_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), manager.ui.mainCamera.transform)
					var_315_4.name = "987"
					arg_312_1.var_.effect987 = var_315_4
				else
					var_315_4.transform:SetParent(var_315_9000)
				end

				var_315_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_315_4.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_315_6 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_315_7 = var_315_4.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_315_0, iter_315_1 in ipairs((var_315_7:ToTable())) do
					iter_315_1.transform.localScale = Vector3.New(iter_315_1.transform.localScale.x / var_315_6 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_315_7 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_315_1.transform.localScale.y / var_315_6, iter_315_1.transform.localScale.z)
				end
			end

			local var_315_9 = manager.ui.mainCamera.transform

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.shakeOldPos = var_315_9.localPosition
			end

			local var_315_10 = 0.8

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_10 then
				local var_315_11, var_315_12 = math.modf((arg_312_1.time_ - 0) / 0.066)

				var_315_9.localPosition = Vector3.New(var_315_12 * 0.13, var_315_12 * 0.13, var_315_12 * 0.13) + arg_312_1.var_.shakeOldPos
			end

			if arg_312_1.time_ >= 0 + var_315_10 and arg_312_1.time_ < 0 + var_315_10 + arg_315_0 then
				var_315_9.localPosition = arg_312_1.var_.shakeOldPos
			end

			local var_315_13 = 0

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_13 + arg_315_0 then
				arg_312_1.allBtn_.enabled = false
			end

			if arg_312_1.time_ >= var_315_13 + 1.56666666666667 and arg_312_1.time_ < var_315_13 + 1.56666666666667 + arg_315_0 then
				arg_312_1.allBtn_.enabled = true
			end

			if 0.1 < arg_312_1.time_ and arg_312_1.time_ <= 0.1 + arg_315_0 then
				arg_312_1:AudioAction("play", "effect", "se_story_140", "se_story_140_rock1", "")
			end

			if arg_312_1.frameCnt_ <= 1 then
				arg_312_1.dialog_:SetActive(false)
			end

			local var_315_15 = 1.20000000298023
			local var_315_16 = 1.425

			if 1.20000000298023 < arg_312_1.time_ and arg_312_1.time_ <= var_315_15 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0

				arg_312_1.dialog_:SetActive(true)

				arg_312_1.dialogCg_.alpha = 0

				local var_315_17 = LeanTween.value(arg_312_1.dialog_, 0, 1, 0.3)

				var_315_17:setOnUpdate(LuaHelper.FloatAction(function(arg_316_0)
					arg_312_1.dialogCg_.alpha = arg_316_0
				end))
				var_315_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_312_1.dialog_)
					var_315_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_312_1.duration_ = arg_312_1.duration_ + 0.3

				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_18 = arg_312_1:FormatText(arg_312_1:GetWordFromCfg(321091074).content)

				arg_312_1.text_.text = var_315_18

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_20 = 57 <= 0 and var_315_16 or var_315_16 * (utf8.len(var_315_18) / 57)

				if (57 <= 0 and var_315_16 or var_315_16 * (utf8.len(var_315_18) / 57)) > 0 and var_315_16 < var_315_20 then
					arg_312_1.talkMaxDuration = var_315_20
					var_315_15 = var_315_15 + 0.3

					if var_315_20 + var_315_15 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_20 + var_315_15
					end
				end

				arg_312_1.text_.text = var_315_18
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_21 = var_315_15 + 0.3
			local var_315_22 = math.max(var_315_16, arg_312_1.talkMaxDuration)

			if var_315_15 + 0.3 <= arg_312_1.time_ and arg_312_1.time_ < var_315_21 + var_315_22 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_21) / var_315_22

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_21 + var_315_22 and arg_312_1.time_ < var_315_21 + var_315_22 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play321091075 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 321091075
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play321091076(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				if arg_318_1.var_.effect987 then
					Object.Destroy(arg_318_1.var_.effect987)

					arg_318_1.var_.effect987 = nil
				end
			end

			local var_321_1 = 0
			local var_321_2 = 1.4

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, false)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_3 = arg_318_1:FormatText(arg_318_1:GetWordFromCfg(321091075).content)

				arg_318_1.text_.text = var_321_3

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_5 = 56 <= 0 and var_321_2 or var_321_2 * (utf8.len(var_321_3) / 56)

				if (56 <= 0 and var_321_2 or var_321_2 * (utf8.len(var_321_3) / 56)) > 0 and var_321_2 < var_321_5 then
					arg_318_1.talkMaxDuration = var_321_5

					if var_321_5 + var_321_1 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_5 + var_321_1
					end
				end

				arg_318_1.text_.text = var_321_3
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_6 = math.max(var_321_2, arg_318_1.talkMaxDuration)

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_6 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_1) / var_321_6

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_1 + var_321_6 and arg_318_1.time_ < var_321_1 + var_321_6 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play321091076 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 321091076
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play321091077(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0.05 < arg_322_1.time_ and arg_322_1.time_ <= 0.05 + arg_325_0 then
				arg_322_1:AudioAction("play", "effect", "se_story_140", "se_story_140_baqin_summon", "")
			end

			local var_325_1 = 0
			local var_325_2 = 0.825

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_3 = arg_322_1:FormatText(arg_322_1:GetWordFromCfg(321091076).content)

				arg_322_1.text_.text = var_325_3

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_5 = 33 <= 0 and var_325_2 or var_325_2 * (utf8.len(var_325_3) / 33)

				if (33 <= 0 and var_325_2 or var_325_2 * (utf8.len(var_325_3) / 33)) > 0 and var_325_2 < var_325_5 then
					arg_322_1.talkMaxDuration = var_325_5

					if var_325_5 + var_325_1 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_5 + var_325_1
					end
				end

				arg_322_1.text_.text = var_325_3
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_6 = math.max(var_325_2, arg_322_1.talkMaxDuration)

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_6 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_1) / var_325_6

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_1 + var_325_6 and arg_322_1.time_ < var_325_1 + var_325_6 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play321091077 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 321091077
		arg_326_1.duration_ = 10.83

		local var_326_0 = {
			zh = 5.566,
			ja = 10.833
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play321091078(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if arg_326_1.actors_["10130ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10130ui_story"))) then
				local var_329_0 = Object.Instantiate(Asset.Load("Char/" .. "10130ui_story"), arg_326_1.stage_.transform)

				var_329_0.name = "10130ui_story"
				var_329_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_326_1.actors_["10130ui_story"] = var_329_0

				local var_329_1 = var_329_0:GetComponentInChildren(typeof(CharacterEffect))

				var_329_1.enabled = true

				local var_329_2 = GameObjectTools.GetOrAddComponent(var_329_0, typeof(DynamicBoneHelper))

				if var_329_2 then
					var_329_2:EnableDynamicBone(false)
				end

				arg_326_1:ShowWeapon(var_329_1.transform, false)

				arg_326_1.var_["10130ui_story" .. "Animator"] = var_329_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_326_1.var_["10130ui_story" .. "Animator"].applyRootMotion = true
				arg_326_1.var_["10130ui_story" .. "LipSync"] = var_329_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_329_3 = arg_326_1.actors_["10130ui_story"]

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(var_329_3) and arg_326_1.var_.characterEffect10130ui_story == nil then
				arg_326_1.var_.characterEffect10130ui_story = var_329_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_4 = 0.200000002980232

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_4 and not isNil(var_329_3) then
				if arg_326_1.var_.characterEffect10130ui_story and not isNil(var_329_3) then
					arg_326_1.var_.characterEffect10130ui_story.fillFlat = false
				end
			end

			if arg_326_1.time_ >= 0 + var_329_4 and arg_326_1.time_ < 0 + var_329_4 + arg_329_0 and not isNil(var_329_3) and arg_326_1.var_.characterEffect10130ui_story then
				arg_326_1.var_.characterEffect10130ui_story.fillFlat = false
			end

			local var_329_6 = arg_326_1.actors_["10130ui_story"].transform

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.var_.moveOldPos10130ui_story = var_329_6.localPosition
			end

			local var_329_7 = 0.001

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_7 then
				var_329_6.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos10130ui_story, Vector3.New(-0.03, -1.02, -5.81), (arg_326_1.time_ - 0) / var_329_7)
				var_329_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_329_6.position).x, (manager.ui.mainCamera.transform.position - var_329_6.position).y, (manager.ui.mainCamera.transform.position - var_329_6.position).z)
				var_329_6.localEulerAngles.z = 0
				var_329_6.localEulerAngles.x = 0
				var_329_6.localEulerAngles = var_329_6.localEulerAngles
			end

			if arg_326_1.time_ >= 0 + var_329_7 and arg_326_1.time_ < 0 + var_329_7 + arg_329_0 then
				var_329_6.localPosition = Vector3.New(-0.03, -1.02, -5.81)
				var_329_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_329_6.position).x, (manager.ui.mainCamera.transform.position - var_329_6.position).y, (manager.ui.mainCamera.transform.position - var_329_6.position).z)
				var_329_6.localEulerAngles.z = 0
				var_329_6.localEulerAngles.x = 0
				var_329_6.localEulerAngles = var_329_6.localEulerAngles
			end

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/story10130/story10130action/10130action1_1")
			end

			local var_329_8 = 0
			local var_329_9 = 0.425

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_8 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_10 = arg_326_1:GetWordFromCfg(321091077)
				local var_329_11 = arg_326_1:FormatText(var_329_10.content)

				arg_326_1.text_.text = var_329_11

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_13 = 17 <= 0 and var_329_9 or var_329_9 * (utf8.len(var_329_11) / 17)

				if (17 <= 0 and var_329_9 or var_329_9 * (utf8.len(var_329_11) / 17)) > 0 and var_329_9 < var_329_13 then
					arg_326_1.talkMaxDuration = var_329_13

					if var_329_13 + var_329_8 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_13 + var_329_8
					end
				end

				arg_326_1.text_.text = var_329_11
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091077", "story_v_out_321091.awb") ~= 0 then
					local var_329_14 = manager.audio:GetVoiceLength("story_v_out_321091", "321091077", "story_v_out_321091.awb") / 1000

					if var_329_14 + var_329_8 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_14 + var_329_8
					end

					if var_329_10.prefab_name ~= "" and arg_326_1.actors_[var_329_10.prefab_name] ~= nil then
						local var_329_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_10.prefab_name].transform, "story_v_out_321091", "321091077", "story_v_out_321091.awb")

						arg_326_1:RecordAudio("321091077", var_329_15)
						arg_326_1:RecordAudio("321091077", var_329_15)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_321091", "321091077", "story_v_out_321091.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_321091", "321091077", "story_v_out_321091.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_16 = math.max(var_329_9, arg_326_1.talkMaxDuration)

			if var_329_8 <= arg_326_1.time_ and arg_326_1.time_ < var_329_8 + var_329_16 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_8) / var_329_16

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_8 + var_329_16 and arg_326_1.time_ < var_329_8 + var_329_16 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_326_1:InitPlayNodeList()
	end,
	Play321091078 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 321091078
		arg_330_1.duration_ = 6.07

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play321091079(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_9002
			local var_333_9001
			local var_333_9000

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(arg_330_1.actors_["10130ui_story"]) and arg_330_1.var_.characterEffect10130ui_story == nil then
				arg_330_1.var_.characterEffect10130ui_story = arg_330_1.actors_["10130ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_0 = 0.200000002980232

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 and not isNil(arg_330_1.actors_["10130ui_story"]) then
				if arg_330_1.var_.characterEffect10130ui_story and not isNil(arg_330_1.actors_["10130ui_story"]) then
					arg_330_1.var_.characterEffect10130ui_story.fillFlat = true
					arg_330_1.var_.characterEffect10130ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_330_1.time_ - 0) / var_333_0)
				end
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 and not isNil(arg_330_1.actors_["10130ui_story"]) and arg_330_1.var_.characterEffect10130ui_story then
				arg_330_1.var_.characterEffect10130ui_story.fillFlat = true
				arg_330_1.var_.characterEffect10130ui_story.fillRatio = 0.5
			end

			local var_333_1 = manager.ui.mainCamera.transform

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.var_.shakeOldPos = var_333_1.localPosition
			end

			local var_333_2 = 0.833333333333333

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_2 then
				local var_333_3, var_333_4 = math.modf((arg_330_1.time_ - 0) / 0.066)

				var_333_1.localPosition = Vector3.New(var_333_4 * 0.13, var_333_4 * 0.13, var_333_4 * 0.13) + arg_330_1.var_.shakeOldPos
			end

			if arg_330_1.time_ >= 0 + var_333_2 and arg_330_1.time_ < 0 + var_333_2 + arg_333_0 then
				var_333_1.localPosition = arg_330_1.var_.shakeOldPos
			end

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				local var_333_5 = arg_330_1.var_.effect112

				if not arg_330_1.var_.effect112 then
					var_333_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), manager.ui.mainCamera.transform)
					var_333_5.name = "112"
					arg_330_1.var_.effect112 = var_333_5
				else
					var_333_5.transform:SetParent(var_333_9002)
				end

				var_333_5.transform.localPosition = Vector3.New(-0.76, -0.06, -0.86)
				var_333_5.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_333_7 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_333_8 = var_333_5.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_333_0, iter_333_1 in ipairs((var_333_8:ToTable())) do
					iter_333_1.transform.localScale = Vector3.New(iter_333_1.transform.localScale.x / var_333_7 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_333_8 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_333_1.transform.localScale.y / var_333_7, iter_333_1.transform.localScale.z)
				end
			end

			if 0.133333333333333 < arg_330_1.time_ and arg_330_1.time_ <= 0.133333333333333 + arg_333_0 then
				local var_333_10 = arg_330_1.var_.effect115

				if not arg_330_1.var_.effect115 then
					var_333_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), manager.ui.mainCamera.transform)
					var_333_10.name = "115"
					arg_330_1.var_.effect115 = var_333_10
				else
					var_333_10.transform:SetParent(var_333_9001)
				end

				var_333_10.transform.localPosition = Vector3.New(0.06, 0, -0.86)
				var_333_10.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_333_12 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_333_13 = var_333_10.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_333_2, iter_333_3 in ipairs((var_333_13:ToTable())) do
					iter_333_3.transform.localScale = Vector3.New(iter_333_3.transform.localScale.x / var_333_12 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_333_13 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_333_3.transform.localScale.y / var_333_12, iter_333_3.transform.localScale.z)
				end
			end

			if 0.333333333333333 < arg_330_1.time_ and arg_330_1.time_ <= 0.333333333333333 + arg_333_0 then
				local var_333_15 = arg_330_1.var_.effect117

				if not arg_330_1.var_.effect117 then
					var_333_15 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), manager.ui.mainCamera.transform)
					var_333_15.name = "117"
					arg_330_1.var_.effect117 = var_333_15
				else
					var_333_15.transform:SetParent(var_333_9000)
				end

				var_333_15.transform.localPosition = Vector3.New(1.21, 0, -0.86)
				var_333_15.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_333_17 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_333_18 = var_333_15.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_333_4, iter_333_5 in ipairs((var_333_18:ToTable())) do
					iter_333_5.transform.localScale = Vector3.New(iter_333_5.transform.localScale.x / var_333_17 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_333_18 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_333_5.transform.localScale.y / var_333_17, iter_333_5.transform.localScale.z)
				end
			end

			local var_333_20 = 0

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_20 + arg_333_0 then
				arg_330_1.allBtn_.enabled = false
			end

			if arg_330_1.time_ >= var_333_20 + 1.63333333333333 and arg_330_1.time_ < var_333_20 + 1.63333333333333 + arg_333_0 then
				arg_330_1.allBtn_.enabled = true
			end

			if 0.05 < arg_330_1.time_ and arg_330_1.time_ <= 0.05 + arg_333_0 then
				arg_330_1:AudioAction("play", "effect", "se_story_140", "se_story_140_baqin_skill02", "")
			end

			local var_333_22 = arg_330_1.actors_["10130ui_story"].transform

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.var_.moveOldPos10130ui_story = var_333_22.localPosition
			end

			local var_333_23 = 0.001

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_23 then
				var_333_22.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos10130ui_story, Vector3.New(0, 100, 0), (arg_330_1.time_ - 0) / var_333_23)
				var_333_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_333_22.position).x, (manager.ui.mainCamera.transform.position - var_333_22.position).y, (manager.ui.mainCamera.transform.position - var_333_22.position).z)
				var_333_22.localEulerAngles.z = 0
				var_333_22.localEulerAngles.x = 0
				var_333_22.localEulerAngles = var_333_22.localEulerAngles
			end

			if arg_330_1.time_ >= 0 + var_333_23 and arg_330_1.time_ < 0 + var_333_23 + arg_333_0 then
				var_333_22.localPosition = Vector3.New(0, 100, 0)
				var_333_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_333_22.position).x, (manager.ui.mainCamera.transform.position - var_333_22.position).y, (manager.ui.mainCamera.transform.position - var_333_22.position).z)
				var_333_22.localEulerAngles.z = 0
				var_333_22.localEulerAngles.x = 0
				var_333_22.localEulerAngles = var_333_22.localEulerAngles
			end

			if arg_330_1.frameCnt_ <= 1 then
				arg_330_1.dialog_:SetActive(false)
			end

			local var_333_24 = 1.06666666666667
			local var_333_25 = 1.225

			if 1.06666666666667 < arg_330_1.time_ and arg_330_1.time_ <= var_333_24 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0

				arg_330_1.dialog_:SetActive(true)

				arg_330_1.dialogCg_.alpha = 0

				local var_333_26 = LeanTween.value(arg_330_1.dialog_, 0, 1, 0.3)

				var_333_26:setOnUpdate(LuaHelper.FloatAction(function(arg_334_0)
					arg_330_1.dialogCg_.alpha = arg_334_0
				end))
				var_333_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_330_1.dialog_)
					var_333_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_330_1.duration_ = arg_330_1.duration_ + 0.3

				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_27 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(321091078).content)

				arg_330_1.text_.text = var_333_27

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_29 = 49 <= 0 and var_333_25 or var_333_25 * (utf8.len(var_333_27) / 49)

				if (49 <= 0 and var_333_25 or var_333_25 * (utf8.len(var_333_27) / 49)) > 0 and var_333_25 < var_333_29 then
					arg_330_1.talkMaxDuration = var_333_29
					var_333_24 = var_333_24 + 0.3

					if var_333_29 + var_333_24 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_29 + var_333_24
					end
				end

				arg_330_1.text_.text = var_333_27
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_30 = var_333_24 + 0.3
			local var_333_31 = math.max(var_333_25, arg_330_1.talkMaxDuration)

			if var_333_24 + 0.3 <= arg_330_1.time_ and arg_330_1.time_ < var_333_30 + var_333_31 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_30) / var_333_31

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_30 + var_333_31 and arg_330_1.time_ < var_333_30 + var_333_31 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play321091079 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 321091079
		arg_336_1.duration_ = 5.33

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play321091080(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_9000

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				if arg_336_1.var_.effect112 then
					Object.Destroy(arg_336_1.var_.effect112)

					arg_336_1.var_.effect112 = nil
				end
			end

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				if arg_336_1.var_.effect115 then
					Object.Destroy(arg_336_1.var_.effect115)

					arg_336_1.var_.effect115 = nil
				end
			end

			if 0.333333333333333 < arg_336_1.time_ and arg_336_1.time_ <= 0.333333333333333 + arg_339_0 then
				if arg_336_1.var_.effect117 then
					Object.Destroy(arg_336_1.var_.effect117)

					arg_336_1.var_.effect117 = nil
				end
			end

			if 0.133333333333333 < arg_336_1.time_ and arg_336_1.time_ <= 0.133333333333333 + arg_339_0 then
				local var_339_3 = arg_336_1.var_.effect744

				if not arg_336_1.var_.effect744 then
					var_339_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_339_3.name = "744"
					arg_336_1.var_.effect744 = var_339_3
				else
					var_339_3.transform:SetParent(var_339_9000)
				end

				var_339_3.transform.localPosition = Vector3.New(0, -0.28, 0)
				var_339_3.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_339_5 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_339_6 = var_339_3.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_339_0, iter_339_1 in ipairs((var_339_6:ToTable())) do
					iter_339_1.transform.localScale = Vector3.New(iter_339_1.transform.localScale.x / var_339_5 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_339_6 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_339_1.transform.localScale.y / var_339_5, iter_339_1.transform.localScale.z)
				end
			end

			local var_339_8 = 0

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_8 + arg_339_0 then
				arg_336_1.allBtn_.enabled = false
			end

			if arg_336_1.time_ >= var_339_8 + 0.433333333333333 and arg_336_1.time_ < var_339_8 + 0.433333333333333 + arg_339_0 then
				arg_336_1.allBtn_.enabled = true
			end

			if 0.133333333333333 < arg_336_1.time_ and arg_336_1.time_ <= 0.133333333333333 + arg_339_0 then
				arg_336_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_gun02", "")
			end

			if arg_336_1.frameCnt_ <= 1 then
				arg_336_1.dialog_:SetActive(false)
			end

			local var_339_10 = 0.333333333333333
			local var_339_11 = 1.55

			if 0.333333333333333 < arg_336_1.time_ and arg_336_1.time_ <= var_339_10 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0

				arg_336_1.dialog_:SetActive(true)

				arg_336_1.dialogCg_.alpha = 0

				local var_339_12 = LeanTween.value(arg_336_1.dialog_, 0, 1, 0.3)

				var_339_12:setOnUpdate(LuaHelper.FloatAction(function(arg_340_0)
					arg_336_1.dialogCg_.alpha = arg_340_0
				end))
				var_339_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_336_1.dialog_)
					var_339_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_336_1.duration_ = arg_336_1.duration_ + 0.3

				SetActive(arg_336_1.leftNameGo_, false)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_13 = arg_336_1:FormatText(arg_336_1:GetWordFromCfg(321091079).content)

				arg_336_1.text_.text = var_339_13

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_15 = 62 <= 0 and var_339_11 or var_339_11 * (utf8.len(var_339_13) / 62)

				if (62 <= 0 and var_339_11 or var_339_11 * (utf8.len(var_339_13) / 62)) > 0 and var_339_11 < var_339_15 then
					arg_336_1.talkMaxDuration = var_339_15
					var_339_10 = var_339_10 + 0.3

					if var_339_15 + var_339_10 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_15 + var_339_10
					end
				end

				arg_336_1.text_.text = var_339_13
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)
				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_16 = var_339_10 + 0.3
			local var_339_17 = math.max(var_339_11, arg_336_1.talkMaxDuration)

			if var_339_10 + 0.3 <= arg_336_1.time_ and arg_336_1.time_ < var_339_16 + var_339_17 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_16) / var_339_17

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_16 + var_339_17 and arg_336_1.time_ < var_339_16 + var_339_17 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play321091080 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 321091080
		arg_342_1.duration_ = 2.3

		local var_342_0 = {
			zh = 1.033,
			ja = 2.3
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play321091081(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(arg_342_1.actors_["10130ui_story"]) and arg_342_1.var_.characterEffect10130ui_story == nil then
				arg_342_1.var_.characterEffect10130ui_story = arg_342_1.actors_["10130ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_0 = 0.200000002980232

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 and not isNil(arg_342_1.actors_["10130ui_story"]) then
				if arg_342_1.var_.characterEffect10130ui_story and not isNil(arg_342_1.actors_["10130ui_story"]) then
					arg_342_1.var_.characterEffect10130ui_story.fillFlat = false
				end
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 and not isNil(arg_342_1.actors_["10130ui_story"]) and arg_342_1.var_.characterEffect10130ui_story then
				arg_342_1.var_.characterEffect10130ui_story.fillFlat = false
			end

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				if arg_342_1.var_.effect744 then
					Object.Destroy(arg_342_1.var_.effect744)

					arg_342_1.var_.effect744 = nil
				end
			end

			local var_345_3 = 0
			local var_345_4 = 0.05

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_3 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10130")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_5 = arg_342_1:GetWordFromCfg(321091080)
				local var_345_6 = arg_342_1:FormatText(var_345_5.content)

				arg_342_1.text_.text = var_345_6

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_8 = 2 <= 0 and var_345_4 or var_345_4 * (utf8.len(var_345_6) / 2)

				if (2 <= 0 and var_345_4 or var_345_4 * (utf8.len(var_345_6) / 2)) > 0 and var_345_4 < var_345_8 then
					arg_342_1.talkMaxDuration = var_345_8

					if var_345_8 + var_345_3 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_8 + var_345_3
					end
				end

				arg_342_1.text_.text = var_345_6
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091080", "story_v_out_321091.awb") ~= 0 then
					local var_345_9 = manager.audio:GetVoiceLength("story_v_out_321091", "321091080", "story_v_out_321091.awb") / 1000

					if var_345_9 + var_345_3 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_9 + var_345_3
					end

					if var_345_5.prefab_name ~= "" and arg_342_1.actors_[var_345_5.prefab_name] ~= nil then
						local var_345_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_5.prefab_name].transform, "story_v_out_321091", "321091080", "story_v_out_321091.awb")

						arg_342_1:RecordAudio("321091080", var_345_10)
						arg_342_1:RecordAudio("321091080", var_345_10)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_321091", "321091080", "story_v_out_321091.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_321091", "321091080", "story_v_out_321091.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_11 = math.max(var_345_4, arg_342_1.talkMaxDuration)

			if var_345_3 <= arg_342_1.time_ and arg_342_1.time_ < var_345_3 + var_345_11 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_3) / var_345_11

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_3 + var_345_11 and arg_342_1.time_ < var_345_3 + var_345_11 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play321091081 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 321091081
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play321091082(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(arg_346_1.actors_["10130ui_story"]) and arg_346_1.var_.characterEffect10130ui_story == nil then
				arg_346_1.var_.characterEffect10130ui_story = arg_346_1.actors_["10130ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_0 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 and not isNil(arg_346_1.actors_["10130ui_story"]) then
				if arg_346_1.var_.characterEffect10130ui_story and not isNil(arg_346_1.actors_["10130ui_story"]) then
					arg_346_1.var_.characterEffect10130ui_story.fillFlat = true
					arg_346_1.var_.characterEffect10130ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_346_1.time_ - 0) / var_349_0)
				end
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 and not isNil(arg_346_1.actors_["10130ui_story"]) and arg_346_1.var_.characterEffect10130ui_story then
				arg_346_1.var_.characterEffect10130ui_story.fillFlat = true
				arg_346_1.var_.characterEffect10130ui_story.fillRatio = 0.5
			end

			local var_349_1 = 0
			local var_349_2 = 1.225

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, false)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_3 = arg_346_1:FormatText(arg_346_1:GetWordFromCfg(321091081).content)

				arg_346_1.text_.text = var_349_3

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_5 = 49 <= 0 and var_349_2 or var_349_2 * (utf8.len(var_349_3) / 49)

				if (49 <= 0 and var_349_2 or var_349_2 * (utf8.len(var_349_3) / 49)) > 0 and var_349_2 < var_349_5 then
					arg_346_1.talkMaxDuration = var_349_5

					if var_349_5 + var_349_1 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_5 + var_349_1
					end
				end

				arg_346_1.text_.text = var_349_3
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_6 = math.max(var_349_2, arg_346_1.talkMaxDuration)

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_6 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_1) / var_349_6

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_1 + var_349_6 and arg_346_1.time_ < var_349_1 + var_349_6 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play321091082 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 321091082
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play321091083(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0.05 < arg_350_1.time_ and arg_350_1.time_ <= 0.05 + arg_353_0 then
				arg_350_1:AudioAction("play", "effect", "se_story_side_1049", "se_story_side_1049_hug", "")
			end

			local var_353_1 = 0
			local var_353_2 = 1.025

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_3 = arg_350_1:FormatText(arg_350_1:GetWordFromCfg(321091082).content)

				arg_350_1.text_.text = var_353_3

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_5 = 41 <= 0 and var_353_2 or var_353_2 * (utf8.len(var_353_3) / 41)

				if (41 <= 0 and var_353_2 or var_353_2 * (utf8.len(var_353_3) / 41)) > 0 and var_353_2 < var_353_5 then
					arg_350_1.talkMaxDuration = var_353_5

					if var_353_5 + var_353_1 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_5 + var_353_1
					end
				end

				arg_350_1.text_.text = var_353_3
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_6 = math.max(var_353_2, arg_350_1.talkMaxDuration)

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_6 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_1) / var_353_6

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_1 + var_353_6 and arg_350_1.time_ < var_353_1 + var_353_6 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play321091083 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 321091083
		arg_354_1.duration_ = 4.9

		local var_354_0 = {
			zh = 3.733,
			ja = 4.9
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
			arg_354_1.auto_ = false
		end

		function arg_354_1.playNext_(arg_356_0)
			arg_354_1.onStoryFinished_()
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(arg_354_1.actors_["10104ui_story"]) and arg_354_1.var_.characterEffect10104ui_story == nil then
				arg_354_1.var_.characterEffect10104ui_story = arg_354_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_0 = 0.200000002980232

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 and not isNil(arg_354_1.actors_["10104ui_story"]) then
				if arg_354_1.var_.characterEffect10104ui_story and not isNil(arg_354_1.actors_["10104ui_story"]) then
					arg_354_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 and not isNil(arg_354_1.actors_["10104ui_story"]) and arg_354_1.var_.characterEffect10104ui_story then
				arg_354_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_357_2 = arg_354_1.actors_["10104ui_story"]

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(var_357_2) and arg_354_1.var_.characterEffect10104ui_story == nil then
				arg_354_1.var_.characterEffect10104ui_story = var_357_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_3 = 0.200000002980232

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_3 and not isNil(var_357_2) then
				if arg_354_1.var_.characterEffect10104ui_story and not isNil(var_357_2) then
					arg_354_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_354_1.time_ >= 0 + var_357_3 and arg_354_1.time_ < 0 + var_357_3 + arg_357_0 and not isNil(var_357_2) and arg_354_1.var_.characterEffect10104ui_story then
				arg_354_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_357_5 = arg_354_1.actors_["10104ui_story"].transform

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.moveOldPos10104ui_story = var_357_5.localPosition
			end

			local var_357_6 = 0.001

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_6 then
				var_357_5.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_354_1.time_ - 0) / var_357_6)
				var_357_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_357_5.position).x, (manager.ui.mainCamera.transform.position - var_357_5.position).y, (manager.ui.mainCamera.transform.position - var_357_5.position).z)
				var_357_5.localEulerAngles.z = 0
				var_357_5.localEulerAngles.x = 0
				var_357_5.localEulerAngles = var_357_5.localEulerAngles
			end

			if arg_354_1.time_ >= 0 + var_357_6 and arg_354_1.time_ < 0 + var_357_6 + arg_357_0 then
				var_357_5.localPosition = Vector3.New(0.02, -1.12, -5.99)
				var_357_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_357_5.position).x, (manager.ui.mainCamera.transform.position - var_357_5.position).y, (manager.ui.mainCamera.transform.position - var_357_5.position).z)
				var_357_5.localEulerAngles.z = 0
				var_357_5.localEulerAngles.x = 0
				var_357_5.localEulerAngles = var_357_5.localEulerAngles
			end

			local var_357_7 = 0
			local var_357_8 = 0.35

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_7 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_9 = arg_354_1:GetWordFromCfg(321091083)
				local var_357_10 = arg_354_1:FormatText(var_357_9.content)

				arg_354_1.text_.text = var_357_10

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_12 = 14 <= 0 and var_357_8 or var_357_8 * (utf8.len(var_357_10) / 14)

				if (14 <= 0 and var_357_8 or var_357_8 * (utf8.len(var_357_10) / 14)) > 0 and var_357_8 < var_357_12 then
					arg_354_1.talkMaxDuration = var_357_12

					if var_357_12 + var_357_7 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_12 + var_357_7
					end
				end

				arg_354_1.text_.text = var_357_10
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321091", "321091083", "story_v_out_321091.awb") ~= 0 then
					local var_357_13 = manager.audio:GetVoiceLength("story_v_out_321091", "321091083", "story_v_out_321091.awb") / 1000

					if var_357_13 + var_357_7 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_13 + var_357_7
					end

					if var_357_9.prefab_name ~= "" and arg_354_1.actors_[var_357_9.prefab_name] ~= nil then
						local var_357_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_9.prefab_name].transform, "story_v_out_321091", "321091083", "story_v_out_321091.awb")

						arg_354_1:RecordAudio("321091083", var_357_14)
						arg_354_1:RecordAudio("321091083", var_357_14)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_321091", "321091083", "story_v_out_321091.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_321091", "321091083", "story_v_out_321091.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_15 = math.max(var_357_8, arg_354_1.talkMaxDuration)

			if var_357_7 <= arg_354_1.time_ and arg_354_1.time_ < var_357_7 + var_357_15 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_7) / var_357_15

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_7 + var_357_15 and arg_354_1.time_ < var_357_7 + var_357_15 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST73",
		"TextureConfig/Background/MS2103a",
		"TextureConfig/Background/ST0507",
		"TextureConfig/Background/ST0507a",
		"TextureConfig/Background/L08g"
	},
	voices = {
		"story_v_out_321091.awb"
	}
}
