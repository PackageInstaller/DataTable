return {
	Play324161001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324161001
		arg_1_1.duration_ = 3.2

		local var_1_0 = {
			zh = 2.96666666666667,
			ja = 3.19966666666667
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
				arg_1_0:Play324161002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST2008 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2008")
				var_4_0.name = "ST2008"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST2008 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST2008

				arg_1_1.bgs_.ST2008.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST2008" then
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

			local var_4_9 = "1036ui_story"

			if arg_1_1.actors_["1036ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1036ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1036ui_story"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect1036ui_story == nil then
				arg_1_1.var_.characterEffect1036ui_story = var_4_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_14 = 0.200000002980232

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_14 and not isNil(var_4_13) then
				if arg_1_1.var_.characterEffect1036ui_story and not isNil(var_4_13) then
					arg_1_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_14 and arg_1_1.time_ < 0 + var_4_14 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect1036ui_story then
				arg_1_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_0_story_dilao", "bgm_activity_5_0_story_dilao", "bgm_activity_5_0_story_dilao.awb")

				local var_4_20 = manager.audio:GetAudioName("bgm_activity_5_0_story_dilao", "bgm_activity_5_0_story_dilao")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_21 = 1.36666666666667
			local var_4_22 = 0.175

			if 1.36666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_24 = arg_1_1:GetWordFromCfg(324161001)
				local var_4_25 = arg_1_1:FormatText(var_4_24.content)

				arg_1_1.text_.text = var_4_25

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_27 = 7 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 7)

				if (7 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 7)) > 0 and var_4_22 < var_4_27 then
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

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161001", "story_v_out_324161.awb") ~= 0 then
					local var_4_28 = manager.audio:GetVoiceLength("story_v_out_324161", "324161001", "story_v_out_324161.awb") / 1000

					if var_4_28 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_21
					end

					if var_4_24.prefab_name ~= "" and arg_1_1.actors_[var_4_24.prefab_name] ~= nil then
						local var_4_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_24.prefab_name].transform, "story_v_out_324161", "324161001", "story_v_out_324161.awb")

						arg_1_1:RecordAudio("324161001", var_4_29)
						arg_1_1:RecordAudio("324161001", var_4_29)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_324161", "324161001", "story_v_out_324161.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_324161", "324161001", "story_v_out_324161.awb")
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
	Play324161002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324161002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play324161003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(arg_8_1.actors_["1036ui_story"]) and arg_8_1.var_.characterEffect1036ui_story == nil then
				arg_8_1.var_.characterEffect1036ui_story = arg_8_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_0 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 and not isNil(arg_8_1.actors_["1036ui_story"]) then
				if arg_8_1.var_.characterEffect1036ui_story and not isNil(arg_8_1.actors_["1036ui_story"]) then
					arg_8_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_0)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 and not isNil(arg_8_1.actors_["1036ui_story"]) and arg_8_1.var_.characterEffect1036ui_story then
				arg_8_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_11_1 = 0
			local var_11_2 = 1.375

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

				local var_11_3 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(324161002).content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 55 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 55)

				if (55 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 55)) > 0 and var_11_2 < var_11_5 then
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
	Play324161003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324161003
		arg_12_1.duration_ = 7.6

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play324161004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_9002
			local var_15_9001
			local var_15_9000

			if arg_12_1.bgs_.J27i == nil then
				local var_15_0 = Object.Instantiate(arg_12_1.paintGo_)

				var_15_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J27i")
				var_15_0.name = "J27i"
				var_15_0.transform.parent = arg_12_1.stage_.transform
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.bgs_.J27i = var_15_0
			end

			if 0.9 < arg_12_1.time_ and arg_12_1.time_ <= 0.9 + arg_15_0 then
				local var_15_1 = arg_12_1.bgs_.J27i

				arg_12_1.bgs_.J27i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_15_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_15_2 = var_15_1:GetComponent("SpriteRenderer")

				if var_15_2 and var_15_2.sprite then
					local var_15_3 = 2 * (var_15_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_15_1.transform.localScale = Vector3.New(var_15_3 / var_15_2.sprite.bounds.size.y < var_15_3 * manager.ui.mainCameraCom_.aspect / var_15_2.sprite.bounds.size.x and var_15_3 * manager.ui.mainCameraCom_.aspect / var_15_2.sprite.bounds.size.x or var_15_3 / var_15_2.sprite.bounds.size.y, var_15_3 / var_15_2.sprite.bounds.size.y < var_15_3 * manager.ui.mainCameraCom_.aspect / var_15_2.sprite.bounds.size.x and var_15_3 * manager.ui.mainCameraCom_.aspect / var_15_2.sprite.bounds.size.x or var_15_3 / var_15_2.sprite.bounds.size.y, 0)
				end

				for iter_15_0, iter_15_1 in pairs(arg_12_1.bgs_) do
					if iter_15_0 ~= "J27i" then
						iter_15_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_15_4 = 0.9

			if 0.9 < arg_12_1.time_ and arg_12_1.time_ <= var_15_4 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			if arg_12_1.time_ >= var_15_4 + 0.3 and arg_12_1.time_ < var_15_4 + 0.3 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end

			if 1.2 < arg_12_1.time_ and arg_12_1.time_ <= 1.2 + arg_15_0 then
				local var_15_5 = arg_12_1.var_.effect4343

				if not arg_12_1.var_.effect4343 then
					var_15_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_monitor"), manager.ui.mainCamera.transform)
					var_15_5.name = "4343"
					arg_12_1.var_.effect4343 = var_15_5
				else
					var_15_5.transform:SetParent(var_15_9002)
				end

				var_15_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_15_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_15_5.transform.localScale = Vector3.New(var_15_5.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_15_5.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_15_5.transform.localScale.z)
			end

			if 1.2 < arg_12_1.time_ and arg_12_1.time_ <= 1.2 + arg_15_0 then
				local var_15_7 = arg_12_1.var_.effect434

				if not arg_12_1.var_.effect434 then
					var_15_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_vignetting"), manager.ui.mainCamera.transform)
					var_15_7.name = "434"
					arg_12_1.var_.effect434 = var_15_7
				else
					var_15_7.transform:SetParent(var_15_9001)
				end

				var_15_7.transform.localPosition = Vector3.New(0, 0, 0)
				var_15_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_15_7.transform.localScale = Vector3.New(var_15_7.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_15_7.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_15_7.transform.localScale.z)
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				local var_15_9 = arg_12_1.var_.effect41122

				if not arg_12_1.var_.effect41122 then
					var_15_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_15_9.name = "41122"
					arg_12_1.var_.effect41122 = var_15_9
				else
					var_15_9.transform:SetParent(var_15_9000)
				end

				var_15_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_15_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_15_9.transform.localScale = Vector3.New(var_15_9.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_15_9.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_15_9.transform.localScale.z)
			end

			local var_15_11 = 1

			if 1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_11 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			if arg_12_1.time_ >= var_15_11 + 2.2 and arg_12_1.time_ < var_15_11 + 2.2 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end

			if 1.2 < arg_12_1.time_ and arg_12_1.time_ <= 1.2 + arg_15_0 then
				arg_12_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if 0.1 < arg_12_1.time_ and arg_12_1.time_ <= 0.1 + arg_15_0 then
				arg_12_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if arg_12_1.frameCnt_ <= 1 then
				arg_12_1.dialog_:SetActive(false)
			end

			local var_15_14 = 2.59610799723305
			local var_15_15 = 1.375

			if 2.59610799723305 < arg_12_1.time_ and arg_12_1.time_ <= var_15_14 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				arg_12_1.dialog_:SetActive(true)

				arg_12_1.dialogCg_.alpha = 0

				local var_15_16 = LeanTween.value(arg_12_1.dialog_, 0, 1, 0.3)

				var_15_16:setOnUpdate(LuaHelper.FloatAction(function(arg_16_0)
					arg_12_1.dialogCg_.alpha = arg_16_0
				end))
				var_15_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_12_1.dialog_)
					var_15_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_12_1.duration_ = arg_12_1.duration_ + 0.3

				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_17 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(324161003).content)

				arg_12_1.text_.text = var_15_17

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_19 = 55 <= 0 and var_15_15 or var_15_15 * (utf8.len(var_15_17) / 55)

				if (55 <= 0 and var_15_15 or var_15_15 * (utf8.len(var_15_17) / 55)) > 0 and var_15_15 < var_15_19 then
					arg_12_1.talkMaxDuration = var_15_19
					var_15_14 = var_15_14 + 0.3

					if var_15_19 + var_15_14 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_19 + var_15_14
					end
				end

				arg_12_1.text_.text = var_15_17
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_20 = var_15_14 + 0.3
			local var_15_21 = math.max(var_15_15, arg_12_1.talkMaxDuration)

			if var_15_14 + 0.3 <= arg_12_1.time_ and arg_12_1.time_ < var_15_20 + var_15_21 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_20) / var_15_21

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_20 + var_15_21 and arg_12_1.time_ < var_15_20 + var_15_21 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play324161004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 324161004
		arg_18_1.duration_ = 7.73

		local var_18_0 = {
			zh = 5.6666666696469,
			ja = 7.7326666696469
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
				arg_18_0:Play324161005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 1.4 < arg_18_1.time_ and arg_18_1.time_ <= 1.4 + arg_21_0 then
				local var_21_0 = arg_18_1.bgs_.ST2008

				arg_18_1.bgs_.ST2008.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_21_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_21_1 = var_21_0:GetComponent("SpriteRenderer")

				if var_21_1 and var_21_1.sprite then
					local var_21_2 = 2 * (var_21_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_21_0.transform.localScale = Vector3.New(var_21_2 / var_21_1.sprite.bounds.size.y < var_21_2 * manager.ui.mainCameraCom_.aspect / var_21_1.sprite.bounds.size.x and var_21_2 * manager.ui.mainCameraCom_.aspect / var_21_1.sprite.bounds.size.x or var_21_2 / var_21_1.sprite.bounds.size.y, var_21_2 / var_21_1.sprite.bounds.size.y < var_21_2 * manager.ui.mainCameraCom_.aspect / var_21_1.sprite.bounds.size.x and var_21_2 * manager.ui.mainCameraCom_.aspect / var_21_1.sprite.bounds.size.x or var_21_2 / var_21_1.sprite.bounds.size.y, 0)
				end

				for iter_21_0, iter_21_1 in pairs(arg_18_1.bgs_) do
					if iter_21_0 ~= "ST2008" then
						iter_21_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_21_3 = 1.4

			if 1.4 < arg_18_1.time_ and arg_18_1.time_ <= var_21_3 + arg_21_0 then
				arg_18_1.allBtn_.enabled = false
			end

			if arg_18_1.time_ >= var_21_3 + 0.3 and arg_18_1.time_ < var_21_3 + 0.3 + arg_21_0 then
				arg_18_1.allBtn_.enabled = true
			end

			local var_21_4 = 0

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_4 + arg_21_0 then
				arg_18_1.mask_.enabled = true
				arg_18_1.mask_.raycastTarget = true

				arg_18_1:SetGaussion(false)
			end

			local var_21_5 = 1.4

			if var_21_4 <= arg_18_1.time_ and arg_18_1.time_ < var_21_4 + var_21_5 then
				local var_21_6 = Color.New(0, 0, 0)

				var_21_6.a = Mathf.Lerp(0, 1, (arg_18_1.time_ - var_21_4) / var_21_5)
				arg_18_1.mask_.color = var_21_6
			end

			if arg_18_1.time_ >= var_21_4 + var_21_5 and arg_18_1.time_ < var_21_4 + var_21_5 + arg_21_0 then
				local var_21_7 = Color.New(0, 0, 0)

				var_21_7.a = 1
				arg_18_1.mask_.color = var_21_7
			end

			local var_21_8 = 1.4

			if 1.4 < arg_18_1.time_ and arg_18_1.time_ <= var_21_8 + arg_21_0 then
				arg_18_1.mask_.enabled = true
				arg_18_1.mask_.raycastTarget = true

				arg_18_1:SetGaussion(false)
			end

			local var_21_9 = 2

			if var_21_8 <= arg_18_1.time_ and arg_18_1.time_ < var_21_8 + var_21_9 then
				local var_21_10 = Color.New(0, 0, 0)

				var_21_10.a = Mathf.Lerp(1, 0, (arg_18_1.time_ - var_21_8) / var_21_9)
				arg_18_1.mask_.color = var_21_10
			end

			if arg_18_1.time_ >= var_21_8 + var_21_9 and arg_18_1.time_ < var_21_8 + var_21_9 + arg_21_0 then
				local var_21_11 = Color.New(0, 0, 0)

				arg_18_1.mask_.enabled = false
				var_21_11.a = 0
				arg_18_1.mask_.color = var_21_11
			end

			local var_21_12 = "1054ui_story"

			if arg_18_1.actors_["1054ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1054ui_story"))) then
				local var_21_13 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_18_1.stage_.transform)

				var_21_13.name = var_21_12
				var_21_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_18_1.actors_[var_21_12] = var_21_13

				local var_21_14 = var_21_13:GetComponentInChildren(typeof(CharacterEffect))

				var_21_14.enabled = true

				local var_21_15 = GameObjectTools.GetOrAddComponent(var_21_13, typeof(DynamicBoneHelper))

				if var_21_15 then
					var_21_15:EnableDynamicBone(false)
				end

				arg_18_1:ShowWeapon(var_21_14.transform, false)

				arg_18_1.var_[var_21_12 .. "Animator"] = var_21_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_18_1.var_[var_21_12 .. "Animator"].applyRootMotion = true
				arg_18_1.var_[var_21_12 .. "LipSync"] = var_21_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_21_16 = arg_18_1.actors_["1054ui_story"].transform

			if 2.96666666666667 < arg_18_1.time_ and arg_18_1.time_ <= 2.96666666666667 + arg_21_0 then
				arg_18_1.var_.moveOldPos1054ui_story = var_21_16.localPosition

				local var_21_17 = GameObjectTools.GetOrAddComponent(var_21_16.gameObject, typeof(DynamicBoneHelper))

				if var_21_17 then
					var_21_17:EnableDynamicBone(false)
				end
			end

			local var_21_18 = 0.001

			if 2.96666666666667 <= arg_18_1.time_ and arg_18_1.time_ < 2.96666666666667 + var_21_18 then
				var_21_16.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_18_1.time_ - 2.96666666666667) / var_21_18)
				var_21_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_21_16.position).x, (manager.ui.mainCamera.transform.position - var_21_16.position).y, (manager.ui.mainCamera.transform.position - var_21_16.position).z)
				var_21_16.localEulerAngles.z = 0
				var_21_16.localEulerAngles.x = 0
				var_21_16.localEulerAngles = var_21_16.localEulerAngles
			end

			if arg_18_1.time_ >= 2.96666666666667 + var_21_18 and arg_18_1.time_ < 2.96666666666667 + var_21_18 + arg_21_0 then
				var_21_16.localPosition = Vector3.New(0, -0.985, -6)
				var_21_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_21_16.position).x, (manager.ui.mainCamera.transform.position - var_21_16.position).y, (manager.ui.mainCamera.transform.position - var_21_16.position).z)
				var_21_16.localEulerAngles.z = 0
				var_21_16.localEulerAngles.x = 0
				var_21_16.localEulerAngles = var_21_16.localEulerAngles

				local var_21_19 = GameObjectTools.GetOrAddComponent(var_21_16.gameObject, typeof(DynamicBoneHelper))

				if var_21_19 then
					var_21_19:EnableDynamicBone(true)
				end
			end

			local var_21_20 = arg_18_1.actors_["1054ui_story"]

			if 2.96666666666667 < arg_18_1.time_ and arg_18_1.time_ <= 2.96666666666667 + arg_21_0 and not isNil(var_21_20) and arg_18_1.var_.characterEffect1054ui_story == nil then
				arg_18_1.var_.characterEffect1054ui_story = var_21_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_21 = 0.200000002980232

			if 2.96666666666667 <= arg_18_1.time_ and arg_18_1.time_ < 2.96666666666667 + var_21_21 and not isNil(var_21_20) then
				if arg_18_1.var_.characterEffect1054ui_story and not isNil(var_21_20) then
					arg_18_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_18_1.time_ >= 2.96666666666667 + var_21_21 and arg_18_1.time_ < 2.96666666666667 + var_21_21 + arg_21_0 and not isNil(var_21_20) and arg_18_1.var_.characterEffect1054ui_story then
				arg_18_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 2.96666666666667 < arg_18_1.time_ and arg_18_1.time_ <= 2.96666666666667 + arg_21_0 then
				arg_18_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 2.96666666666667 < arg_18_1.time_ and arg_18_1.time_ <= 2.96666666666667 + arg_21_0 then
				arg_18_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 1.4 < arg_18_1.time_ and arg_18_1.time_ <= 1.4 + arg_21_0 then
				if arg_18_1.var_.effect4343 then
					Object.Destroy(arg_18_1.var_.effect4343)

					arg_18_1.var_.effect4343 = nil
				end
			end

			if 1.4 < arg_18_1.time_ and arg_18_1.time_ <= 1.4 + arg_21_0 then
				if arg_18_1.var_.effect434 then
					Object.Destroy(arg_18_1.var_.effect434)

					arg_18_1.var_.effect434 = nil
				end
			end

			if 1.43333333333333 < arg_18_1.time_ and arg_18_1.time_ <= 1.43333333333333 + arg_21_0 then
				if arg_18_1.var_.effect41122 then
					Object.Destroy(arg_18_1.var_.effect41122)

					arg_18_1.var_.effect41122 = nil
				end
			end

			if 1.2 < arg_18_1.time_ and arg_18_1.time_ <= 1.2 + arg_21_0 then
				arg_18_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if 0.1 < arg_18_1.time_ and arg_18_1.time_ <= 0.1 + arg_21_0 then
				arg_18_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if arg_18_1.frameCnt_ <= 1 then
				arg_18_1.dialog_:SetActive(false)
			end

			local var_21_28 = 3.1666666696469
			local var_21_29 = 0.3

			if 3.1666666696469 < arg_18_1.time_ and arg_18_1.time_ <= var_21_28 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0

				arg_18_1.dialog_:SetActive(true)

				arg_18_1.dialogCg_.alpha = 0

				local var_21_30 = LeanTween.value(arg_18_1.dialog_, 0, 1, 0.3)

				var_21_30:setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
					arg_18_1.dialogCg_.alpha = arg_22_0
				end))
				var_21_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_18_1.dialog_)
					var_21_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_18_1.duration_ = arg_18_1.duration_ + 0.3

				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_31 = arg_18_1:GetWordFromCfg(324161004)
				local var_21_32 = arg_18_1:FormatText(var_21_31.content)

				arg_18_1.text_.text = var_21_32

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_34 = 12 <= 0 and var_21_29 or var_21_29 * (utf8.len(var_21_32) / 12)

				if (12 <= 0 and var_21_29 or var_21_29 * (utf8.len(var_21_32) / 12)) > 0 and var_21_29 < var_21_34 then
					arg_18_1.talkMaxDuration = var_21_34
					var_21_28 = var_21_28 + 0.3

					if var_21_34 + var_21_28 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_34 + var_21_28
					end
				end

				arg_18_1.text_.text = var_21_32
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161004", "story_v_out_324161.awb") ~= 0 then
					local var_21_35 = manager.audio:GetVoiceLength("story_v_out_324161", "324161004", "story_v_out_324161.awb") / 1000

					if var_21_35 + var_21_28 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_35 + var_21_28
					end

					if var_21_31.prefab_name ~= "" and arg_18_1.actors_[var_21_31.prefab_name] ~= nil then
						local var_21_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_31.prefab_name].transform, "story_v_out_324161", "324161004", "story_v_out_324161.awb")

						arg_18_1:RecordAudio("324161004", var_21_36)
						arg_18_1:RecordAudio("324161004", var_21_36)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_324161", "324161004", "story_v_out_324161.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_324161", "324161004", "story_v_out_324161.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_37 = var_21_28 + 0.3
			local var_21_38 = math.max(var_21_29, arg_18_1.talkMaxDuration)

			if var_21_28 + 0.3 <= arg_18_1.time_ and arg_18_1.time_ < var_21_37 + var_21_38 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_37) / var_21_38

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_37 + var_21_38 and arg_18_1.time_ < var_21_37 + var_21_38 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play324161005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324161005
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play324161006(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1054ui_story = arg_24_1.actors_["1054ui_story"].transform.localPosition

				local var_27_0 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_0 then
					var_27_0:EnableDynamicBone(false)
				end
			end

			local var_27_1 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_1 then
				arg_24_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_1)
				arg_24_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1054ui_story"].transform.position).z)
				arg_24_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["1054ui_story"].transform.localEulerAngles = arg_24_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_1 and arg_24_1.time_ < 0 + var_27_1 + arg_27_0 then
				arg_24_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1054ui_story"].transform.position).z)
				arg_24_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["1054ui_story"].transform.localEulerAngles = arg_24_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_27_2 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(true)
				end
			end

			local var_27_3 = arg_24_1.actors_["1054ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_3) and arg_24_1.var_.characterEffect1054ui_story == nil then
				arg_24_1.var_.characterEffect1054ui_story = var_27_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_4 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 and not isNil(var_27_3) then
				if arg_24_1.var_.characterEffect1054ui_story and not isNil(var_27_3) then
					arg_24_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_4)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 and not isNil(var_27_3) and arg_24_1.var_.characterEffect1054ui_story then
				arg_24_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_27_5 = 0
			local var_27_6 = 0.725

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_7 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(324161005).content)

				arg_24_1.text_.text = var_27_7

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_9 = 29 <= 0 and var_27_6 or var_27_6 * (utf8.len(var_27_7) / 29)

				if (29 <= 0 and var_27_6 or var_27_6 * (utf8.len(var_27_7) / 29)) > 0 and var_27_6 < var_27_9 then
					arg_24_1.talkMaxDuration = var_27_9

					if var_27_9 + var_27_5 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_9 + var_27_5
					end
				end

				arg_24_1.text_.text = var_27_7
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_10 = math.max(var_27_6, arg_24_1.talkMaxDuration)

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_10 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_5) / var_27_10

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_5 + var_27_10 and arg_24_1.time_ < var_27_5 + var_27_10 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play324161006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 324161006
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play324161007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0.1 < arg_28_1.time_ and arg_28_1.time_ <= 0.1 + arg_31_0 then
				arg_28_1:AudioAction("play", "effect", "se_story_side_1028", "se_story_1028_warning", "")
			end

			local var_31_1 = 0
			local var_31_2 = 1.175

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_3 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(324161006).content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 47 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 47)

				if (47 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 47)) > 0 and var_31_2 < var_31_5 then
					arg_28_1.talkMaxDuration = var_31_5

					if var_31_5 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + var_31_1
					end
				end

				arg_28_1.text_.text = var_31_3
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_6 = math.max(var_31_2, arg_28_1.talkMaxDuration)

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_6 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_1) / var_31_6

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_1 + var_31_6 and arg_28_1.time_ < var_31_1 + var_31_6 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play324161007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 324161007
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play324161008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.825

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_1 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(324161007).content)

				arg_32_1.text_.text = var_35_1

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_3 = 33 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_1) / 33)

				if (33 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_1) / 33)) > 0 and var_35_0 < var_35_3 then
					arg_32_1.talkMaxDuration = var_35_3

					if var_35_3 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_3 + 0
					end
				end

				arg_32_1.text_.text = var_35_1
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_4 = math.max(var_35_0, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_4 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - 0) / var_35_4

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_4 and arg_32_1.time_ < 0 + var_35_4 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play324161008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 324161008
		arg_36_1.duration_ = 6.27

		local var_36_0 = {
			zh = 5.166,
			ja = 6.266
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
				arg_36_0:Play324161009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1054ui_story = arg_36_1.actors_["1054ui_story"].transform.localPosition

				local var_39_0 = GameObjectTools.GetOrAddComponent(arg_36_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_39_0 then
					var_39_0:EnableDynamicBone(false)
				end
			end

			local var_39_1 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_1 then
				arg_36_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_36_1.time_ - 0) / var_39_1)
				arg_36_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1054ui_story"].transform.position).z)
				arg_36_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1054ui_story"].transform.localEulerAngles = arg_36_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_1 and arg_36_1.time_ < 0 + var_39_1 + arg_39_0 then
				arg_36_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_36_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1054ui_story"].transform.position).z)
				arg_36_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1054ui_story"].transform.localEulerAngles = arg_36_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_39_2 = GameObjectTools.GetOrAddComponent(arg_36_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(true)
				end
			end

			local var_39_3 = arg_36_1.actors_["1054ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_3) and arg_36_1.var_.characterEffect1054ui_story == nil then
				arg_36_1.var_.characterEffect1054ui_story = var_39_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_4 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_4 and not isNil(var_39_3) then
				if arg_36_1.var_.characterEffect1054ui_story and not isNil(var_39_3) then
					arg_36_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_4 and arg_36_1.time_ < 0 + var_39_4 + arg_39_0 and not isNil(var_39_3) and arg_36_1.var_.characterEffect1054ui_story then
				arg_36_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_39_6 = 0
			local var_39_7 = 0.475

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_8 = arg_36_1:GetWordFromCfg(324161008)
				local var_39_9 = arg_36_1:FormatText(var_39_8.content)

				arg_36_1.text_.text = var_39_9

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_11 = 19 <= 0 and var_39_7 or var_39_7 * (utf8.len(var_39_9) / 19)

				if (19 <= 0 and var_39_7 or var_39_7 * (utf8.len(var_39_9) / 19)) > 0 and var_39_7 < var_39_11 then
					arg_36_1.talkMaxDuration = var_39_11

					if var_39_11 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_11 + var_39_6
					end
				end

				arg_36_1.text_.text = var_39_9
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161008", "story_v_out_324161.awb") ~= 0 then
					local var_39_12 = manager.audio:GetVoiceLength("story_v_out_324161", "324161008", "story_v_out_324161.awb") / 1000

					if var_39_12 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_12 + var_39_6
					end

					if var_39_8.prefab_name ~= "" and arg_36_1.actors_[var_39_8.prefab_name] ~= nil then
						local var_39_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_8.prefab_name].transform, "story_v_out_324161", "324161008", "story_v_out_324161.awb")

						arg_36_1:RecordAudio("324161008", var_39_13)
						arg_36_1:RecordAudio("324161008", var_39_13)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_324161", "324161008", "story_v_out_324161.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_324161", "324161008", "story_v_out_324161.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_14 = math.max(var_39_7, arg_36_1.talkMaxDuration)

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_14 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_6) / var_39_14

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_6 + var_39_14 and arg_36_1.time_ < var_39_6 + var_39_14 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play324161009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 324161009
		arg_40_1.duration_ = 5.5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play324161010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1054ui_story = arg_40_1.actors_["1054ui_story"].transform.localPosition

				local var_43_0 = GameObjectTools.GetOrAddComponent(arg_40_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_43_0 then
					var_43_0:EnableDynamicBone(false)
				end
			end

			local var_43_1 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_1 then
				arg_40_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_40_1.time_ - 0) / var_43_1)
				arg_40_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1054ui_story"].transform.position).z)
				arg_40_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["1054ui_story"].transform.localEulerAngles = arg_40_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_1 and arg_40_1.time_ < 0 + var_43_1 + arg_43_0 then
				arg_40_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1054ui_story"].transform.position).z)
				arg_40_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["1054ui_story"].transform.localEulerAngles = arg_40_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_43_2 = GameObjectTools.GetOrAddComponent(arg_40_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_43_2 then
					var_43_2:EnableDynamicBone(true)
				end
			end

			local var_43_3 = arg_40_1.actors_["1054ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_3) and arg_40_1.var_.characterEffect1054ui_story == nil then
				arg_40_1.var_.characterEffect1054ui_story = var_43_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_4 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_4 and not isNil(var_43_3) then
				if arg_40_1.var_.characterEffect1054ui_story and not isNil(var_43_3) then
					arg_40_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_4)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_4 and arg_40_1.time_ < 0 + var_43_4 + arg_43_0 and not isNil(var_43_3) and arg_40_1.var_.characterEffect1054ui_story then
				arg_40_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if arg_40_1.frameCnt_ <= 1 then
				arg_40_1.dialog_:SetActive(false)
			end

			local var_43_5 = 0.5
			local var_43_6 = 1.025

			if 0.5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0

				arg_40_1.dialog_:SetActive(true)

				arg_40_1.dialogCg_.alpha = 0

				local var_43_7 = LeanTween.value(arg_40_1.dialog_, 0, 1, 0.3)

				var_43_7:setOnUpdate(LuaHelper.FloatAction(function(arg_44_0)
					arg_40_1.dialogCg_.alpha = arg_44_0
				end))
				var_43_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_40_1.dialog_)
					var_43_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_40_1.duration_ = arg_40_1.duration_ + 0.3

				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_8 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(324161009).content)

				arg_40_1.text_.text = var_43_8

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_10 = 41 <= 0 and var_43_6 or var_43_6 * (utf8.len(var_43_8) / 41)

				if (41 <= 0 and var_43_6 or var_43_6 * (utf8.len(var_43_8) / 41)) > 0 and var_43_6 < var_43_10 then
					arg_40_1.talkMaxDuration = var_43_10
					var_43_5 = var_43_5 + 0.3

					if var_43_10 + var_43_5 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_5
					end
				end

				arg_40_1.text_.text = var_43_8
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_11 = var_43_5 + 0.3
			local var_43_12 = math.max(var_43_6, arg_40_1.talkMaxDuration)

			if var_43_5 + 0.3 <= arg_40_1.time_ and arg_40_1.time_ < var_43_11 + var_43_12 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_11) / var_43_12

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_11 + var_43_12 and arg_40_1.time_ < var_43_11 + var_43_12 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
				frequencyGain = 1,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 0.7,
				amplitudeGain = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play324161010 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 324161010
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play324161011(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0.75

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_1 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(324161010).content)

				arg_46_1.text_.text = var_49_1

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_3 = 30 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_1) / 30)

				if (30 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_1) / 30)) > 0 and var_49_0 < var_49_3 then
					arg_46_1.talkMaxDuration = var_49_3

					if var_49_3 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_3 + 0
					end
				end

				arg_46_1.text_.text = var_49_1
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_4 = math.max(var_49_0, arg_46_1.talkMaxDuration)

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_4 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - 0) / var_49_4

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= 0 + var_49_4 and arg_46_1.time_ < 0 + var_49_4 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play324161011 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 324161011
		arg_50_1.duration_ = 7.27

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play324161012(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_9002
			local var_53_9001
			local var_53_9000

			if 0.733333333333333 < arg_50_1.time_ and arg_50_1.time_ <= 0.733333333333333 + arg_53_0 then
				local var_53_0 = arg_50_1.bgs_.J27i

				arg_50_1.bgs_.J27i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_53_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_53_1 = var_53_0:GetComponent("SpriteRenderer")

				if var_53_1 and var_53_1.sprite then
					local var_53_2 = 2 * (var_53_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_53_0.transform.localScale = Vector3.New(var_53_2 / var_53_1.sprite.bounds.size.y < var_53_2 * manager.ui.mainCameraCom_.aspect / var_53_1.sprite.bounds.size.x and var_53_2 * manager.ui.mainCameraCom_.aspect / var_53_1.sprite.bounds.size.x or var_53_2 / var_53_1.sprite.bounds.size.y, var_53_2 / var_53_1.sprite.bounds.size.y < var_53_2 * manager.ui.mainCameraCom_.aspect / var_53_1.sprite.bounds.size.x and var_53_2 * manager.ui.mainCameraCom_.aspect / var_53_1.sprite.bounds.size.x or var_53_2 / var_53_1.sprite.bounds.size.y, 0)
				end

				for iter_53_0, iter_53_1 in pairs(arg_50_1.bgs_) do
					if iter_53_0 ~= "J27i" then
						iter_53_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_53_3 = 0

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_3 + arg_53_0 then
				arg_50_1.allBtn_.enabled = false
			end

			if arg_50_1.time_ >= var_53_3 + 0.3 and arg_50_1.time_ < var_53_3 + 0.3 + arg_53_0 then
				arg_50_1.allBtn_.enabled = true
			end

			if 1.2 < arg_50_1.time_ and arg_50_1.time_ <= 1.2 + arg_53_0 then
				local var_53_4 = arg_50_1.var_.effect43439

				if not arg_50_1.var_.effect43439 then
					var_53_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_monitor"), manager.ui.mainCamera.transform)
					var_53_4.name = "43439"
					arg_50_1.var_.effect43439 = var_53_4
				else
					var_53_4.transform:SetParent(var_53_9002)
				end

				var_53_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_53_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.2 < arg_50_1.time_ and arg_50_1.time_ <= 1.2 + arg_53_0 then
				local var_53_6 = arg_50_1.var_.effect4349

				if not arg_50_1.var_.effect4349 then
					var_53_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_vignetting"), manager.ui.mainCamera.transform)
					var_53_6.name = "4349"
					arg_50_1.var_.effect4349 = var_53_6
				else
					var_53_6.transform:SetParent(var_53_9001)
				end

				var_53_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_53_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				local var_53_8 = arg_50_1.var_.effect411229

				if not arg_50_1.var_.effect411229 then
					var_53_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_53_8.name = "411229"
					arg_50_1.var_.effect411229 = var_53_8
				else
					var_53_8.transform:SetParent(var_53_9000)
				end

				var_53_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_53_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_53_8.transform.localScale = Vector3.New(var_53_8.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_53_8.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_53_8.transform.localScale.z)
			end

			if 1.53333333333333 < arg_50_1.time_ and arg_50_1.time_ <= 1.53333333333333 + arg_53_0 then
				if arg_50_1.var_.effect411229 then
					Object.Destroy(arg_50_1.var_.effect411229)

					arg_50_1.var_.effect411229 = nil
				end
			end

			local var_53_11 = 1

			if 1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_11 + arg_53_0 then
				arg_50_1.allBtn_.enabled = false
			end

			if arg_50_1.time_ >= var_53_11 + 1.26666666666667 and arg_50_1.time_ < var_53_11 + 1.26666666666667 + arg_53_0 then
				arg_50_1.allBtn_.enabled = true
			end

			if 1.2 < arg_50_1.time_ and arg_50_1.time_ <= 1.2 + arg_53_0 then
				arg_50_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if 0.1 < arg_50_1.time_ and arg_50_1.time_ <= 0.1 + arg_53_0 then
				arg_50_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if arg_50_1.frameCnt_ <= 1 then
				arg_50_1.dialog_:SetActive(false)
			end

			local var_53_14 = 2.26666666666667
			local var_53_15 = 1.25

			if 2.26666666666667 < arg_50_1.time_ and arg_50_1.time_ <= var_53_14 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0

				arg_50_1.dialog_:SetActive(true)

				arg_50_1.dialogCg_.alpha = 0

				local var_53_16 = LeanTween.value(arg_50_1.dialog_, 0, 1, 0.3)

				var_53_16:setOnUpdate(LuaHelper.FloatAction(function(arg_54_0)
					arg_50_1.dialogCg_.alpha = arg_54_0
				end))
				var_53_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_50_1.dialog_)
					var_53_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_50_1.duration_ = arg_50_1.duration_ + 0.3

				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_17 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(324161011).content)

				arg_50_1.text_.text = var_53_17

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_19 = 50 <= 0 and var_53_15 or var_53_15 * (utf8.len(var_53_17) / 50)

				if (50 <= 0 and var_53_15 or var_53_15 * (utf8.len(var_53_17) / 50)) > 0 and var_53_15 < var_53_19 then
					arg_50_1.talkMaxDuration = var_53_19
					var_53_14 = var_53_14 + 0.3

					if var_53_19 + var_53_14 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_19 + var_53_14
					end
				end

				arg_50_1.text_.text = var_53_17
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_20 = var_53_14 + 0.3
			local var_53_21 = math.max(var_53_15, arg_50_1.talkMaxDuration)

			if var_53_14 + 0.3 <= arg_50_1.time_ and arg_50_1.time_ < var_53_20 + var_53_21 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_20) / var_53_21

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_20 + var_53_21 and arg_50_1.time_ < var_53_20 + var_53_21 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play324161012 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 324161012
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play324161013(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 1.35

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_1 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(324161012).content)

				arg_56_1.text_.text = var_59_1

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_3 = 54 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 54)

				if (54 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 54)) > 0 and var_59_0 < var_59_3 then
					arg_56_1.talkMaxDuration = var_59_3

					if var_59_3 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_3 + 0
					end
				end

				arg_56_1.text_.text = var_59_1
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_4 = math.max(var_59_0, arg_56_1.talkMaxDuration)

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - 0) / var_59_4

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play324161013 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 324161013
		arg_60_1.duration_ = 2.7

		local var_60_0 = {
			zh = 1.966,
			ja = 2.7
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play324161014(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1054ui_story"]) and arg_60_1.var_.characterEffect1054ui_story == nil then
				arg_60_1.var_.characterEffect1054ui_story = arg_60_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1054ui_story"]) then
				if arg_60_1.var_.characterEffect1054ui_story and not isNil(arg_60_1.actors_["1054ui_story"]) then
					arg_60_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1054ui_story"]) and arg_60_1.var_.characterEffect1054ui_story then
				arg_60_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_63_2 = 0
			local var_63_3 = 0.225

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_2 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_4 = arg_60_1:GetWordFromCfg(324161013)
				local var_63_5 = arg_60_1:FormatText(var_63_4.content)

				arg_60_1.text_.text = var_63_5

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_7 = 9 <= 0 and var_63_3 or var_63_3 * (utf8.len(var_63_5) / 9)

				if (9 <= 0 and var_63_3 or var_63_3 * (utf8.len(var_63_5) / 9)) > 0 and var_63_3 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_2 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_2
					end
				end

				arg_60_1.text_.text = var_63_5
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161013", "story_v_out_324161.awb") ~= 0 then
					local var_63_8 = manager.audio:GetVoiceLength("story_v_out_324161", "324161013", "story_v_out_324161.awb") / 1000

					if var_63_8 + var_63_2 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_2
					end

					if var_63_4.prefab_name ~= "" and arg_60_1.actors_[var_63_4.prefab_name] ~= nil then
						local var_63_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_4.prefab_name].transform, "story_v_out_324161", "324161013", "story_v_out_324161.awb")

						arg_60_1:RecordAudio("324161013", var_63_9)
						arg_60_1:RecordAudio("324161013", var_63_9)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_324161", "324161013", "story_v_out_324161.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_324161", "324161013", "story_v_out_324161.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_10 = math.max(var_63_3, arg_60_1.talkMaxDuration)

			if var_63_2 <= arg_60_1.time_ and arg_60_1.time_ < var_63_2 + var_63_10 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_2) / var_63_10

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_2 + var_63_10 and arg_60_1.time_ < var_63_2 + var_63_10 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play324161014 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 324161014
		arg_64_1.duration_ = 5.87

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play324161015(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_9000

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1054ui_story"]) and arg_64_1.var_.characterEffect1054ui_story == nil then
				arg_64_1.var_.characterEffect1054ui_story = arg_64_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1054ui_story"]) then
				if arg_64_1.var_.characterEffect1054ui_story and not isNil(arg_64_1.actors_["1054ui_story"]) then
					arg_64_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_0)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1054ui_story"]) and arg_64_1.var_.characterEffect1054ui_story then
				arg_64_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_64_1.time_ and arg_64_1.time_ <= 0.1 + arg_67_0 then
				arg_64_1:AudioAction("play", "effect", "se_story_140", "se_story_140_explosion01", "")
			end

			if 0.1 < arg_64_1.time_ and arg_64_1.time_ <= 0.1 + arg_67_0 then
				local var_67_2 = arg_64_1.var_.effect43243

				if not arg_64_1.var_.effect43243 then
					var_67_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_67_2.name = "43243"
					arg_64_1.var_.effect43243 = var_67_2
				else
					var_67_2.transform:SetParent(var_67_9000)
				end

				var_67_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_67_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.26666666666667 < arg_64_1.time_ and arg_64_1.time_ <= 1.26666666666667 + arg_67_0 then
				if arg_64_1.var_.effect43243 then
					Object.Destroy(arg_64_1.var_.effect43243)

					arg_64_1.var_.effect43243 = nil
				end
			end

			local var_67_5 = 0

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 then
				arg_64_1.allBtn_.enabled = false
			end

			if arg_64_1.time_ >= var_67_5 + 1.36666666666667 and arg_64_1.time_ < var_67_5 + 1.36666666666667 + arg_67_0 then
				arg_64_1.allBtn_.enabled = true
			end

			local var_67_6 = 0.866666666666667
			local var_67_7 = 1.575

			if 0.866666666666667 < arg_64_1.time_ and arg_64_1.time_ <= var_67_6 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_8 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(324161014).content)

				arg_64_1.text_.text = var_67_8

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_10 = 63 <= 0 and var_67_7 or var_67_7 * (utf8.len(var_67_8) / 63)

				if (63 <= 0 and var_67_7 or var_67_7 * (utf8.len(var_67_8) / 63)) > 0 and var_67_7 < var_67_10 then
					arg_64_1.talkMaxDuration = var_67_10

					if var_67_10 + var_67_6 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_10 + var_67_6
					end
				end

				arg_64_1.text_.text = var_67_8
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_11 = math.max(var_67_7, arg_64_1.talkMaxDuration)

			if var_67_6 <= arg_64_1.time_ and arg_64_1.time_ < var_67_6 + var_67_11 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_6) / var_67_11

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_6 + var_67_11 and arg_64_1.time_ < var_67_6 + var_67_11 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play324161015 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 324161015
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play324161016(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 1.05

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_1 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(324161015).content)

				arg_68_1.text_.text = var_71_1

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_3 = 42 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 42)

				if (42 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 42)) > 0 and var_71_0 < var_71_3 then
					arg_68_1.talkMaxDuration = var_71_3

					if var_71_3 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_3 + 0
					end
				end

				arg_68_1.text_.text = var_71_1
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_4 = math.max(var_71_0, arg_68_1.talkMaxDuration)

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - 0) / var_71_4

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play324161016 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 324161016
		arg_72_1.duration_ = 5.23

		local var_72_0 = {
			zh = 4.59933333333333,
			ja = 5.23333333333333
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play324161017(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 1.1 < arg_72_1.time_ and arg_72_1.time_ <= 1.1 + arg_75_0 then
				local var_75_0 = arg_72_1.bgs_.ST2008

				arg_72_1.bgs_.ST2008.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_75_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_75_1 = var_75_0:GetComponent("SpriteRenderer")

				if var_75_1 and var_75_1.sprite then
					local var_75_2 = 2 * (var_75_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_75_0.transform.localScale = Vector3.New(var_75_2 / var_75_1.sprite.bounds.size.y < var_75_2 * manager.ui.mainCameraCom_.aspect / var_75_1.sprite.bounds.size.x and var_75_2 * manager.ui.mainCameraCom_.aspect / var_75_1.sprite.bounds.size.x or var_75_2 / var_75_1.sprite.bounds.size.y, var_75_2 / var_75_1.sprite.bounds.size.y < var_75_2 * manager.ui.mainCameraCom_.aspect / var_75_1.sprite.bounds.size.x and var_75_2 * manager.ui.mainCameraCom_.aspect / var_75_1.sprite.bounds.size.x or var_75_2 / var_75_1.sprite.bounds.size.y, 0)
				end

				for iter_75_0, iter_75_1 in pairs(arg_72_1.bgs_) do
					if iter_75_0 ~= "ST2008" then
						iter_75_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_75_3 = arg_72_1.actors_["1054ui_story"].transform

			if 2.66666666666667 < arg_72_1.time_ and arg_72_1.time_ <= 2.66666666666667 + arg_75_0 then
				arg_72_1.var_.moveOldPos1054ui_story = var_75_3.localPosition

				local var_75_4 = GameObjectTools.GetOrAddComponent(var_75_3.gameObject, typeof(DynamicBoneHelper))

				if var_75_4 then
					var_75_4:EnableDynamicBone(false)
				end
			end

			local var_75_5 = 0.001

			if 2.66666666666667 <= arg_72_1.time_ and arg_72_1.time_ < 2.66666666666667 + var_75_5 then
				var_75_3.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_72_1.time_ - 2.66666666666667) / var_75_5)
				var_75_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_3.position).x, (manager.ui.mainCamera.transform.position - var_75_3.position).y, (manager.ui.mainCamera.transform.position - var_75_3.position).z)
				var_75_3.localEulerAngles.z = 0
				var_75_3.localEulerAngles.x = 0
				var_75_3.localEulerAngles = var_75_3.localEulerAngles
			end

			if arg_72_1.time_ >= 2.66666666666667 + var_75_5 and arg_72_1.time_ < 2.66666666666667 + var_75_5 + arg_75_0 then
				var_75_3.localPosition = Vector3.New(0, -0.985, -6)
				var_75_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_3.position).x, (manager.ui.mainCamera.transform.position - var_75_3.position).y, (manager.ui.mainCamera.transform.position - var_75_3.position).z)
				var_75_3.localEulerAngles.z = 0
				var_75_3.localEulerAngles.x = 0
				var_75_3.localEulerAngles = var_75_3.localEulerAngles

				local var_75_6 = GameObjectTools.GetOrAddComponent(var_75_3.gameObject, typeof(DynamicBoneHelper))

				if var_75_6 then
					var_75_6:EnableDynamicBone(true)
				end
			end

			local var_75_7 = arg_72_1.actors_["1054ui_story"]

			if 2.56666666666667 < arg_72_1.time_ and arg_72_1.time_ <= 2.56666666666667 + arg_75_0 and not isNil(var_75_7) and arg_72_1.var_.characterEffect1054ui_story == nil then
				arg_72_1.var_.characterEffect1054ui_story = var_75_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_8 = 0.200000002980232

			if 2.56666666666667 <= arg_72_1.time_ and arg_72_1.time_ < 2.56666666666667 + var_75_8 and not isNil(var_75_7) then
				if arg_72_1.var_.characterEffect1054ui_story and not isNil(var_75_7) then
					arg_72_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 2.56666666666667 + var_75_8 and arg_72_1.time_ < 2.56666666666667 + var_75_8 + arg_75_0 and not isNil(var_75_7) and arg_72_1.var_.characterEffect1054ui_story then
				arg_72_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 2.566666666666 < arg_72_1.time_ and arg_72_1.time_ <= 2.566666666666 + arg_75_0 then
				arg_72_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 2.56666666666667 < arg_72_1.time_ and arg_72_1.time_ <= 2.56666666666667 + arg_75_0 then
				arg_72_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			if 1.1 < arg_72_1.time_ and arg_72_1.time_ <= 1.1 + arg_75_0 then
				if arg_72_1.var_.effect43439 then
					Object.Destroy(arg_72_1.var_.effect43439)

					arg_72_1.var_.effect43439 = nil
				end
			end

			if 1.1 < arg_72_1.time_ and arg_72_1.time_ <= 1.1 + arg_75_0 then
				if arg_72_1.var_.effect4349 then
					Object.Destroy(arg_72_1.var_.effect4349)

					arg_72_1.var_.effect4349 = nil
				end
			end

			if 0.6 < arg_72_1.time_ and arg_72_1.time_ <= 0.6 + arg_75_0 then
				if arg_72_1.var_.effect411229 then
					Object.Destroy(arg_72_1.var_.effect411229)

					arg_72_1.var_.effect411229 = nil
				end
			end

			if 2.83333333333333 < arg_72_1.time_ and arg_72_1.time_ <= 2.83333333333333 + arg_75_0 then
				if arg_72_1.var_.effect411229 then
					Object.Destroy(arg_72_1.var_.effect411229)

					arg_72_1.var_.effect411229 = nil
				end
			end

			local var_75_14 = 1.3

			if 1.3 < arg_72_1.time_ and arg_72_1.time_ <= var_75_14 + arg_75_0 then
				arg_72_1.allBtn_.enabled = false
			end

			if arg_72_1.time_ >= var_75_14 + 1.26666666666667 and arg_72_1.time_ < var_75_14 + 1.26666666666667 + arg_75_0 then
				arg_72_1.allBtn_.enabled = true
			end

			local var_75_15 = 0

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_15 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_16 = 1.1

			if var_75_15 <= arg_72_1.time_ and arg_72_1.time_ < var_75_15 + var_75_16 then
				local var_75_17 = Color.New(0, 0, 0)

				var_75_17.a = Mathf.Lerp(0, 1, (arg_72_1.time_ - var_75_15) / var_75_16)
				arg_72_1.mask_.color = var_75_17
			end

			if arg_72_1.time_ >= var_75_15 + var_75_16 and arg_72_1.time_ < var_75_15 + var_75_16 + arg_75_0 then
				local var_75_18 = Color.New(0, 0, 0)

				var_75_18.a = 1
				arg_72_1.mask_.color = var_75_18
			end

			local var_75_19 = 1.1

			if 1.1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_19 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_20 = 1.1

			if var_75_19 <= arg_72_1.time_ and arg_72_1.time_ < var_75_19 + var_75_20 then
				local var_75_21 = Color.New(0, 0, 0)

				var_75_21.a = Mathf.Lerp(1, 0, (arg_72_1.time_ - var_75_19) / var_75_20)
				arg_72_1.mask_.color = var_75_21
			end

			if arg_72_1.time_ >= var_75_19 + var_75_20 and arg_72_1.time_ < var_75_19 + var_75_20 + arg_75_0 then
				local var_75_22 = Color.New(0, 0, 0)

				arg_72_1.mask_.enabled = false
				var_75_22.a = 0
				arg_72_1.mask_.color = var_75_22
			end

			if 1.2 < arg_72_1.time_ and arg_72_1.time_ <= 1.2 + arg_75_0 then
				arg_72_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if 0.1 < arg_72_1.time_ and arg_72_1.time_ <= 0.1 + arg_75_0 then
				arg_72_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if arg_72_1.frameCnt_ <= 1 then
				arg_72_1.dialog_:SetActive(false)
			end

			local var_75_25 = 2.83333333333333
			local var_75_26 = 0.175

			if 2.83333333333333 < arg_72_1.time_ and arg_72_1.time_ <= var_75_25 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0

				arg_72_1.dialog_:SetActive(true)

				arg_72_1.dialogCg_.alpha = 0

				local var_75_27 = LeanTween.value(arg_72_1.dialog_, 0, 1, 0.3)

				var_75_27:setOnUpdate(LuaHelper.FloatAction(function(arg_76_0)
					arg_72_1.dialogCg_.alpha = arg_76_0
				end))
				var_75_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_72_1.dialog_)
					var_75_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_72_1.duration_ = arg_72_1.duration_ + 0.3

				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_28 = arg_72_1:GetWordFromCfg(324161016)
				local var_75_29 = arg_72_1:FormatText(var_75_28.content)

				arg_72_1.text_.text = var_75_29

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_31 = 7 <= 0 and var_75_26 or var_75_26 * (utf8.len(var_75_29) / 7)

				if (7 <= 0 and var_75_26 or var_75_26 * (utf8.len(var_75_29) / 7)) > 0 and var_75_26 < var_75_31 then
					arg_72_1.talkMaxDuration = var_75_31
					var_75_25 = var_75_25 + 0.3

					if var_75_31 + var_75_25 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_31 + var_75_25
					end
				end

				arg_72_1.text_.text = var_75_29
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161016", "story_v_out_324161.awb") ~= 0 then
					local var_75_32 = manager.audio:GetVoiceLength("story_v_out_324161", "324161016", "story_v_out_324161.awb") / 1000

					if var_75_32 + var_75_25 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_32 + var_75_25
					end

					if var_75_28.prefab_name ~= "" and arg_72_1.actors_[var_75_28.prefab_name] ~= nil then
						local var_75_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_28.prefab_name].transform, "story_v_out_324161", "324161016", "story_v_out_324161.awb")

						arg_72_1:RecordAudio("324161016", var_75_33)
						arg_72_1:RecordAudio("324161016", var_75_33)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_324161", "324161016", "story_v_out_324161.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_324161", "324161016", "story_v_out_324161.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_34 = var_75_25 + 0.3
			local var_75_35 = math.max(var_75_26, arg_72_1.talkMaxDuration)

			if var_75_25 + 0.3 <= arg_72_1.time_ and arg_72_1.time_ < var_75_34 + var_75_35 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_34) / var_75_35

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_34 + var_75_35 and arg_72_1.time_ < var_75_34 + var_75_35 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play324161017 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 324161017
		arg_78_1.duration_ = 3.4

		local var_78_0 = {
			zh = 1.966,
			ja = 3.4
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play324161018(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0.2

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_1 = arg_78_1:GetWordFromCfg(324161017)
				local var_81_2 = arg_78_1:FormatText(var_81_1.content)

				arg_78_1.text_.text = var_81_2

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_4 = 8 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 8)

				if (8 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 8)) > 0 and var_81_0 < var_81_4 then
					arg_78_1.talkMaxDuration = var_81_4

					if var_81_4 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_4 + 0
					end
				end

				arg_78_1.text_.text = var_81_2
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161017", "story_v_out_324161.awb") ~= 0 then
					local var_81_5 = manager.audio:GetVoiceLength("story_v_out_324161", "324161017", "story_v_out_324161.awb") / 1000

					if var_81_5 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_5 + 0
					end

					if var_81_1.prefab_name ~= "" and arg_78_1.actors_[var_81_1.prefab_name] ~= nil then
						local var_81_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_1.prefab_name].transform, "story_v_out_324161", "324161017", "story_v_out_324161.awb")

						arg_78_1:RecordAudio("324161017", var_81_6)
						arg_78_1:RecordAudio("324161017", var_81_6)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_324161", "324161017", "story_v_out_324161.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_324161", "324161017", "story_v_out_324161.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_7 = math.max(var_81_0, arg_78_1.talkMaxDuration)

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_7 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - 0) / var_81_7

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= 0 + var_81_7 and arg_78_1.time_ < 0 + var_81_7 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play324161018 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 324161018
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play324161019(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos1054ui_story = arg_82_1.actors_["1054ui_story"].transform.localPosition

				local var_85_0 = GameObjectTools.GetOrAddComponent(arg_82_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_85_0 then
					var_85_0:EnableDynamicBone(false)
				end
			end

			local var_85_1 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_1 then
				arg_82_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_82_1.time_ - 0) / var_85_1)
				arg_82_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1054ui_story"].transform.position).z)
				arg_82_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["1054ui_story"].transform.localEulerAngles = arg_82_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_82_1.time_ >= 0 + var_85_1 and arg_82_1.time_ < 0 + var_85_1 + arg_85_0 then
				arg_82_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_82_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1054ui_story"].transform.position).z)
				arg_82_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["1054ui_story"].transform.localEulerAngles = arg_82_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_85_2 = GameObjectTools.GetOrAddComponent(arg_82_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_85_2 then
					var_85_2:EnableDynamicBone(true)
				end
			end

			local var_85_3 = arg_82_1.actors_["1054ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_3) and arg_82_1.var_.characterEffect1054ui_story == nil then
				arg_82_1.var_.characterEffect1054ui_story = var_85_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_4 = 0.200000002980232

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_4 and not isNil(var_85_3) then
				if arg_82_1.var_.characterEffect1054ui_story and not isNil(var_85_3) then
					arg_82_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_82_1.time_ - 0) / var_85_4)
				end
			end

			if arg_82_1.time_ >= 0 + var_85_4 and arg_82_1.time_ < 0 + var_85_4 + arg_85_0 and not isNil(var_85_3) and arg_82_1.var_.characterEffect1054ui_story then
				arg_82_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_85_5 = 0
			local var_85_6 = 1.125

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_5 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_7 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(324161018).content)

				arg_82_1.text_.text = var_85_7

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_9 = 45 <= 0 and var_85_6 or var_85_6 * (utf8.len(var_85_7) / 45)

				if (45 <= 0 and var_85_6 or var_85_6 * (utf8.len(var_85_7) / 45)) > 0 and var_85_6 < var_85_9 then
					arg_82_1.talkMaxDuration = var_85_9

					if var_85_9 + var_85_5 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_9 + var_85_5
					end
				end

				arg_82_1.text_.text = var_85_7
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_10 = math.max(var_85_6, arg_82_1.talkMaxDuration)

			if var_85_5 <= arg_82_1.time_ and arg_82_1.time_ < var_85_5 + var_85_10 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_5) / var_85_10

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_5 + var_85_10 and arg_82_1.time_ < var_85_5 + var_85_10 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play324161019 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 324161019
		arg_86_1.duration_ = 4.27

		local var_86_0 = {
			zh = 4.266,
			ja = 3.966
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play324161020(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1054ui_story = arg_86_1.actors_["1054ui_story"].transform.localPosition

				local var_89_0 = GameObjectTools.GetOrAddComponent(arg_86_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_89_0 then
					var_89_0:EnableDynamicBone(false)
				end
			end

			local var_89_1 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_1 then
				arg_86_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_86_1.time_ - 0) / var_89_1)
				arg_86_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1054ui_story"].transform.position).z)
				arg_86_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["1054ui_story"].transform.localEulerAngles = arg_86_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_1 and arg_86_1.time_ < 0 + var_89_1 + arg_89_0 then
				arg_86_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_86_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1054ui_story"].transform.position).z)
				arg_86_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["1054ui_story"].transform.localEulerAngles = arg_86_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_89_2 = GameObjectTools.GetOrAddComponent(arg_86_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_89_2 then
					var_89_2:EnableDynamicBone(true)
				end
			end

			local var_89_3 = arg_86_1.actors_["1054ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_3) and arg_86_1.var_.characterEffect1054ui_story == nil then
				arg_86_1.var_.characterEffect1054ui_story = var_89_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_4 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_4 and not isNil(var_89_3) then
				if arg_86_1.var_.characterEffect1054ui_story and not isNil(var_89_3) then
					arg_86_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_4 and arg_86_1.time_ < 0 + var_89_4 + arg_89_0 and not isNil(var_89_3) and arg_86_1.var_.characterEffect1054ui_story then
				arg_86_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_89_6 = 0
			local var_89_7 = 0.45

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_6 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_8 = arg_86_1:GetWordFromCfg(324161019)
				local var_89_9 = arg_86_1:FormatText(var_89_8.content)

				arg_86_1.text_.text = var_89_9

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_11 = 18 <= 0 and var_89_7 or var_89_7 * (utf8.len(var_89_9) / 18)

				if (18 <= 0 and var_89_7 or var_89_7 * (utf8.len(var_89_9) / 18)) > 0 and var_89_7 < var_89_11 then
					arg_86_1.talkMaxDuration = var_89_11

					if var_89_11 + var_89_6 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_11 + var_89_6
					end
				end

				arg_86_1.text_.text = var_89_9
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161019", "story_v_out_324161.awb") ~= 0 then
					local var_89_12 = manager.audio:GetVoiceLength("story_v_out_324161", "324161019", "story_v_out_324161.awb") / 1000

					if var_89_12 + var_89_6 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_12 + var_89_6
					end

					if var_89_8.prefab_name ~= "" and arg_86_1.actors_[var_89_8.prefab_name] ~= nil then
						local var_89_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_8.prefab_name].transform, "story_v_out_324161", "324161019", "story_v_out_324161.awb")

						arg_86_1:RecordAudio("324161019", var_89_13)
						arg_86_1:RecordAudio("324161019", var_89_13)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_324161", "324161019", "story_v_out_324161.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_324161", "324161019", "story_v_out_324161.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_14 = math.max(var_89_7, arg_86_1.talkMaxDuration)

			if var_89_6 <= arg_86_1.time_ and arg_86_1.time_ < var_89_6 + var_89_14 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_6) / var_89_14

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_6 + var_89_14 and arg_86_1.time_ < var_89_6 + var_89_14 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play324161020 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 324161020
		arg_90_1.duration_ = 5.63

		local var_90_0 = {
			zh = 5.633,
			ja = 3.833
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play324161021(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0.625

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_1 = arg_90_1:GetWordFromCfg(324161020)
				local var_93_2 = arg_90_1:FormatText(var_93_1.content)

				arg_90_1.text_.text = var_93_2

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 25 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 25)

				if (25 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 25)) > 0 and var_93_0 < var_93_4 then
					arg_90_1.talkMaxDuration = var_93_4

					if var_93_4 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_4 + 0
					end
				end

				arg_90_1.text_.text = var_93_2
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161020", "story_v_out_324161.awb") ~= 0 then
					local var_93_5 = manager.audio:GetVoiceLength("story_v_out_324161", "324161020", "story_v_out_324161.awb") / 1000

					if var_93_5 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + 0
					end

					if var_93_1.prefab_name ~= "" and arg_90_1.actors_[var_93_1.prefab_name] ~= nil then
						local var_93_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_1.prefab_name].transform, "story_v_out_324161", "324161020", "story_v_out_324161.awb")

						arg_90_1:RecordAudio("324161020", var_93_6)
						arg_90_1:RecordAudio("324161020", var_93_6)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_324161", "324161020", "story_v_out_324161.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_324161", "324161020", "story_v_out_324161.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_7 and arg_90_1.time_ < 0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play324161021 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 324161021
		arg_94_1.duration_ = 7.37

		local var_94_0 = {
			zh = 5.766,
			ja = 7.366
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play324161022(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0.7

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_1 = arg_94_1:GetWordFromCfg(324161021)
				local var_97_2 = arg_94_1:FormatText(var_97_1.content)

				arg_94_1.text_.text = var_97_2

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 28 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 28)

				if (28 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 28)) > 0 and var_97_0 < var_97_4 then
					arg_94_1.talkMaxDuration = var_97_4

					if var_97_4 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_4 + 0
					end
				end

				arg_94_1.text_.text = var_97_2
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161021", "story_v_out_324161.awb") ~= 0 then
					local var_97_5 = manager.audio:GetVoiceLength("story_v_out_324161", "324161021", "story_v_out_324161.awb") / 1000

					if var_97_5 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_5 + 0
					end

					if var_97_1.prefab_name ~= "" and arg_94_1.actors_[var_97_1.prefab_name] ~= nil then
						local var_97_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_1.prefab_name].transform, "story_v_out_324161", "324161021", "story_v_out_324161.awb")

						arg_94_1:RecordAudio("324161021", var_97_6)
						arg_94_1:RecordAudio("324161021", var_97_6)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_324161", "324161021", "story_v_out_324161.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_324161", "324161021", "story_v_out_324161.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_7 = math.max(var_97_0, arg_94_1.talkMaxDuration)

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_7 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - 0) / var_97_7

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= 0 + var_97_7 and arg_94_1.time_ < 0 + var_97_7 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play324161022 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 324161022
		arg_98_1.duration_ = 2

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play324161023(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_2")
			end

			local var_101_0 = 0
			local var_101_1 = 0.05

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_2 = arg_98_1:GetWordFromCfg(324161022)
				local var_101_3 = arg_98_1:FormatText(var_101_2.content)

				arg_98_1.text_.text = var_101_3

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 2 <= 0 and var_101_1 or var_101_1 * (utf8.len(var_101_3) / 2)

				if (2 <= 0 and var_101_1 or var_101_1 * (utf8.len(var_101_3) / 2)) > 0 and var_101_1 < var_101_5 then
					arg_98_1.talkMaxDuration = var_101_5

					if var_101_5 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_3
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161022", "story_v_out_324161.awb") ~= 0 then
					local var_101_6 = manager.audio:GetVoiceLength("story_v_out_324161", "324161022", "story_v_out_324161.awb") / 1000

					if var_101_6 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_6 + var_101_0
					end

					if var_101_2.prefab_name ~= "" and arg_98_1.actors_[var_101_2.prefab_name] ~= nil then
						local var_101_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_2.prefab_name].transform, "story_v_out_324161", "324161022", "story_v_out_324161.awb")

						arg_98_1:RecordAudio("324161022", var_101_7)
						arg_98_1:RecordAudio("324161022", var_101_7)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_324161", "324161022", "story_v_out_324161.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_324161", "324161022", "story_v_out_324161.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_8 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_8 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_8

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_8 and arg_98_1.time_ < var_101_0 + var_101_8 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play324161023 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 324161023
		arg_102_1.duration_ = 2.5

		local var_102_0 = {
			zh = 2.233,
			ja = 2.5
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play324161024(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos1054ui_story = arg_102_1.actors_["1054ui_story"].transform.localPosition

				local var_105_0 = GameObjectTools.GetOrAddComponent(arg_102_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_105_0 then
					var_105_0:EnableDynamicBone(false)
				end
			end

			local var_105_1 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_1 then
				arg_102_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_102_1.time_ - 0) / var_105_1)
				arg_102_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1054ui_story"].transform.position).z)
				arg_102_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["1054ui_story"].transform.localEulerAngles = arg_102_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_1 and arg_102_1.time_ < 0 + var_105_1 + arg_105_0 then
				arg_102_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_102_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1054ui_story"].transform.position).z)
				arg_102_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["1054ui_story"].transform.localEulerAngles = arg_102_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_105_2 = GameObjectTools.GetOrAddComponent(arg_102_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_105_2 then
					var_105_2:EnableDynamicBone(true)
				end
			end

			local var_105_3 = "1037ui_story"

			if arg_102_1.actors_["1037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1037ui_story"))) then
				local var_105_4 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_102_1.stage_.transform)

				var_105_4.name = var_105_3
				var_105_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_102_1.actors_[var_105_3] = var_105_4

				local var_105_5 = var_105_4:GetComponentInChildren(typeof(CharacterEffect))

				var_105_5.enabled = true

				local var_105_6 = GameObjectTools.GetOrAddComponent(var_105_4, typeof(DynamicBoneHelper))

				if var_105_6 then
					var_105_6:EnableDynamicBone(false)
				end

				arg_102_1:ShowWeapon(var_105_5.transform, false)

				arg_102_1.var_[var_105_3 .. "Animator"] = var_105_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_102_1.var_[var_105_3 .. "Animator"].applyRootMotion = true
				arg_102_1.var_[var_105_3 .. "LipSync"] = var_105_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_105_7 = arg_102_1.actors_["1037ui_story"].transform

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos1037ui_story = var_105_7.localPosition
			end

			local var_105_8 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_8 then
				var_105_7.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_102_1.time_ - 0) / var_105_8)
				var_105_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_7.position).x, (manager.ui.mainCamera.transform.position - var_105_7.position).y, (manager.ui.mainCamera.transform.position - var_105_7.position).z)
				var_105_7.localEulerAngles.z = 0
				var_105_7.localEulerAngles.x = 0
				var_105_7.localEulerAngles = var_105_7.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_8 and arg_102_1.time_ < 0 + var_105_8 + arg_105_0 then
				var_105_7.localPosition = Vector3.New(0, 100, 0)
				var_105_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_7.position).x, (manager.ui.mainCamera.transform.position - var_105_7.position).y, (manager.ui.mainCamera.transform.position - var_105_7.position).z)
				var_105_7.localEulerAngles.z = 0
				var_105_7.localEulerAngles.x = 0
				var_105_7.localEulerAngles = var_105_7.localEulerAngles
			end

			local var_105_9 = arg_102_1.actors_["1037ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_9) and arg_102_1.var_.characterEffect1037ui_story == nil then
				arg_102_1.var_.characterEffect1037ui_story = var_105_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_10 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_10 and not isNil(var_105_9) then
				if arg_102_1.var_.characterEffect1037ui_story and not isNil(var_105_9) then
					arg_102_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_10 and arg_102_1.time_ < 0 + var_105_10 + arg_105_0 and not isNil(var_105_9) and arg_102_1.var_.characterEffect1037ui_story then
				arg_102_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_105_12 = arg_102_1.actors_["1054ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_12) and arg_102_1.var_.characterEffect1054ui_story == nil then
				arg_102_1.var_.characterEffect1054ui_story = var_105_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_13 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_13 and not isNil(var_105_12) then
				if arg_102_1.var_.characterEffect1054ui_story and not isNil(var_105_12) then
					arg_102_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_13)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_13 and arg_102_1.time_ < 0 + var_105_13 + arg_105_0 and not isNil(var_105_12) and arg_102_1.var_.characterEffect1054ui_story then
				arg_102_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_105_14 = "6148ui_story"

			if arg_102_1.actors_["6148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6148ui_story"))) then
				local var_105_15 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_102_1.stage_.transform)

				var_105_15.name = var_105_14
				var_105_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_102_1.actors_[var_105_14] = var_105_15

				local var_105_16 = var_105_15:GetComponentInChildren(typeof(CharacterEffect))

				var_105_16.enabled = true

				local var_105_17 = GameObjectTools.GetOrAddComponent(var_105_15, typeof(DynamicBoneHelper))

				if var_105_17 then
					var_105_17:EnableDynamicBone(false)
				end

				arg_102_1:ShowWeapon(var_105_16.transform, false)

				arg_102_1.var_[var_105_14 .. "Animator"] = var_105_16.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_102_1.var_[var_105_14 .. "Animator"].applyRootMotion = true
				arg_102_1.var_[var_105_14 .. "LipSync"] = var_105_16.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_105_18 = 0
			local var_105_19 = 0.25

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_18 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6148")

				arg_102_1.callingController_:SetSelectedState("calling")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_20 = arg_102_1:GetWordFromCfg(324161023)
				local var_105_21 = arg_102_1:FormatText(var_105_20.content)

				arg_102_1.text_.text = var_105_21

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_23 = 10 <= 0 and var_105_19 or var_105_19 * (utf8.len(var_105_21) / 10)

				if (10 <= 0 and var_105_19 or var_105_19 * (utf8.len(var_105_21) / 10)) > 0 and var_105_19 < var_105_23 then
					arg_102_1.talkMaxDuration = var_105_23

					if var_105_23 + var_105_18 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_23 + var_105_18
					end
				end

				arg_102_1.text_.text = var_105_21
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161023", "story_v_out_324161.awb") ~= 0 then
					local var_105_24 = manager.audio:GetVoiceLength("story_v_out_324161", "324161023", "story_v_out_324161.awb") / 1000

					if var_105_24 + var_105_18 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_24 + var_105_18
					end

					if var_105_20.prefab_name ~= "" and arg_102_1.actors_[var_105_20.prefab_name] ~= nil then
						local var_105_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_20.prefab_name].transform, "story_v_out_324161", "324161023", "story_v_out_324161.awb")

						arg_102_1:RecordAudio("324161023", var_105_25)
						arg_102_1:RecordAudio("324161023", var_105_25)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_324161", "324161023", "story_v_out_324161.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_324161", "324161023", "story_v_out_324161.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_26 = math.max(var_105_19, arg_102_1.talkMaxDuration)

			if var_105_18 <= arg_102_1.time_ and arg_102_1.time_ < var_105_18 + var_105_26 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_18) / var_105_26

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_18 + var_105_26 and arg_102_1.time_ < var_105_18 + var_105_26 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_102_1:InitPlayNodeList()
	end,
	Play324161024 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 324161024
		arg_106_1.duration_ = 1.8

		local var_106_0 = {
			zh = 1,
			ja = 1.8
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play324161025(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["1054ui_story"]) and arg_106_1.var_.characterEffect1054ui_story == nil then
				arg_106_1.var_.characterEffect1054ui_story = arg_106_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_0 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["1054ui_story"]) then
				if arg_106_1.var_.characterEffect1054ui_story and not isNil(arg_106_1.actors_["1054ui_story"]) then
					arg_106_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["1054ui_story"]) and arg_106_1.var_.characterEffect1054ui_story then
				arg_106_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_109_2 = arg_106_1.actors_["1037ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.characterEffect1037ui_story == nil then
				arg_106_1.var_.characterEffect1037ui_story = var_109_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_3 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_3 and not isNil(var_109_2) then
				if arg_106_1.var_.characterEffect1037ui_story and not isNil(var_109_2) then
					arg_106_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_3)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_3 and arg_106_1.time_ < 0 + var_109_3 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.characterEffect1037ui_story then
				arg_106_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_109_4 = 0
			local var_109_5 = 0.05

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_4 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_6 = arg_106_1:GetWordFromCfg(324161024)
				local var_109_7 = arg_106_1:FormatText(var_109_6.content)

				arg_106_1.text_.text = var_109_7

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_9 = 2 <= 0 and var_109_5 or var_109_5 * (utf8.len(var_109_7) / 2)

				if (2 <= 0 and var_109_5 or var_109_5 * (utf8.len(var_109_7) / 2)) > 0 and var_109_5 < var_109_9 then
					arg_106_1.talkMaxDuration = var_109_9

					if var_109_9 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_9 + var_109_4
					end
				end

				arg_106_1.text_.text = var_109_7
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161024", "story_v_out_324161.awb") ~= 0 then
					local var_109_10 = manager.audio:GetVoiceLength("story_v_out_324161", "324161024", "story_v_out_324161.awb") / 1000

					if var_109_10 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_10 + var_109_4
					end

					if var_109_6.prefab_name ~= "" and arg_106_1.actors_[var_109_6.prefab_name] ~= nil then
						local var_109_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_6.prefab_name].transform, "story_v_out_324161", "324161024", "story_v_out_324161.awb")

						arg_106_1:RecordAudio("324161024", var_109_11)
						arg_106_1:RecordAudio("324161024", var_109_11)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_324161", "324161024", "story_v_out_324161.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_324161", "324161024", "story_v_out_324161.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_12 = math.max(var_109_5, arg_106_1.talkMaxDuration)

			if var_109_4 <= arg_106_1.time_ and arg_106_1.time_ < var_109_4 + var_109_12 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_4) / var_109_12

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_4 + var_109_12 and arg_106_1.time_ < var_109_4 + var_109_12 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play324161025 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 324161025
		arg_110_1.duration_ = 4.33

		local var_110_0 = {
			zh = 4.333,
			ja = 3.766
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play324161026(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["1037ui_story"]) and arg_110_1.var_.characterEffect1037ui_story == nil then
				arg_110_1.var_.characterEffect1037ui_story = arg_110_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_0 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["1037ui_story"]) then
				if arg_110_1.var_.characterEffect1037ui_story and not isNil(arg_110_1.actors_["1037ui_story"]) then
					arg_110_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["1037ui_story"]) and arg_110_1.var_.characterEffect1037ui_story then
				arg_110_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_113_2 = arg_110_1.actors_["1054ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_2) and arg_110_1.var_.characterEffect1054ui_story == nil then
				arg_110_1.var_.characterEffect1054ui_story = var_113_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_3 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_3 and not isNil(var_113_2) then
				if arg_110_1.var_.characterEffect1054ui_story and not isNil(var_113_2) then
					arg_110_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_3)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_3 and arg_110_1.time_ < 0 + var_113_3 + arg_113_0 and not isNil(var_113_2) and arg_110_1.var_.characterEffect1054ui_story then
				arg_110_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_113_4 = 0
			local var_113_5 = 0.6

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6148")

				arg_110_1.callingController_:SetSelectedState("calling")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_6 = arg_110_1:GetWordFromCfg(324161025)
				local var_113_7 = arg_110_1:FormatText(var_113_6.content)

				arg_110_1.text_.text = var_113_7

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_9 = 24 <= 0 and var_113_5 or var_113_5 * (utf8.len(var_113_7) / 24)

				if (24 <= 0 and var_113_5 or var_113_5 * (utf8.len(var_113_7) / 24)) > 0 and var_113_5 < var_113_9 then
					arg_110_1.talkMaxDuration = var_113_9

					if var_113_9 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_9 + var_113_4
					end
				end

				arg_110_1.text_.text = var_113_7
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161025", "story_v_out_324161.awb") ~= 0 then
					local var_113_10 = manager.audio:GetVoiceLength("story_v_out_324161", "324161025", "story_v_out_324161.awb") / 1000

					if var_113_10 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_10 + var_113_4
					end

					if var_113_6.prefab_name ~= "" and arg_110_1.actors_[var_113_6.prefab_name] ~= nil then
						local var_113_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_6.prefab_name].transform, "story_v_out_324161", "324161025", "story_v_out_324161.awb")

						arg_110_1:RecordAudio("324161025", var_113_11)
						arg_110_1:RecordAudio("324161025", var_113_11)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_324161", "324161025", "story_v_out_324161.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_324161", "324161025", "story_v_out_324161.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_12 = math.max(var_113_5, arg_110_1.talkMaxDuration)

			if var_113_4 <= arg_110_1.time_ and arg_110_1.time_ < var_113_4 + var_113_12 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_4) / var_113_12

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_4 + var_113_12 and arg_110_1.time_ < var_113_4 + var_113_12 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play324161026 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 324161026
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play324161027(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos1054ui_story = arg_114_1.actors_["1054ui_story"].transform.localPosition

				local var_117_0 = GameObjectTools.GetOrAddComponent(arg_114_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_117_0 then
					var_117_0:EnableDynamicBone(false)
				end
			end

			local var_117_1 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_1 then
				arg_114_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_114_1.time_ - 0) / var_117_1)
				arg_114_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_114_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1054ui_story"].transform.position).z)
				arg_114_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_114_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_114_1.actors_["1054ui_story"].transform.localEulerAngles = arg_114_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_1 and arg_114_1.time_ < 0 + var_117_1 + arg_117_0 then
				arg_114_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_114_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_114_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1054ui_story"].transform.position).z)
				arg_114_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_114_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_114_1.actors_["1054ui_story"].transform.localEulerAngles = arg_114_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_117_2 = GameObjectTools.GetOrAddComponent(arg_114_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_117_2 then
					var_117_2:EnableDynamicBone(true)
				end
			end

			local var_117_3 = arg_114_1.actors_["1037ui_story"].transform

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos1037ui_story = var_117_3.localPosition
			end

			local var_117_4 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_4 then
				var_117_3.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_114_1.time_ - 0) / var_117_4)
				var_117_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_3.position).x, (manager.ui.mainCamera.transform.position - var_117_3.position).y, (manager.ui.mainCamera.transform.position - var_117_3.position).z)
				var_117_3.localEulerAngles.z = 0
				var_117_3.localEulerAngles.x = 0
				var_117_3.localEulerAngles = var_117_3.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_4 and arg_114_1.time_ < 0 + var_117_4 + arg_117_0 then
				var_117_3.localPosition = Vector3.New(0, 100, 0)
				var_117_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_3.position).x, (manager.ui.mainCamera.transform.position - var_117_3.position).y, (manager.ui.mainCamera.transform.position - var_117_3.position).z)
				var_117_3.localEulerAngles.z = 0
				var_117_3.localEulerAngles.x = 0
				var_117_3.localEulerAngles = var_117_3.localEulerAngles
			end

			local var_117_5 = arg_114_1.actors_["1037ui_story"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_5) and arg_114_1.var_.characterEffect1037ui_story == nil then
				arg_114_1.var_.characterEffect1037ui_story = var_117_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_6 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_6 and not isNil(var_117_5) then
				if arg_114_1.var_.characterEffect1037ui_story and not isNil(var_117_5) then
					arg_114_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_114_1.time_ - 0) / var_117_6)
				end
			end

			if arg_114_1.time_ >= 0 + var_117_6 and arg_114_1.time_ < 0 + var_117_6 + arg_117_0 and not isNil(var_117_5) and arg_114_1.var_.characterEffect1037ui_story then
				arg_114_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_117_7 = 0
			local var_117_8 = 0.775

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_7 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_9 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(324161026).content)

				arg_114_1.text_.text = var_117_9

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_11 = 31 <= 0 and var_117_8 or var_117_8 * (utf8.len(var_117_9) / 31)

				if (31 <= 0 and var_117_8 or var_117_8 * (utf8.len(var_117_9) / 31)) > 0 and var_117_8 < var_117_11 then
					arg_114_1.talkMaxDuration = var_117_11

					if var_117_11 + var_117_7 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_11 + var_117_7
					end
				end

				arg_114_1.text_.text = var_117_9
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_12 = math.max(var_117_8, arg_114_1.talkMaxDuration)

			if var_117_7 <= arg_114_1.time_ and arg_114_1.time_ < var_117_7 + var_117_12 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_7) / var_117_12

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_7 + var_117_12 and arg_114_1.time_ < var_117_7 + var_117_12 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_114_1:InitPlayNodeList()
	end,
	Play324161027 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 324161027
		arg_118_1.duration_ = 7.37

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play324161028(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 1.36666666666667 < arg_118_1.time_ and arg_118_1.time_ <= 1.36666666666667 + arg_121_0 then
				local var_121_0 = arg_118_1.bgs_.J27i

				arg_118_1.bgs_.J27i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_121_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_121_1 = var_121_0:GetComponent("SpriteRenderer")

				if var_121_1 and var_121_1.sprite then
					local var_121_2 = 2 * (var_121_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_121_0.transform.localScale = Vector3.New(var_121_2 / var_121_1.sprite.bounds.size.y < var_121_2 * manager.ui.mainCameraCom_.aspect / var_121_1.sprite.bounds.size.x and var_121_2 * manager.ui.mainCameraCom_.aspect / var_121_1.sprite.bounds.size.x or var_121_2 / var_121_1.sprite.bounds.size.y, var_121_2 / var_121_1.sprite.bounds.size.y < var_121_2 * manager.ui.mainCameraCom_.aspect / var_121_1.sprite.bounds.size.x and var_121_2 * manager.ui.mainCameraCom_.aspect / var_121_1.sprite.bounds.size.x or var_121_2 / var_121_1.sprite.bounds.size.y, 0)
				end

				for iter_121_0, iter_121_1 in pairs(arg_118_1.bgs_) do
					if iter_121_0 ~= "J27i" then
						iter_121_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_121_3 = 0

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_3 + arg_121_0 then
				arg_118_1.allBtn_.enabled = false
			end

			if arg_118_1.time_ >= var_121_3 + 0.3 and arg_118_1.time_ < var_121_3 + 0.3 + arg_121_0 then
				arg_118_1.allBtn_.enabled = true
			end

			local var_121_4 = 0

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_4 + arg_121_0 then
				arg_118_1.mask_.enabled = true
				arg_118_1.mask_.raycastTarget = true

				arg_118_1:SetGaussion(false)
			end

			local var_121_5 = 1.36666666666667

			if var_121_4 <= arg_118_1.time_ and arg_118_1.time_ < var_121_4 + var_121_5 then
				local var_121_6 = Color.New(0, 0, 0)

				var_121_6.a = Mathf.Lerp(0, 1, (arg_118_1.time_ - var_121_4) / var_121_5)
				arg_118_1.mask_.color = var_121_6
			end

			if arg_118_1.time_ >= var_121_4 + var_121_5 and arg_118_1.time_ < var_121_4 + var_121_5 + arg_121_0 then
				local var_121_7 = Color.New(0, 0, 0)

				var_121_7.a = 1
				arg_118_1.mask_.color = var_121_7
			end

			local var_121_8 = 1.36666666666667

			if 1.36666666666667 < arg_118_1.time_ and arg_118_1.time_ <= var_121_8 + arg_121_0 then
				arg_118_1.mask_.enabled = true
				arg_118_1.mask_.raycastTarget = true

				arg_118_1:SetGaussion(false)
			end

			local var_121_9 = 1.26666666666567

			if var_121_8 <= arg_118_1.time_ and arg_118_1.time_ < var_121_8 + var_121_9 then
				local var_121_10 = Color.New(0, 0, 0)

				var_121_10.a = Mathf.Lerp(1, 0, (arg_118_1.time_ - var_121_8) / var_121_9)
				arg_118_1.mask_.color = var_121_10
			end

			if arg_118_1.time_ >= var_121_8 + var_121_9 and arg_118_1.time_ < var_121_8 + var_121_9 + arg_121_0 then
				local var_121_11 = Color.New(0, 0, 0)

				arg_118_1.mask_.enabled = false
				var_121_11.a = 0
				arg_118_1.mask_.color = var_121_11
			end

			if 1.2 < arg_118_1.time_ and arg_118_1.time_ <= 1.2 + arg_121_0 then
				arg_118_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if 0.1 < arg_118_1.time_ and arg_118_1.time_ <= 0.1 + arg_121_0 then
				arg_118_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if arg_118_1.frameCnt_ <= 1 then
				arg_118_1.dialog_:SetActive(false)
			end

			local var_121_14 = 2.36666666666667
			local var_121_15 = 1.5

			if 2.36666666666667 < arg_118_1.time_ and arg_118_1.time_ <= var_121_14 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0

				arg_118_1.dialog_:SetActive(true)

				arg_118_1.dialogCg_.alpha = 0

				local var_121_16 = LeanTween.value(arg_118_1.dialog_, 0, 1, 0.3)

				var_121_16:setOnUpdate(LuaHelper.FloatAction(function(arg_122_0)
					arg_118_1.dialogCg_.alpha = arg_122_0
				end))
				var_121_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_118_1.dialog_)
					var_121_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_118_1.duration_ = arg_118_1.duration_ + 0.3

				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_17 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(324161027).content)

				arg_118_1.text_.text = var_121_17

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_19 = 60 <= 0 and var_121_15 or var_121_15 * (utf8.len(var_121_17) / 60)

				if (60 <= 0 and var_121_15 or var_121_15 * (utf8.len(var_121_17) / 60)) > 0 and var_121_15 < var_121_19 then
					arg_118_1.talkMaxDuration = var_121_19
					var_121_14 = var_121_14 + 0.3

					if var_121_19 + var_121_14 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_19 + var_121_14
					end
				end

				arg_118_1.text_.text = var_121_17
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_20 = var_121_14 + 0.3
			local var_121_21 = math.max(var_121_15, arg_118_1.talkMaxDuration)

			if var_121_14 + 0.3 <= arg_118_1.time_ and arg_118_1.time_ < var_121_20 + var_121_21 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_20) / var_121_21

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_20 + var_121_21 and arg_118_1.time_ < var_121_20 + var_121_21 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play324161028 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 324161028
		arg_124_1.duration_ = 2.97

		local var_124_0 = {
			zh = 2.966,
			ja = 2.4
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play324161029(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos1054ui_story = arg_124_1.actors_["1054ui_story"].transform.localPosition

				local var_127_0 = GameObjectTools.GetOrAddComponent(arg_124_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_127_0 then
					var_127_0:EnableDynamicBone(false)
				end
			end

			local var_127_1 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_1 then
				arg_124_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_124_1.time_ - 0) / var_127_1)
				arg_124_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1054ui_story"].transform.position).z)
				arg_124_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["1054ui_story"].transform.localEulerAngles = arg_124_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_1 and arg_124_1.time_ < 0 + var_127_1 + arg_127_0 then
				arg_124_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_124_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1054ui_story"].transform.position).z)
				arg_124_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["1054ui_story"].transform.localEulerAngles = arg_124_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_127_2 = GameObjectTools.GetOrAddComponent(arg_124_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_127_2 then
					var_127_2:EnableDynamicBone(true)
				end
			end

			local var_127_3 = arg_124_1.actors_["1054ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_3) and arg_124_1.var_.characterEffect1054ui_story == nil then
				arg_124_1.var_.characterEffect1054ui_story = var_127_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_4 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_4 and not isNil(var_127_3) then
				if arg_124_1.var_.characterEffect1054ui_story and not isNil(var_127_3) then
					arg_124_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_4 and arg_124_1.time_ < 0 + var_127_4 + arg_127_0 and not isNil(var_127_3) and arg_124_1.var_.characterEffect1054ui_story then
				arg_124_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action8_1")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_127_6 = 0
			local var_127_7 = 0.15

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_6 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_8 = arg_124_1:GetWordFromCfg(324161028)
				local var_127_9 = arg_124_1:FormatText(var_127_8.content)

				arg_124_1.text_.text = var_127_9

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_11 = 6 <= 0 and var_127_7 or var_127_7 * (utf8.len(var_127_9) / 6)

				if (6 <= 0 and var_127_7 or var_127_7 * (utf8.len(var_127_9) / 6)) > 0 and var_127_7 < var_127_11 then
					arg_124_1.talkMaxDuration = var_127_11

					if var_127_11 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_11 + var_127_6
					end
				end

				arg_124_1.text_.text = var_127_9
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161028", "story_v_out_324161.awb") ~= 0 then
					local var_127_12 = manager.audio:GetVoiceLength("story_v_out_324161", "324161028", "story_v_out_324161.awb") / 1000

					if var_127_12 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_12 + var_127_6
					end

					if var_127_8.prefab_name ~= "" and arg_124_1.actors_[var_127_8.prefab_name] ~= nil then
						local var_127_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_8.prefab_name].transform, "story_v_out_324161", "324161028", "story_v_out_324161.awb")

						arg_124_1:RecordAudio("324161028", var_127_13)
						arg_124_1:RecordAudio("324161028", var_127_13)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_324161", "324161028", "story_v_out_324161.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_324161", "324161028", "story_v_out_324161.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_14 = math.max(var_127_7, arg_124_1.talkMaxDuration)

			if var_127_6 <= arg_124_1.time_ and arg_124_1.time_ < var_127_6 + var_127_14 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_6) / var_127_14

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_6 + var_127_14 and arg_124_1.time_ < var_127_6 + var_127_14 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play324161029 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 324161029
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play324161030(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1054ui_story = arg_128_1.actors_["1054ui_story"].transform.localPosition

				local var_131_0 = GameObjectTools.GetOrAddComponent(arg_128_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_131_0 then
					var_131_0:EnableDynamicBone(false)
				end
			end

			local var_131_1 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_1 then
				arg_128_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_128_1.time_ - 0) / var_131_1)
				arg_128_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1054ui_story"].transform.position).z)
				arg_128_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1054ui_story"].transform.localEulerAngles = arg_128_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_1 and arg_128_1.time_ < 0 + var_131_1 + arg_131_0 then
				arg_128_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_128_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1054ui_story"].transform.position).z)
				arg_128_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1054ui_story"].transform.localEulerAngles = arg_128_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_131_2 = GameObjectTools.GetOrAddComponent(arg_128_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_131_2 then
					var_131_2:EnableDynamicBone(true)
				end
			end

			local var_131_3 = arg_128_1.actors_["1054ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_3) and arg_128_1.var_.characterEffect1054ui_story == nil then
				arg_128_1.var_.characterEffect1054ui_story = var_131_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_4 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_4 and not isNil(var_131_3) then
				if arg_128_1.var_.characterEffect1054ui_story and not isNil(var_131_3) then
					arg_128_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_4)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 and not isNil(var_131_3) and arg_128_1.var_.characterEffect1054ui_story then
				arg_128_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_131_5 = 0
			local var_131_6 = 0.8

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_7 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(324161029).content)

				arg_128_1.text_.text = var_131_7

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_9 = 32 <= 0 and var_131_6 or var_131_6 * (utf8.len(var_131_7) / 32)

				if (32 <= 0 and var_131_6 or var_131_6 * (utf8.len(var_131_7) / 32)) > 0 and var_131_6 < var_131_9 then
					arg_128_1.talkMaxDuration = var_131_9

					if var_131_9 + var_131_5 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_5
					end
				end

				arg_128_1.text_.text = var_131_7
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_10 = math.max(var_131_6, arg_128_1.talkMaxDuration)

			if var_131_5 <= arg_128_1.time_ and arg_128_1.time_ < var_131_5 + var_131_10 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_5) / var_131_10

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_5 + var_131_10 and arg_128_1.time_ < var_131_5 + var_131_10 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play324161030 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 324161030
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play324161031(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 1.35

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_1 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(324161030).content)

				arg_132_1.text_.text = var_135_1

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_3 = 54 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_1) / 54)

				if (54 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_1) / 54)) > 0 and var_135_0 < var_135_3 then
					arg_132_1.talkMaxDuration = var_135_3

					if var_135_3 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_3 + 0
					end
				end

				arg_132_1.text_.text = var_135_1
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_4 = math.max(var_135_0, arg_132_1.talkMaxDuration)

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_4 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - 0) / var_135_4

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= 0 + var_135_4 and arg_132_1.time_ < 0 + var_135_4 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play324161031 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 324161031
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play324161032(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 1.6

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_1 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(324161031).content)

				arg_136_1.text_.text = var_139_1

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_3 = 64 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_1) / 64)

				if (64 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_1) / 64)) > 0 and var_139_0 < var_139_3 then
					arg_136_1.talkMaxDuration = var_139_3

					if var_139_3 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_3 + 0
					end
				end

				arg_136_1.text_.text = var_139_1
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_4 = math.max(var_139_0, arg_136_1.talkMaxDuration)

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_4 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - 0) / var_139_4

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= 0 + var_139_4 and arg_136_1.time_ < 0 + var_139_4 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play324161032 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 324161032
		arg_140_1.duration_ = 2.5

		local var_140_0 = {
			zh = 2.4,
			ja = 2.5
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play324161033(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos6148ui_story = arg_140_1.actors_["6148ui_story"].transform.localPosition

				local var_143_0 = GameObjectTools.GetOrAddComponent(arg_140_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_143_0 then
					var_143_0:EnableDynamicBone(false)
				end
			end

			local var_143_1 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_1 then
				arg_140_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_140_1.time_ - 0) / var_143_1)
				arg_140_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["6148ui_story"].transform.position).z)
				arg_140_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["6148ui_story"].transform.localEulerAngles = arg_140_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_1 and arg_140_1.time_ < 0 + var_143_1 + arg_143_0 then
				arg_140_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_140_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["6148ui_story"].transform.position).z)
				arg_140_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["6148ui_story"].transform.localEulerAngles = arg_140_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_143_2 = GameObjectTools.GetOrAddComponent(arg_140_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_143_2 then
					var_143_2:EnableDynamicBone(true)
				end
			end

			local var_143_3 = arg_140_1.actors_["6148ui_story"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_3) and arg_140_1.var_.characterEffect6148ui_story == nil then
				arg_140_1.var_.characterEffect6148ui_story = var_143_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_4 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_4 and not isNil(var_143_3) then
				if arg_140_1.var_.characterEffect6148ui_story and not isNil(var_143_3) then
					arg_140_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_4 and arg_140_1.time_ < 0 + var_143_4 + arg_143_0 and not isNil(var_143_3) and arg_140_1.var_.characterEffect6148ui_story then
				arg_140_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_143_6 = 0
			local var_143_7 = 0.2

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_6 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_8 = arg_140_1:GetWordFromCfg(324161032)
				local var_143_9 = arg_140_1:FormatText(var_143_8.content)

				arg_140_1.text_.text = var_143_9

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_11 = 8 <= 0 and var_143_7 or var_143_7 * (utf8.len(var_143_9) / 8)

				if (8 <= 0 and var_143_7 or var_143_7 * (utf8.len(var_143_9) / 8)) > 0 and var_143_7 < var_143_11 then
					arg_140_1.talkMaxDuration = var_143_11

					if var_143_11 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_11 + var_143_6
					end
				end

				arg_140_1.text_.text = var_143_9
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161032", "story_v_out_324161.awb") ~= 0 then
					local var_143_12 = manager.audio:GetVoiceLength("story_v_out_324161", "324161032", "story_v_out_324161.awb") / 1000

					if var_143_12 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_12 + var_143_6
					end

					if var_143_8.prefab_name ~= "" and arg_140_1.actors_[var_143_8.prefab_name] ~= nil then
						local var_143_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_8.prefab_name].transform, "story_v_out_324161", "324161032", "story_v_out_324161.awb")

						arg_140_1:RecordAudio("324161032", var_143_13)
						arg_140_1:RecordAudio("324161032", var_143_13)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_324161", "324161032", "story_v_out_324161.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_324161", "324161032", "story_v_out_324161.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_14 = math.max(var_143_7, arg_140_1.talkMaxDuration)

			if var_143_6 <= arg_140_1.time_ and arg_140_1.time_ < var_143_6 + var_143_14 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_6) / var_143_14

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_6 + var_143_14 and arg_140_1.time_ < var_143_6 + var_143_14 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play324161033 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 324161033
		arg_144_1.duration_ = 3.3

		local var_144_0 = {
			zh = 2.166,
			ja = 3.3
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play324161034(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos1054ui_story = arg_144_1.actors_["1054ui_story"].transform.localPosition

				local var_147_0 = GameObjectTools.GetOrAddComponent(arg_144_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_147_0 then
					var_147_0:EnableDynamicBone(false)
				end
			end

			local var_147_1 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_1 then
				arg_144_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_144_1.time_ - 0) / var_147_1)
				arg_144_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_144_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1054ui_story"].transform.position).z)
				arg_144_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_144_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_144_1.actors_["1054ui_story"].transform.localEulerAngles = arg_144_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_144_1.time_ >= 0 + var_147_1 and arg_144_1.time_ < 0 + var_147_1 + arg_147_0 then
				arg_144_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_144_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_144_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1054ui_story"].transform.position).z)
				arg_144_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_144_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_144_1.actors_["1054ui_story"].transform.localEulerAngles = arg_144_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_147_2 = GameObjectTools.GetOrAddComponent(arg_144_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_147_2 then
					var_147_2:EnableDynamicBone(true)
				end
			end

			local var_147_3 = arg_144_1.actors_["1054ui_story"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_3) and arg_144_1.var_.characterEffect1054ui_story == nil then
				arg_144_1.var_.characterEffect1054ui_story = var_147_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_4 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_4 and not isNil(var_147_3) then
				if arg_144_1.var_.characterEffect1054ui_story and not isNil(var_147_3) then
					arg_144_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_4 and arg_144_1.time_ < 0 + var_147_4 + arg_147_0 and not isNil(var_147_3) and arg_144_1.var_.characterEffect1054ui_story then
				arg_144_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_147_6 = arg_144_1.actors_["6148ui_story"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_6) and arg_144_1.var_.characterEffect6148ui_story == nil then
				arg_144_1.var_.characterEffect6148ui_story = var_147_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_7 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_7 and not isNil(var_147_6) then
				if arg_144_1.var_.characterEffect6148ui_story and not isNil(var_147_6) then
					arg_144_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_144_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_144_1.time_ - 0) / var_147_7)
				end
			end

			if arg_144_1.time_ >= 0 + var_147_7 and arg_144_1.time_ < 0 + var_147_7 + arg_147_0 and not isNil(var_147_6) and arg_144_1.var_.characterEffect6148ui_story then
				arg_144_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_144_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action8_2")
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_147_8 = 0
			local var_147_9 = 0.25

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_8 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_10 = arg_144_1:GetWordFromCfg(324161033)
				local var_147_11 = arg_144_1:FormatText(var_147_10.content)

				arg_144_1.text_.text = var_147_11

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_13 = 10 <= 0 and var_147_9 or var_147_9 * (utf8.len(var_147_11) / 10)

				if (10 <= 0 and var_147_9 or var_147_9 * (utf8.len(var_147_11) / 10)) > 0 and var_147_9 < var_147_13 then
					arg_144_1.talkMaxDuration = var_147_13

					if var_147_13 + var_147_8 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_13 + var_147_8
					end
				end

				arg_144_1.text_.text = var_147_11
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161033", "story_v_out_324161.awb") ~= 0 then
					local var_147_14 = manager.audio:GetVoiceLength("story_v_out_324161", "324161033", "story_v_out_324161.awb") / 1000

					if var_147_14 + var_147_8 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_14 + var_147_8
					end

					if var_147_10.prefab_name ~= "" and arg_144_1.actors_[var_147_10.prefab_name] ~= nil then
						local var_147_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_10.prefab_name].transform, "story_v_out_324161", "324161033", "story_v_out_324161.awb")

						arg_144_1:RecordAudio("324161033", var_147_15)
						arg_144_1:RecordAudio("324161033", var_147_15)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_324161", "324161033", "story_v_out_324161.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_324161", "324161033", "story_v_out_324161.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_16 = math.max(var_147_9, arg_144_1.talkMaxDuration)

			if var_147_8 <= arg_144_1.time_ and arg_144_1.time_ < var_147_8 + var_147_16 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_8) / var_147_16

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_8 + var_147_16 and arg_144_1.time_ < var_147_8 + var_147_16 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play324161034 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 324161034
		arg_148_1.duration_ = 1.97

		local var_148_0 = {
			zh = 1.1,
			ja = 1.966
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play324161035(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["6148ui_story"]) and arg_148_1.var_.characterEffect6148ui_story == nil then
				arg_148_1.var_.characterEffect6148ui_story = arg_148_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_0 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["6148ui_story"]) then
				if arg_148_1.var_.characterEffect6148ui_story and not isNil(arg_148_1.actors_["6148ui_story"]) then
					arg_148_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["6148ui_story"]) and arg_148_1.var_.characterEffect6148ui_story then
				arg_148_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_151_2 = arg_148_1.actors_["1054ui_story"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_2) and arg_148_1.var_.characterEffect1054ui_story == nil then
				arg_148_1.var_.characterEffect1054ui_story = var_151_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_3 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_3 and not isNil(var_151_2) then
				if arg_148_1.var_.characterEffect1054ui_story and not isNil(var_151_2) then
					arg_148_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 0) / var_151_3)
				end
			end

			if arg_148_1.time_ >= 0 + var_151_3 and arg_148_1.time_ < 0 + var_151_3 + arg_151_0 and not isNil(var_151_2) and arg_148_1.var_.characterEffect1054ui_story then
				arg_148_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_151_4 = 0
			local var_151_5 = 0.075

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_4 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_6 = arg_148_1:GetWordFromCfg(324161034)
				local var_151_7 = arg_148_1:FormatText(var_151_6.content)

				arg_148_1.text_.text = var_151_7

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_9 = 3 <= 0 and var_151_5 or var_151_5 * (utf8.len(var_151_7) / 3)

				if (3 <= 0 and var_151_5 or var_151_5 * (utf8.len(var_151_7) / 3)) > 0 and var_151_5 < var_151_9 then
					arg_148_1.talkMaxDuration = var_151_9

					if var_151_9 + var_151_4 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_9 + var_151_4
					end
				end

				arg_148_1.text_.text = var_151_7
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161034", "story_v_out_324161.awb") ~= 0 then
					local var_151_10 = manager.audio:GetVoiceLength("story_v_out_324161", "324161034", "story_v_out_324161.awb") / 1000

					if var_151_10 + var_151_4 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_10 + var_151_4
					end

					if var_151_6.prefab_name ~= "" and arg_148_1.actors_[var_151_6.prefab_name] ~= nil then
						local var_151_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_6.prefab_name].transform, "story_v_out_324161", "324161034", "story_v_out_324161.awb")

						arg_148_1:RecordAudio("324161034", var_151_11)
						arg_148_1:RecordAudio("324161034", var_151_11)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_324161", "324161034", "story_v_out_324161.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_324161", "324161034", "story_v_out_324161.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_12 = math.max(var_151_5, arg_148_1.talkMaxDuration)

			if var_151_4 <= arg_148_1.time_ and arg_148_1.time_ < var_151_4 + var_151_12 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_4) / var_151_12

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_4 + var_151_12 and arg_148_1.time_ < var_151_4 + var_151_12 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play324161035 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 324161035
		arg_152_1.duration_ = 4.7

		local var_152_0 = {
			zh = 2.133,
			ja = 4.7
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
				arg_152_0:Play324161036(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["1054ui_story"]) and arg_152_1.var_.characterEffect1054ui_story == nil then
				arg_152_1.var_.characterEffect1054ui_story = arg_152_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_0 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["1054ui_story"]) then
				if arg_152_1.var_.characterEffect1054ui_story and not isNil(arg_152_1.actors_["1054ui_story"]) then
					arg_152_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["1054ui_story"]) and arg_152_1.var_.characterEffect1054ui_story then
				arg_152_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_155_2 = arg_152_1.actors_["6148ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_2) and arg_152_1.var_.characterEffect6148ui_story == nil then
				arg_152_1.var_.characterEffect6148ui_story = var_155_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_3 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_3 and not isNil(var_155_2) then
				if arg_152_1.var_.characterEffect6148ui_story and not isNil(var_155_2) then
					arg_152_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_152_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_152_1.time_ - 0) / var_155_3)
				end
			end

			if arg_152_1.time_ >= 0 + var_155_3 and arg_152_1.time_ < 0 + var_155_3 + arg_155_0 and not isNil(var_155_2) and arg_152_1.var_.characterEffect6148ui_story then
				arg_152_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_152_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_1")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_155_4 = 0
			local var_155_5 = 0.2

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_4 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_6 = arg_152_1:GetWordFromCfg(324161035)
				local var_155_7 = arg_152_1:FormatText(var_155_6.content)

				arg_152_1.text_.text = var_155_7

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_9 = 8 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 8)

				if (8 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 8)) > 0 and var_155_5 < var_155_9 then
					arg_152_1.talkMaxDuration = var_155_9

					if var_155_9 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_9 + var_155_4
					end
				end

				arg_152_1.text_.text = var_155_7
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161035", "story_v_out_324161.awb") ~= 0 then
					local var_155_10 = manager.audio:GetVoiceLength("story_v_out_324161", "324161035", "story_v_out_324161.awb") / 1000

					if var_155_10 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_4
					end

					if var_155_6.prefab_name ~= "" and arg_152_1.actors_[var_155_6.prefab_name] ~= nil then
						local var_155_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_6.prefab_name].transform, "story_v_out_324161", "324161035", "story_v_out_324161.awb")

						arg_152_1:RecordAudio("324161035", var_155_11)
						arg_152_1:RecordAudio("324161035", var_155_11)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_324161", "324161035", "story_v_out_324161.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_324161", "324161035", "story_v_out_324161.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_12 = math.max(var_155_5, arg_152_1.talkMaxDuration)

			if var_155_4 <= arg_152_1.time_ and arg_152_1.time_ < var_155_4 + var_155_12 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_4) / var_155_12

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_4 + var_155_12 and arg_152_1.time_ < var_155_4 + var_155_12 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play324161036 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 324161036
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play324161037(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos1054ui_story = arg_156_1.actors_["1054ui_story"].transform.localPosition

				local var_159_0 = GameObjectTools.GetOrAddComponent(arg_156_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_159_0 then
					var_159_0:EnableDynamicBone(false)
				end
			end

			local var_159_1 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_1 then
				arg_156_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_156_1.time_ - 0) / var_159_1)
				arg_156_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1054ui_story"].transform.position).z)
				arg_156_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1054ui_story"].transform.localEulerAngles = arg_156_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_1 and arg_156_1.time_ < 0 + var_159_1 + arg_159_0 then
				arg_156_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_156_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1054ui_story"].transform.position).z)
				arg_156_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1054ui_story"].transform.localEulerAngles = arg_156_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_159_2 = GameObjectTools.GetOrAddComponent(arg_156_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_159_2 then
					var_159_2:EnableDynamicBone(true)
				end
			end

			local var_159_3 = arg_156_1.actors_["6148ui_story"].transform

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos6148ui_story = var_159_3.localPosition

				local var_159_4 = GameObjectTools.GetOrAddComponent(var_159_3.gameObject, typeof(DynamicBoneHelper))

				if var_159_4 then
					var_159_4:EnableDynamicBone(false)
				end
			end

			local var_159_5 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_5 then
				var_159_3.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_156_1.time_ - 0) / var_159_5)
				var_159_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_3.position).x, (manager.ui.mainCamera.transform.position - var_159_3.position).y, (manager.ui.mainCamera.transform.position - var_159_3.position).z)
				var_159_3.localEulerAngles.z = 0
				var_159_3.localEulerAngles.x = 0
				var_159_3.localEulerAngles = var_159_3.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_5 and arg_156_1.time_ < 0 + var_159_5 + arg_159_0 then
				var_159_3.localPosition = Vector3.New(0, 100, 0)
				var_159_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_3.position).x, (manager.ui.mainCamera.transform.position - var_159_3.position).y, (manager.ui.mainCamera.transform.position - var_159_3.position).z)
				var_159_3.localEulerAngles.z = 0
				var_159_3.localEulerAngles.x = 0
				var_159_3.localEulerAngles = var_159_3.localEulerAngles

				local var_159_6 = GameObjectTools.GetOrAddComponent(var_159_3.gameObject, typeof(DynamicBoneHelper))

				if var_159_6 then
					var_159_6:EnableDynamicBone(true)
				end
			end

			local var_159_7 = arg_156_1.actors_["1054ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_7) and arg_156_1.var_.characterEffect1054ui_story == nil then
				arg_156_1.var_.characterEffect1054ui_story = var_159_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_8 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_8 and not isNil(var_159_7) then
				if arg_156_1.var_.characterEffect1054ui_story and not isNil(var_159_7) then
					arg_156_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_8)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_8 and arg_156_1.time_ < 0 + var_159_8 + arg_159_0 and not isNil(var_159_7) and arg_156_1.var_.characterEffect1054ui_story then
				arg_156_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0.3 < arg_156_1.time_ and arg_156_1.time_ <= 0.3 + arg_159_0 then
				arg_156_1:AudioAction("play", "effect", "se_story_150", "se_story_150_monster_growl", "")
			end

			local var_159_10 = 0
			local var_159_11 = 0.975

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_10 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_12 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(324161036).content)

				arg_156_1.text_.text = var_159_12

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_14 = 39 <= 0 and var_159_11 or var_159_11 * (utf8.len(var_159_12) / 39)

				if (39 <= 0 and var_159_11 or var_159_11 * (utf8.len(var_159_12) / 39)) > 0 and var_159_11 < var_159_14 then
					arg_156_1.talkMaxDuration = var_159_14

					if var_159_14 + var_159_10 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_14 + var_159_10
					end
				end

				arg_156_1.text_.text = var_159_12
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_15 = math.max(var_159_11, arg_156_1.talkMaxDuration)

			if var_159_10 <= arg_156_1.time_ and arg_156_1.time_ < var_159_10 + var_159_15 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_10) / var_159_15

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_10 + var_159_15 and arg_156_1.time_ < var_159_10 + var_159_15 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play324161037 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 324161037
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play324161038(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0.825

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_1 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(324161037).content)

				arg_160_1.text_.text = var_163_1

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_3 = 33 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_1) / 33)

				if (33 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_1) / 33)) > 0 and var_163_0 < var_163_3 then
					arg_160_1.talkMaxDuration = var_163_3

					if var_163_3 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_3 + 0
					end
				end

				arg_160_1.text_.text = var_163_1
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_4 = math.max(var_163_0, arg_160_1.talkMaxDuration)

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_4 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - 0) / var_163_4

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= 0 + var_163_4 and arg_160_1.time_ < 0 + var_163_4 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play324161038 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 324161038
		arg_164_1.duration_ = 2.03

		local var_164_0 = {
			zh = 1.999999999999,
			ja = 2.033
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play324161039(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos6148ui_story = arg_164_1.actors_["6148ui_story"].transform.localPosition

				local var_167_0 = GameObjectTools.GetOrAddComponent(arg_164_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_167_0 then
					var_167_0:EnableDynamicBone(false)
				end
			end

			local var_167_1 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_1 then
				arg_164_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_164_1.time_ - 0) / var_167_1)
				arg_164_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["6148ui_story"].transform.position).z)
				arg_164_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["6148ui_story"].transform.localEulerAngles = arg_164_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_164_1.time_ >= 0 + var_167_1 and arg_164_1.time_ < 0 + var_167_1 + arg_167_0 then
				arg_164_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_164_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["6148ui_story"].transform.position).z)
				arg_164_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["6148ui_story"].transform.localEulerAngles = arg_164_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_167_2 = GameObjectTools.GetOrAddComponent(arg_164_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_167_2 then
					var_167_2:EnableDynamicBone(true)
				end
			end

			local var_167_3 = arg_164_1.actors_["6148ui_story"]

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(var_167_3) and arg_164_1.var_.characterEffect6148ui_story == nil then
				arg_164_1.var_.characterEffect6148ui_story = var_167_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_4 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_4 and not isNil(var_167_3) then
				if arg_164_1.var_.characterEffect6148ui_story and not isNil(var_167_3) then
					arg_164_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= 0 + var_167_4 and arg_164_1.time_ < 0 + var_167_4 + arg_167_0 and not isNil(var_167_3) and arg_164_1.var_.characterEffect6148ui_story then
				arg_164_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action8_1")
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_167_6 = 0
			local var_167_7 = 0.15

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_6 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_8 = arg_164_1:GetWordFromCfg(324161038)
				local var_167_9 = arg_164_1:FormatText(var_167_8.content)

				arg_164_1.text_.text = var_167_9

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_11 = 6 <= 0 and var_167_7 or var_167_7 * (utf8.len(var_167_9) / 6)

				if (6 <= 0 and var_167_7 or var_167_7 * (utf8.len(var_167_9) / 6)) > 0 and var_167_7 < var_167_11 then
					arg_164_1.talkMaxDuration = var_167_11

					if var_167_11 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_11 + var_167_6
					end
				end

				arg_164_1.text_.text = var_167_9
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161038", "story_v_out_324161.awb") ~= 0 then
					local var_167_12 = manager.audio:GetVoiceLength("story_v_out_324161", "324161038", "story_v_out_324161.awb") / 1000

					if var_167_12 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_12 + var_167_6
					end

					if var_167_8.prefab_name ~= "" and arg_164_1.actors_[var_167_8.prefab_name] ~= nil then
						local var_167_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_8.prefab_name].transform, "story_v_out_324161", "324161038", "story_v_out_324161.awb")

						arg_164_1:RecordAudio("324161038", var_167_13)
						arg_164_1:RecordAudio("324161038", var_167_13)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_324161", "324161038", "story_v_out_324161.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_324161", "324161038", "story_v_out_324161.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_14 = math.max(var_167_7, arg_164_1.talkMaxDuration)

			if var_167_6 <= arg_164_1.time_ and arg_164_1.time_ < var_167_6 + var_167_14 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_6) / var_167_14

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_6 + var_167_14 and arg_164_1.time_ < var_167_6 + var_167_14 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play324161039 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 324161039
		arg_168_1.duration_ = 2.6

		local var_168_0 = {
			zh = 2.5,
			ja = 2.6
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play324161040(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos1054ui_story = arg_168_1.actors_["1054ui_story"].transform.localPosition

				local var_171_0 = GameObjectTools.GetOrAddComponent(arg_168_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_171_0 then
					var_171_0:EnableDynamicBone(false)
				end
			end

			local var_171_1 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_1 then
				arg_168_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_168_1.time_ - 0) / var_171_1)
				arg_168_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1054ui_story"].transform.position).z)
				arg_168_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["1054ui_story"].transform.localEulerAngles = arg_168_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_168_1.time_ >= 0 + var_171_1 and arg_168_1.time_ < 0 + var_171_1 + arg_171_0 then
				arg_168_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_168_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1054ui_story"].transform.position).z)
				arg_168_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["1054ui_story"].transform.localEulerAngles = arg_168_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_171_2 = GameObjectTools.GetOrAddComponent(arg_168_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_171_2 then
					var_171_2:EnableDynamicBone(true)
				end
			end

			local var_171_3 = arg_168_1.actors_["1054ui_story"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_3) and arg_168_1.var_.characterEffect1054ui_story == nil then
				arg_168_1.var_.characterEffect1054ui_story = var_171_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_4 = 0.200000002980232

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_4 and not isNil(var_171_3) then
				if arg_168_1.var_.characterEffect1054ui_story and not isNil(var_171_3) then
					arg_168_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= 0 + var_171_4 and arg_168_1.time_ < 0 + var_171_4 + arg_171_0 and not isNil(var_171_3) and arg_168_1.var_.characterEffect1054ui_story then
				arg_168_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_171_6 = arg_168_1.actors_["6148ui_story"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_6) and arg_168_1.var_.characterEffect6148ui_story == nil then
				arg_168_1.var_.characterEffect6148ui_story = var_171_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_7 = 0.200000002980232

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_7 and not isNil(var_171_6) then
				if arg_168_1.var_.characterEffect6148ui_story and not isNil(var_171_6) then
					arg_168_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_168_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_168_1.time_ - 0) / var_171_7)
				end
			end

			if arg_168_1.time_ >= 0 + var_171_7 and arg_168_1.time_ < 0 + var_171_7 + arg_171_0 and not isNil(var_171_6) and arg_168_1.var_.characterEffect6148ui_story then
				arg_168_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_168_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_171_8 = 0
			local var_171_9 = 0.225

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_8 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_10 = arg_168_1:GetWordFromCfg(324161039)
				local var_171_11 = arg_168_1:FormatText(var_171_10.content)

				arg_168_1.text_.text = var_171_11

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_13 = 9 <= 0 and var_171_9 or var_171_9 * (utf8.len(var_171_11) / 9)

				if (9 <= 0 and var_171_9 or var_171_9 * (utf8.len(var_171_11) / 9)) > 0 and var_171_9 < var_171_13 then
					arg_168_1.talkMaxDuration = var_171_13

					if var_171_13 + var_171_8 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_13 + var_171_8
					end
				end

				arg_168_1.text_.text = var_171_11
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161039", "story_v_out_324161.awb") ~= 0 then
					local var_171_14 = manager.audio:GetVoiceLength("story_v_out_324161", "324161039", "story_v_out_324161.awb") / 1000

					if var_171_14 + var_171_8 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_14 + var_171_8
					end

					if var_171_10.prefab_name ~= "" and arg_168_1.actors_[var_171_10.prefab_name] ~= nil then
						local var_171_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_10.prefab_name].transform, "story_v_out_324161", "324161039", "story_v_out_324161.awb")

						arg_168_1:RecordAudio("324161039", var_171_15)
						arg_168_1:RecordAudio("324161039", var_171_15)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_324161", "324161039", "story_v_out_324161.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_324161", "324161039", "story_v_out_324161.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_16 = math.max(var_171_9, arg_168_1.talkMaxDuration)

			if var_171_8 <= arg_168_1.time_ and arg_168_1.time_ < var_171_8 + var_171_16 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_8) / var_171_16

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_8 + var_171_16 and arg_168_1.time_ < var_171_8 + var_171_16 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play324161040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 324161040
		arg_172_1.duration_ = 7.17

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play324161041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_9000

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.moveOldPos1054ui_story = arg_172_1.actors_["1054ui_story"].transform.localPosition

				local var_175_0 = GameObjectTools.GetOrAddComponent(arg_172_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_175_0 then
					var_175_0:EnableDynamicBone(false)
				end
			end

			local var_175_1 = 0.001

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_1 then
				arg_172_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_172_1.time_ - 0) / var_175_1)
				arg_172_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_172_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1054ui_story"].transform.position).z)
				arg_172_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_172_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_172_1.actors_["1054ui_story"].transform.localEulerAngles = arg_172_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_172_1.time_ >= 0 + var_175_1 and arg_172_1.time_ < 0 + var_175_1 + arg_175_0 then
				arg_172_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_172_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_172_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1054ui_story"].transform.position).z)
				arg_172_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_172_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_172_1.actors_["1054ui_story"].transform.localEulerAngles = arg_172_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_175_2 = GameObjectTools.GetOrAddComponent(arg_172_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_175_2 then
					var_175_2:EnableDynamicBone(true)
				end
			end

			local var_175_3 = arg_172_1.actors_["6148ui_story"].transform

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.moveOldPos6148ui_story = var_175_3.localPosition

				local var_175_4 = GameObjectTools.GetOrAddComponent(var_175_3.gameObject, typeof(DynamicBoneHelper))

				if var_175_4 then
					var_175_4:EnableDynamicBone(false)
				end
			end

			local var_175_5 = 0.001

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_5 then
				var_175_3.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_172_1.time_ - 0) / var_175_5)
				var_175_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_175_3.position).x, (manager.ui.mainCamera.transform.position - var_175_3.position).y, (manager.ui.mainCamera.transform.position - var_175_3.position).z)
				var_175_3.localEulerAngles.z = 0
				var_175_3.localEulerAngles.x = 0
				var_175_3.localEulerAngles = var_175_3.localEulerAngles
			end

			if arg_172_1.time_ >= 0 + var_175_5 and arg_172_1.time_ < 0 + var_175_5 + arg_175_0 then
				var_175_3.localPosition = Vector3.New(0, 100, 0)
				var_175_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_175_3.position).x, (manager.ui.mainCamera.transform.position - var_175_3.position).y, (manager.ui.mainCamera.transform.position - var_175_3.position).z)
				var_175_3.localEulerAngles.z = 0
				var_175_3.localEulerAngles.x = 0
				var_175_3.localEulerAngles = var_175_3.localEulerAngles

				local var_175_6 = GameObjectTools.GetOrAddComponent(var_175_3.gameObject, typeof(DynamicBoneHelper))

				if var_175_6 then
					var_175_6:EnableDynamicBone(true)
				end
			end

			local var_175_7 = arg_172_1.actors_["1054ui_story"]

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(var_175_7) and arg_172_1.var_.characterEffect1054ui_story == nil then
				arg_172_1.var_.characterEffect1054ui_story = var_175_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_8 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_8 and not isNil(var_175_7) then
				if arg_172_1.var_.characterEffect1054ui_story and not isNil(var_175_7) then
					arg_172_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_172_1.time_ - 0) / var_175_8)
				end
			end

			if arg_172_1.time_ >= 0 + var_175_8 and arg_172_1.time_ < 0 + var_175_8 + arg_175_0 and not isNil(var_175_7) and arg_172_1.var_.characterEffect1054ui_story then
				arg_172_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				local var_175_9 = arg_172_1.var_.effect213

				if not arg_172_1.var_.effect213 then
					var_175_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dataglow"), manager.ui.mainCamera.transform)
					var_175_9.name = "213"
					arg_172_1.var_.effect213 = var_175_9
				else
					var_175_9.transform:SetParent(var_175_9000)
				end

				var_175_9.transform.localPosition = Vector3.New(0, 1.19, -5.07)
				var_175_9.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_175_11 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_175_9.transform.localScale = Vector3.New(var_175_9.transform.localScale.x * var_175_11, var_175_9.transform.localScale.y * var_175_11, var_175_9.transform.localScale.z * var_175_11)
			end

			if 1.5 < arg_172_1.time_ and arg_172_1.time_ <= 1.5 + arg_175_0 then
				if arg_172_1.var_.effect213 then
					Object.Destroy(arg_172_1.var_.effect213)

					arg_172_1.var_.effect213 = nil
				end
			end

			local var_175_13 = 1.26666666666667

			if 1.26666666666667 < arg_172_1.time_ and arg_172_1.time_ <= var_175_13 + arg_175_0 then
				arg_172_1.mask_.enabled = true
				arg_172_1.mask_.raycastTarget = false

				arg_172_1:SetGaussion(false)
			end

			local var_175_14 = 0.9

			if var_175_13 <= arg_172_1.time_ and arg_172_1.time_ < var_175_13 + var_175_14 then
				local var_175_15 = Color.New(1, 1, 1)

				var_175_15.a = Mathf.Lerp(1, 0, (arg_172_1.time_ - var_175_13) / var_175_14)
				arg_172_1.mask_.color = var_175_15
			end

			if arg_172_1.time_ >= var_175_13 + var_175_14 and arg_172_1.time_ < var_175_13 + var_175_14 + arg_175_0 then
				local var_175_16 = Color.New(1, 1, 1)

				arg_172_1.mask_.enabled = false
				var_175_16.a = 0
				arg_172_1.mask_.color = var_175_16
			end

			local var_175_17 = 0

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_17 + arg_175_0 then
				arg_172_1.allBtn_.enabled = false
			end

			if arg_172_1.time_ >= var_175_17 + 2.36666666666667 and arg_172_1.time_ < var_175_17 + 2.36666666666667 + arg_175_0 then
				arg_172_1.allBtn_.enabled = true
			end

			if 1.26666666666667 < arg_172_1.time_ and arg_172_1.time_ <= 1.26666666666667 + arg_175_0 then
				arg_172_1:AudioAction("play", "effect", "se_story_126_01", "se_story_126_01_Portal", "")
			end

			if arg_172_1.frameCnt_ <= 1 then
				arg_172_1.dialog_:SetActive(false)
			end

			local var_175_19 = 2.16666666666667
			local var_175_20 = 1.325

			if 2.16666666666667 < arg_172_1.time_ and arg_172_1.time_ <= var_175_19 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0

				arg_172_1.dialog_:SetActive(true)

				arg_172_1.dialogCg_.alpha = 0

				local var_175_21 = LeanTween.value(arg_172_1.dialog_, 0, 1, 0.3)

				var_175_21:setOnUpdate(LuaHelper.FloatAction(function(arg_176_0)
					arg_172_1.dialogCg_.alpha = arg_176_0
				end))
				var_175_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_172_1.dialog_)
					var_175_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_172_1.duration_ = arg_172_1.duration_ + 0.3

				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_22 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(324161040).content)

				arg_172_1.text_.text = var_175_22

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_24 = 53 <= 0 and var_175_20 or var_175_20 * (utf8.len(var_175_22) / 53)

				if (53 <= 0 and var_175_20 or var_175_20 * (utf8.len(var_175_22) / 53)) > 0 and var_175_20 < var_175_24 then
					arg_172_1.talkMaxDuration = var_175_24
					var_175_19 = var_175_19 + 0.3

					if var_175_24 + var_175_19 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_24 + var_175_19
					end
				end

				arg_172_1.text_.text = var_175_22
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_25 = var_175_19 + 0.3
			local var_175_26 = math.max(var_175_20, arg_172_1.talkMaxDuration)

			if var_175_19 + 0.3 <= arg_172_1.time_ and arg_172_1.time_ < var_175_25 + var_175_26 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_25) / var_175_26

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_25 + var_175_26 and arg_172_1.time_ < var_175_25 + var_175_26 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play324161041 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 324161041
		arg_178_1.duration_ = 4.87

		local var_178_0 = {
			zh = 3.90833333333333,
			ja = 4.87433333333333
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play324161042(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if arg_178_1.bgs_.J27g == nil then
				local var_181_0 = Object.Instantiate(arg_178_1.paintGo_)

				var_181_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J27g")
				var_181_0.name = "J27g"
				var_181_0.transform.parent = arg_178_1.stage_.transform
				var_181_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_178_1.bgs_.J27g = var_181_0
			end

			if 0.833333333333333 < arg_178_1.time_ and arg_178_1.time_ <= 0.833333333333333 + arg_181_0 then
				local var_181_1 = arg_178_1.bgs_.J27g

				arg_178_1.bgs_.J27g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_181_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_181_2 = var_181_1:GetComponent("SpriteRenderer")

				if var_181_2 and var_181_2.sprite then
					local var_181_3 = 2 * (var_181_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_181_1.transform.localScale = Vector3.New(var_181_3 / var_181_2.sprite.bounds.size.y < var_181_3 * manager.ui.mainCameraCom_.aspect / var_181_2.sprite.bounds.size.x and var_181_3 * manager.ui.mainCameraCom_.aspect / var_181_2.sprite.bounds.size.x or var_181_3 / var_181_2.sprite.bounds.size.y, var_181_3 / var_181_2.sprite.bounds.size.y < var_181_3 * manager.ui.mainCameraCom_.aspect / var_181_2.sprite.bounds.size.x and var_181_3 * manager.ui.mainCameraCom_.aspect / var_181_2.sprite.bounds.size.x or var_181_3 / var_181_2.sprite.bounds.size.y, 0)
				end

				for iter_181_0, iter_181_1 in pairs(arg_178_1.bgs_) do
					if iter_181_0 ~= "J27g" then
						iter_181_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_181_4 = 0

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_4 + arg_181_0 then
				arg_178_1.allBtn_.enabled = false
			end

			if arg_178_1.time_ >= var_181_4 + 0.3 and arg_178_1.time_ < var_181_4 + 0.3 + arg_181_0 then
				arg_178_1.allBtn_.enabled = true
			end

			local var_181_5 = 0

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_5 + arg_181_0 then
				arg_178_1.mask_.enabled = true
				arg_178_1.mask_.raycastTarget = true

				arg_178_1:SetGaussion(false)
			end

			local var_181_6 = 0.833333333333333

			if var_181_5 <= arg_178_1.time_ and arg_178_1.time_ < var_181_5 + var_181_6 then
				local var_181_7 = Color.New(0, 0, 0)

				var_181_7.a = Mathf.Lerp(0, 1, (arg_178_1.time_ - var_181_5) / var_181_6)
				arg_178_1.mask_.color = var_181_7
			end

			if arg_178_1.time_ >= var_181_5 + var_181_6 and arg_178_1.time_ < var_181_5 + var_181_6 + arg_181_0 then
				local var_181_8 = Color.New(0, 0, 0)

				var_181_8.a = 1
				arg_178_1.mask_.color = var_181_8
			end

			local var_181_9 = 0.833333333333333

			if 0.833333333333333 < arg_178_1.time_ and arg_178_1.time_ <= var_181_9 + arg_181_0 then
				arg_178_1.mask_.enabled = true
				arg_178_1.mask_.raycastTarget = true

				arg_178_1:SetGaussion(false)
			end

			local var_181_10 = 1.6

			if var_181_9 <= arg_178_1.time_ and arg_178_1.time_ < var_181_9 + var_181_10 then
				local var_181_11 = Color.New(0, 0, 0)

				var_181_11.a = Mathf.Lerp(1, 0, (arg_178_1.time_ - var_181_9) / var_181_10)
				arg_178_1.mask_.color = var_181_11
			end

			if arg_178_1.time_ >= var_181_9 + var_181_10 and arg_178_1.time_ < var_181_9 + var_181_10 + arg_181_0 then
				local var_181_12 = Color.New(0, 0, 0)

				arg_178_1.mask_.enabled = false
				var_181_12.a = 0
				arg_178_1.mask_.color = var_181_12
			end

			local var_181_13 = arg_178_1.actors_["1054ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_13) and arg_178_1.var_.characterEffect1054ui_story == nil then
				arg_178_1.var_.characterEffect1054ui_story = var_181_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_14 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_14 and not isNil(var_181_13) then
				if arg_178_1.var_.characterEffect1054ui_story and not isNil(var_181_13) then
					arg_178_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= 0 + var_181_14 and arg_178_1.time_ < 0 + var_181_14 + arg_181_0 and not isNil(var_181_13) and arg_178_1.var_.characterEffect1054ui_story then
				arg_178_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 1.2 < arg_178_1.time_ and arg_178_1.time_ <= 1.2 + arg_181_0 then
				arg_178_1:AudioAction("play", "effect", "se_story_150", "se_story_150_huatian", "")
			end

			if 0.1 < arg_178_1.time_ and arg_178_1.time_ <= 0.1 + arg_181_0 then
				arg_178_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if arg_178_1.frameCnt_ <= 1 then
				arg_178_1.dialog_:SetActive(false)
			end

			local var_181_18 = 2.70833333333333
			local var_181_19 = 0.125

			if 2.70833333333333 < arg_178_1.time_ and arg_178_1.time_ <= var_181_18 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0

				arg_178_1.dialog_:SetActive(true)

				arg_178_1.dialogCg_.alpha = 0

				local var_181_20 = LeanTween.value(arg_178_1.dialog_, 0, 1, 0.3)

				var_181_20:setOnUpdate(LuaHelper.FloatAction(function(arg_182_0)
					arg_178_1.dialogCg_.alpha = arg_182_0
				end))
				var_181_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_178_1.dialog_)
					var_181_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_178_1.duration_ = arg_178_1.duration_ + 0.3

				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_21 = arg_178_1:GetWordFromCfg(324161041)
				local var_181_22 = arg_178_1:FormatText(var_181_21.content)

				arg_178_1.text_.text = var_181_22

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_24 = 5 <= 0 and var_181_19 or var_181_19 * (utf8.len(var_181_22) / 5)

				if (5 <= 0 and var_181_19 or var_181_19 * (utf8.len(var_181_22) / 5)) > 0 and var_181_19 < var_181_24 then
					arg_178_1.talkMaxDuration = var_181_24
					var_181_18 = var_181_18 + 0.3

					if var_181_24 + var_181_18 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_24 + var_181_18
					end
				end

				arg_178_1.text_.text = var_181_22
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161041", "story_v_out_324161.awb") ~= 0 then
					local var_181_25 = manager.audio:GetVoiceLength("story_v_out_324161", "324161041", "story_v_out_324161.awb") / 1000

					if var_181_25 + var_181_18 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_25 + var_181_18
					end

					if var_181_21.prefab_name ~= "" and arg_178_1.actors_[var_181_21.prefab_name] ~= nil then
						local var_181_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_21.prefab_name].transform, "story_v_out_324161", "324161041", "story_v_out_324161.awb")

						arg_178_1:RecordAudio("324161041", var_181_26)
						arg_178_1:RecordAudio("324161041", var_181_26)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_324161", "324161041", "story_v_out_324161.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_324161", "324161041", "story_v_out_324161.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_27 = var_181_18 + 0.3
			local var_181_28 = math.max(var_181_19, arg_178_1.talkMaxDuration)

			if var_181_18 + 0.3 <= arg_178_1.time_ and arg_178_1.time_ < var_181_27 + var_181_28 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_27) / var_181_28

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_27 + var_181_28 and arg_178_1.time_ < var_181_27 + var_181_28 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play324161042 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 324161042
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play324161043(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["1054ui_story"]) and arg_184_1.var_.characterEffect1054ui_story == nil then
				arg_184_1.var_.characterEffect1054ui_story = arg_184_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_0 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["1054ui_story"]) then
				if arg_184_1.var_.characterEffect1054ui_story and not isNil(arg_184_1.actors_["1054ui_story"]) then
					arg_184_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_184_1.time_ - 0) / var_187_0)
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["1054ui_story"]) and arg_184_1.var_.characterEffect1054ui_story then
				arg_184_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_184_1.time_ and arg_184_1.time_ <= 0.1 + arg_187_0 then
				arg_184_1:AudioAction("play", "effect", "se_story_150", "se_story_150_portal_fall", "")
			end

			local var_187_2 = 0
			local var_187_3 = 1.425

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_2 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_4 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(324161042).content)

				arg_184_1.text_.text = var_187_4

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_6 = 57 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_4) / 57)

				if (57 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_4) / 57)) > 0 and var_187_3 < var_187_6 then
					arg_184_1.talkMaxDuration = var_187_6

					if var_187_6 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_6 + var_187_2
					end
				end

				arg_184_1.text_.text = var_187_4
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_7 = math.max(var_187_3, arg_184_1.talkMaxDuration)

			if var_187_2 <= arg_184_1.time_ and arg_184_1.time_ < var_187_2 + var_187_7 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_2) / var_187_7

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_2 + var_187_7 and arg_184_1.time_ < var_187_2 + var_187_7 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play324161043 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 324161043
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play324161044(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 1.225

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_1 = arg_188_1:FormatText(arg_188_1:GetWordFromCfg(324161043).content)

				arg_188_1.text_.text = var_191_1

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_3 = 49 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_1) / 49)

				if (49 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_1) / 49)) > 0 and var_191_0 < var_191_3 then
					arg_188_1.talkMaxDuration = var_191_3

					if var_191_3 + 0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_3 + 0
					end
				end

				arg_188_1.text_.text = var_191_1
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_4 = math.max(var_191_0, arg_188_1.talkMaxDuration)

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_4 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - 0) / var_191_4

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= 0 + var_191_4 and arg_188_1.time_ < 0 + var_191_4 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play324161044 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 324161044
		arg_192_1.duration_ = 3.1

		local var_192_0 = {
			zh = 1.5,
			ja = 3.1
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play324161045(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos6148ui_story = arg_192_1.actors_["6148ui_story"].transform.localPosition

				local var_195_0 = GameObjectTools.GetOrAddComponent(arg_192_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_195_0 then
					var_195_0:EnableDynamicBone(false)
				end
			end

			local var_195_1 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_1 then
				arg_192_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_192_1.time_ - 0) / var_195_1)
				arg_192_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_192_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["6148ui_story"].transform.position).z)
				arg_192_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_192_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_192_1.actors_["6148ui_story"].transform.localEulerAngles = arg_192_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_192_1.time_ >= 0 + var_195_1 and arg_192_1.time_ < 0 + var_195_1 + arg_195_0 then
				arg_192_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_192_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_192_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["6148ui_story"].transform.position).z)
				arg_192_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_192_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_192_1.actors_["6148ui_story"].transform.localEulerAngles = arg_192_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_195_2 = GameObjectTools.GetOrAddComponent(arg_192_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_195_2 then
					var_195_2:EnableDynamicBone(true)
				end
			end

			local var_195_3 = arg_192_1.actors_["6148ui_story"]

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(var_195_3) and arg_192_1.var_.characterEffect6148ui_story == nil then
				arg_192_1.var_.characterEffect6148ui_story = var_195_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_4 = 0.200000002980232

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_4 and not isNil(var_195_3) then
				if arg_192_1.var_.characterEffect6148ui_story and not isNil(var_195_3) then
					arg_192_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= 0 + var_195_4 and arg_192_1.time_ < 0 + var_195_4 + arg_195_0 and not isNil(var_195_3) and arg_192_1.var_.characterEffect6148ui_story then
				arg_192_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_195_6 = 0
			local var_195_7 = 0.175

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_6 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_8 = arg_192_1:GetWordFromCfg(324161044)
				local var_195_9 = arg_192_1:FormatText(var_195_8.content)

				arg_192_1.text_.text = var_195_9

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_11 = 7 <= 0 and var_195_7 or var_195_7 * (utf8.len(var_195_9) / 7)

				if (7 <= 0 and var_195_7 or var_195_7 * (utf8.len(var_195_9) / 7)) > 0 and var_195_7 < var_195_11 then
					arg_192_1.talkMaxDuration = var_195_11

					if var_195_11 + var_195_6 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_11 + var_195_6
					end
				end

				arg_192_1.text_.text = var_195_9
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161044", "story_v_out_324161.awb") ~= 0 then
					local var_195_12 = manager.audio:GetVoiceLength("story_v_out_324161", "324161044", "story_v_out_324161.awb") / 1000

					if var_195_12 + var_195_6 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_12 + var_195_6
					end

					if var_195_8.prefab_name ~= "" and arg_192_1.actors_[var_195_8.prefab_name] ~= nil then
						local var_195_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_8.prefab_name].transform, "story_v_out_324161", "324161044", "story_v_out_324161.awb")

						arg_192_1:RecordAudio("324161044", var_195_13)
						arg_192_1:RecordAudio("324161044", var_195_13)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_324161", "324161044", "story_v_out_324161.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_324161", "324161044", "story_v_out_324161.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_14 = math.max(var_195_7, arg_192_1.talkMaxDuration)

			if var_195_6 <= arg_192_1.time_ and arg_192_1.time_ < var_195_6 + var_195_14 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_6) / var_195_14

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_6 + var_195_14 and arg_192_1.time_ < var_195_6 + var_195_14 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play324161045 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 324161045
		arg_196_1.duration_ = 2

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play324161046(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos1054ui_story = arg_196_1.actors_["1054ui_story"].transform.localPosition

				local var_199_0 = GameObjectTools.GetOrAddComponent(arg_196_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_199_0 then
					var_199_0:EnableDynamicBone(false)
				end
			end

			local var_199_1 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_1 then
				arg_196_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_196_1.time_ - 0) / var_199_1)
				arg_196_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_196_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1054ui_story"].transform.position).z)
				arg_196_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_196_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_196_1.actors_["1054ui_story"].transform.localEulerAngles = arg_196_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_196_1.time_ >= 0 + var_199_1 and arg_196_1.time_ < 0 + var_199_1 + arg_199_0 then
				arg_196_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_196_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_196_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1054ui_story"].transform.position).z)
				arg_196_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_196_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_196_1.actors_["1054ui_story"].transform.localEulerAngles = arg_196_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_199_2 = GameObjectTools.GetOrAddComponent(arg_196_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_199_2 then
					var_199_2:EnableDynamicBone(true)
				end
			end

			local var_199_3 = arg_196_1.actors_["6148ui_story"].transform

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos6148ui_story = var_199_3.localPosition

				local var_199_4 = GameObjectTools.GetOrAddComponent(var_199_3.gameObject, typeof(DynamicBoneHelper))

				if var_199_4 then
					var_199_4:EnableDynamicBone(false)
				end
			end

			local var_199_5 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_5 then
				var_199_3.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_196_1.time_ - 0) / var_199_5)
				var_199_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_199_3.position).x, (manager.ui.mainCamera.transform.position - var_199_3.position).y, (manager.ui.mainCamera.transform.position - var_199_3.position).z)
				var_199_3.localEulerAngles.z = 0
				var_199_3.localEulerAngles.x = 0
				var_199_3.localEulerAngles = var_199_3.localEulerAngles
			end

			if arg_196_1.time_ >= 0 + var_199_5 and arg_196_1.time_ < 0 + var_199_5 + arg_199_0 then
				var_199_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_199_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_199_3.position).x, (manager.ui.mainCamera.transform.position - var_199_3.position).y, (manager.ui.mainCamera.transform.position - var_199_3.position).z)
				var_199_3.localEulerAngles.z = 0
				var_199_3.localEulerAngles.x = 0
				var_199_3.localEulerAngles = var_199_3.localEulerAngles

				local var_199_6 = GameObjectTools.GetOrAddComponent(var_199_3.gameObject, typeof(DynamicBoneHelper))

				if var_199_6 then
					var_199_6:EnableDynamicBone(true)
				end
			end

			local var_199_7 = arg_196_1.actors_["1054ui_story"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_7) and arg_196_1.var_.characterEffect1054ui_story == nil then
				arg_196_1.var_.characterEffect1054ui_story = var_199_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_8 = 0.200000002980232

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_8 and not isNil(var_199_7) then
				if arg_196_1.var_.characterEffect1054ui_story and not isNil(var_199_7) then
					arg_196_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= 0 + var_199_8 and arg_196_1.time_ < 0 + var_199_8 + arg_199_0 and not isNil(var_199_7) and arg_196_1.var_.characterEffect1054ui_story then
				arg_196_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_199_10 = arg_196_1.actors_["6148ui_story"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_10) and arg_196_1.var_.characterEffect6148ui_story == nil then
				arg_196_1.var_.characterEffect6148ui_story = var_199_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_11 = 0.200000002980232

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_11 and not isNil(var_199_10) then
				if arg_196_1.var_.characterEffect6148ui_story and not isNil(var_199_10) then
					arg_196_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_196_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_196_1.time_ - 0) / var_199_11)
				end
			end

			if arg_196_1.time_ >= 0 + var_199_11 and arg_196_1.time_ < 0 + var_199_11 + arg_199_0 and not isNil(var_199_10) and arg_196_1.var_.characterEffect6148ui_story then
				arg_196_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_196_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_199_12 = 0
			local var_199_13 = 0.125

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_12 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_14 = arg_196_1:GetWordFromCfg(324161045)
				local var_199_15 = arg_196_1:FormatText(var_199_14.content)

				arg_196_1.text_.text = var_199_15

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_17 = 5 <= 0 and var_199_13 or var_199_13 * (utf8.len(var_199_15) / 5)

				if (5 <= 0 and var_199_13 or var_199_13 * (utf8.len(var_199_15) / 5)) > 0 and var_199_13 < var_199_17 then
					arg_196_1.talkMaxDuration = var_199_17

					if var_199_17 + var_199_12 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_17 + var_199_12
					end
				end

				arg_196_1.text_.text = var_199_15
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161045", "story_v_out_324161.awb") ~= 0 then
					local var_199_18 = manager.audio:GetVoiceLength("story_v_out_324161", "324161045", "story_v_out_324161.awb") / 1000

					if var_199_18 + var_199_12 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_18 + var_199_12
					end

					if var_199_14.prefab_name ~= "" and arg_196_1.actors_[var_199_14.prefab_name] ~= nil then
						local var_199_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_14.prefab_name].transform, "story_v_out_324161", "324161045", "story_v_out_324161.awb")

						arg_196_1:RecordAudio("324161045", var_199_19)
						arg_196_1:RecordAudio("324161045", var_199_19)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_324161", "324161045", "story_v_out_324161.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_324161", "324161045", "story_v_out_324161.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_20 = math.max(var_199_13, arg_196_1.talkMaxDuration)

			if var_199_12 <= arg_196_1.time_ and arg_196_1.time_ < var_199_12 + var_199_20 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_12) / var_199_20

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_12 + var_199_20 and arg_196_1.time_ < var_199_12 + var_199_20 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play324161046 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 324161046
		arg_200_1.duration_ = 5.27

		local var_200_0 = {
			zh = 3.9,
			ja = 5.266
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play324161047(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos6148ui_story = arg_200_1.actors_["6148ui_story"].transform.localPosition

				local var_203_0 = GameObjectTools.GetOrAddComponent(arg_200_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_203_0 then
					var_203_0:EnableDynamicBone(false)
				end
			end

			local var_203_1 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_1 then
				arg_200_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_200_1.time_ - 0) / var_203_1)
				arg_200_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_200_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["6148ui_story"].transform.position).z)
				arg_200_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_200_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_200_1.actors_["6148ui_story"].transform.localEulerAngles = arg_200_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_200_1.time_ >= 0 + var_203_1 and arg_200_1.time_ < 0 + var_203_1 + arg_203_0 then
				arg_200_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_200_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_200_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["6148ui_story"].transform.position).z)
				arg_200_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_200_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_200_1.actors_["6148ui_story"].transform.localEulerAngles = arg_200_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_203_2 = GameObjectTools.GetOrAddComponent(arg_200_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_203_2 then
					var_203_2:EnableDynamicBone(true)
				end
			end

			local var_203_3 = arg_200_1.actors_["6148ui_story"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_3) and arg_200_1.var_.characterEffect6148ui_story == nil then
				arg_200_1.var_.characterEffect6148ui_story = var_203_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_4 = 0.200000002980232

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_4 and not isNil(var_203_3) then
				if arg_200_1.var_.characterEffect6148ui_story and not isNil(var_203_3) then
					arg_200_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= 0 + var_203_4 and arg_200_1.time_ < 0 + var_203_4 + arg_203_0 and not isNil(var_203_3) and arg_200_1.var_.characterEffect6148ui_story then
				arg_200_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_203_6 = arg_200_1.actors_["1054ui_story"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_6) and arg_200_1.var_.characterEffect1054ui_story == nil then
				arg_200_1.var_.characterEffect1054ui_story = var_203_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_7 = 0.200000002980232

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_7 and not isNil(var_203_6) then
				if arg_200_1.var_.characterEffect1054ui_story and not isNil(var_203_6) then
					arg_200_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_200_1.time_ - 0) / var_203_7)
				end
			end

			if arg_200_1.time_ >= 0 + var_203_7 and arg_200_1.time_ < 0 + var_203_7 + arg_203_0 and not isNil(var_203_6) and arg_200_1.var_.characterEffect1054ui_story then
				arg_200_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_203_8 = 0
			local var_203_9 = 0.525

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_8 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_10 = arg_200_1:GetWordFromCfg(324161046)
				local var_203_11 = arg_200_1:FormatText(var_203_10.content)

				arg_200_1.text_.text = var_203_11

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_13 = 21 <= 0 and var_203_9 or var_203_9 * (utf8.len(var_203_11) / 21)

				if (21 <= 0 and var_203_9 or var_203_9 * (utf8.len(var_203_11) / 21)) > 0 and var_203_9 < var_203_13 then
					arg_200_1.talkMaxDuration = var_203_13

					if var_203_13 + var_203_8 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_13 + var_203_8
					end
				end

				arg_200_1.text_.text = var_203_11
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161046", "story_v_out_324161.awb") ~= 0 then
					local var_203_14 = manager.audio:GetVoiceLength("story_v_out_324161", "324161046", "story_v_out_324161.awb") / 1000

					if var_203_14 + var_203_8 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_14 + var_203_8
					end

					if var_203_10.prefab_name ~= "" and arg_200_1.actors_[var_203_10.prefab_name] ~= nil then
						local var_203_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_10.prefab_name].transform, "story_v_out_324161", "324161046", "story_v_out_324161.awb")

						arg_200_1:RecordAudio("324161046", var_203_15)
						arg_200_1:RecordAudio("324161046", var_203_15)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_324161", "324161046", "story_v_out_324161.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_324161", "324161046", "story_v_out_324161.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_16 = math.max(var_203_9, arg_200_1.talkMaxDuration)

			if var_203_8 <= arg_200_1.time_ and arg_200_1.time_ < var_203_8 + var_203_16 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_8) / var_203_16

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_8 + var_203_16 and arg_200_1.time_ < var_203_8 + var_203_16 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play324161047 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 324161047
		arg_204_1.duration_ = 4.47

		local var_204_0 = {
			zh = 2.4,
			ja = 4.466
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play324161048(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(arg_204_1.actors_["1054ui_story"]) and arg_204_1.var_.characterEffect1054ui_story == nil then
				arg_204_1.var_.characterEffect1054ui_story = arg_204_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_0 = 0.200000002980232

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 and not isNil(arg_204_1.actors_["1054ui_story"]) then
				if arg_204_1.var_.characterEffect1054ui_story and not isNil(arg_204_1.actors_["1054ui_story"]) then
					arg_204_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 and not isNil(arg_204_1.actors_["1054ui_story"]) and arg_204_1.var_.characterEffect1054ui_story then
				arg_204_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_207_2 = arg_204_1.actors_["6148ui_story"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_2) and arg_204_1.var_.characterEffect6148ui_story == nil then
				arg_204_1.var_.characterEffect6148ui_story = var_207_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_3 = 0.200000002980232

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_3 and not isNil(var_207_2) then
				if arg_204_1.var_.characterEffect6148ui_story and not isNil(var_207_2) then
					arg_204_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_204_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_204_1.time_ - 0) / var_207_3)
				end
			end

			if arg_204_1.time_ >= 0 + var_207_3 and arg_204_1.time_ < 0 + var_207_3 + arg_207_0 and not isNil(var_207_2) and arg_204_1.var_.characterEffect6148ui_story then
				arg_204_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_204_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_207_4 = 0
			local var_207_5 = 0.3

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_4 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_6 = arg_204_1:GetWordFromCfg(324161047)
				local var_207_7 = arg_204_1:FormatText(var_207_6.content)

				arg_204_1.text_.text = var_207_7

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_9 = 12 <= 0 and var_207_5 or var_207_5 * (utf8.len(var_207_7) / 12)

				if (12 <= 0 and var_207_5 or var_207_5 * (utf8.len(var_207_7) / 12)) > 0 and var_207_5 < var_207_9 then
					arg_204_1.talkMaxDuration = var_207_9

					if var_207_9 + var_207_4 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_9 + var_207_4
					end
				end

				arg_204_1.text_.text = var_207_7
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161047", "story_v_out_324161.awb") ~= 0 then
					local var_207_10 = manager.audio:GetVoiceLength("story_v_out_324161", "324161047", "story_v_out_324161.awb") / 1000

					if var_207_10 + var_207_4 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_10 + var_207_4
					end

					if var_207_6.prefab_name ~= "" and arg_204_1.actors_[var_207_6.prefab_name] ~= nil then
						local var_207_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_6.prefab_name].transform, "story_v_out_324161", "324161047", "story_v_out_324161.awb")

						arg_204_1:RecordAudio("324161047", var_207_11)
						arg_204_1:RecordAudio("324161047", var_207_11)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_324161", "324161047", "story_v_out_324161.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_324161", "324161047", "story_v_out_324161.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_12 = math.max(var_207_5, arg_204_1.talkMaxDuration)

			if var_207_4 <= arg_204_1.time_ and arg_204_1.time_ < var_207_4 + var_207_12 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_4) / var_207_12

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_4 + var_207_12 and arg_204_1.time_ < var_207_4 + var_207_12 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play324161048 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 324161048
		arg_208_1.duration_ = 6.67

		local var_208_0 = {
			zh = 2.5,
			ja = 6.666
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play324161049(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(arg_208_1.actors_["6148ui_story"]) and arg_208_1.var_.characterEffect6148ui_story == nil then
				arg_208_1.var_.characterEffect6148ui_story = arg_208_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_0 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 and not isNil(arg_208_1.actors_["6148ui_story"]) then
				if arg_208_1.var_.characterEffect6148ui_story and not isNil(arg_208_1.actors_["6148ui_story"]) then
					arg_208_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 and not isNil(arg_208_1.actors_["6148ui_story"]) and arg_208_1.var_.characterEffect6148ui_story then
				arg_208_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_211_2 = arg_208_1.actors_["1054ui_story"]

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(var_211_2) and arg_208_1.var_.characterEffect1054ui_story == nil then
				arg_208_1.var_.characterEffect1054ui_story = var_211_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_3 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_3 and not isNil(var_211_2) then
				if arg_208_1.var_.characterEffect1054ui_story and not isNil(var_211_2) then
					arg_208_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_208_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_208_1.time_ - 0) / var_211_3)
				end
			end

			if arg_208_1.time_ >= 0 + var_211_3 and arg_208_1.time_ < 0 + var_211_3 + arg_211_0 and not isNil(var_211_2) and arg_208_1.var_.characterEffect1054ui_story then
				arg_208_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_208_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_211_4 = 0
			local var_211_5 = 0.325

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_4 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_6 = arg_208_1:GetWordFromCfg(324161048)
				local var_211_7 = arg_208_1:FormatText(var_211_6.content)

				arg_208_1.text_.text = var_211_7

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_9 = 13 <= 0 and var_211_5 or var_211_5 * (utf8.len(var_211_7) / 13)

				if (13 <= 0 and var_211_5 or var_211_5 * (utf8.len(var_211_7) / 13)) > 0 and var_211_5 < var_211_9 then
					arg_208_1.talkMaxDuration = var_211_9

					if var_211_9 + var_211_4 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_9 + var_211_4
					end
				end

				arg_208_1.text_.text = var_211_7
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161048", "story_v_out_324161.awb") ~= 0 then
					local var_211_10 = manager.audio:GetVoiceLength("story_v_out_324161", "324161048", "story_v_out_324161.awb") / 1000

					if var_211_10 + var_211_4 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_10 + var_211_4
					end

					if var_211_6.prefab_name ~= "" and arg_208_1.actors_[var_211_6.prefab_name] ~= nil then
						local var_211_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_6.prefab_name].transform, "story_v_out_324161", "324161048", "story_v_out_324161.awb")

						arg_208_1:RecordAudio("324161048", var_211_11)
						arg_208_1:RecordAudio("324161048", var_211_11)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_324161", "324161048", "story_v_out_324161.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_324161", "324161048", "story_v_out_324161.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_12 = math.max(var_211_5, arg_208_1.talkMaxDuration)

			if var_211_4 <= arg_208_1.time_ and arg_208_1.time_ < var_211_4 + var_211_12 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_4) / var_211_12

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_4 + var_211_12 and arg_208_1.time_ < var_211_4 + var_211_12 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play324161049 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 324161049
		arg_212_1.duration_ = 7.6

		local var_212_0 = {
			zh = 5.1,
			ja = 7.6
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play324161050(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(arg_212_1.actors_["1054ui_story"]) and arg_212_1.var_.characterEffect1054ui_story == nil then
				arg_212_1.var_.characterEffect1054ui_story = arg_212_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_0 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 and not isNil(arg_212_1.actors_["1054ui_story"]) then
				if arg_212_1.var_.characterEffect1054ui_story and not isNil(arg_212_1.actors_["1054ui_story"]) then
					arg_212_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 and not isNil(arg_212_1.actors_["1054ui_story"]) and arg_212_1.var_.characterEffect1054ui_story then
				arg_212_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_215_2 = arg_212_1.actors_["6148ui_story"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_2) and arg_212_1.var_.characterEffect6148ui_story == nil then
				arg_212_1.var_.characterEffect6148ui_story = var_215_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_3 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_3 and not isNil(var_215_2) then
				if arg_212_1.var_.characterEffect6148ui_story and not isNil(var_215_2) then
					arg_212_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_212_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_212_1.time_ - 0) / var_215_3)
				end
			end

			if arg_212_1.time_ >= 0 + var_215_3 and arg_212_1.time_ < 0 + var_215_3 + arg_215_0 and not isNil(var_215_2) and arg_212_1.var_.characterEffect6148ui_story then
				arg_212_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_212_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action2_1")
			end

			local var_215_4 = 0
			local var_215_5 = 0.45

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_4 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_6 = arg_212_1:GetWordFromCfg(324161049)
				local var_215_7 = arg_212_1:FormatText(var_215_6.content)

				arg_212_1.text_.text = var_215_7

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_9 = 18 <= 0 and var_215_5 or var_215_5 * (utf8.len(var_215_7) / 18)

				if (18 <= 0 and var_215_5 or var_215_5 * (utf8.len(var_215_7) / 18)) > 0 and var_215_5 < var_215_9 then
					arg_212_1.talkMaxDuration = var_215_9

					if var_215_9 + var_215_4 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_9 + var_215_4
					end
				end

				arg_212_1.text_.text = var_215_7
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161049", "story_v_out_324161.awb") ~= 0 then
					local var_215_10 = manager.audio:GetVoiceLength("story_v_out_324161", "324161049", "story_v_out_324161.awb") / 1000

					if var_215_10 + var_215_4 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_10 + var_215_4
					end

					if var_215_6.prefab_name ~= "" and arg_212_1.actors_[var_215_6.prefab_name] ~= nil then
						local var_215_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_6.prefab_name].transform, "story_v_out_324161", "324161049", "story_v_out_324161.awb")

						arg_212_1:RecordAudio("324161049", var_215_11)
						arg_212_1:RecordAudio("324161049", var_215_11)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_324161", "324161049", "story_v_out_324161.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_324161", "324161049", "story_v_out_324161.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_12 = math.max(var_215_5, arg_212_1.talkMaxDuration)

			if var_215_4 <= arg_212_1.time_ and arg_212_1.time_ < var_215_4 + var_215_12 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_4) / var_215_12

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_4 + var_215_12 and arg_212_1.time_ < var_215_4 + var_215_12 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play324161050 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 324161050
		arg_216_1.duration_ = 1.87

		local var_216_0 = {
			zh = 1,
			ja = 1.866
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play324161051(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(arg_216_1.actors_["6148ui_story"]) and arg_216_1.var_.characterEffect6148ui_story == nil then
				arg_216_1.var_.characterEffect6148ui_story = arg_216_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_0 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 and not isNil(arg_216_1.actors_["6148ui_story"]) then
				if arg_216_1.var_.characterEffect6148ui_story and not isNil(arg_216_1.actors_["6148ui_story"]) then
					arg_216_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 and not isNil(arg_216_1.actors_["6148ui_story"]) and arg_216_1.var_.characterEffect6148ui_story then
				arg_216_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_219_2 = arg_216_1.actors_["1054ui_story"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_2) and arg_216_1.var_.characterEffect1054ui_story == nil then
				arg_216_1.var_.characterEffect1054ui_story = var_219_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_3 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_3 and not isNil(var_219_2) then
				if arg_216_1.var_.characterEffect1054ui_story and not isNil(var_219_2) then
					arg_216_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_216_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_216_1.time_ - 0) / var_219_3)
				end
			end

			if arg_216_1.time_ >= 0 + var_219_3 and arg_216_1.time_ < 0 + var_219_3 + arg_219_0 and not isNil(var_219_2) and arg_216_1.var_.characterEffect1054ui_story then
				arg_216_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_216_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_219_4 = 0
			local var_219_5 = 0.05

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_4 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_6 = arg_216_1:GetWordFromCfg(324161050)
				local var_219_7 = arg_216_1:FormatText(var_219_6.content)

				arg_216_1.text_.text = var_219_7

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_9 = 2 <= 0 and var_219_5 or var_219_5 * (utf8.len(var_219_7) / 2)

				if (2 <= 0 and var_219_5 or var_219_5 * (utf8.len(var_219_7) / 2)) > 0 and var_219_5 < var_219_9 then
					arg_216_1.talkMaxDuration = var_219_9

					if var_219_9 + var_219_4 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_9 + var_219_4
					end
				end

				arg_216_1.text_.text = var_219_7
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161050", "story_v_out_324161.awb") ~= 0 then
					local var_219_10 = manager.audio:GetVoiceLength("story_v_out_324161", "324161050", "story_v_out_324161.awb") / 1000

					if var_219_10 + var_219_4 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_10 + var_219_4
					end

					if var_219_6.prefab_name ~= "" and arg_216_1.actors_[var_219_6.prefab_name] ~= nil then
						local var_219_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_6.prefab_name].transform, "story_v_out_324161", "324161050", "story_v_out_324161.awb")

						arg_216_1:RecordAudio("324161050", var_219_11)
						arg_216_1:RecordAudio("324161050", var_219_11)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_324161", "324161050", "story_v_out_324161.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_324161", "324161050", "story_v_out_324161.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_12 = math.max(var_219_5, arg_216_1.talkMaxDuration)

			if var_219_4 <= arg_216_1.time_ and arg_216_1.time_ < var_219_4 + var_219_12 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_4) / var_219_12

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_4 + var_219_12 and arg_216_1.time_ < var_219_4 + var_219_12 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play324161051 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 324161051
		arg_220_1.duration_ = 6.67

		local var_220_0 = {
			zh = 6.166,
			ja = 6.666
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play324161052(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(arg_220_1.actors_["1054ui_story"]) and arg_220_1.var_.characterEffect1054ui_story == nil then
				arg_220_1.var_.characterEffect1054ui_story = arg_220_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_0 = 0.200000002980232

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 and not isNil(arg_220_1.actors_["1054ui_story"]) then
				if arg_220_1.var_.characterEffect1054ui_story and not isNil(arg_220_1.actors_["1054ui_story"]) then
					arg_220_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 and not isNil(arg_220_1.actors_["1054ui_story"]) and arg_220_1.var_.characterEffect1054ui_story then
				arg_220_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_223_2 = arg_220_1.actors_["6148ui_story"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_2) and arg_220_1.var_.characterEffect6148ui_story == nil then
				arg_220_1.var_.characterEffect6148ui_story = var_223_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_3 = 0.200000002980232

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_3 and not isNil(var_223_2) then
				if arg_220_1.var_.characterEffect6148ui_story and not isNil(var_223_2) then
					arg_220_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_220_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_220_1.time_ - 0) / var_223_3)
				end
			end

			if arg_220_1.time_ >= 0 + var_223_3 and arg_220_1.time_ < 0 + var_223_3 + arg_223_0 and not isNil(var_223_2) and arg_220_1.var_.characterEffect6148ui_story then
				arg_220_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_220_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action2_2")
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_223_4 = 0
			local var_223_5 = 0.7

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_4 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_6 = arg_220_1:GetWordFromCfg(324161051)
				local var_223_7 = arg_220_1:FormatText(var_223_6.content)

				arg_220_1.text_.text = var_223_7

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_9 = 28 <= 0 and var_223_5 or var_223_5 * (utf8.len(var_223_7) / 28)

				if (28 <= 0 and var_223_5 or var_223_5 * (utf8.len(var_223_7) / 28)) > 0 and var_223_5 < var_223_9 then
					arg_220_1.talkMaxDuration = var_223_9

					if var_223_9 + var_223_4 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_9 + var_223_4
					end
				end

				arg_220_1.text_.text = var_223_7
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161051", "story_v_out_324161.awb") ~= 0 then
					local var_223_10 = manager.audio:GetVoiceLength("story_v_out_324161", "324161051", "story_v_out_324161.awb") / 1000

					if var_223_10 + var_223_4 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_10 + var_223_4
					end

					if var_223_6.prefab_name ~= "" and arg_220_1.actors_[var_223_6.prefab_name] ~= nil then
						local var_223_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_6.prefab_name].transform, "story_v_out_324161", "324161051", "story_v_out_324161.awb")

						arg_220_1:RecordAudio("324161051", var_223_11)
						arg_220_1:RecordAudio("324161051", var_223_11)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_324161", "324161051", "story_v_out_324161.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_324161", "324161051", "story_v_out_324161.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_12 = math.max(var_223_5, arg_220_1.talkMaxDuration)

			if var_223_4 <= arg_220_1.time_ and arg_220_1.time_ < var_223_4 + var_223_12 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_4) / var_223_12

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_4 + var_223_12 and arg_220_1.time_ < var_223_4 + var_223_12 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play324161052 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 324161052
		arg_224_1.duration_ = 3.33

		local var_224_0 = {
			zh = 3.333,
			ja = 3.3
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play324161053(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(arg_224_1.actors_["6148ui_story"]) and arg_224_1.var_.characterEffect6148ui_story == nil then
				arg_224_1.var_.characterEffect6148ui_story = arg_224_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_0 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 and not isNil(arg_224_1.actors_["6148ui_story"]) then
				if arg_224_1.var_.characterEffect6148ui_story and not isNil(arg_224_1.actors_["6148ui_story"]) then
					arg_224_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 and not isNil(arg_224_1.actors_["6148ui_story"]) and arg_224_1.var_.characterEffect6148ui_story then
				arg_224_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_227_2 = arg_224_1.actors_["1054ui_story"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_2) and arg_224_1.var_.characterEffect1054ui_story == nil then
				arg_224_1.var_.characterEffect1054ui_story = var_227_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_3 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_3 and not isNil(var_227_2) then
				if arg_224_1.var_.characterEffect1054ui_story and not isNil(var_227_2) then
					arg_224_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_224_1.time_ - 0) / var_227_3)
				end
			end

			if arg_224_1.time_ >= 0 + var_227_3 and arg_224_1.time_ < 0 + var_227_3 + arg_227_0 and not isNil(var_227_2) and arg_224_1.var_.characterEffect1054ui_story then
				arg_224_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_227_4 = 0
			local var_227_5 = 0.275

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_4 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_6 = arg_224_1:GetWordFromCfg(324161052)
				local var_227_7 = arg_224_1:FormatText(var_227_6.content)

				arg_224_1.text_.text = var_227_7

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_9 = 11 <= 0 and var_227_5 or var_227_5 * (utf8.len(var_227_7) / 11)

				if (11 <= 0 and var_227_5 or var_227_5 * (utf8.len(var_227_7) / 11)) > 0 and var_227_5 < var_227_9 then
					arg_224_1.talkMaxDuration = var_227_9

					if var_227_9 + var_227_4 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_9 + var_227_4
					end
				end

				arg_224_1.text_.text = var_227_7
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161052", "story_v_out_324161.awb") ~= 0 then
					local var_227_10 = manager.audio:GetVoiceLength("story_v_out_324161", "324161052", "story_v_out_324161.awb") / 1000

					if var_227_10 + var_227_4 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_10 + var_227_4
					end

					if var_227_6.prefab_name ~= "" and arg_224_1.actors_[var_227_6.prefab_name] ~= nil then
						local var_227_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_6.prefab_name].transform, "story_v_out_324161", "324161052", "story_v_out_324161.awb")

						arg_224_1:RecordAudio("324161052", var_227_11)
						arg_224_1:RecordAudio("324161052", var_227_11)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_324161", "324161052", "story_v_out_324161.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_324161", "324161052", "story_v_out_324161.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_12 = math.max(var_227_5, arg_224_1.talkMaxDuration)

			if var_227_4 <= arg_224_1.time_ and arg_224_1.time_ < var_227_4 + var_227_12 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_4) / var_227_12

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_4 + var_227_12 and arg_224_1.time_ < var_227_4 + var_227_12 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play324161053 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 324161053
		arg_228_1.duration_ = 5.33

		local var_228_0 = {
			zh = 5.333,
			ja = 4.633
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play324161054(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(arg_228_1.actors_["1054ui_story"]) and arg_228_1.var_.characterEffect1054ui_story == nil then
				arg_228_1.var_.characterEffect1054ui_story = arg_228_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_0 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 and not isNil(arg_228_1.actors_["1054ui_story"]) then
				if arg_228_1.var_.characterEffect1054ui_story and not isNil(arg_228_1.actors_["1054ui_story"]) then
					arg_228_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 and not isNil(arg_228_1.actors_["1054ui_story"]) and arg_228_1.var_.characterEffect1054ui_story then
				arg_228_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_231_2 = arg_228_1.actors_["6148ui_story"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_2) and arg_228_1.var_.characterEffect6148ui_story == nil then
				arg_228_1.var_.characterEffect6148ui_story = var_231_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_3 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_3 and not isNil(var_231_2) then
				if arg_228_1.var_.characterEffect6148ui_story and not isNil(var_231_2) then
					arg_228_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_228_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_228_1.time_ - 0) / var_231_3)
				end
			end

			if arg_228_1.time_ >= 0 + var_231_3 and arg_228_1.time_ < 0 + var_231_3 + arg_231_0 and not isNil(var_231_2) and arg_228_1.var_.characterEffect6148ui_story then
				arg_228_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_228_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_231_4 = 0
			local var_231_5 = 0.475

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_4 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_6 = arg_228_1:GetWordFromCfg(324161053)
				local var_231_7 = arg_228_1:FormatText(var_231_6.content)

				arg_228_1.text_.text = var_231_7

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_9 = 19 <= 0 and var_231_5 or var_231_5 * (utf8.len(var_231_7) / 19)

				if (19 <= 0 and var_231_5 or var_231_5 * (utf8.len(var_231_7) / 19)) > 0 and var_231_5 < var_231_9 then
					arg_228_1.talkMaxDuration = var_231_9

					if var_231_9 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_9 + var_231_4
					end
				end

				arg_228_1.text_.text = var_231_7
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161053", "story_v_out_324161.awb") ~= 0 then
					local var_231_10 = manager.audio:GetVoiceLength("story_v_out_324161", "324161053", "story_v_out_324161.awb") / 1000

					if var_231_10 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_10 + var_231_4
					end

					if var_231_6.prefab_name ~= "" and arg_228_1.actors_[var_231_6.prefab_name] ~= nil then
						local var_231_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_6.prefab_name].transform, "story_v_out_324161", "324161053", "story_v_out_324161.awb")

						arg_228_1:RecordAudio("324161053", var_231_11)
						arg_228_1:RecordAudio("324161053", var_231_11)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_324161", "324161053", "story_v_out_324161.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_324161", "324161053", "story_v_out_324161.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_12 = math.max(var_231_5, arg_228_1.talkMaxDuration)

			if var_231_4 <= arg_228_1.time_ and arg_228_1.time_ < var_231_4 + var_231_12 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_4) / var_231_12

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_4 + var_231_12 and arg_228_1.time_ < var_231_4 + var_231_12 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play324161054 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 324161054
		arg_232_1.duration_ = 4.2

		local var_232_0 = {
			zh = 3.6,
			ja = 4.2
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play324161055(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(arg_232_1.actors_["6148ui_story"]) and arg_232_1.var_.characterEffect6148ui_story == nil then
				arg_232_1.var_.characterEffect6148ui_story = arg_232_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_0 = 0.200000002980232

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_0 and not isNil(arg_232_1.actors_["6148ui_story"]) then
				if arg_232_1.var_.characterEffect6148ui_story and not isNil(arg_232_1.actors_["6148ui_story"]) then
					arg_232_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= 0 + var_235_0 and arg_232_1.time_ < 0 + var_235_0 + arg_235_0 and not isNil(arg_232_1.actors_["6148ui_story"]) and arg_232_1.var_.characterEffect6148ui_story then
				arg_232_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_235_2 = arg_232_1.actors_["1054ui_story"]

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(var_235_2) and arg_232_1.var_.characterEffect1054ui_story == nil then
				arg_232_1.var_.characterEffect1054ui_story = var_235_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_3 = 0.200000002980232

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_3 and not isNil(var_235_2) then
				if arg_232_1.var_.characterEffect1054ui_story and not isNil(var_235_2) then
					arg_232_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_232_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_232_1.time_ - 0) / var_235_3)
				end
			end

			if arg_232_1.time_ >= 0 + var_235_3 and arg_232_1.time_ < 0 + var_235_3 + arg_235_0 and not isNil(var_235_2) and arg_232_1.var_.characterEffect1054ui_story then
				arg_232_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_232_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_235_4 = 0
			local var_235_5 = 0.275

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_4 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_6 = arg_232_1:GetWordFromCfg(324161054)
				local var_235_7 = arg_232_1:FormatText(var_235_6.content)

				arg_232_1.text_.text = var_235_7

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_9 = 11 <= 0 and var_235_5 or var_235_5 * (utf8.len(var_235_7) / 11)

				if (11 <= 0 and var_235_5 or var_235_5 * (utf8.len(var_235_7) / 11)) > 0 and var_235_5 < var_235_9 then
					arg_232_1.talkMaxDuration = var_235_9

					if var_235_9 + var_235_4 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_9 + var_235_4
					end
				end

				arg_232_1.text_.text = var_235_7
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161054", "story_v_out_324161.awb") ~= 0 then
					local var_235_10 = manager.audio:GetVoiceLength("story_v_out_324161", "324161054", "story_v_out_324161.awb") / 1000

					if var_235_10 + var_235_4 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_10 + var_235_4
					end

					if var_235_6.prefab_name ~= "" and arg_232_1.actors_[var_235_6.prefab_name] ~= nil then
						local var_235_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_6.prefab_name].transform, "story_v_out_324161", "324161054", "story_v_out_324161.awb")

						arg_232_1:RecordAudio("324161054", var_235_11)
						arg_232_1:RecordAudio("324161054", var_235_11)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_324161", "324161054", "story_v_out_324161.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_324161", "324161054", "story_v_out_324161.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_12 = math.max(var_235_5, arg_232_1.talkMaxDuration)

			if var_235_4 <= arg_232_1.time_ and arg_232_1.time_ < var_235_4 + var_235_12 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_4) / var_235_12

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_4 + var_235_12 and arg_232_1.time_ < var_235_4 + var_235_12 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play324161055 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 324161055
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play324161056(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos1054ui_story = arg_236_1.actors_["1054ui_story"].transform.localPosition

				local var_239_0 = GameObjectTools.GetOrAddComponent(arg_236_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_239_0 then
					var_239_0:EnableDynamicBone(false)
				end
			end

			local var_239_1 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_1 then
				arg_236_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_236_1.time_ - 0) / var_239_1)
				arg_236_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1054ui_story"].transform.position).z)
				arg_236_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["1054ui_story"].transform.localEulerAngles = arg_236_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_236_1.time_ >= 0 + var_239_1 and arg_236_1.time_ < 0 + var_239_1 + arg_239_0 then
				arg_236_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_236_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1054ui_story"].transform.position).z)
				arg_236_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["1054ui_story"].transform.localEulerAngles = arg_236_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_239_2 = GameObjectTools.GetOrAddComponent(arg_236_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_239_2 then
					var_239_2:EnableDynamicBone(true)
				end
			end

			local var_239_3 = arg_236_1.actors_["6148ui_story"].transform

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos6148ui_story = var_239_3.localPosition

				local var_239_4 = GameObjectTools.GetOrAddComponent(var_239_3.gameObject, typeof(DynamicBoneHelper))

				if var_239_4 then
					var_239_4:EnableDynamicBone(false)
				end
			end

			local var_239_5 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_5 then
				var_239_3.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_236_1.time_ - 0) / var_239_5)
				var_239_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_239_3.position).x, (manager.ui.mainCamera.transform.position - var_239_3.position).y, (manager.ui.mainCamera.transform.position - var_239_3.position).z)
				var_239_3.localEulerAngles.z = 0
				var_239_3.localEulerAngles.x = 0
				var_239_3.localEulerAngles = var_239_3.localEulerAngles
			end

			if arg_236_1.time_ >= 0 + var_239_5 and arg_236_1.time_ < 0 + var_239_5 + arg_239_0 then
				var_239_3.localPosition = Vector3.New(0, 100, 0)
				var_239_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_239_3.position).x, (manager.ui.mainCamera.transform.position - var_239_3.position).y, (manager.ui.mainCamera.transform.position - var_239_3.position).z)
				var_239_3.localEulerAngles.z = 0
				var_239_3.localEulerAngles.x = 0
				var_239_3.localEulerAngles = var_239_3.localEulerAngles

				local var_239_6 = GameObjectTools.GetOrAddComponent(var_239_3.gameObject, typeof(DynamicBoneHelper))

				if var_239_6 then
					var_239_6:EnableDynamicBone(true)
				end
			end

			local var_239_7 = arg_236_1.actors_["6148ui_story"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_7) and arg_236_1.var_.characterEffect6148ui_story == nil then
				arg_236_1.var_.characterEffect6148ui_story = var_239_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_8 = 0.200000002980232

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_8 and not isNil(var_239_7) then
				if arg_236_1.var_.characterEffect6148ui_story and not isNil(var_239_7) then
					arg_236_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_236_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_236_1.time_ - 0) / var_239_8)
				end
			end

			if arg_236_1.time_ >= 0 + var_239_8 and arg_236_1.time_ < 0 + var_239_8 + arg_239_0 and not isNil(var_239_7) and arg_236_1.var_.characterEffect6148ui_story then
				arg_236_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_236_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_239_9 = 0
			local var_239_10 = 1.025

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_9 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, false)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_11 = arg_236_1:FormatText(arg_236_1:GetWordFromCfg(324161055).content)

				arg_236_1.text_.text = var_239_11

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_13 = 41 <= 0 and var_239_10 or var_239_10 * (utf8.len(var_239_11) / 41)

				if (41 <= 0 and var_239_10 or var_239_10 * (utf8.len(var_239_11) / 41)) > 0 and var_239_10 < var_239_13 then
					arg_236_1.talkMaxDuration = var_239_13

					if var_239_13 + var_239_9 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_13 + var_239_9
					end
				end

				arg_236_1.text_.text = var_239_11
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_14 = math.max(var_239_10, arg_236_1.talkMaxDuration)

			if var_239_9 <= arg_236_1.time_ and arg_236_1.time_ < var_239_9 + var_239_14 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_9) / var_239_14

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_9 + var_239_14 and arg_236_1.time_ < var_239_9 + var_239_14 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play324161056 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 324161056
		arg_240_1.duration_ = 6.33

		local var_240_0 = {
			zh = 6.333,
			ja = 5.966
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play324161057(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos6148ui_story = arg_240_1.actors_["6148ui_story"].transform.localPosition

				local var_243_0 = GameObjectTools.GetOrAddComponent(arg_240_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_243_0 then
					var_243_0:EnableDynamicBone(false)
				end
			end

			local var_243_1 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_1 then
				arg_240_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_240_1.time_ - 0) / var_243_1)
				arg_240_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["6148ui_story"].transform.position).z)
				arg_240_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["6148ui_story"].transform.localEulerAngles = arg_240_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_240_1.time_ >= 0 + var_243_1 and arg_240_1.time_ < 0 + var_243_1 + arg_243_0 then
				arg_240_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_240_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["6148ui_story"].transform.position).z)
				arg_240_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["6148ui_story"].transform.localEulerAngles = arg_240_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_243_2 = GameObjectTools.GetOrAddComponent(arg_240_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_243_2 then
					var_243_2:EnableDynamicBone(true)
				end
			end

			local var_243_3 = arg_240_1.actors_["1054ui_story"]

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(var_243_3) and arg_240_1.var_.characterEffect1054ui_story == nil then
				arg_240_1.var_.characterEffect1054ui_story = var_243_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_4 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_4 and not isNil(var_243_3) then
				if arg_240_1.var_.characterEffect1054ui_story and not isNil(var_243_3) then
					arg_240_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_240_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_240_1.time_ - 0) / var_243_4)
				end
			end

			if arg_240_1.time_ >= 0 + var_243_4 and arg_240_1.time_ < 0 + var_243_4 + arg_243_0 and not isNil(var_243_3) and arg_240_1.var_.characterEffect1054ui_story then
				arg_240_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_240_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_243_5 = arg_240_1.actors_["6148ui_story"]

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(var_243_5) and arg_240_1.var_.characterEffect6148ui_story == nil then
				arg_240_1.var_.characterEffect6148ui_story = var_243_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_6 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_6 and not isNil(var_243_5) then
				if arg_240_1.var_.characterEffect6148ui_story and not isNil(var_243_5) then
					arg_240_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= 0 + var_243_6 and arg_240_1.time_ < 0 + var_243_6 + arg_243_0 and not isNil(var_243_5) and arg_240_1.var_.characterEffect6148ui_story then
				arg_240_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_243_8 = 0
			local var_243_9 = 0.6

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_8 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_10 = arg_240_1:GetWordFromCfg(324161056)
				local var_243_11 = arg_240_1:FormatText(var_243_10.content)

				arg_240_1.text_.text = var_243_11

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_13 = 24 <= 0 and var_243_9 or var_243_9 * (utf8.len(var_243_11) / 24)

				if (24 <= 0 and var_243_9 or var_243_9 * (utf8.len(var_243_11) / 24)) > 0 and var_243_9 < var_243_13 then
					arg_240_1.talkMaxDuration = var_243_13

					if var_243_13 + var_243_8 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_13 + var_243_8
					end
				end

				arg_240_1.text_.text = var_243_11
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161056", "story_v_out_324161.awb") ~= 0 then
					local var_243_14 = manager.audio:GetVoiceLength("story_v_out_324161", "324161056", "story_v_out_324161.awb") / 1000

					if var_243_14 + var_243_8 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_14 + var_243_8
					end

					if var_243_10.prefab_name ~= "" and arg_240_1.actors_[var_243_10.prefab_name] ~= nil then
						local var_243_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_10.prefab_name].transform, "story_v_out_324161", "324161056", "story_v_out_324161.awb")

						arg_240_1:RecordAudio("324161056", var_243_15)
						arg_240_1:RecordAudio("324161056", var_243_15)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_324161", "324161056", "story_v_out_324161.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_324161", "324161056", "story_v_out_324161.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_16 = math.max(var_243_9, arg_240_1.talkMaxDuration)

			if var_243_8 <= arg_240_1.time_ and arg_240_1.time_ < var_243_8 + var_243_16 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_8) / var_243_16

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_8 + var_243_16 and arg_240_1.time_ < var_243_8 + var_243_16 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play324161057 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 324161057
		arg_244_1.duration_ = 3.87

		local var_244_0 = {
			zh = 3.033,
			ja = 3.866
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play324161058(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(arg_244_1.actors_["1054ui_story"]) and arg_244_1.var_.characterEffect1054ui_story == nil then
				arg_244_1.var_.characterEffect1054ui_story = arg_244_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_0 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 and not isNil(arg_244_1.actors_["1054ui_story"]) then
				if arg_244_1.var_.characterEffect1054ui_story and not isNil(arg_244_1.actors_["1054ui_story"]) then
					arg_244_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 and not isNil(arg_244_1.actors_["1054ui_story"]) and arg_244_1.var_.characterEffect1054ui_story then
				arg_244_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_247_2 = arg_244_1.actors_["1054ui_story"].transform

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos1054ui_story = var_247_2.localPosition

				local var_247_3 = GameObjectTools.GetOrAddComponent(var_247_2.gameObject, typeof(DynamicBoneHelper))

				if var_247_3 then
					var_247_3:EnableDynamicBone(false)
				end
			end

			local var_247_4 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_4 then
				var_247_2.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_244_1.time_ - 0) / var_247_4)
				var_247_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_247_2.position).x, (manager.ui.mainCamera.transform.position - var_247_2.position).y, (manager.ui.mainCamera.transform.position - var_247_2.position).z)
				var_247_2.localEulerAngles.z = 0
				var_247_2.localEulerAngles.x = 0
				var_247_2.localEulerAngles = var_247_2.localEulerAngles
			end

			if arg_244_1.time_ >= 0 + var_247_4 and arg_244_1.time_ < 0 + var_247_4 + arg_247_0 then
				var_247_2.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_247_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_247_2.position).x, (manager.ui.mainCamera.transform.position - var_247_2.position).y, (manager.ui.mainCamera.transform.position - var_247_2.position).z)
				var_247_2.localEulerAngles.z = 0
				var_247_2.localEulerAngles.x = 0
				var_247_2.localEulerAngles = var_247_2.localEulerAngles

				local var_247_5 = GameObjectTools.GetOrAddComponent(var_247_2.gameObject, typeof(DynamicBoneHelper))

				if var_247_5 then
					var_247_5:EnableDynamicBone(true)
				end
			end

			local var_247_6 = arg_244_1.actors_["6148ui_story"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_6) and arg_244_1.var_.characterEffect6148ui_story == nil then
				arg_244_1.var_.characterEffect6148ui_story = var_247_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_7 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_7 and not isNil(var_247_6) then
				if arg_244_1.var_.characterEffect6148ui_story and not isNil(var_247_6) then
					arg_244_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_244_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_244_1.time_ - 0) / var_247_7)
				end
			end

			if arg_244_1.time_ >= 0 + var_247_7 and arg_244_1.time_ < 0 + var_247_7 + arg_247_0 and not isNil(var_247_6) and arg_244_1.var_.characterEffect6148ui_story then
				arg_244_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_244_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_2")
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_247_8 = 0
			local var_247_9 = 0.35

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_8 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_10 = arg_244_1:GetWordFromCfg(324161057)
				local var_247_11 = arg_244_1:FormatText(var_247_10.content)

				arg_244_1.text_.text = var_247_11

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_13 = 14 <= 0 and var_247_9 or var_247_9 * (utf8.len(var_247_11) / 14)

				if (14 <= 0 and var_247_9 or var_247_9 * (utf8.len(var_247_11) / 14)) > 0 and var_247_9 < var_247_13 then
					arg_244_1.talkMaxDuration = var_247_13

					if var_247_13 + var_247_8 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_13 + var_247_8
					end
				end

				arg_244_1.text_.text = var_247_11
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161057", "story_v_out_324161.awb") ~= 0 then
					local var_247_14 = manager.audio:GetVoiceLength("story_v_out_324161", "324161057", "story_v_out_324161.awb") / 1000

					if var_247_14 + var_247_8 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_14 + var_247_8
					end

					if var_247_10.prefab_name ~= "" and arg_244_1.actors_[var_247_10.prefab_name] ~= nil then
						local var_247_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_10.prefab_name].transform, "story_v_out_324161", "324161057", "story_v_out_324161.awb")

						arg_244_1:RecordAudio("324161057", var_247_15)
						arg_244_1:RecordAudio("324161057", var_247_15)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_324161", "324161057", "story_v_out_324161.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_324161", "324161057", "story_v_out_324161.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_16 = math.max(var_247_9, arg_244_1.talkMaxDuration)

			if var_247_8 <= arg_244_1.time_ and arg_244_1.time_ < var_247_8 + var_247_16 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_8) / var_247_16

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_8 + var_247_16 and arg_244_1.time_ < var_247_8 + var_247_16 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play324161058 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 324161058
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play324161059(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos1054ui_story = arg_248_1.actors_["1054ui_story"].transform.localPosition

				local var_251_0 = GameObjectTools.GetOrAddComponent(arg_248_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_251_0 then
					var_251_0:EnableDynamicBone(false)
				end
			end

			local var_251_1 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_1 then
				arg_248_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_248_1.time_ - 0) / var_251_1)
				arg_248_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1054ui_story"].transform.position).z)
				arg_248_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["1054ui_story"].transform.localEulerAngles = arg_248_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_1 and arg_248_1.time_ < 0 + var_251_1 + arg_251_0 then
				arg_248_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_248_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1054ui_story"].transform.position).z)
				arg_248_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["1054ui_story"].transform.localEulerAngles = arg_248_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_251_2 = GameObjectTools.GetOrAddComponent(arg_248_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_251_2 then
					var_251_2:EnableDynamicBone(true)
				end
			end

			local var_251_3 = arg_248_1.actors_["6148ui_story"].transform

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos6148ui_story = var_251_3.localPosition

				local var_251_4 = GameObjectTools.GetOrAddComponent(var_251_3.gameObject, typeof(DynamicBoneHelper))

				if var_251_4 then
					var_251_4:EnableDynamicBone(false)
				end
			end

			local var_251_5 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_5 then
				var_251_3.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_248_1.time_ - 0) / var_251_5)
				var_251_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_251_3.position).x, (manager.ui.mainCamera.transform.position - var_251_3.position).y, (manager.ui.mainCamera.transform.position - var_251_3.position).z)
				var_251_3.localEulerAngles.z = 0
				var_251_3.localEulerAngles.x = 0
				var_251_3.localEulerAngles = var_251_3.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_5 and arg_248_1.time_ < 0 + var_251_5 + arg_251_0 then
				var_251_3.localPosition = Vector3.New(0, 100, 0)
				var_251_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_251_3.position).x, (manager.ui.mainCamera.transform.position - var_251_3.position).y, (manager.ui.mainCamera.transform.position - var_251_3.position).z)
				var_251_3.localEulerAngles.z = 0
				var_251_3.localEulerAngles.x = 0
				var_251_3.localEulerAngles = var_251_3.localEulerAngles

				local var_251_6 = GameObjectTools.GetOrAddComponent(var_251_3.gameObject, typeof(DynamicBoneHelper))

				if var_251_6 then
					var_251_6:EnableDynamicBone(true)
				end
			end

			local var_251_7 = arg_248_1.actors_["1054ui_story"]

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(var_251_7) and arg_248_1.var_.characterEffect1054ui_story == nil then
				arg_248_1.var_.characterEffect1054ui_story = var_251_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_8 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_8 and not isNil(var_251_7) then
				if arg_248_1.var_.characterEffect1054ui_story and not isNil(var_251_7) then
					arg_248_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_248_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_248_1.time_ - 0) / var_251_8)
				end
			end

			if arg_248_1.time_ >= 0 + var_251_8 and arg_248_1.time_ < 0 + var_251_8 + arg_251_0 and not isNil(var_251_7) and arg_248_1.var_.characterEffect1054ui_story then
				arg_248_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_248_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_251_9 = 0
			local var_251_10 = 1.075

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_9 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_11 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(324161058).content)

				arg_248_1.text_.text = var_251_11

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_13 = 43 <= 0 and var_251_10 or var_251_10 * (utf8.len(var_251_11) / 43)

				if (43 <= 0 and var_251_10 or var_251_10 * (utf8.len(var_251_11) / 43)) > 0 and var_251_10 < var_251_13 then
					arg_248_1.talkMaxDuration = var_251_13

					if var_251_13 + var_251_9 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_13 + var_251_9
					end
				end

				arg_248_1.text_.text = var_251_11
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_14 = math.max(var_251_10, arg_248_1.talkMaxDuration)

			if var_251_9 <= arg_248_1.time_ and arg_248_1.time_ < var_251_9 + var_251_14 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_9) / var_251_14

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_9 + var_251_14 and arg_248_1.time_ < var_251_9 + var_251_14 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_248_1:InitPlayNodeList()
	end,
	Play324161059 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 324161059
		arg_252_1.duration_ = 7.57

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play324161060(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if arg_252_1.bgs_.MS2404 == nil then
				local var_255_0 = Object.Instantiate(arg_252_1.paintGo_)

				var_255_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS2404")
				var_255_0.name = "MS2404"
				var_255_0.transform.parent = arg_252_1.stage_.transform
				var_255_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_252_1.bgs_.MS2404 = var_255_0
			end

			if 0.983333333333333 < arg_252_1.time_ and arg_252_1.time_ <= 0.983333333333333 + arg_255_0 then
				local var_255_1 = arg_252_1.bgs_.MS2404

				arg_252_1.bgs_.MS2404.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_255_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_255_2 = var_255_1:GetComponent("SpriteRenderer")

				if var_255_2 and var_255_2.sprite then
					local var_255_3 = 2 * (var_255_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_255_1.transform.localScale = Vector3.New(var_255_3 / var_255_2.sprite.bounds.size.y < var_255_3 * manager.ui.mainCameraCom_.aspect / var_255_2.sprite.bounds.size.x and var_255_3 * manager.ui.mainCameraCom_.aspect / var_255_2.sprite.bounds.size.x or var_255_3 / var_255_2.sprite.bounds.size.y, var_255_3 / var_255_2.sprite.bounds.size.y < var_255_3 * manager.ui.mainCameraCom_.aspect / var_255_2.sprite.bounds.size.x and var_255_3 * manager.ui.mainCameraCom_.aspect / var_255_2.sprite.bounds.size.x or var_255_3 / var_255_2.sprite.bounds.size.y, 0)
				end

				for iter_255_0, iter_255_1 in pairs(arg_252_1.bgs_) do
					if iter_255_0 ~= "MS2404" then
						iter_255_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_255_4 = 0

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_4 + arg_255_0 then
				arg_252_1.allBtn_.enabled = false
			end

			if arg_252_1.time_ >= var_255_4 + 0.3 and arg_252_1.time_ < var_255_4 + 0.3 + arg_255_0 then
				arg_252_1.allBtn_.enabled = true
			end

			local var_255_5 = 0

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_5 + arg_255_0 then
				arg_252_1.mask_.enabled = true
				arg_252_1.mask_.raycastTarget = true

				arg_252_1:SetGaussion(false)
			end

			local var_255_6 = 1

			if var_255_5 <= arg_252_1.time_ and arg_252_1.time_ < var_255_5 + var_255_6 then
				local var_255_7 = Color.New(0, 0, 0)

				var_255_7.a = Mathf.Lerp(0, 1, (arg_252_1.time_ - var_255_5) / var_255_6)
				arg_252_1.mask_.color = var_255_7
			end

			if arg_252_1.time_ >= var_255_5 + var_255_6 and arg_252_1.time_ < var_255_5 + var_255_6 + arg_255_0 then
				local var_255_8 = Color.New(0, 0, 0)

				var_255_8.a = 1
				arg_252_1.mask_.color = var_255_8
			end

			local var_255_9 = 1

			if 1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_9 + arg_255_0 then
				arg_252_1.mask_.enabled = true
				arg_252_1.mask_.raycastTarget = true

				arg_252_1:SetGaussion(false)
			end

			local var_255_10 = 1

			if var_255_9 <= arg_252_1.time_ and arg_252_1.time_ < var_255_9 + var_255_10 then
				local var_255_11 = Color.New(0, 0, 0)

				var_255_11.a = Mathf.Lerp(1, 0, (arg_252_1.time_ - var_255_9) / var_255_10)
				arg_252_1.mask_.color = var_255_11
			end

			if arg_252_1.time_ >= var_255_9 + var_255_10 and arg_252_1.time_ < var_255_9 + var_255_10 + arg_255_0 then
				local var_255_12 = Color.New(0, 0, 0)

				arg_252_1.mask_.enabled = false
				var_255_12.a = 0
				arg_252_1.mask_.color = var_255_12
			end

			local var_255_13 = arg_252_1.bgs_.MS2404.transform

			if 1 < arg_252_1.time_ and arg_252_1.time_ <= 1 + arg_255_0 then
				arg_252_1.var_.moveOldPosMS2404 = var_255_13.localPosition
			end

			local var_255_14 = 1.7

			if 1 <= arg_252_1.time_ and arg_252_1.time_ < 1 + var_255_14 then
				var_255_13.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPosMS2404, Vector3.New(0, 0.03, 5), (arg_252_1.time_ - 1) / var_255_14)
			end

			if arg_252_1.time_ >= 1 + var_255_14 and arg_252_1.time_ < 1 + var_255_14 + arg_255_0 then
				var_255_13.localPosition = Vector3.New(0, 0.03, 5)
			end

			local var_255_15 = 1

			if 1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_15 + arg_255_0 then
				arg_252_1.allBtn_.enabled = false
			end

			if arg_252_1.time_ >= var_255_15 + 1.7 and arg_252_1.time_ < var_255_15 + 1.7 + arg_255_0 then
				arg_252_1.allBtn_.enabled = true
			end

			if 1.2 < arg_252_1.time_ and arg_252_1.time_ <= 1.2 + arg_255_0 then
				arg_252_1:AudioAction("play", "effect", "se_story_148", "se_story_148_sword11", "")
			end

			if 0.1 < arg_252_1.time_ and arg_252_1.time_ <= 0.1 + arg_255_0 then
				arg_252_1:AudioAction("stop", "effect", "se_story_150", "se_story_150_huatian", "")
			end

			if arg_252_1.frameCnt_ <= 1 then
				arg_252_1.dialog_:SetActive(false)
			end

			local var_255_18 = 2.56666666666667
			local var_255_19 = 0.7

			if 2.56666666666667 < arg_252_1.time_ and arg_252_1.time_ <= var_255_18 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0

				arg_252_1.dialog_:SetActive(true)

				arg_252_1.dialogCg_.alpha = 0

				local var_255_20 = LeanTween.value(arg_252_1.dialog_, 0, 1, 0.3)

				var_255_20:setOnUpdate(LuaHelper.FloatAction(function(arg_256_0)
					arg_252_1.dialogCg_.alpha = arg_256_0
				end))
				var_255_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_252_1.dialog_)
					var_255_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_252_1.duration_ = arg_252_1.duration_ + 0.3

				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_21 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(324161059).content)

				arg_252_1.text_.text = var_255_21

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_23 = 28 <= 0 and var_255_19 or var_255_19 * (utf8.len(var_255_21) / 28)

				if (28 <= 0 and var_255_19 or var_255_19 * (utf8.len(var_255_21) / 28)) > 0 and var_255_19 < var_255_23 then
					arg_252_1.talkMaxDuration = var_255_23
					var_255_18 = var_255_18 + 0.3

					if var_255_23 + var_255_18 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_23 + var_255_18
					end
				end

				arg_252_1.text_.text = var_255_21
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_24 = var_255_18 + 0.3
			local var_255_25 = math.max(var_255_19, arg_252_1.talkMaxDuration)

			if var_255_18 + 0.3 <= arg_252_1.time_ and arg_252_1.time_ < var_255_24 + var_255_25 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_24) / var_255_25

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_24 + var_255_25 and arg_252_1.time_ < var_255_24 + var_255_25 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2404",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.7,
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9),
					endPos = Vector3.New(0, 0.03, 5),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_252_1:InitPlayNodeList()
	end,
	Play324161060 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 324161060
		arg_258_1.duration_ = 2.37

		local var_258_0 = {
			zh = 2.066,
			ja = 2.366
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play324161061(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(arg_258_1.actors_["6148ui_story"]) and arg_258_1.var_.characterEffect6148ui_story == nil then
				arg_258_1.var_.characterEffect6148ui_story = arg_258_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_0 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 and not isNil(arg_258_1.actors_["6148ui_story"]) then
				if arg_258_1.var_.characterEffect6148ui_story and not isNil(arg_258_1.actors_["6148ui_story"]) then
					arg_258_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 and not isNil(arg_258_1.actors_["6148ui_story"]) and arg_258_1.var_.characterEffect6148ui_story then
				arg_258_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_261_2 = 0
			local var_261_3 = 0.2

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_2 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_4 = arg_258_1:GetWordFromCfg(324161060)
				local var_261_5 = arg_258_1:FormatText(var_261_4.content)

				arg_258_1.text_.text = var_261_5

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_7 = 8 <= 0 and var_261_3 or var_261_3 * (utf8.len(var_261_5) / 8)

				if (8 <= 0 and var_261_3 or var_261_3 * (utf8.len(var_261_5) / 8)) > 0 and var_261_3 < var_261_7 then
					arg_258_1.talkMaxDuration = var_261_7

					if var_261_7 + var_261_2 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_7 + var_261_2
					end
				end

				arg_258_1.text_.text = var_261_5
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161060", "story_v_out_324161.awb") ~= 0 then
					local var_261_8 = manager.audio:GetVoiceLength("story_v_out_324161", "324161060", "story_v_out_324161.awb") / 1000

					if var_261_8 + var_261_2 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_8 + var_261_2
					end

					if var_261_4.prefab_name ~= "" and arg_258_1.actors_[var_261_4.prefab_name] ~= nil then
						local var_261_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_4.prefab_name].transform, "story_v_out_324161", "324161060", "story_v_out_324161.awb")

						arg_258_1:RecordAudio("324161060", var_261_9)
						arg_258_1:RecordAudio("324161060", var_261_9)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_324161", "324161060", "story_v_out_324161.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_324161", "324161060", "story_v_out_324161.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_10 = math.max(var_261_3, arg_258_1.talkMaxDuration)

			if var_261_2 <= arg_258_1.time_ and arg_258_1.time_ < var_261_2 + var_261_10 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_2) / var_261_10

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_2 + var_261_10 and arg_258_1.time_ < var_261_2 + var_261_10 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play324161061 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 324161061
		arg_262_1.duration_ = 7.47

		local var_262_0 = {
			zh = 4.9,
			ja = 7.466
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
				arg_262_0:Play324161062(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(arg_262_1.actors_["1054ui_story"]) and arg_262_1.var_.characterEffect1054ui_story == nil then
				arg_262_1.var_.characterEffect1054ui_story = arg_262_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_0 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 and not isNil(arg_262_1.actors_["1054ui_story"]) then
				if arg_262_1.var_.characterEffect1054ui_story and not isNil(arg_262_1.actors_["1054ui_story"]) then
					arg_262_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 and not isNil(arg_262_1.actors_["1054ui_story"]) and arg_262_1.var_.characterEffect1054ui_story then
				arg_262_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_265_2 = arg_262_1.actors_["6148ui_story"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_2) and arg_262_1.var_.characterEffect6148ui_story == nil then
				arg_262_1.var_.characterEffect6148ui_story = var_265_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_3 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_3 and not isNil(var_265_2) then
				if arg_262_1.var_.characterEffect6148ui_story and not isNil(var_265_2) then
					arg_262_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_262_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_262_1.time_ - 0) / var_265_3)
				end
			end

			if arg_262_1.time_ >= 0 + var_265_3 and arg_262_1.time_ < 0 + var_265_3 + arg_265_0 and not isNil(var_265_2) and arg_262_1.var_.characterEffect6148ui_story then
				arg_262_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_262_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_265_4 = 0
			local var_265_5 = 0.5

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_4 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_6 = arg_262_1:GetWordFromCfg(324161061)
				local var_265_7 = arg_262_1:FormatText(var_265_6.content)

				arg_262_1.text_.text = var_265_7

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_9 = 20 <= 0 and var_265_5 or var_265_5 * (utf8.len(var_265_7) / 20)

				if (20 <= 0 and var_265_5 or var_265_5 * (utf8.len(var_265_7) / 20)) > 0 and var_265_5 < var_265_9 then
					arg_262_1.talkMaxDuration = var_265_9

					if var_265_9 + var_265_4 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_9 + var_265_4
					end
				end

				arg_262_1.text_.text = var_265_7
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161061", "story_v_out_324161.awb") ~= 0 then
					local var_265_10 = manager.audio:GetVoiceLength("story_v_out_324161", "324161061", "story_v_out_324161.awb") / 1000

					if var_265_10 + var_265_4 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_10 + var_265_4
					end

					if var_265_6.prefab_name ~= "" and arg_262_1.actors_[var_265_6.prefab_name] ~= nil then
						local var_265_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_6.prefab_name].transform, "story_v_out_324161", "324161061", "story_v_out_324161.awb")

						arg_262_1:RecordAudio("324161061", var_265_11)
						arg_262_1:RecordAudio("324161061", var_265_11)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_324161", "324161061", "story_v_out_324161.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_324161", "324161061", "story_v_out_324161.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_12 = math.max(var_265_5, arg_262_1.talkMaxDuration)

			if var_265_4 <= arg_262_1.time_ and arg_262_1.time_ < var_265_4 + var_265_12 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_4) / var_265_12

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_4 + var_265_12 and arg_262_1.time_ < var_265_4 + var_265_12 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play324161062 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 324161062
		arg_266_1.duration_ = 2.3

		local var_266_0 = {
			zh = 2.3,
			ja = 2.266
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play324161063(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(arg_266_1.actors_["6148ui_story"]) and arg_266_1.var_.characterEffect6148ui_story == nil then
				arg_266_1.var_.characterEffect6148ui_story = arg_266_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_0 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 and not isNil(arg_266_1.actors_["6148ui_story"]) then
				if arg_266_1.var_.characterEffect6148ui_story and not isNil(arg_266_1.actors_["6148ui_story"]) then
					arg_266_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 and not isNil(arg_266_1.actors_["6148ui_story"]) and arg_266_1.var_.characterEffect6148ui_story then
				arg_266_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_269_2 = arg_266_1.actors_["1054ui_story"]

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(var_269_2) and arg_266_1.var_.characterEffect1054ui_story == nil then
				arg_266_1.var_.characterEffect1054ui_story = var_269_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_3 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_3 and not isNil(var_269_2) then
				if arg_266_1.var_.characterEffect1054ui_story and not isNil(var_269_2) then
					arg_266_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_266_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_266_1.time_ - 0) / var_269_3)
				end
			end

			if arg_266_1.time_ >= 0 + var_269_3 and arg_266_1.time_ < 0 + var_269_3 + arg_269_0 and not isNil(var_269_2) and arg_266_1.var_.characterEffect1054ui_story then
				arg_266_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_266_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_269_4 = 0
			local var_269_5 = 0.25

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_4 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_6 = arg_266_1:GetWordFromCfg(324161062)
				local var_269_7 = arg_266_1:FormatText(var_269_6.content)

				arg_266_1.text_.text = var_269_7

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_9 = 10 <= 0 and var_269_5 or var_269_5 * (utf8.len(var_269_7) / 10)

				if (10 <= 0 and var_269_5 or var_269_5 * (utf8.len(var_269_7) / 10)) > 0 and var_269_5 < var_269_9 then
					arg_266_1.talkMaxDuration = var_269_9

					if var_269_9 + var_269_4 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_9 + var_269_4
					end
				end

				arg_266_1.text_.text = var_269_7
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161062", "story_v_out_324161.awb") ~= 0 then
					local var_269_10 = manager.audio:GetVoiceLength("story_v_out_324161", "324161062", "story_v_out_324161.awb") / 1000

					if var_269_10 + var_269_4 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_10 + var_269_4
					end

					if var_269_6.prefab_name ~= "" and arg_266_1.actors_[var_269_6.prefab_name] ~= nil then
						local var_269_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_6.prefab_name].transform, "story_v_out_324161", "324161062", "story_v_out_324161.awb")

						arg_266_1:RecordAudio("324161062", var_269_11)
						arg_266_1:RecordAudio("324161062", var_269_11)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_324161", "324161062", "story_v_out_324161.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_324161", "324161062", "story_v_out_324161.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_12 = math.max(var_269_5, arg_266_1.talkMaxDuration)

			if var_269_4 <= arg_266_1.time_ and arg_266_1.time_ < var_269_4 + var_269_12 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_4) / var_269_12

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_4 + var_269_12 and arg_266_1.time_ < var_269_4 + var_269_12 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play324161063 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 324161063
		arg_270_1.duration_ = 5.57

		local var_270_0 = {
			zh = 5.166,
			ja = 5.566
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play324161064(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(arg_270_1.actors_["1054ui_story"]) and arg_270_1.var_.characterEffect1054ui_story == nil then
				arg_270_1.var_.characterEffect1054ui_story = arg_270_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_0 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 and not isNil(arg_270_1.actors_["1054ui_story"]) then
				if arg_270_1.var_.characterEffect1054ui_story and not isNil(arg_270_1.actors_["1054ui_story"]) then
					arg_270_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 and not isNil(arg_270_1.actors_["1054ui_story"]) and arg_270_1.var_.characterEffect1054ui_story then
				arg_270_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_273_2 = arg_270_1.actors_["6148ui_story"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_2) and arg_270_1.var_.characterEffect6148ui_story == nil then
				arg_270_1.var_.characterEffect6148ui_story = var_273_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_3 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_3 and not isNil(var_273_2) then
				if arg_270_1.var_.characterEffect6148ui_story and not isNil(var_273_2) then
					arg_270_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_270_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_270_1.time_ - 0) / var_273_3)
				end
			end

			if arg_270_1.time_ >= 0 + var_273_3 and arg_270_1.time_ < 0 + var_273_3 + arg_273_0 and not isNil(var_273_2) and arg_270_1.var_.characterEffect6148ui_story then
				arg_270_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_270_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_273_4 = 0
			local var_273_5 = 0.45

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_4 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_6 = arg_270_1:GetWordFromCfg(324161063)
				local var_273_7 = arg_270_1:FormatText(var_273_6.content)

				arg_270_1.text_.text = var_273_7

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_9 = 18 <= 0 and var_273_5 or var_273_5 * (utf8.len(var_273_7) / 18)

				if (18 <= 0 and var_273_5 or var_273_5 * (utf8.len(var_273_7) / 18)) > 0 and var_273_5 < var_273_9 then
					arg_270_1.talkMaxDuration = var_273_9

					if var_273_9 + var_273_4 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_9 + var_273_4
					end
				end

				arg_270_1.text_.text = var_273_7
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161063", "story_v_out_324161.awb") ~= 0 then
					local var_273_10 = manager.audio:GetVoiceLength("story_v_out_324161", "324161063", "story_v_out_324161.awb") / 1000

					if var_273_10 + var_273_4 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_10 + var_273_4
					end

					if var_273_6.prefab_name ~= "" and arg_270_1.actors_[var_273_6.prefab_name] ~= nil then
						local var_273_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_6.prefab_name].transform, "story_v_out_324161", "324161063", "story_v_out_324161.awb")

						arg_270_1:RecordAudio("324161063", var_273_11)
						arg_270_1:RecordAudio("324161063", var_273_11)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_324161", "324161063", "story_v_out_324161.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_324161", "324161063", "story_v_out_324161.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_12 = math.max(var_273_5, arg_270_1.talkMaxDuration)

			if var_273_4 <= arg_270_1.time_ and arg_270_1.time_ < var_273_4 + var_273_12 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_4) / var_273_12

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_4 + var_273_12 and arg_270_1.time_ < var_273_4 + var_273_12 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play324161064 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 324161064
		arg_274_1.duration_ = 12.43

		local var_274_0 = {
			zh = 10.3333333333333,
			ja = 12.4333333333333
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
				arg_274_0:Play324161065(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if arg_274_1.bgs_.ST2007 == nil then
				local var_277_0 = Object.Instantiate(arg_274_1.paintGo_)

				var_277_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2007")
				var_277_0.name = "ST2007"
				var_277_0.transform.parent = arg_274_1.stage_.transform
				var_277_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_274_1.bgs_.ST2007 = var_277_0
			end

			if 0.833333333333333 < arg_274_1.time_ and arg_274_1.time_ <= 0.833333333333333 + arg_277_0 then
				local var_277_1 = arg_274_1.bgs_.ST2007

				arg_274_1.bgs_.ST2007.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_277_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_277_2 = var_277_1:GetComponent("SpriteRenderer")

				if var_277_2 and var_277_2.sprite then
					local var_277_3 = 2 * (var_277_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_277_1.transform.localScale = Vector3.New(var_277_3 / var_277_2.sprite.bounds.size.y < var_277_3 * manager.ui.mainCameraCom_.aspect / var_277_2.sprite.bounds.size.x and var_277_3 * manager.ui.mainCameraCom_.aspect / var_277_2.sprite.bounds.size.x or var_277_3 / var_277_2.sprite.bounds.size.y, var_277_3 / var_277_2.sprite.bounds.size.y < var_277_3 * manager.ui.mainCameraCom_.aspect / var_277_2.sprite.bounds.size.x and var_277_3 * manager.ui.mainCameraCom_.aspect / var_277_2.sprite.bounds.size.x or var_277_3 / var_277_2.sprite.bounds.size.y, 0)
				end

				for iter_277_0, iter_277_1 in pairs(arg_274_1.bgs_) do
					if iter_277_0 ~= "ST2007" then
						iter_277_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_277_4 = 0

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_4 + arg_277_0 then
				arg_274_1.mask_.enabled = true
				arg_274_1.mask_.raycastTarget = true

				arg_274_1:SetGaussion(false)
			end

			local var_277_5 = 0.833333333333333

			if var_277_4 <= arg_274_1.time_ and arg_274_1.time_ < var_277_4 + var_277_5 then
				local var_277_6 = Color.New(0, 0, 0)

				var_277_6.a = Mathf.Lerp(0, 1, (arg_274_1.time_ - var_277_4) / var_277_5)
				arg_274_1.mask_.color = var_277_6
			end

			if arg_274_1.time_ >= var_277_4 + var_277_5 and arg_274_1.time_ < var_277_4 + var_277_5 + arg_277_0 then
				local var_277_7 = Color.New(0, 0, 0)

				var_277_7.a = 1
				arg_274_1.mask_.color = var_277_7
			end

			local var_277_8 = 0.833333333333333

			if 0.833333333333333 < arg_274_1.time_ and arg_274_1.time_ <= var_277_8 + arg_277_0 then
				arg_274_1.mask_.enabled = true
				arg_274_1.mask_.raycastTarget = true

				arg_274_1:SetGaussion(false)
			end

			local var_277_9 = 1.76666666666667

			if var_277_8 <= arg_274_1.time_ and arg_274_1.time_ < var_277_8 + var_277_9 then
				local var_277_10 = Color.New(0, 0, 0)

				var_277_10.a = Mathf.Lerp(1, 0, (arg_274_1.time_ - var_277_8) / var_277_9)
				arg_274_1.mask_.color = var_277_10
			end

			if arg_274_1.time_ >= var_277_8 + var_277_9 and arg_274_1.time_ < var_277_8 + var_277_9 + arg_277_0 then
				local var_277_11 = Color.New(0, 0, 0)

				arg_274_1.mask_.enabled = false
				var_277_11.a = 0
				arg_274_1.mask_.color = var_277_11
			end

			local var_277_12 = arg_274_1.actors_["6148ui_story"]

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(var_277_12) and arg_274_1.var_.characterEffect6148ui_story == nil then
				arg_274_1.var_.characterEffect6148ui_story = var_277_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_13 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_13 and not isNil(var_277_12) then
				if arg_274_1.var_.characterEffect6148ui_story and not isNil(var_277_12) then
					arg_274_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= 0 + var_277_13 and arg_274_1.time_ < 0 + var_277_13 + arg_277_0 and not isNil(var_277_12) and arg_274_1.var_.characterEffect6148ui_story then
				arg_274_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_277_15 = arg_274_1.actors_["1054ui_story"]

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(var_277_15) and arg_274_1.var_.characterEffect1054ui_story == nil then
				arg_274_1.var_.characterEffect1054ui_story = var_277_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_16 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_16 and not isNil(var_277_15) then
				if arg_274_1.var_.characterEffect1054ui_story and not isNil(var_277_15) then
					arg_274_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_274_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_274_1.time_ - 0) / var_277_16)
				end
			end

			if arg_274_1.time_ >= 0 + var_277_16 and arg_274_1.time_ < 0 + var_277_16 + arg_277_0 and not isNil(var_277_15) and arg_274_1.var_.characterEffect1054ui_story then
				arg_274_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_274_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_277_17 = arg_274_1.actors_["1054ui_story"].transform

			if 0.833333333333333 < arg_274_1.time_ and arg_274_1.time_ <= 0.833333333333333 + arg_277_0 then
				arg_274_1.var_.moveOldPos1054ui_story = var_277_17.localPosition

				local var_277_18 = GameObjectTools.GetOrAddComponent(var_277_17.gameObject, typeof(DynamicBoneHelper))

				if var_277_18 then
					var_277_18:EnableDynamicBone(false)
				end
			end

			local var_277_19 = 0.001

			if 0.833333333333333 <= arg_274_1.time_ and arg_274_1.time_ < 0.833333333333333 + var_277_19 then
				var_277_17.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_274_1.time_ - 0.833333333333333) / var_277_19)
				var_277_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_277_17.position).x, (manager.ui.mainCamera.transform.position - var_277_17.position).y, (manager.ui.mainCamera.transform.position - var_277_17.position).z)
				var_277_17.localEulerAngles.z = 0
				var_277_17.localEulerAngles.x = 0
				var_277_17.localEulerAngles = var_277_17.localEulerAngles
			end

			if arg_274_1.time_ >= 0.833333333333333 + var_277_19 and arg_274_1.time_ < 0.833333333333333 + var_277_19 + arg_277_0 then
				var_277_17.localPosition = Vector3.New(0, 100, 0)
				var_277_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_277_17.position).x, (manager.ui.mainCamera.transform.position - var_277_17.position).y, (manager.ui.mainCamera.transform.position - var_277_17.position).z)
				var_277_17.localEulerAngles.z = 0
				var_277_17.localEulerAngles.x = 0
				var_277_17.localEulerAngles = var_277_17.localEulerAngles

				local var_277_20 = GameObjectTools.GetOrAddComponent(var_277_17.gameObject, typeof(DynamicBoneHelper))

				if var_277_20 then
					var_277_20:EnableDynamicBone(true)
				end
			end

			local var_277_21 = arg_274_1.actors_["6148ui_story"].transform

			if 0.833333333333333 < arg_274_1.time_ and arg_274_1.time_ <= 0.833333333333333 + arg_277_0 then
				arg_274_1.var_.moveOldPos6148ui_story = var_277_21.localPosition

				local var_277_22 = GameObjectTools.GetOrAddComponent(var_277_21.gameObject, typeof(DynamicBoneHelper))

				if var_277_22 then
					var_277_22:EnableDynamicBone(false)
				end
			end

			local var_277_23 = 0.001

			if 0.833333333333333 <= arg_274_1.time_ and arg_274_1.time_ < 0.833333333333333 + var_277_23 then
				var_277_21.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_274_1.time_ - 0.833333333333333) / var_277_23)
				var_277_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_277_21.position).x, (manager.ui.mainCamera.transform.position - var_277_21.position).y, (manager.ui.mainCamera.transform.position - var_277_21.position).z)
				var_277_21.localEulerAngles.z = 0
				var_277_21.localEulerAngles.x = 0
				var_277_21.localEulerAngles = var_277_21.localEulerAngles
			end

			if arg_274_1.time_ >= 0.833333333333333 + var_277_23 and arg_274_1.time_ < 0.833333333333333 + var_277_23 + arg_277_0 then
				var_277_21.localPosition = Vector3.New(0, 100, 0)
				var_277_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_277_21.position).x, (manager.ui.mainCamera.transform.position - var_277_21.position).y, (manager.ui.mainCamera.transform.position - var_277_21.position).z)
				var_277_21.localEulerAngles.z = 0
				var_277_21.localEulerAngles.x = 0
				var_277_21.localEulerAngles = var_277_21.localEulerAngles

				local var_277_24 = GameObjectTools.GetOrAddComponent(var_277_21.gameObject, typeof(DynamicBoneHelper))

				if var_277_24 then
					var_277_24:EnableDynamicBone(true)
				end
			end

			local var_277_25 = 0.833333333333333

			arg_274_1.isInRecall_ = false

			if var_277_25 < arg_274_1.time_ and arg_274_1.time_ <= var_277_25 + arg_277_0 then
				arg_274_1.screenFilterGo_:SetActive(true)

				arg_274_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_277_2, iter_277_3 in pairs(arg_274_1.actors_) do
					for iter_277_4, iter_277_5 in ipairs((iter_277_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_277_5.color = iter_277_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_277_26 = 0.034000001847744

			if var_277_25 <= arg_274_1.time_ and arg_274_1.time_ < var_277_25 + var_277_26 then
				arg_274_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_274_1.time_ - var_277_25) / var_277_26)
			end

			if arg_274_1.time_ >= var_277_25 + var_277_26 and arg_274_1.time_ < var_277_25 + var_277_26 + arg_277_0 then
				arg_274_1.screenFilterEffect_.weight = 1
			end

			if 1.2 < arg_274_1.time_ and arg_274_1.time_ <= 1.2 + arg_277_0 then
				arg_274_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if 0.1 < arg_274_1.time_ and arg_274_1.time_ <= 0.1 + arg_277_0 then
				arg_274_1:AudioAction("stop", "effect", "se_story_148", "se_story_148_sword11", "")
			end

			if arg_274_1.frameCnt_ <= 1 then
				arg_274_1.dialog_:SetActive(false)
			end

			local var_277_29 = 2.23333333333333
			local var_277_30 = 1.075

			if 2.23333333333333 < arg_274_1.time_ and arg_274_1.time_ <= var_277_29 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0

				arg_274_1.dialog_:SetActive(true)

				arg_274_1.dialogCg_.alpha = 0

				local var_277_31 = LeanTween.value(arg_274_1.dialog_, 0, 1, 0.3)

				var_277_31:setOnUpdate(LuaHelper.FloatAction(function(arg_278_0)
					arg_274_1.dialogCg_.alpha = arg_278_0
				end))
				var_277_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_274_1.dialog_)
					var_277_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_274_1.duration_ = arg_274_1.duration_ + 0.3

				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6148")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_274_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_277_32 = arg_274_1:GetWordFromCfg(324161064)
				local var_277_33 = arg_274_1:FormatText(var_277_32.content)

				arg_274_1.text_.text = var_277_33

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_35 = 43 <= 0 and var_277_30 or var_277_30 * (utf8.len(var_277_33) / 43)

				if (43 <= 0 and var_277_30 or var_277_30 * (utf8.len(var_277_33) / 43)) > 0 and var_277_30 < var_277_35 then
					arg_274_1.talkMaxDuration = var_277_35
					var_277_29 = var_277_29 + 0.3

					if var_277_35 + var_277_29 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_35 + var_277_29
					end
				end

				arg_274_1.text_.text = var_277_33
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161064", "story_v_out_324161.awb") ~= 0 then
					local var_277_36 = manager.audio:GetVoiceLength("story_v_out_324161", "324161064", "story_v_out_324161.awb") / 1000

					if var_277_36 + var_277_29 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_36 + var_277_29
					end

					if var_277_32.prefab_name ~= "" and arg_274_1.actors_[var_277_32.prefab_name] ~= nil then
						local var_277_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_32.prefab_name].transform, "story_v_out_324161", "324161064", "story_v_out_324161.awb")

						arg_274_1:RecordAudio("324161064", var_277_37)
						arg_274_1:RecordAudio("324161064", var_277_37)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_324161", "324161064", "story_v_out_324161.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_324161", "324161064", "story_v_out_324161.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_38 = var_277_29 + 0.3
			local var_277_39 = math.max(var_277_30, arg_274_1.talkMaxDuration)

			if var_277_29 + 0.3 <= arg_274_1.time_ and arg_274_1.time_ < var_277_38 + var_277_39 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_38) / var_277_39

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_38 + var_277_39 and arg_274_1.time_ < var_277_38 + var_277_39 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.833333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.833333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play324161065 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 324161065
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play324161066(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(arg_280_1.actors_["6148ui_story"]) and arg_280_1.var_.characterEffect6148ui_story == nil then
				arg_280_1.var_.characterEffect6148ui_story = arg_280_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_0 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_0 and not isNil(arg_280_1.actors_["6148ui_story"]) then
				if arg_280_1.var_.characterEffect6148ui_story and not isNil(arg_280_1.actors_["6148ui_story"]) then
					arg_280_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_280_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_280_1.time_ - 0) / var_283_0)
				end
			end

			if arg_280_1.time_ >= 0 + var_283_0 and arg_280_1.time_ < 0 + var_283_0 + arg_283_0 and not isNil(arg_280_1.actors_["6148ui_story"]) and arg_280_1.var_.characterEffect6148ui_story then
				arg_280_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_280_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_283_1 = 0
			local var_283_2 = 0.25

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, true)
				arg_280_1.iconController_:SetSelectedState("hero")

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_280_1.callingController_:SetSelectedState("normal")

				arg_280_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_280_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_283_3 = arg_280_1:FormatText(arg_280_1:GetWordFromCfg(324161065).content)

				arg_280_1.text_.text = var_283_3

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_5 = 10 <= 0 and var_283_2 or var_283_2 * (utf8.len(var_283_3) / 10)

				if (10 <= 0 and var_283_2 or var_283_2 * (utf8.len(var_283_3) / 10)) > 0 and var_283_2 < var_283_5 then
					arg_280_1.talkMaxDuration = var_283_5

					if var_283_5 + var_283_1 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_5 + var_283_1
					end
				end

				arg_280_1.text_.text = var_283_3
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_6 = math.max(var_283_2, arg_280_1.talkMaxDuration)

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_6 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_1) / var_283_6

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_1 + var_283_6 and arg_280_1.time_ < var_283_1 + var_283_6 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play324161066 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 324161066
		arg_284_1.duration_ = 3.93

		local var_284_0 = {
			zh = 2.633,
			ja = 3.933
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play324161067(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.var_.moveOldPos1054ui_story = arg_284_1.actors_["1054ui_story"].transform.localPosition

				local var_287_0 = GameObjectTools.GetOrAddComponent(arg_284_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_287_0 then
					var_287_0:EnableDynamicBone(false)
				end
			end

			local var_287_1 = 0.001

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_1 then
				arg_284_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_284_1.time_ - 0) / var_287_1)
				arg_284_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_284_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1054ui_story"].transform.position).z)
				arg_284_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_284_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_284_1.actors_["1054ui_story"].transform.localEulerAngles = arg_284_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_284_1.time_ >= 0 + var_287_1 and arg_284_1.time_ < 0 + var_287_1 + arg_287_0 then
				arg_284_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_284_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_284_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1054ui_story"].transform.position).z)
				arg_284_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_284_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_284_1.actors_["1054ui_story"].transform.localEulerAngles = arg_284_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_287_2 = GameObjectTools.GetOrAddComponent(arg_284_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_287_2 then
					var_287_2:EnableDynamicBone(true)
				end
			end

			local var_287_3 = arg_284_1.actors_["1054ui_story"]

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(var_287_3) and arg_284_1.var_.characterEffect1054ui_story == nil then
				arg_284_1.var_.characterEffect1054ui_story = var_287_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_4 = 0.200000002980232

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_4 and not isNil(var_287_3) then
				if arg_284_1.var_.characterEffect1054ui_story and not isNil(var_287_3) then
					arg_284_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_284_1.time_ >= 0 + var_287_4 and arg_284_1.time_ < 0 + var_287_4 + arg_287_0 and not isNil(var_287_3) and arg_284_1.var_.characterEffect1054ui_story then
				arg_284_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_287_6 = 0
			local var_287_7 = 0.3

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_6 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_8 = arg_284_1:GetWordFromCfg(324161066)
				local var_287_9 = arg_284_1:FormatText(var_287_8.content)

				arg_284_1.text_.text = var_287_9

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_11 = 12 <= 0 and var_287_7 or var_287_7 * (utf8.len(var_287_9) / 12)

				if (12 <= 0 and var_287_7 or var_287_7 * (utf8.len(var_287_9) / 12)) > 0 and var_287_7 < var_287_11 then
					arg_284_1.talkMaxDuration = var_287_11

					if var_287_11 + var_287_6 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_11 + var_287_6
					end
				end

				arg_284_1.text_.text = var_287_9
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161066", "story_v_out_324161.awb") ~= 0 then
					local var_287_12 = manager.audio:GetVoiceLength("story_v_out_324161", "324161066", "story_v_out_324161.awb") / 1000

					if var_287_12 + var_287_6 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_12 + var_287_6
					end

					if var_287_8.prefab_name ~= "" and arg_284_1.actors_[var_287_8.prefab_name] ~= nil then
						local var_287_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_8.prefab_name].transform, "story_v_out_324161", "324161066", "story_v_out_324161.awb")

						arg_284_1:RecordAudio("324161066", var_287_13)
						arg_284_1:RecordAudio("324161066", var_287_13)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_324161", "324161066", "story_v_out_324161.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_324161", "324161066", "story_v_out_324161.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_14 = math.max(var_287_7, arg_284_1.talkMaxDuration)

			if var_287_6 <= arg_284_1.time_ and arg_284_1.time_ < var_287_6 + var_287_14 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_6) / var_287_14

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_6 + var_287_14 and arg_284_1.time_ < var_287_6 + var_287_14 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play324161067 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 324161067
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play324161068(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(arg_288_1.actors_["1054ui_story"]) and arg_288_1.var_.characterEffect1054ui_story == nil then
				arg_288_1.var_.characterEffect1054ui_story = arg_288_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_0 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 and not isNil(arg_288_1.actors_["1054ui_story"]) then
				if arg_288_1.var_.characterEffect1054ui_story and not isNil(arg_288_1.actors_["1054ui_story"]) then
					arg_288_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_288_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_288_1.time_ - 0) / var_291_0)
				end
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 and not isNil(arg_288_1.actors_["1054ui_story"]) and arg_288_1.var_.characterEffect1054ui_story then
				arg_288_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_288_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_291_1 = 0
			local var_291_2 = 1.05

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_288_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_291_3 = arg_288_1:FormatText(arg_288_1:GetWordFromCfg(324161067).content)

				arg_288_1.text_.text = var_291_3

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_5 = 42 <= 0 and var_291_2 or var_291_2 * (utf8.len(var_291_3) / 42)

				if (42 <= 0 and var_291_2 or var_291_2 * (utf8.len(var_291_3) / 42)) > 0 and var_291_2 < var_291_5 then
					arg_288_1.talkMaxDuration = var_291_5

					if var_291_5 + var_291_1 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_5 + var_291_1
					end
				end

				arg_288_1.text_.text = var_291_3
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_6 = math.max(var_291_2, arg_288_1.talkMaxDuration)

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_6 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_1) / var_291_6

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_1 + var_291_6 and arg_288_1.time_ < var_291_1 + var_291_6 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play324161068 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 324161068
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play324161069(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 1.175

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_292_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_295_1 = arg_292_1:FormatText(arg_292_1:GetWordFromCfg(324161068).content)

				arg_292_1.text_.text = var_295_1

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_3 = 47 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_1) / 47)

				if (47 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_1) / 47)) > 0 and var_295_0 < var_295_3 then
					arg_292_1.talkMaxDuration = var_295_3

					if var_295_3 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_3 + 0
					end
				end

				arg_292_1.text_.text = var_295_1
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_4 = math.max(var_295_0, arg_292_1.talkMaxDuration)

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_4 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - 0) / var_295_4

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= 0 + var_295_4 and arg_292_1.time_ < 0 + var_295_4 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play324161069 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 324161069
		arg_296_1.duration_ = 7

		local var_296_0 = {
			zh = 3.9,
			ja = 7
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play324161070(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos6148ui_story = arg_296_1.actors_["6148ui_story"].transform.localPosition

				local var_299_0 = GameObjectTools.GetOrAddComponent(arg_296_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_299_0 then
					var_299_0:EnableDynamicBone(false)
				end
			end

			local var_299_1 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_1 then
				arg_296_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_296_1.time_ - 0) / var_299_1)
				arg_296_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["6148ui_story"].transform.position).z)
				arg_296_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["6148ui_story"].transform.localEulerAngles = arg_296_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_296_1.time_ >= 0 + var_299_1 and arg_296_1.time_ < 0 + var_299_1 + arg_299_0 then
				arg_296_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_296_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["6148ui_story"].transform.position).z)
				arg_296_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["6148ui_story"].transform.localEulerAngles = arg_296_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_299_2 = GameObjectTools.GetOrAddComponent(arg_296_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_299_2 then
					var_299_2:EnableDynamicBone(true)
				end
			end

			local var_299_3 = arg_296_1.actors_["1054ui_story"].transform

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos1054ui_story = var_299_3.localPosition

				local var_299_4 = GameObjectTools.GetOrAddComponent(var_299_3.gameObject, typeof(DynamicBoneHelper))

				if var_299_4 then
					var_299_4:EnableDynamicBone(false)
				end
			end

			local var_299_5 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_5 then
				var_299_3.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_296_1.time_ - 0) / var_299_5)
				var_299_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_299_3.position).x, (manager.ui.mainCamera.transform.position - var_299_3.position).y, (manager.ui.mainCamera.transform.position - var_299_3.position).z)
				var_299_3.localEulerAngles.z = 0
				var_299_3.localEulerAngles.x = 0
				var_299_3.localEulerAngles = var_299_3.localEulerAngles
			end

			if arg_296_1.time_ >= 0 + var_299_5 and arg_296_1.time_ < 0 + var_299_5 + arg_299_0 then
				var_299_3.localPosition = Vector3.New(0, 100, 0)
				var_299_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_299_3.position).x, (manager.ui.mainCamera.transform.position - var_299_3.position).y, (manager.ui.mainCamera.transform.position - var_299_3.position).z)
				var_299_3.localEulerAngles.z = 0
				var_299_3.localEulerAngles.x = 0
				var_299_3.localEulerAngles = var_299_3.localEulerAngles

				local var_299_6 = GameObjectTools.GetOrAddComponent(var_299_3.gameObject, typeof(DynamicBoneHelper))

				if var_299_6 then
					var_299_6:EnableDynamicBone(true)
				end
			end

			local var_299_7 = arg_296_1.actors_["6148ui_story"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_7) and arg_296_1.var_.characterEffect6148ui_story == nil then
				arg_296_1.var_.characterEffect6148ui_story = var_299_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_8 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_8 and not isNil(var_299_7) then
				if arg_296_1.var_.characterEffect6148ui_story and not isNil(var_299_7) then
					arg_296_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= 0 + var_299_8 and arg_296_1.time_ < 0 + var_299_8 + arg_299_0 and not isNil(var_299_7) and arg_296_1.var_.characterEffect6148ui_story then
				arg_296_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_299_10 = 0
			local var_299_11 = 0.35

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_10 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_12 = arg_296_1:GetWordFromCfg(324161069)
				local var_299_13 = arg_296_1:FormatText(var_299_12.content)

				arg_296_1.text_.text = var_299_13

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_15 = 14 <= 0 and var_299_11 or var_299_11 * (utf8.len(var_299_13) / 14)

				if (14 <= 0 and var_299_11 or var_299_11 * (utf8.len(var_299_13) / 14)) > 0 and var_299_11 < var_299_15 then
					arg_296_1.talkMaxDuration = var_299_15

					if var_299_15 + var_299_10 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_15 + var_299_10
					end
				end

				arg_296_1.text_.text = var_299_13
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161069", "story_v_out_324161.awb") ~= 0 then
					local var_299_16 = manager.audio:GetVoiceLength("story_v_out_324161", "324161069", "story_v_out_324161.awb") / 1000

					if var_299_16 + var_299_10 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_16 + var_299_10
					end

					if var_299_12.prefab_name ~= "" and arg_296_1.actors_[var_299_12.prefab_name] ~= nil then
						local var_299_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_12.prefab_name].transform, "story_v_out_324161", "324161069", "story_v_out_324161.awb")

						arg_296_1:RecordAudio("324161069", var_299_17)
						arg_296_1:RecordAudio("324161069", var_299_17)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_324161", "324161069", "story_v_out_324161.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_324161", "324161069", "story_v_out_324161.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_18 = math.max(var_299_11, arg_296_1.talkMaxDuration)

			if var_299_10 <= arg_296_1.time_ and arg_296_1.time_ < var_299_10 + var_299_18 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_10) / var_299_18

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_10 + var_299_18 and arg_296_1.time_ < var_299_10 + var_299_18 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play324161070 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 324161070
		arg_300_1.duration_ = 9.73

		local var_300_0 = {
			zh = 9.73333333333333,
			ja = 9.53333333333333
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play324161071(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0.867333335181077 < arg_300_1.time_ and arg_300_1.time_ <= 0.867333335181077 + arg_303_0 then
				local var_303_0 = arg_300_1.bgs_.MS2404

				arg_300_1.bgs_.MS2404.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_303_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_303_1 = var_303_0:GetComponent("SpriteRenderer")

				if var_303_1 and var_303_1.sprite then
					local var_303_2 = 2 * (var_303_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_303_0.transform.localScale = Vector3.New(var_303_2 / var_303_1.sprite.bounds.size.y < var_303_2 * manager.ui.mainCameraCom_.aspect / var_303_1.sprite.bounds.size.x and var_303_2 * manager.ui.mainCameraCom_.aspect / var_303_1.sprite.bounds.size.x or var_303_2 / var_303_1.sprite.bounds.size.y, var_303_2 / var_303_1.sprite.bounds.size.y < var_303_2 * manager.ui.mainCameraCom_.aspect / var_303_1.sprite.bounds.size.x and var_303_2 * manager.ui.mainCameraCom_.aspect / var_303_1.sprite.bounds.size.x or var_303_2 / var_303_1.sprite.bounds.size.y, 0)
				end

				for iter_303_0, iter_303_1 in pairs(arg_300_1.bgs_) do
					if iter_303_0 ~= "MS2404" then
						iter_303_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_303_3 = 0

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_3 + arg_303_0 then
				arg_300_1.allBtn_.enabled = false
			end

			if arg_300_1.time_ >= var_303_3 + 0.3 and arg_300_1.time_ < var_303_3 + 0.3 + arg_303_0 then
				arg_300_1.allBtn_.enabled = true
			end

			local var_303_4 = 0

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_4 + arg_303_0 then
				arg_300_1.mask_.enabled = true
				arg_300_1.mask_.raycastTarget = true

				arg_300_1:SetGaussion(false)
			end

			local var_303_5 = 0.867333335181077

			if var_303_4 <= arg_300_1.time_ and arg_300_1.time_ < var_303_4 + var_303_5 then
				local var_303_6 = Color.New(0, 0, 0)

				var_303_6.a = Mathf.Lerp(0, 1, (arg_300_1.time_ - var_303_4) / var_303_5)
				arg_300_1.mask_.color = var_303_6
			end

			if arg_300_1.time_ >= var_303_4 + var_303_5 and arg_300_1.time_ < var_303_4 + var_303_5 + arg_303_0 then
				local var_303_7 = Color.New(0, 0, 0)

				var_303_7.a = 1
				arg_300_1.mask_.color = var_303_7
			end

			local var_303_8 = 0.833333333333333

			if 0.833333333333333 < arg_300_1.time_ and arg_300_1.time_ <= var_303_8 + arg_303_0 then
				arg_300_1.mask_.enabled = true
				arg_300_1.mask_.raycastTarget = true

				arg_300_1:SetGaussion(false)
			end

			local var_303_9 = 2

			if var_303_8 <= arg_300_1.time_ and arg_300_1.time_ < var_303_8 + var_303_9 then
				local var_303_10 = Color.New(0, 0, 0)

				var_303_10.a = Mathf.Lerp(1, 0, (arg_300_1.time_ - var_303_8) / var_303_9)
				arg_300_1.mask_.color = var_303_10
			end

			if arg_300_1.time_ >= var_303_8 + var_303_9 and arg_300_1.time_ < var_303_8 + var_303_9 + arg_303_0 then
				local var_303_11 = Color.New(0, 0, 0)

				arg_300_1.mask_.enabled = false
				var_303_11.a = 0
				arg_300_1.mask_.color = var_303_11
			end

			local var_303_12 = arg_300_1.actors_["6148ui_story"].transform

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos6148ui_story = var_303_12.localPosition

				local var_303_13 = GameObjectTools.GetOrAddComponent(var_303_12.gameObject, typeof(DynamicBoneHelper))

				if var_303_13 then
					var_303_13:EnableDynamicBone(false)
				end
			end

			local var_303_14 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_14 then
				var_303_12.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_300_1.time_ - 0) / var_303_14)
				var_303_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_303_12.position).x, (manager.ui.mainCamera.transform.position - var_303_12.position).y, (manager.ui.mainCamera.transform.position - var_303_12.position).z)
				var_303_12.localEulerAngles.z = 0
				var_303_12.localEulerAngles.x = 0
				var_303_12.localEulerAngles = var_303_12.localEulerAngles
			end

			if arg_300_1.time_ >= 0 + var_303_14 and arg_300_1.time_ < 0 + var_303_14 + arg_303_0 then
				var_303_12.localPosition = Vector3.New(0, 100, 0)
				var_303_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_303_12.position).x, (manager.ui.mainCamera.transform.position - var_303_12.position).y, (manager.ui.mainCamera.transform.position - var_303_12.position).z)
				var_303_12.localEulerAngles.z = 0
				var_303_12.localEulerAngles.x = 0
				var_303_12.localEulerAngles = var_303_12.localEulerAngles

				local var_303_15 = GameObjectTools.GetOrAddComponent(var_303_12.gameObject, typeof(DynamicBoneHelper))

				if var_303_15 then
					var_303_15:EnableDynamicBone(true)
				end
			end

			local var_303_16 = arg_300_1.actors_["1054ui_story"]

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(var_303_16) and arg_300_1.var_.characterEffect1054ui_story == nil then
				arg_300_1.var_.characterEffect1054ui_story = var_303_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_17 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_17 and not isNil(var_303_16) then
				if arg_300_1.var_.characterEffect1054ui_story and not isNil(var_303_16) then
					arg_300_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= 0 + var_303_17 and arg_300_1.time_ < 0 + var_303_17 + arg_303_0 and not isNil(var_303_16) and arg_300_1.var_.characterEffect1054ui_story then
				arg_300_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_303_19 = arg_300_1.actors_["6148ui_story"]

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(var_303_19) and arg_300_1.var_.characterEffect6148ui_story == nil then
				arg_300_1.var_.characterEffect6148ui_story = var_303_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_20 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_20 and not isNil(var_303_19) then
				if arg_300_1.var_.characterEffect6148ui_story and not isNil(var_303_19) then
					arg_300_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_300_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_300_1.time_ - 0) / var_303_20)
				end
			end

			if arg_300_1.time_ >= 0 + var_303_20 and arg_300_1.time_ < 0 + var_303_20 + arg_303_0 and not isNil(var_303_19) and arg_300_1.var_.characterEffect6148ui_story then
				arg_300_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_300_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_303_21 = 0.833333333333333

			arg_300_1.isInRecall_ = false

			if var_303_21 < arg_300_1.time_ and arg_300_1.time_ <= var_303_21 + arg_303_0 then
				arg_300_1.screenFilterGo_:SetActive(false)

				for iter_303_2, iter_303_3 in pairs(arg_300_1.actors_) do
					for iter_303_4, iter_303_5 in ipairs((iter_303_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_303_5.color = iter_303_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_303_22 = 0.034000001847744

			if var_303_21 <= arg_300_1.time_ and arg_300_1.time_ < var_303_21 + var_303_22 then
				arg_300_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_300_1.time_ - var_303_21) / var_303_22)
			end

			if arg_300_1.time_ >= var_303_21 + var_303_22 and arg_300_1.time_ < var_303_21 + var_303_22 + arg_303_0 then
				arg_300_1.screenFilterEffect_.weight = 0
			end

			if arg_300_1.frameCnt_ <= 1 then
				arg_300_1.dialog_:SetActive(false)
			end

			local var_303_23 = 2.53333333333333
			local var_303_24 = 0.75

			if 2.53333333333333 < arg_300_1.time_ and arg_300_1.time_ <= var_303_23 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0

				arg_300_1.dialog_:SetActive(true)

				arg_300_1.dialogCg_.alpha = 0

				local var_303_25 = LeanTween.value(arg_300_1.dialog_, 0, 1, 0.3)

				var_303_25:setOnUpdate(LuaHelper.FloatAction(function(arg_304_0)
					arg_300_1.dialogCg_.alpha = arg_304_0
				end))
				var_303_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_300_1.dialog_)
					var_303_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_300_1.duration_ = arg_300_1.duration_ + 0.3

				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_26 = arg_300_1:GetWordFromCfg(324161070)
				local var_303_27 = arg_300_1:FormatText(var_303_26.content)

				arg_300_1.text_.text = var_303_27

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_29 = 30 <= 0 and var_303_24 or var_303_24 * (utf8.len(var_303_27) / 30)

				if (30 <= 0 and var_303_24 or var_303_24 * (utf8.len(var_303_27) / 30)) > 0 and var_303_24 < var_303_29 then
					arg_300_1.talkMaxDuration = var_303_29
					var_303_23 = var_303_23 + 0.3

					if var_303_29 + var_303_23 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_29 + var_303_23
					end
				end

				arg_300_1.text_.text = var_303_27
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161070", "story_v_out_324161.awb") ~= 0 then
					local var_303_30 = manager.audio:GetVoiceLength("story_v_out_324161", "324161070", "story_v_out_324161.awb") / 1000

					if var_303_30 + var_303_23 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_30 + var_303_23
					end

					if var_303_26.prefab_name ~= "" and arg_300_1.actors_[var_303_26.prefab_name] ~= nil then
						local var_303_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_26.prefab_name].transform, "story_v_out_324161", "324161070", "story_v_out_324161.awb")

						arg_300_1:RecordAudio("324161070", var_303_31)
						arg_300_1:RecordAudio("324161070", var_303_31)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_324161", "324161070", "story_v_out_324161.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_324161", "324161070", "story_v_out_324161.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_32 = var_303_23 + 0.3
			local var_303_33 = math.max(var_303_24, arg_300_1.talkMaxDuration)

			if var_303_23 + 0.3 <= arg_300_1.time_ and arg_300_1.time_ < var_303_32 + var_303_33 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_32) / var_303_33

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_32 + var_303_33 and arg_300_1.time_ < var_303_32 + var_303_33 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play324161071 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 324161071
		arg_306_1.duration_ = 12

		local var_306_0 = {
			zh = 12,
			ja = 9.966
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play324161072(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 1.175

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_1 = arg_306_1:GetWordFromCfg(324161071)
				local var_309_2 = arg_306_1:FormatText(var_309_1.content)

				arg_306_1.text_.text = var_309_2

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_4 = 47 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_2) / 47)

				if (47 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_2) / 47)) > 0 and var_309_0 < var_309_4 then
					arg_306_1.talkMaxDuration = var_309_4

					if var_309_4 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_4 + 0
					end
				end

				arg_306_1.text_.text = var_309_2
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161071", "story_v_out_324161.awb") ~= 0 then
					local var_309_5 = manager.audio:GetVoiceLength("story_v_out_324161", "324161071", "story_v_out_324161.awb") / 1000

					if var_309_5 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_5 + 0
					end

					if var_309_1.prefab_name ~= "" and arg_306_1.actors_[var_309_1.prefab_name] ~= nil then
						local var_309_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_1.prefab_name].transform, "story_v_out_324161", "324161071", "story_v_out_324161.awb")

						arg_306_1:RecordAudio("324161071", var_309_6)
						arg_306_1:RecordAudio("324161071", var_309_6)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_324161", "324161071", "story_v_out_324161.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_324161", "324161071", "story_v_out_324161.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_7 = math.max(var_309_0, arg_306_1.talkMaxDuration)

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_7 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - 0) / var_309_7

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= 0 + var_309_7 and arg_306_1.time_ < 0 + var_309_7 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play324161072 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 324161072
		arg_310_1.duration_ = 7.93

		local var_310_0 = {
			zh = 4.866,
			ja = 7.933
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play324161073(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(arg_310_1.actors_["6148ui_story"]) and arg_310_1.var_.characterEffect6148ui_story == nil then
				arg_310_1.var_.characterEffect6148ui_story = arg_310_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_0 = 0.200000002980232

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 and not isNil(arg_310_1.actors_["6148ui_story"]) then
				if arg_310_1.var_.characterEffect6148ui_story and not isNil(arg_310_1.actors_["6148ui_story"]) then
					arg_310_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 and not isNil(arg_310_1.actors_["6148ui_story"]) and arg_310_1.var_.characterEffect6148ui_story then
				arg_310_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_313_2 = arg_310_1.actors_["1054ui_story"]

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(var_313_2) and arg_310_1.var_.characterEffect1054ui_story == nil then
				arg_310_1.var_.characterEffect1054ui_story = var_313_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_3 = 0.200000002980232

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_3 and not isNil(var_313_2) then
				if arg_310_1.var_.characterEffect1054ui_story and not isNil(var_313_2) then
					arg_310_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_310_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_310_1.time_ - 0) / var_313_3)
				end
			end

			if arg_310_1.time_ >= 0 + var_313_3 and arg_310_1.time_ < 0 + var_313_3 + arg_313_0 and not isNil(var_313_2) and arg_310_1.var_.characterEffect1054ui_story then
				arg_310_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_310_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_313_4 = 0
			local var_313_5 = 0.575

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_4 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_6 = arg_310_1:GetWordFromCfg(324161072)
				local var_313_7 = arg_310_1:FormatText(var_313_6.content)

				arg_310_1.text_.text = var_313_7

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_9 = 23 <= 0 and var_313_5 or var_313_5 * (utf8.len(var_313_7) / 23)

				if (23 <= 0 and var_313_5 or var_313_5 * (utf8.len(var_313_7) / 23)) > 0 and var_313_5 < var_313_9 then
					arg_310_1.talkMaxDuration = var_313_9

					if var_313_9 + var_313_4 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_9 + var_313_4
					end
				end

				arg_310_1.text_.text = var_313_7
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161072", "story_v_out_324161.awb") ~= 0 then
					local var_313_10 = manager.audio:GetVoiceLength("story_v_out_324161", "324161072", "story_v_out_324161.awb") / 1000

					if var_313_10 + var_313_4 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_10 + var_313_4
					end

					if var_313_6.prefab_name ~= "" and arg_310_1.actors_[var_313_6.prefab_name] ~= nil then
						local var_313_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_6.prefab_name].transform, "story_v_out_324161", "324161072", "story_v_out_324161.awb")

						arg_310_1:RecordAudio("324161072", var_313_11)
						arg_310_1:RecordAudio("324161072", var_313_11)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_324161", "324161072", "story_v_out_324161.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_324161", "324161072", "story_v_out_324161.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_12 = math.max(var_313_5, arg_310_1.talkMaxDuration)

			if var_313_4 <= arg_310_1.time_ and arg_310_1.time_ < var_313_4 + var_313_12 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_4) / var_313_12

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_4 + var_313_12 and arg_310_1.time_ < var_313_4 + var_313_12 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play324161073 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 324161073
		arg_314_1.duration_ = 6.77

		local var_314_0 = {
			zh = 6.766,
			ja = 6.133
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play324161074(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(arg_314_1.actors_["1054ui_story"]) and arg_314_1.var_.characterEffect1054ui_story == nil then
				arg_314_1.var_.characterEffect1054ui_story = arg_314_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_0 = 0.200000002980232

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 and not isNil(arg_314_1.actors_["1054ui_story"]) then
				if arg_314_1.var_.characterEffect1054ui_story and not isNil(arg_314_1.actors_["1054ui_story"]) then
					arg_314_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 and not isNil(arg_314_1.actors_["1054ui_story"]) and arg_314_1.var_.characterEffect1054ui_story then
				arg_314_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_317_2 = arg_314_1.actors_["6148ui_story"]

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(var_317_2) and arg_314_1.var_.characterEffect6148ui_story == nil then
				arg_314_1.var_.characterEffect6148ui_story = var_317_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_3 = 0.200000002980232

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_3 and not isNil(var_317_2) then
				if arg_314_1.var_.characterEffect6148ui_story and not isNil(var_317_2) then
					arg_314_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_314_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_314_1.time_ - 0) / var_317_3)
				end
			end

			if arg_314_1.time_ >= 0 + var_317_3 and arg_314_1.time_ < 0 + var_317_3 + arg_317_0 and not isNil(var_317_2) and arg_314_1.var_.characterEffect6148ui_story then
				arg_314_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_314_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_317_4 = 0
			local var_317_5 = 0.775

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_4 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_6 = arg_314_1:GetWordFromCfg(324161073)
				local var_317_7 = arg_314_1:FormatText(var_317_6.content)

				arg_314_1.text_.text = var_317_7

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_9 = 31 <= 0 and var_317_5 or var_317_5 * (utf8.len(var_317_7) / 31)

				if (31 <= 0 and var_317_5 or var_317_5 * (utf8.len(var_317_7) / 31)) > 0 and var_317_5 < var_317_9 then
					arg_314_1.talkMaxDuration = var_317_9

					if var_317_9 + var_317_4 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_9 + var_317_4
					end
				end

				arg_314_1.text_.text = var_317_7
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161073", "story_v_out_324161.awb") ~= 0 then
					local var_317_10 = manager.audio:GetVoiceLength("story_v_out_324161", "324161073", "story_v_out_324161.awb") / 1000

					if var_317_10 + var_317_4 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_10 + var_317_4
					end

					if var_317_6.prefab_name ~= "" and arg_314_1.actors_[var_317_6.prefab_name] ~= nil then
						local var_317_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_6.prefab_name].transform, "story_v_out_324161", "324161073", "story_v_out_324161.awb")

						arg_314_1:RecordAudio("324161073", var_317_11)
						arg_314_1:RecordAudio("324161073", var_317_11)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_324161", "324161073", "story_v_out_324161.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_324161", "324161073", "story_v_out_324161.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_12 = math.max(var_317_5, arg_314_1.talkMaxDuration)

			if var_317_4 <= arg_314_1.time_ and arg_314_1.time_ < var_317_4 + var_317_12 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_4) / var_317_12

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_4 + var_317_12 and arg_314_1.time_ < var_317_4 + var_317_12 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play324161074 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 324161074
		arg_318_1.duration_ = 4.87

		local var_318_0 = {
			zh = 4,
			ja = 4.866
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play324161075(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(arg_318_1.actors_["6148ui_story"]) and arg_318_1.var_.characterEffect6148ui_story == nil then
				arg_318_1.var_.characterEffect6148ui_story = arg_318_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_0 = 0.200000002980232

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 and not isNil(arg_318_1.actors_["6148ui_story"]) then
				if arg_318_1.var_.characterEffect6148ui_story and not isNil(arg_318_1.actors_["6148ui_story"]) then
					arg_318_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 and not isNil(arg_318_1.actors_["6148ui_story"]) and arg_318_1.var_.characterEffect6148ui_story then
				arg_318_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_321_2 = arg_318_1.actors_["1054ui_story"]

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(var_321_2) and arg_318_1.var_.characterEffect1054ui_story == nil then
				arg_318_1.var_.characterEffect1054ui_story = var_321_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_3 = 0.200000002980232

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_3 and not isNil(var_321_2) then
				if arg_318_1.var_.characterEffect1054ui_story and not isNil(var_321_2) then
					arg_318_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_318_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_318_1.time_ - 0) / var_321_3)
				end
			end

			if arg_318_1.time_ >= 0 + var_321_3 and arg_318_1.time_ < 0 + var_321_3 + arg_321_0 and not isNil(var_321_2) and arg_318_1.var_.characterEffect1054ui_story then
				arg_318_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_318_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_321_4 = 0
			local var_321_5 = 0.575

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_4 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_6 = arg_318_1:GetWordFromCfg(324161074)
				local var_321_7 = arg_318_1:FormatText(var_321_6.content)

				arg_318_1.text_.text = var_321_7

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_9 = 23 <= 0 and var_321_5 or var_321_5 * (utf8.len(var_321_7) / 23)

				if (23 <= 0 and var_321_5 or var_321_5 * (utf8.len(var_321_7) / 23)) > 0 and var_321_5 < var_321_9 then
					arg_318_1.talkMaxDuration = var_321_9

					if var_321_9 + var_321_4 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_9 + var_321_4
					end
				end

				arg_318_1.text_.text = var_321_7
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161074", "story_v_out_324161.awb") ~= 0 then
					local var_321_10 = manager.audio:GetVoiceLength("story_v_out_324161", "324161074", "story_v_out_324161.awb") / 1000

					if var_321_10 + var_321_4 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_10 + var_321_4
					end

					if var_321_6.prefab_name ~= "" and arg_318_1.actors_[var_321_6.prefab_name] ~= nil then
						local var_321_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_6.prefab_name].transform, "story_v_out_324161", "324161074", "story_v_out_324161.awb")

						arg_318_1:RecordAudio("324161074", var_321_11)
						arg_318_1:RecordAudio("324161074", var_321_11)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_324161", "324161074", "story_v_out_324161.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_324161", "324161074", "story_v_out_324161.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_12 = math.max(var_321_5, arg_318_1.talkMaxDuration)

			if var_321_4 <= arg_318_1.time_ and arg_318_1.time_ < var_321_4 + var_321_12 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_4) / var_321_12

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_4 + var_321_12 and arg_318_1.time_ < var_321_4 + var_321_12 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play324161075 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 324161075
		arg_322_1.duration_ = 15.97

		local var_322_0 = {
			zh = 6.033,
			ja = 15.966
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play324161076(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0.775

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_1 = arg_322_1:GetWordFromCfg(324161075)
				local var_325_2 = arg_322_1:FormatText(var_325_1.content)

				arg_322_1.text_.text = var_325_2

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_4 = 31 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_2) / 31)

				if (31 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_2) / 31)) > 0 and var_325_0 < var_325_4 then
					arg_322_1.talkMaxDuration = var_325_4

					if var_325_4 + 0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_4 + 0
					end
				end

				arg_322_1.text_.text = var_325_2
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161075", "story_v_out_324161.awb") ~= 0 then
					local var_325_5 = manager.audio:GetVoiceLength("story_v_out_324161", "324161075", "story_v_out_324161.awb") / 1000

					if var_325_5 + 0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_5 + 0
					end

					if var_325_1.prefab_name ~= "" and arg_322_1.actors_[var_325_1.prefab_name] ~= nil then
						local var_325_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_1.prefab_name].transform, "story_v_out_324161", "324161075", "story_v_out_324161.awb")

						arg_322_1:RecordAudio("324161075", var_325_6)
						arg_322_1:RecordAudio("324161075", var_325_6)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_324161", "324161075", "story_v_out_324161.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_324161", "324161075", "story_v_out_324161.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_7 = math.max(var_325_0, arg_322_1.talkMaxDuration)

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_7 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - 0) / var_325_7

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= 0 + var_325_7 and arg_322_1.time_ < 0 + var_325_7 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play324161076 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 324161076
		arg_326_1.duration_ = 3.63

		local var_326_0 = {
			zh = 2.9,
			ja = 3.633
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
				arg_326_0:Play324161077(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(arg_326_1.actors_["1054ui_story"]) and arg_326_1.var_.characterEffect1054ui_story == nil then
				arg_326_1.var_.characterEffect1054ui_story = arg_326_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_0 = 0.200000002980232

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_0 and not isNil(arg_326_1.actors_["1054ui_story"]) then
				if arg_326_1.var_.characterEffect1054ui_story and not isNil(arg_326_1.actors_["1054ui_story"]) then
					arg_326_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_326_1.time_ >= 0 + var_329_0 and arg_326_1.time_ < 0 + var_329_0 + arg_329_0 and not isNil(arg_326_1.actors_["1054ui_story"]) and arg_326_1.var_.characterEffect1054ui_story then
				arg_326_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_329_2 = arg_326_1.actors_["6148ui_story"]

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(var_329_2) and arg_326_1.var_.characterEffect6148ui_story == nil then
				arg_326_1.var_.characterEffect6148ui_story = var_329_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_3 = 0.200000002980232

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_3 and not isNil(var_329_2) then
				if arg_326_1.var_.characterEffect6148ui_story and not isNil(var_329_2) then
					arg_326_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_326_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_326_1.time_ - 0) / var_329_3)
				end
			end

			if arg_326_1.time_ >= 0 + var_329_3 and arg_326_1.time_ < 0 + var_329_3 + arg_329_0 and not isNil(var_329_2) and arg_326_1.var_.characterEffect6148ui_story then
				arg_326_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_326_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_329_4 = 0
			local var_329_5 = 0.2

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_4 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_6 = arg_326_1:GetWordFromCfg(324161076)
				local var_329_7 = arg_326_1:FormatText(var_329_6.content)

				arg_326_1.text_.text = var_329_7

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_9 = 8 <= 0 and var_329_5 or var_329_5 * (utf8.len(var_329_7) / 8)

				if (8 <= 0 and var_329_5 or var_329_5 * (utf8.len(var_329_7) / 8)) > 0 and var_329_5 < var_329_9 then
					arg_326_1.talkMaxDuration = var_329_9

					if var_329_9 + var_329_4 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_9 + var_329_4
					end
				end

				arg_326_1.text_.text = var_329_7
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161076", "story_v_out_324161.awb") ~= 0 then
					local var_329_10 = manager.audio:GetVoiceLength("story_v_out_324161", "324161076", "story_v_out_324161.awb") / 1000

					if var_329_10 + var_329_4 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_10 + var_329_4
					end

					if var_329_6.prefab_name ~= "" and arg_326_1.actors_[var_329_6.prefab_name] ~= nil then
						local var_329_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_6.prefab_name].transform, "story_v_out_324161", "324161076", "story_v_out_324161.awb")

						arg_326_1:RecordAudio("324161076", var_329_11)
						arg_326_1:RecordAudio("324161076", var_329_11)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_324161", "324161076", "story_v_out_324161.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_324161", "324161076", "story_v_out_324161.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_12 = math.max(var_329_5, arg_326_1.talkMaxDuration)

			if var_329_4 <= arg_326_1.time_ and arg_326_1.time_ < var_329_4 + var_329_12 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_4) / var_329_12

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_4 + var_329_12 and arg_326_1.time_ < var_329_4 + var_329_12 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play324161077 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 324161077
		arg_330_1.duration_ = 6.47

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play324161078(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(arg_330_1.actors_["1054ui_story"]) and arg_330_1.var_.characterEffect1054ui_story == nil then
				arg_330_1.var_.characterEffect1054ui_story = arg_330_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_0 = 0.200000002980232

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 and not isNil(arg_330_1.actors_["1054ui_story"]) then
				if arg_330_1.var_.characterEffect1054ui_story and not isNil(arg_330_1.actors_["1054ui_story"]) then
					arg_330_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_330_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_330_1.time_ - 0) / var_333_0)
				end
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 and not isNil(arg_330_1.actors_["1054ui_story"]) and arg_330_1.var_.characterEffect1054ui_story then
				arg_330_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_330_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_333_1 = arg_330_1.bgs_.MS2404.transform

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.var_.moveOldPosMS2404 = var_333_1.localPosition
			end

			local var_333_2 = 1.26666666666667

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_2 then
				var_333_1.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPosMS2404, Vector3.New(0, 0.42, 6.64), (arg_330_1.time_ - 0) / var_333_2)
			end

			if arg_330_1.time_ >= 0 + var_333_2 and arg_330_1.time_ < 0 + var_333_2 + arg_333_0 then
				var_333_1.localPosition = Vector3.New(0, 0.42, 6.64)
			end

			local var_333_3 = 0

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_3 + arg_333_0 then
				arg_330_1.allBtn_.enabled = false
			end

			if arg_330_1.time_ >= var_333_3 + 1.83333333333333 and arg_330_1.time_ < var_333_3 + 1.83333333333333 + arg_333_0 then
				arg_330_1.allBtn_.enabled = true
			end

			if arg_330_1.frameCnt_ <= 1 then
				arg_330_1.dialog_:SetActive(false)
			end

			local var_333_4 = 1.46666666666667
			local var_333_5 = 0.825

			if 1.46666666666667 < arg_330_1.time_ and arg_330_1.time_ <= var_333_4 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0

				arg_330_1.dialog_:SetActive(true)

				arg_330_1.dialogCg_.alpha = 0

				local var_333_6 = LeanTween.value(arg_330_1.dialog_, 0, 1, 0.3)

				var_333_6:setOnUpdate(LuaHelper.FloatAction(function(arg_334_0)
					arg_330_1.dialogCg_.alpha = arg_334_0
				end))
				var_333_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_330_1.dialog_)
					var_333_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_330_1.duration_ = arg_330_1.duration_ + 0.3

				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_7 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(324161077).content)

				arg_330_1.text_.text = var_333_7

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_9 = 33 <= 0 and var_333_5 or var_333_5 * (utf8.len(var_333_7) / 33)

				if (33 <= 0 and var_333_5 or var_333_5 * (utf8.len(var_333_7) / 33)) > 0 and var_333_5 < var_333_9 then
					arg_330_1.talkMaxDuration = var_333_9
					var_333_4 = var_333_4 + 0.3

					if var_333_9 + var_333_4 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_9 + var_333_4
					end
				end

				arg_330_1.text_.text = var_333_7
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_10 = var_333_4 + 0.3
			local var_333_11 = math.max(var_333_5, arg_330_1.talkMaxDuration)

			if var_333_4 + 0.3 <= arg_330_1.time_ and arg_330_1.time_ < var_333_10 + var_333_11 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_10) / var_333_11

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_10 + var_333_11 and arg_330_1.time_ < var_333_10 + var_333_11 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2404",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.26666666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9),
					endPos = Vector3.New(0, 0.42, 6.64),
					easeType = LeanTweenType.easeInOutQuad
				}
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play324161078 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 324161078
		arg_336_1.duration_ = 7.93

		local var_336_0 = {
			zh = 7.5,
			ja = 7.933
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play324161079(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(arg_336_1.actors_["1054ui_story"]) and arg_336_1.var_.characterEffect1054ui_story == nil then
				arg_336_1.var_.characterEffect1054ui_story = arg_336_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_0 = 0.200000002980232

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_0 and not isNil(arg_336_1.actors_["1054ui_story"]) then
				if arg_336_1.var_.characterEffect1054ui_story and not isNil(arg_336_1.actors_["1054ui_story"]) then
					arg_336_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_336_1.time_ >= 0 + var_339_0 and arg_336_1.time_ < 0 + var_339_0 + arg_339_0 and not isNil(arg_336_1.actors_["1054ui_story"]) and arg_336_1.var_.characterEffect1054ui_story then
				arg_336_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_339_2 = 0
			local var_339_3 = 0.8

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_2 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_4 = arg_336_1:GetWordFromCfg(324161078)
				local var_339_5 = arg_336_1:FormatText(var_339_4.content)

				arg_336_1.text_.text = var_339_5

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_7 = 32 <= 0 and var_339_3 or var_339_3 * (utf8.len(var_339_5) / 32)

				if (32 <= 0 and var_339_3 or var_339_3 * (utf8.len(var_339_5) / 32)) > 0 and var_339_3 < var_339_7 then
					arg_336_1.talkMaxDuration = var_339_7

					if var_339_7 + var_339_2 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_7 + var_339_2
					end
				end

				arg_336_1.text_.text = var_339_5
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161078", "story_v_out_324161.awb") ~= 0 then
					local var_339_8 = manager.audio:GetVoiceLength("story_v_out_324161", "324161078", "story_v_out_324161.awb") / 1000

					if var_339_8 + var_339_2 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_8 + var_339_2
					end

					if var_339_4.prefab_name ~= "" and arg_336_1.actors_[var_339_4.prefab_name] ~= nil then
						local var_339_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_4.prefab_name].transform, "story_v_out_324161", "324161078", "story_v_out_324161.awb")

						arg_336_1:RecordAudio("324161078", var_339_9)
						arg_336_1:RecordAudio("324161078", var_339_9)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_324161", "324161078", "story_v_out_324161.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_324161", "324161078", "story_v_out_324161.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_10 = math.max(var_339_3, arg_336_1.talkMaxDuration)

			if var_339_2 <= arg_336_1.time_ and arg_336_1.time_ < var_339_2 + var_339_10 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_2) / var_339_10

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_2 + var_339_10 and arg_336_1.time_ < var_339_2 + var_339_10 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play324161079 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 324161079
		arg_340_1.duration_ = 9.37

		local var_340_0 = {
			zh = 6.966,
			ja = 9.366
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play324161080(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0.85

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_1 = arg_340_1:GetWordFromCfg(324161079)
				local var_343_2 = arg_340_1:FormatText(var_343_1.content)

				arg_340_1.text_.text = var_343_2

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_4 = 34 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_2) / 34)

				if (34 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_2) / 34)) > 0 and var_343_0 < var_343_4 then
					arg_340_1.talkMaxDuration = var_343_4

					if var_343_4 + 0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_4 + 0
					end
				end

				arg_340_1.text_.text = var_343_2
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161079", "story_v_out_324161.awb") ~= 0 then
					local var_343_5 = manager.audio:GetVoiceLength("story_v_out_324161", "324161079", "story_v_out_324161.awb") / 1000

					if var_343_5 + 0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_5 + 0
					end

					if var_343_1.prefab_name ~= "" and arg_340_1.actors_[var_343_1.prefab_name] ~= nil then
						local var_343_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_1.prefab_name].transform, "story_v_out_324161", "324161079", "story_v_out_324161.awb")

						arg_340_1:RecordAudio("324161079", var_343_6)
						arg_340_1:RecordAudio("324161079", var_343_6)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_324161", "324161079", "story_v_out_324161.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_324161", "324161079", "story_v_out_324161.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_7 = math.max(var_343_0, arg_340_1.talkMaxDuration)

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_7 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - 0) / var_343_7

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= 0 + var_343_7 and arg_340_1.time_ < 0 + var_343_7 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play324161080 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 324161080
		arg_344_1.duration_ = 2.2

		local var_344_0 = {
			zh = 1.8,
			ja = 2.2
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play324161081(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(arg_344_1.actors_["6148ui_story"]) and arg_344_1.var_.characterEffect6148ui_story == nil then
				arg_344_1.var_.characterEffect6148ui_story = arg_344_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_0 = 0.200000002980232

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_0 and not isNil(arg_344_1.actors_["6148ui_story"]) then
				if arg_344_1.var_.characterEffect6148ui_story and not isNil(arg_344_1.actors_["6148ui_story"]) then
					arg_344_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_344_1.time_ >= 0 + var_347_0 and arg_344_1.time_ < 0 + var_347_0 + arg_347_0 and not isNil(arg_344_1.actors_["6148ui_story"]) and arg_344_1.var_.characterEffect6148ui_story then
				arg_344_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_347_2 = arg_344_1.actors_["1054ui_story"]

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(var_347_2) and arg_344_1.var_.characterEffect1054ui_story == nil then
				arg_344_1.var_.characterEffect1054ui_story = var_347_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_3 = 0.200000002980232

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_3 and not isNil(var_347_2) then
				if arg_344_1.var_.characterEffect1054ui_story and not isNil(var_347_2) then
					arg_344_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_344_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_344_1.time_ - 0) / var_347_3)
				end
			end

			if arg_344_1.time_ >= 0 + var_347_3 and arg_344_1.time_ < 0 + var_347_3 + arg_347_0 and not isNil(var_347_2) and arg_344_1.var_.characterEffect1054ui_story then
				arg_344_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_344_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_347_4 = 0
			local var_347_5 = 0.075

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_4 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_6 = arg_344_1:GetWordFromCfg(324161080)
				local var_347_7 = arg_344_1:FormatText(var_347_6.content)

				arg_344_1.text_.text = var_347_7

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_9 = 3 <= 0 and var_347_5 or var_347_5 * (utf8.len(var_347_7) / 3)

				if (3 <= 0 and var_347_5 or var_347_5 * (utf8.len(var_347_7) / 3)) > 0 and var_347_5 < var_347_9 then
					arg_344_1.talkMaxDuration = var_347_9

					if var_347_9 + var_347_4 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_9 + var_347_4
					end
				end

				arg_344_1.text_.text = var_347_7
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161080", "story_v_out_324161.awb") ~= 0 then
					local var_347_10 = manager.audio:GetVoiceLength("story_v_out_324161", "324161080", "story_v_out_324161.awb") / 1000

					if var_347_10 + var_347_4 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_10 + var_347_4
					end

					if var_347_6.prefab_name ~= "" and arg_344_1.actors_[var_347_6.prefab_name] ~= nil then
						local var_347_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_6.prefab_name].transform, "story_v_out_324161", "324161080", "story_v_out_324161.awb")

						arg_344_1:RecordAudio("324161080", var_347_11)
						arg_344_1:RecordAudio("324161080", var_347_11)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_324161", "324161080", "story_v_out_324161.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_324161", "324161080", "story_v_out_324161.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_12 = math.max(var_347_5, arg_344_1.talkMaxDuration)

			if var_347_4 <= arg_344_1.time_ and arg_344_1.time_ < var_347_4 + var_347_12 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_4) / var_347_12

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_4 + var_347_12 and arg_344_1.time_ < var_347_4 + var_347_12 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play324161081 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 324161081
		arg_348_1.duration_ = 5.73

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play324161082(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 and not isNil(arg_348_1.actors_["6148ui_story"]) and arg_348_1.var_.characterEffect6148ui_story == nil then
				arg_348_1.var_.characterEffect6148ui_story = arg_348_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_0 = 0.200000002980232

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_0 and not isNil(arg_348_1.actors_["6148ui_story"]) then
				if arg_348_1.var_.characterEffect6148ui_story and not isNil(arg_348_1.actors_["6148ui_story"]) then
					arg_348_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_348_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_348_1.time_ - 0) / var_351_0)
				end
			end

			if arg_348_1.time_ >= 0 + var_351_0 and arg_348_1.time_ < 0 + var_351_0 + arg_351_0 and not isNil(arg_348_1.actors_["6148ui_story"]) and arg_348_1.var_.characterEffect6148ui_story then
				arg_348_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_348_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_351_1 = 0

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 then
				arg_348_1.allBtn_.enabled = false
			end

			if arg_348_1.time_ >= var_351_1 + 1.33333333333333 and arg_348_1.time_ < var_351_1 + 1.33333333333333 + arg_351_0 then
				arg_348_1.allBtn_.enabled = true
			end

			local var_351_2 = manager.ui.mainCamera.transform

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.var_.shakeOldPos = var_351_2.localPosition
			end

			local var_351_3 = 1.13333333333333

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_3 then
				local var_351_4, var_351_5 = math.modf((arg_348_1.time_ - 0) / 0.066)

				var_351_2.localPosition = Vector3.New(var_351_5 * 0.13, var_351_5 * 0.13, var_351_5 * 0.13) + arg_348_1.var_.shakeOldPos
			end

			if arg_348_1.time_ >= 0 + var_351_3 and arg_348_1.time_ < 0 + var_351_3 + arg_351_0 then
				var_351_2.localPosition = arg_348_1.var_.shakeOldPos
			end

			if arg_348_1.frameCnt_ <= 1 then
				arg_348_1.dialog_:SetActive(false)
			end

			local var_351_6 = 0.733333333333333
			local var_351_7 = 1.4

			if 0.733333333333333 < arg_348_1.time_ and arg_348_1.time_ <= var_351_6 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0

				arg_348_1.dialog_:SetActive(true)

				arg_348_1.dialogCg_.alpha = 0

				local var_351_8 = LeanTween.value(arg_348_1.dialog_, 0, 1, 0.3)

				var_351_8:setOnUpdate(LuaHelper.FloatAction(function(arg_352_0)
					arg_348_1.dialogCg_.alpha = arg_352_0
				end))
				var_351_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_348_1.dialog_)
					var_351_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_348_1.duration_ = arg_348_1.duration_ + 0.3

				SetActive(arg_348_1.leftNameGo_, false)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_9 = arg_348_1:FormatText(arg_348_1:GetWordFromCfg(324161081).content)

				arg_348_1.text_.text = var_351_9

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_11 = 56 <= 0 and var_351_7 or var_351_7 * (utf8.len(var_351_9) / 56)

				if (56 <= 0 and var_351_7 or var_351_7 * (utf8.len(var_351_9) / 56)) > 0 and var_351_7 < var_351_11 then
					arg_348_1.talkMaxDuration = var_351_11
					var_351_6 = var_351_6 + 0.3

					if var_351_11 + var_351_6 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_11 + var_351_6
					end
				end

				arg_348_1.text_.text = var_351_9
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_12 = var_351_6 + 0.3
			local var_351_13 = math.max(var_351_7, arg_348_1.talkMaxDuration)

			if var_351_6 + 0.3 <= arg_348_1.time_ and arg_348_1.time_ < var_351_12 + var_351_13 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_12) / var_351_13

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_12 + var_351_13 and arg_348_1.time_ < var_351_12 + var_351_13 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play324161082 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 324161082
		arg_354_1.duration_ = 18.23

		local var_354_0 = {
			zh = 11.266,
			ja = 18.233
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
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play324161083(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(arg_354_1.actors_["6148ui_story"]) and arg_354_1.var_.characterEffect6148ui_story == nil then
				arg_354_1.var_.characterEffect6148ui_story = arg_354_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_0 = 0.200000002980232

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 and not isNil(arg_354_1.actors_["6148ui_story"]) then
				if arg_354_1.var_.characterEffect6148ui_story and not isNil(arg_354_1.actors_["6148ui_story"]) then
					arg_354_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 and not isNil(arg_354_1.actors_["6148ui_story"]) and arg_354_1.var_.characterEffect6148ui_story then
				arg_354_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_357_2 = 0
			local var_357_3 = 1.2

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_2 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_4 = arg_354_1:GetWordFromCfg(324161082)
				local var_357_5 = arg_354_1:FormatText(var_357_4.content)

				arg_354_1.text_.text = var_357_5

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_7 = 48 <= 0 and var_357_3 or var_357_3 * (utf8.len(var_357_5) / 48)

				if (48 <= 0 and var_357_3 or var_357_3 * (utf8.len(var_357_5) / 48)) > 0 and var_357_3 < var_357_7 then
					arg_354_1.talkMaxDuration = var_357_7

					if var_357_7 + var_357_2 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_7 + var_357_2
					end
				end

				arg_354_1.text_.text = var_357_5
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161082", "story_v_out_324161.awb") ~= 0 then
					local var_357_8 = manager.audio:GetVoiceLength("story_v_out_324161", "324161082", "story_v_out_324161.awb") / 1000

					if var_357_8 + var_357_2 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_8 + var_357_2
					end

					if var_357_4.prefab_name ~= "" and arg_354_1.actors_[var_357_4.prefab_name] ~= nil then
						local var_357_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_4.prefab_name].transform, "story_v_out_324161", "324161082", "story_v_out_324161.awb")

						arg_354_1:RecordAudio("324161082", var_357_9)
						arg_354_1:RecordAudio("324161082", var_357_9)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_324161", "324161082", "story_v_out_324161.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_324161", "324161082", "story_v_out_324161.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_10 = math.max(var_357_3, arg_354_1.talkMaxDuration)

			if var_357_2 <= arg_354_1.time_ and arg_354_1.time_ < var_357_2 + var_357_10 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_2) / var_357_10

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_2 + var_357_10 and arg_354_1.time_ < var_357_2 + var_357_10 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play324161083 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 324161083
		arg_358_1.duration_ = 8.7

		local var_358_0 = {
			zh = 8.7,
			ja = 8.233
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play324161084(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 1.175

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_1 = arg_358_1:GetWordFromCfg(324161083)
				local var_361_2 = arg_358_1:FormatText(var_361_1.content)

				arg_358_1.text_.text = var_361_2

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_4 = 47 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_2) / 47)

				if (47 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_2) / 47)) > 0 and var_361_0 < var_361_4 then
					arg_358_1.talkMaxDuration = var_361_4

					if var_361_4 + 0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_4 + 0
					end
				end

				arg_358_1.text_.text = var_361_2
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161083", "story_v_out_324161.awb") ~= 0 then
					local var_361_5 = manager.audio:GetVoiceLength("story_v_out_324161", "324161083", "story_v_out_324161.awb") / 1000

					if var_361_5 + 0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_5 + 0
					end

					if var_361_1.prefab_name ~= "" and arg_358_1.actors_[var_361_1.prefab_name] ~= nil then
						local var_361_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_1.prefab_name].transform, "story_v_out_324161", "324161083", "story_v_out_324161.awb")

						arg_358_1:RecordAudio("324161083", var_361_6)
						arg_358_1:RecordAudio("324161083", var_361_6)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_324161", "324161083", "story_v_out_324161.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_324161", "324161083", "story_v_out_324161.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_7 = math.max(var_361_0, arg_358_1.talkMaxDuration)

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_7 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - 0) / var_361_7

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= 0 + var_361_7 and arg_358_1.time_ < 0 + var_361_7 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play324161084 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 324161084
		arg_362_1.duration_ = 12.73

		local var_362_0 = {
			zh = 7.833,
			ja = 12.733
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play324161085(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0.825

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_1 = arg_362_1:GetWordFromCfg(324161084)
				local var_365_2 = arg_362_1:FormatText(var_365_1.content)

				arg_362_1.text_.text = var_365_2

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_4 = 33 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_2) / 33)

				if (33 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_2) / 33)) > 0 and var_365_0 < var_365_4 then
					arg_362_1.talkMaxDuration = var_365_4

					if var_365_4 + 0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_4 + 0
					end
				end

				arg_362_1.text_.text = var_365_2
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161084", "story_v_out_324161.awb") ~= 0 then
					local var_365_5 = manager.audio:GetVoiceLength("story_v_out_324161", "324161084", "story_v_out_324161.awb") / 1000

					if var_365_5 + 0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_5 + 0
					end

					if var_365_1.prefab_name ~= "" and arg_362_1.actors_[var_365_1.prefab_name] ~= nil then
						local var_365_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_1.prefab_name].transform, "story_v_out_324161", "324161084", "story_v_out_324161.awb")

						arg_362_1:RecordAudio("324161084", var_365_6)
						arg_362_1:RecordAudio("324161084", var_365_6)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_324161", "324161084", "story_v_out_324161.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_324161", "324161084", "story_v_out_324161.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_7 = math.max(var_365_0, arg_362_1.talkMaxDuration)

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_7 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - 0) / var_365_7

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= 0 + var_365_7 and arg_362_1.time_ < 0 + var_365_7 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play324161085 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 324161085
		arg_366_1.duration_ = 3.37

		local var_366_0 = {
			zh = 2.666,
			ja = 3.366
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play324161086(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(arg_366_1.actors_["1054ui_story"]) and arg_366_1.var_.characterEffect1054ui_story == nil then
				arg_366_1.var_.characterEffect1054ui_story = arg_366_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_0 = 0.200000002980232

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_0 and not isNil(arg_366_1.actors_["1054ui_story"]) then
				if arg_366_1.var_.characterEffect1054ui_story and not isNil(arg_366_1.actors_["1054ui_story"]) then
					arg_366_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_366_1.time_ >= 0 + var_369_0 and arg_366_1.time_ < 0 + var_369_0 + arg_369_0 and not isNil(arg_366_1.actors_["1054ui_story"]) and arg_366_1.var_.characterEffect1054ui_story then
				arg_366_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_369_2 = arg_366_1.actors_["6148ui_story"]

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(var_369_2) and arg_366_1.var_.characterEffect6148ui_story == nil then
				arg_366_1.var_.characterEffect6148ui_story = var_369_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_3 = 0.200000002980232

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_3 and not isNil(var_369_2) then
				if arg_366_1.var_.characterEffect6148ui_story and not isNil(var_369_2) then
					arg_366_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_366_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_366_1.time_ - 0) / var_369_3)
				end
			end

			if arg_366_1.time_ >= 0 + var_369_3 and arg_366_1.time_ < 0 + var_369_3 + arg_369_0 and not isNil(var_369_2) and arg_366_1.var_.characterEffect6148ui_story then
				arg_366_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_366_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_369_4 = 0
			local var_369_5 = 0.275

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_4 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_6 = arg_366_1:GetWordFromCfg(324161085)
				local var_369_7 = arg_366_1:FormatText(var_369_6.content)

				arg_366_1.text_.text = var_369_7

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_9 = 11 <= 0 and var_369_5 or var_369_5 * (utf8.len(var_369_7) / 11)

				if (11 <= 0 and var_369_5 or var_369_5 * (utf8.len(var_369_7) / 11)) > 0 and var_369_5 < var_369_9 then
					arg_366_1.talkMaxDuration = var_369_9

					if var_369_9 + var_369_4 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_9 + var_369_4
					end
				end

				arg_366_1.text_.text = var_369_7
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161085", "story_v_out_324161.awb") ~= 0 then
					local var_369_10 = manager.audio:GetVoiceLength("story_v_out_324161", "324161085", "story_v_out_324161.awb") / 1000

					if var_369_10 + var_369_4 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_10 + var_369_4
					end

					if var_369_6.prefab_name ~= "" and arg_366_1.actors_[var_369_6.prefab_name] ~= nil then
						local var_369_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_6.prefab_name].transform, "story_v_out_324161", "324161085", "story_v_out_324161.awb")

						arg_366_1:RecordAudio("324161085", var_369_11)
						arg_366_1:RecordAudio("324161085", var_369_11)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_324161", "324161085", "story_v_out_324161.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_324161", "324161085", "story_v_out_324161.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_12 = math.max(var_369_5, arg_366_1.talkMaxDuration)

			if var_369_4 <= arg_366_1.time_ and arg_366_1.time_ < var_369_4 + var_369_12 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_4) / var_369_12

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_4 + var_369_12 and arg_366_1.time_ < var_369_4 + var_369_12 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play324161086 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 324161086
		arg_370_1.duration_ = 5.57

		local var_370_0 = {
			zh = 5.566,
			ja = 4.433
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play324161087(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(arg_370_1.actors_["6148ui_story"]) and arg_370_1.var_.characterEffect6148ui_story == nil then
				arg_370_1.var_.characterEffect6148ui_story = arg_370_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_0 = 0.200000002980232

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 and not isNil(arg_370_1.actors_["6148ui_story"]) then
				if arg_370_1.var_.characterEffect6148ui_story and not isNil(arg_370_1.actors_["6148ui_story"]) then
					arg_370_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 and not isNil(arg_370_1.actors_["6148ui_story"]) and arg_370_1.var_.characterEffect6148ui_story then
				arg_370_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_373_2 = arg_370_1.actors_["1054ui_story"]

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(var_373_2) and arg_370_1.var_.characterEffect1054ui_story == nil then
				arg_370_1.var_.characterEffect1054ui_story = var_373_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_3 = 0.200000002980232

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_3 and not isNil(var_373_2) then
				if arg_370_1.var_.characterEffect1054ui_story and not isNil(var_373_2) then
					arg_370_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_370_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_370_1.time_ - 0) / var_373_3)
				end
			end

			if arg_370_1.time_ >= 0 + var_373_3 and arg_370_1.time_ < 0 + var_373_3 + arg_373_0 and not isNil(var_373_2) and arg_370_1.var_.characterEffect1054ui_story then
				arg_370_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_370_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_373_4 = 0
			local var_373_5 = 0.55

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_4 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_6 = arg_370_1:GetWordFromCfg(324161086)
				local var_373_7 = arg_370_1:FormatText(var_373_6.content)

				arg_370_1.text_.text = var_373_7

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_9 = 22 <= 0 and var_373_5 or var_373_5 * (utf8.len(var_373_7) / 22)

				if (22 <= 0 and var_373_5 or var_373_5 * (utf8.len(var_373_7) / 22)) > 0 and var_373_5 < var_373_9 then
					arg_370_1.talkMaxDuration = var_373_9

					if var_373_9 + var_373_4 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_9 + var_373_4
					end
				end

				arg_370_1.text_.text = var_373_7
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161086", "story_v_out_324161.awb") ~= 0 then
					local var_373_10 = manager.audio:GetVoiceLength("story_v_out_324161", "324161086", "story_v_out_324161.awb") / 1000

					if var_373_10 + var_373_4 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_10 + var_373_4
					end

					if var_373_6.prefab_name ~= "" and arg_370_1.actors_[var_373_6.prefab_name] ~= nil then
						local var_373_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_6.prefab_name].transform, "story_v_out_324161", "324161086", "story_v_out_324161.awb")

						arg_370_1:RecordAudio("324161086", var_373_11)
						arg_370_1:RecordAudio("324161086", var_373_11)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_324161", "324161086", "story_v_out_324161.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_324161", "324161086", "story_v_out_324161.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_12 = math.max(var_373_5, arg_370_1.talkMaxDuration)

			if var_373_4 <= arg_370_1.time_ and arg_370_1.time_ < var_373_4 + var_373_12 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_4) / var_373_12

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_4 + var_373_12 and arg_370_1.time_ < var_373_4 + var_373_12 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play324161087 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 324161087
		arg_374_1.duration_ = 4.7

		local var_374_0 = {
			zh = 4.7,
			ja = 3.266
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play324161088(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(arg_374_1.actors_["1054ui_story"]) and arg_374_1.var_.characterEffect1054ui_story == nil then
				arg_374_1.var_.characterEffect1054ui_story = arg_374_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_0 = 0.200000002980232

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_0 and not isNil(arg_374_1.actors_["1054ui_story"]) then
				if arg_374_1.var_.characterEffect1054ui_story and not isNil(arg_374_1.actors_["1054ui_story"]) then
					arg_374_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_374_1.time_ >= 0 + var_377_0 and arg_374_1.time_ < 0 + var_377_0 + arg_377_0 and not isNil(arg_374_1.actors_["1054ui_story"]) and arg_374_1.var_.characterEffect1054ui_story then
				arg_374_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_377_2 = arg_374_1.actors_["6148ui_story"]

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(var_377_2) and arg_374_1.var_.characterEffect6148ui_story == nil then
				arg_374_1.var_.characterEffect6148ui_story = var_377_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_3 = 0.200000002980232

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_3 and not isNil(var_377_2) then
				if arg_374_1.var_.characterEffect6148ui_story and not isNil(var_377_2) then
					arg_374_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_374_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_374_1.time_ - 0) / var_377_3)
				end
			end

			if arg_374_1.time_ >= 0 + var_377_3 and arg_374_1.time_ < 0 + var_377_3 + arg_377_0 and not isNil(var_377_2) and arg_374_1.var_.characterEffect6148ui_story then
				arg_374_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_374_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_377_4 = 0
			local var_377_5 = 0.45

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_4 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_6 = arg_374_1:GetWordFromCfg(324161087)
				local var_377_7 = arg_374_1:FormatText(var_377_6.content)

				arg_374_1.text_.text = var_377_7

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_9 = 18 <= 0 and var_377_5 or var_377_5 * (utf8.len(var_377_7) / 18)

				if (18 <= 0 and var_377_5 or var_377_5 * (utf8.len(var_377_7) / 18)) > 0 and var_377_5 < var_377_9 then
					arg_374_1.talkMaxDuration = var_377_9

					if var_377_9 + var_377_4 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_9 + var_377_4
					end
				end

				arg_374_1.text_.text = var_377_7
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161087", "story_v_out_324161.awb") ~= 0 then
					local var_377_10 = manager.audio:GetVoiceLength("story_v_out_324161", "324161087", "story_v_out_324161.awb") / 1000

					if var_377_10 + var_377_4 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_10 + var_377_4
					end

					if var_377_6.prefab_name ~= "" and arg_374_1.actors_[var_377_6.prefab_name] ~= nil then
						local var_377_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_6.prefab_name].transform, "story_v_out_324161", "324161087", "story_v_out_324161.awb")

						arg_374_1:RecordAudio("324161087", var_377_11)
						arg_374_1:RecordAudio("324161087", var_377_11)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_324161", "324161087", "story_v_out_324161.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_324161", "324161087", "story_v_out_324161.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_12 = math.max(var_377_5, arg_374_1.talkMaxDuration)

			if var_377_4 <= arg_374_1.time_ and arg_374_1.time_ < var_377_4 + var_377_12 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_4) / var_377_12

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_4 + var_377_12 and arg_374_1.time_ < var_377_4 + var_377_12 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play324161088 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 324161088
		arg_378_1.duration_ = 6.07

		local var_378_0 = {
			zh = 6.066,
			ja = 5.433
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play324161089(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0.525

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_1 = arg_378_1:GetWordFromCfg(324161088)
				local var_381_2 = arg_378_1:FormatText(var_381_1.content)

				arg_378_1.text_.text = var_381_2

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_4 = 21 <= 0 and var_381_0 or var_381_0 * (utf8.len(var_381_2) / 21)

				if (21 <= 0 and var_381_0 or var_381_0 * (utf8.len(var_381_2) / 21)) > 0 and var_381_0 < var_381_4 then
					arg_378_1.talkMaxDuration = var_381_4

					if var_381_4 + 0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_4 + 0
					end
				end

				arg_378_1.text_.text = var_381_2
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161088", "story_v_out_324161.awb") ~= 0 then
					local var_381_5 = manager.audio:GetVoiceLength("story_v_out_324161", "324161088", "story_v_out_324161.awb") / 1000

					if var_381_5 + 0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_5 + 0
					end

					if var_381_1.prefab_name ~= "" and arg_378_1.actors_[var_381_1.prefab_name] ~= nil then
						local var_381_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_1.prefab_name].transform, "story_v_out_324161", "324161088", "story_v_out_324161.awb")

						arg_378_1:RecordAudio("324161088", var_381_6)
						arg_378_1:RecordAudio("324161088", var_381_6)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_324161", "324161088", "story_v_out_324161.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_324161", "324161088", "story_v_out_324161.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_7 = math.max(var_381_0, arg_378_1.talkMaxDuration)

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_7 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - 0) / var_381_7

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= 0 + var_381_7 and arg_378_1.time_ < 0 + var_381_7 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play324161089 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 324161089
		arg_382_1.duration_ = 6.53

		local var_382_0 = {
			zh = 6.133,
			ja = 6.533
		}
		local var_382_1 = manager.audio:GetLocalizationFlag()

		if var_382_0[var_382_1] ~= nil then
			arg_382_1.duration_ = var_382_0[var_382_1]
		end

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play324161090(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(arg_382_1.actors_["6148ui_story"]) and arg_382_1.var_.characterEffect6148ui_story == nil then
				arg_382_1.var_.characterEffect6148ui_story = arg_382_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_0 = 0.200000002980232

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 and not isNil(arg_382_1.actors_["6148ui_story"]) then
				if arg_382_1.var_.characterEffect6148ui_story and not isNil(arg_382_1.actors_["6148ui_story"]) then
					arg_382_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 and not isNil(arg_382_1.actors_["6148ui_story"]) and arg_382_1.var_.characterEffect6148ui_story then
				arg_382_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_385_2 = arg_382_1.actors_["1054ui_story"]

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(var_385_2) and arg_382_1.var_.characterEffect1054ui_story == nil then
				arg_382_1.var_.characterEffect1054ui_story = var_385_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_3 = 0.200000002980232

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_3 and not isNil(var_385_2) then
				if arg_382_1.var_.characterEffect1054ui_story and not isNil(var_385_2) then
					arg_382_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_382_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_382_1.time_ - 0) / var_385_3)
				end
			end

			if arg_382_1.time_ >= 0 + var_385_3 and arg_382_1.time_ < 0 + var_385_3 + arg_385_0 and not isNil(var_385_2) and arg_382_1.var_.characterEffect1054ui_story then
				arg_382_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_382_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_385_4 = 0
			local var_385_5 = 0.7

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_4 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_6 = arg_382_1:GetWordFromCfg(324161089)
				local var_385_7 = arg_382_1:FormatText(var_385_6.content)

				arg_382_1.text_.text = var_385_7

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_9 = 28 <= 0 and var_385_5 or var_385_5 * (utf8.len(var_385_7) / 28)

				if (28 <= 0 and var_385_5 or var_385_5 * (utf8.len(var_385_7) / 28)) > 0 and var_385_5 < var_385_9 then
					arg_382_1.talkMaxDuration = var_385_9

					if var_385_9 + var_385_4 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_9 + var_385_4
					end
				end

				arg_382_1.text_.text = var_385_7
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161089", "story_v_out_324161.awb") ~= 0 then
					local var_385_10 = manager.audio:GetVoiceLength("story_v_out_324161", "324161089", "story_v_out_324161.awb") / 1000

					if var_385_10 + var_385_4 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_10 + var_385_4
					end

					if var_385_6.prefab_name ~= "" and arg_382_1.actors_[var_385_6.prefab_name] ~= nil then
						local var_385_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_6.prefab_name].transform, "story_v_out_324161", "324161089", "story_v_out_324161.awb")

						arg_382_1:RecordAudio("324161089", var_385_11)
						arg_382_1:RecordAudio("324161089", var_385_11)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_324161", "324161089", "story_v_out_324161.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_324161", "324161089", "story_v_out_324161.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_12 = math.max(var_385_5, arg_382_1.talkMaxDuration)

			if var_385_4 <= arg_382_1.time_ and arg_382_1.time_ < var_385_4 + var_385_12 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_4) / var_385_12

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_4 + var_385_12 and arg_382_1.time_ < var_385_4 + var_385_12 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play324161090 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 324161090
		arg_386_1.duration_ = 5.6

		local var_386_0 = {
			zh = 5.4,
			ja = 5.6
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play324161091(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(arg_386_1.actors_["1054ui_story"]) and arg_386_1.var_.characterEffect1054ui_story == nil then
				arg_386_1.var_.characterEffect1054ui_story = arg_386_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_0 = 0.200000002980232

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_0 and not isNil(arg_386_1.actors_["1054ui_story"]) then
				if arg_386_1.var_.characterEffect1054ui_story and not isNil(arg_386_1.actors_["1054ui_story"]) then
					arg_386_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_386_1.time_ >= 0 + var_389_0 and arg_386_1.time_ < 0 + var_389_0 + arg_389_0 and not isNil(arg_386_1.actors_["1054ui_story"]) and arg_386_1.var_.characterEffect1054ui_story then
				arg_386_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_389_2 = arg_386_1.actors_["6148ui_story"]

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(var_389_2) and arg_386_1.var_.characterEffect6148ui_story == nil then
				arg_386_1.var_.characterEffect6148ui_story = var_389_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_3 = 0.200000002980232

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_3 and not isNil(var_389_2) then
				if arg_386_1.var_.characterEffect6148ui_story and not isNil(var_389_2) then
					arg_386_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_386_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_386_1.time_ - 0) / var_389_3)
				end
			end

			if arg_386_1.time_ >= 0 + var_389_3 and arg_386_1.time_ < 0 + var_389_3 + arg_389_0 and not isNil(var_389_2) and arg_386_1.var_.characterEffect6148ui_story then
				arg_386_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_386_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_389_4 = 0
			local var_389_5 = 0.425

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_4 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_6 = arg_386_1:GetWordFromCfg(324161090)
				local var_389_7 = arg_386_1:FormatText(var_389_6.content)

				arg_386_1.text_.text = var_389_7

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_9 = 17 <= 0 and var_389_5 or var_389_5 * (utf8.len(var_389_7) / 17)

				if (17 <= 0 and var_389_5 or var_389_5 * (utf8.len(var_389_7) / 17)) > 0 and var_389_5 < var_389_9 then
					arg_386_1.talkMaxDuration = var_389_9

					if var_389_9 + var_389_4 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_9 + var_389_4
					end
				end

				arg_386_1.text_.text = var_389_7
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161090", "story_v_out_324161.awb") ~= 0 then
					local var_389_10 = manager.audio:GetVoiceLength("story_v_out_324161", "324161090", "story_v_out_324161.awb") / 1000

					if var_389_10 + var_389_4 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_10 + var_389_4
					end

					if var_389_6.prefab_name ~= "" and arg_386_1.actors_[var_389_6.prefab_name] ~= nil then
						local var_389_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_6.prefab_name].transform, "story_v_out_324161", "324161090", "story_v_out_324161.awb")

						arg_386_1:RecordAudio("324161090", var_389_11)
						arg_386_1:RecordAudio("324161090", var_389_11)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_324161", "324161090", "story_v_out_324161.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_324161", "324161090", "story_v_out_324161.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_12 = math.max(var_389_5, arg_386_1.talkMaxDuration)

			if var_389_4 <= arg_386_1.time_ and arg_386_1.time_ < var_389_4 + var_389_12 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_4) / var_389_12

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_4 + var_389_12 and arg_386_1.time_ < var_389_4 + var_389_12 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play324161091 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 324161091
		arg_390_1.duration_ = 3.77

		local var_390_0 = {
			zh = 3.766,
			ja = 3.3
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play324161092(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(arg_390_1.actors_["6148ui_story"]) and arg_390_1.var_.characterEffect6148ui_story == nil then
				arg_390_1.var_.characterEffect6148ui_story = arg_390_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_0 = 0.200000002980232

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_0 and not isNil(arg_390_1.actors_["6148ui_story"]) then
				if arg_390_1.var_.characterEffect6148ui_story and not isNil(arg_390_1.actors_["6148ui_story"]) then
					arg_390_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_390_1.time_ >= 0 + var_393_0 and arg_390_1.time_ < 0 + var_393_0 + arg_393_0 and not isNil(arg_390_1.actors_["6148ui_story"]) and arg_390_1.var_.characterEffect6148ui_story then
				arg_390_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_393_2 = arg_390_1.actors_["1054ui_story"]

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(var_393_2) and arg_390_1.var_.characterEffect1054ui_story == nil then
				arg_390_1.var_.characterEffect1054ui_story = var_393_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_3 = 0.200000002980232

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_3 and not isNil(var_393_2) then
				if arg_390_1.var_.characterEffect1054ui_story and not isNil(var_393_2) then
					arg_390_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_390_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_390_1.time_ - 0) / var_393_3)
				end
			end

			if arg_390_1.time_ >= 0 + var_393_3 and arg_390_1.time_ < 0 + var_393_3 + arg_393_0 and not isNil(var_393_2) and arg_390_1.var_.characterEffect1054ui_story then
				arg_390_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_390_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_393_4 = 0
			local var_393_5 = 0.35

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_4 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_6 = arg_390_1:GetWordFromCfg(324161091)
				local var_393_7 = arg_390_1:FormatText(var_393_6.content)

				arg_390_1.text_.text = var_393_7

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_9 = 14 <= 0 and var_393_5 or var_393_5 * (utf8.len(var_393_7) / 14)

				if (14 <= 0 and var_393_5 or var_393_5 * (utf8.len(var_393_7) / 14)) > 0 and var_393_5 < var_393_9 then
					arg_390_1.talkMaxDuration = var_393_9

					if var_393_9 + var_393_4 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_9 + var_393_4
					end
				end

				arg_390_1.text_.text = var_393_7
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161091", "story_v_out_324161.awb") ~= 0 then
					local var_393_10 = manager.audio:GetVoiceLength("story_v_out_324161", "324161091", "story_v_out_324161.awb") / 1000

					if var_393_10 + var_393_4 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_10 + var_393_4
					end

					if var_393_6.prefab_name ~= "" and arg_390_1.actors_[var_393_6.prefab_name] ~= nil then
						local var_393_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_6.prefab_name].transform, "story_v_out_324161", "324161091", "story_v_out_324161.awb")

						arg_390_1:RecordAudio("324161091", var_393_11)
						arg_390_1:RecordAudio("324161091", var_393_11)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_324161", "324161091", "story_v_out_324161.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_324161", "324161091", "story_v_out_324161.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_12 = math.max(var_393_5, arg_390_1.talkMaxDuration)

			if var_393_4 <= arg_390_1.time_ and arg_390_1.time_ < var_393_4 + var_393_12 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_4) / var_393_12

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_4 + var_393_12 and arg_390_1.time_ < var_393_4 + var_393_12 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play324161092 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 324161092
		arg_394_1.duration_ = 6.3

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play324161093(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(arg_394_1.actors_["6148ui_story"]) and arg_394_1.var_.characterEffect6148ui_story == nil then
				arg_394_1.var_.characterEffect6148ui_story = arg_394_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_0 = 0.200000002980232

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_0 and not isNil(arg_394_1.actors_["6148ui_story"]) then
				if arg_394_1.var_.characterEffect6148ui_story and not isNil(arg_394_1.actors_["6148ui_story"]) then
					arg_394_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_394_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_394_1.time_ - 0) / var_397_0)
				end
			end

			if arg_394_1.time_ >= 0 + var_397_0 and arg_394_1.time_ < 0 + var_397_0 + arg_397_0 and not isNil(arg_394_1.actors_["6148ui_story"]) and arg_394_1.var_.characterEffect6148ui_story then
				arg_394_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_394_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_397_1 = arg_394_1.bgs_.MS2404.transform

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.var_.moveOldPosMS2404 = var_397_1.localPosition
			end

			local var_397_2 = 2.13333333333333

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_2 then
				var_397_1.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPosMS2404, Vector3.New(0, -0.48, 4.03), (arg_394_1.time_ - 0) / var_397_2)
			end

			if arg_394_1.time_ >= 0 + var_397_2 and arg_394_1.time_ < 0 + var_397_2 + arg_397_0 then
				var_397_1.localPosition = Vector3.New(0, -0.48, 4.03)
			end

			local var_397_3 = 0

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_3 + arg_397_0 then
				arg_394_1.allBtn_.enabled = false
			end

			if arg_394_1.time_ >= var_397_3 + 1.7 and arg_394_1.time_ < var_397_3 + 1.7 + arg_397_0 then
				arg_394_1.allBtn_.enabled = true
			end

			if arg_394_1.frameCnt_ <= 1 then
				arg_394_1.dialog_:SetActive(false)
			end

			local var_397_4 = 1.3
			local var_397_5 = 0.675

			if 1.3 < arg_394_1.time_ and arg_394_1.time_ <= var_397_4 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0

				arg_394_1.dialog_:SetActive(true)

				arg_394_1.dialogCg_.alpha = 0

				local var_397_6 = LeanTween.value(arg_394_1.dialog_, 0, 1, 0.3)

				var_397_6:setOnUpdate(LuaHelper.FloatAction(function(arg_398_0)
					arg_394_1.dialogCg_.alpha = arg_398_0
				end))
				var_397_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_394_1.dialog_)
					var_397_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_394_1.duration_ = arg_394_1.duration_ + 0.3

				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_7 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(324161092).content)

				arg_394_1.text_.text = var_397_7

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_9 = 27 <= 0 and var_397_5 or var_397_5 * (utf8.len(var_397_7) / 27)

				if (27 <= 0 and var_397_5 or var_397_5 * (utf8.len(var_397_7) / 27)) > 0 and var_397_5 < var_397_9 then
					arg_394_1.talkMaxDuration = var_397_9
					var_397_4 = var_397_4 + 0.3

					if var_397_9 + var_397_4 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_9 + var_397_4
					end
				end

				arg_394_1.text_.text = var_397_7
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_10 = var_397_4 + 0.3
			local var_397_11 = math.max(var_397_5, arg_394_1.talkMaxDuration)

			if var_397_4 + 0.3 <= arg_394_1.time_ and arg_394_1.time_ < var_397_10 + var_397_11 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_10) / var_397_11

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_10 + var_397_11 and arg_394_1.time_ < var_397_10 + var_397_11 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2404",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.13333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 0.42, 6.64),
					endPos = Vector3.New(0, -0.48, 4.03),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_394_1:InitPlayNodeList()
	end,
	Play324161093 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 324161093
		arg_400_1.duration_ = 3.4

		local var_400_0 = {
			zh = 2.466,
			ja = 3.4
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play324161094(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(arg_400_1.actors_["6148ui_story"]) and arg_400_1.var_.characterEffect6148ui_story == nil then
				arg_400_1.var_.characterEffect6148ui_story = arg_400_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_0 = 0.200000002980232

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_0 and not isNil(arg_400_1.actors_["6148ui_story"]) then
				if arg_400_1.var_.characterEffect6148ui_story and not isNil(arg_400_1.actors_["6148ui_story"]) then
					arg_400_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_400_1.time_ >= 0 + var_403_0 and arg_400_1.time_ < 0 + var_403_0 + arg_403_0 and not isNil(arg_400_1.actors_["6148ui_story"]) and arg_400_1.var_.characterEffect6148ui_story then
				arg_400_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_403_2 = 0
			local var_403_3 = 0.25

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_2 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_4 = arg_400_1:GetWordFromCfg(324161093)
				local var_403_5 = arg_400_1:FormatText(var_403_4.content)

				arg_400_1.text_.text = var_403_5

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_7 = 10 <= 0 and var_403_3 or var_403_3 * (utf8.len(var_403_5) / 10)

				if (10 <= 0 and var_403_3 or var_403_3 * (utf8.len(var_403_5) / 10)) > 0 and var_403_3 < var_403_7 then
					arg_400_1.talkMaxDuration = var_403_7

					if var_403_7 + var_403_2 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_7 + var_403_2
					end
				end

				arg_400_1.text_.text = var_403_5
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161093", "story_v_out_324161.awb") ~= 0 then
					local var_403_8 = manager.audio:GetVoiceLength("story_v_out_324161", "324161093", "story_v_out_324161.awb") / 1000

					if var_403_8 + var_403_2 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_8 + var_403_2
					end

					if var_403_4.prefab_name ~= "" and arg_400_1.actors_[var_403_4.prefab_name] ~= nil then
						local var_403_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_4.prefab_name].transform, "story_v_out_324161", "324161093", "story_v_out_324161.awb")

						arg_400_1:RecordAudio("324161093", var_403_9)
						arg_400_1:RecordAudio("324161093", var_403_9)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_324161", "324161093", "story_v_out_324161.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_324161", "324161093", "story_v_out_324161.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_10 = math.max(var_403_3, arg_400_1.talkMaxDuration)

			if var_403_2 <= arg_400_1.time_ and arg_400_1.time_ < var_403_2 + var_403_10 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_2) / var_403_10

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_2 + var_403_10 and arg_400_1.time_ < var_403_2 + var_403_10 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play324161094 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 324161094
		arg_404_1.duration_ = 4.4

		local var_404_0 = {
			zh = 4.4,
			ja = 4
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play324161095(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(arg_404_1.actors_["1054ui_story"]) and arg_404_1.var_.characterEffect1054ui_story == nil then
				arg_404_1.var_.characterEffect1054ui_story = arg_404_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_0 = 0.200000002980232

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_0 and not isNil(arg_404_1.actors_["1054ui_story"]) then
				if arg_404_1.var_.characterEffect1054ui_story and not isNil(arg_404_1.actors_["1054ui_story"]) then
					arg_404_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_404_1.time_ >= 0 + var_407_0 and arg_404_1.time_ < 0 + var_407_0 + arg_407_0 and not isNil(arg_404_1.actors_["1054ui_story"]) and arg_404_1.var_.characterEffect1054ui_story then
				arg_404_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_407_2 = arg_404_1.actors_["6148ui_story"]

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(var_407_2) and arg_404_1.var_.characterEffect6148ui_story == nil then
				arg_404_1.var_.characterEffect6148ui_story = var_407_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_3 = 0.200000002980232

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_3 and not isNil(var_407_2) then
				if arg_404_1.var_.characterEffect6148ui_story and not isNil(var_407_2) then
					arg_404_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_404_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_404_1.time_ - 0) / var_407_3)
				end
			end

			if arg_404_1.time_ >= 0 + var_407_3 and arg_404_1.time_ < 0 + var_407_3 + arg_407_0 and not isNil(var_407_2) and arg_404_1.var_.characterEffect6148ui_story then
				arg_404_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_404_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_407_4 = 0
			local var_407_5 = 0.4

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_4 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_6 = arg_404_1:GetWordFromCfg(324161094)
				local var_407_7 = arg_404_1:FormatText(var_407_6.content)

				arg_404_1.text_.text = var_407_7

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_9 = 16 <= 0 and var_407_5 or var_407_5 * (utf8.len(var_407_7) / 16)

				if (16 <= 0 and var_407_5 or var_407_5 * (utf8.len(var_407_7) / 16)) > 0 and var_407_5 < var_407_9 then
					arg_404_1.talkMaxDuration = var_407_9

					if var_407_9 + var_407_4 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_9 + var_407_4
					end
				end

				arg_404_1.text_.text = var_407_7
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161094", "story_v_out_324161.awb") ~= 0 then
					local var_407_10 = manager.audio:GetVoiceLength("story_v_out_324161", "324161094", "story_v_out_324161.awb") / 1000

					if var_407_10 + var_407_4 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_10 + var_407_4
					end

					if var_407_6.prefab_name ~= "" and arg_404_1.actors_[var_407_6.prefab_name] ~= nil then
						local var_407_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_6.prefab_name].transform, "story_v_out_324161", "324161094", "story_v_out_324161.awb")

						arg_404_1:RecordAudio("324161094", var_407_11)
						arg_404_1:RecordAudio("324161094", var_407_11)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_324161", "324161094", "story_v_out_324161.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_324161", "324161094", "story_v_out_324161.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_12 = math.max(var_407_5, arg_404_1.talkMaxDuration)

			if var_407_4 <= arg_404_1.time_ and arg_404_1.time_ < var_407_4 + var_407_12 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_4) / var_407_12

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_4 + var_407_12 and arg_404_1.time_ < var_407_4 + var_407_12 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play324161095 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 324161095
		arg_408_1.duration_ = 7.6

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play324161096(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			if 1.3 < arg_408_1.time_ and arg_408_1.time_ <= 1.3 + arg_411_0 then
				local var_411_0 = arg_408_1.bgs_.J27g

				arg_408_1.bgs_.J27g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_411_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_411_1 = var_411_0:GetComponent("SpriteRenderer")

				if var_411_1 and var_411_1.sprite then
					local var_411_2 = 2 * (var_411_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_411_0.transform.localScale = Vector3.New(var_411_2 / var_411_1.sprite.bounds.size.y < var_411_2 * manager.ui.mainCameraCom_.aspect / var_411_1.sprite.bounds.size.x and var_411_2 * manager.ui.mainCameraCom_.aspect / var_411_1.sprite.bounds.size.x or var_411_2 / var_411_1.sprite.bounds.size.y, var_411_2 / var_411_1.sprite.bounds.size.y < var_411_2 * manager.ui.mainCameraCom_.aspect / var_411_1.sprite.bounds.size.x and var_411_2 * manager.ui.mainCameraCom_.aspect / var_411_1.sprite.bounds.size.x or var_411_2 / var_411_1.sprite.bounds.size.y, 0)
				end

				for iter_411_0, iter_411_1 in pairs(arg_408_1.bgs_) do
					if iter_411_0 ~= "J27g" then
						iter_411_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_411_3 = 0

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_3 + arg_411_0 then
				arg_408_1.allBtn_.enabled = false
			end

			if arg_408_1.time_ >= var_411_3 + 0.3 and arg_408_1.time_ < var_411_3 + 0.3 + arg_411_0 then
				arg_408_1.allBtn_.enabled = true
			end

			local var_411_4 = 0

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_4 + arg_411_0 then
				arg_408_1.mask_.enabled = true
				arg_408_1.mask_.raycastTarget = true

				arg_408_1:SetGaussion(false)
			end

			local var_411_5 = 1.3

			if var_411_4 <= arg_408_1.time_ and arg_408_1.time_ < var_411_4 + var_411_5 then
				local var_411_6 = Color.New(0, 0, 0)

				var_411_6.a = Mathf.Lerp(0, 1, (arg_408_1.time_ - var_411_4) / var_411_5)
				arg_408_1.mask_.color = var_411_6
			end

			if arg_408_1.time_ >= var_411_4 + var_411_5 and arg_408_1.time_ < var_411_4 + var_411_5 + arg_411_0 then
				local var_411_7 = Color.New(0, 0, 0)

				var_411_7.a = 1
				arg_408_1.mask_.color = var_411_7
			end

			local var_411_8 = 1.3

			if 1.3 < arg_408_1.time_ and arg_408_1.time_ <= var_411_8 + arg_411_0 then
				arg_408_1.mask_.enabled = true
				arg_408_1.mask_.raycastTarget = true

				arg_408_1:SetGaussion(false)
			end

			local var_411_9 = 1.3

			if var_411_8 <= arg_408_1.time_ and arg_408_1.time_ < var_411_8 + var_411_9 then
				local var_411_10 = Color.New(0, 0, 0)

				var_411_10.a = Mathf.Lerp(1, 0, (arg_408_1.time_ - var_411_8) / var_411_9)
				arg_408_1.mask_.color = var_411_10
			end

			if arg_408_1.time_ >= var_411_8 + var_411_9 and arg_408_1.time_ < var_411_8 + var_411_9 + arg_411_0 then
				local var_411_11 = Color.New(0, 0, 0)

				arg_408_1.mask_.enabled = false
				var_411_11.a = 0
				arg_408_1.mask_.color = var_411_11
			end

			local var_411_12 = arg_408_1.actors_["1054ui_story"]

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 and not isNil(var_411_12) and arg_408_1.var_.characterEffect1054ui_story == nil then
				arg_408_1.var_.characterEffect1054ui_story = var_411_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_13 = 0.200000002980232

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_13 and not isNil(var_411_12) then
				if arg_408_1.var_.characterEffect1054ui_story and not isNil(var_411_12) then
					arg_408_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_408_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_408_1.time_ - 0) / var_411_13)
				end
			end

			if arg_408_1.time_ >= 0 + var_411_13 and arg_408_1.time_ < 0 + var_411_13 + arg_411_0 and not isNil(var_411_12) and arg_408_1.var_.characterEffect1054ui_story then
				arg_408_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_408_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 1.2 < arg_408_1.time_ and arg_408_1.time_ <= 1.2 + arg_411_0 then
				arg_408_1:AudioAction("play", "effect", "se_story_150", "se_story_150_huatian", "")
			end

			if 0.1 < arg_408_1.time_ and arg_408_1.time_ <= 0.1 + arg_411_0 then
				arg_408_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if 1.7 < arg_408_1.time_ and arg_408_1.time_ <= 1.7 + arg_411_0 then
				arg_408_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_magic", "")
			end

			if arg_408_1.frameCnt_ <= 1 then
				arg_408_1.dialog_:SetActive(false)
			end

			local var_411_17 = 2.6
			local var_411_18 = 1.725

			if 2.6 < arg_408_1.time_ and arg_408_1.time_ <= var_411_17 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0

				arg_408_1.dialog_:SetActive(true)

				arg_408_1.dialogCg_.alpha = 0

				local var_411_19 = LeanTween.value(arg_408_1.dialog_, 0, 1, 0.3)

				var_411_19:setOnUpdate(LuaHelper.FloatAction(function(arg_412_0)
					arg_408_1.dialogCg_.alpha = arg_412_0
				end))
				var_411_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_408_1.dialog_)
					var_411_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_408_1.duration_ = arg_408_1.duration_ + 0.3

				SetActive(arg_408_1.leftNameGo_, false)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_20 = arg_408_1:FormatText(arg_408_1:GetWordFromCfg(324161095).content)

				arg_408_1.text_.text = var_411_20

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_22 = 69 <= 0 and var_411_18 or var_411_18 * (utf8.len(var_411_20) / 69)

				if (69 <= 0 and var_411_18 or var_411_18 * (utf8.len(var_411_20) / 69)) > 0 and var_411_18 < var_411_22 then
					arg_408_1.talkMaxDuration = var_411_22
					var_411_17 = var_411_17 + 0.3

					if var_411_22 + var_411_17 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_22 + var_411_17
					end
				end

				arg_408_1.text_.text = var_411_20
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_23 = var_411_17 + 0.3
			local var_411_24 = math.max(var_411_18, arg_408_1.talkMaxDuration)

			if var_411_17 + 0.3 <= arg_408_1.time_ and arg_408_1.time_ < var_411_23 + var_411_24 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_23) / var_411_24

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_23 + var_411_24 and arg_408_1.time_ < var_411_23 + var_411_24 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play324161096 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 324161096
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play324161097(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0.7

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, false)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_1 = arg_414_1:FormatText(arg_414_1:GetWordFromCfg(324161096).content)

				arg_414_1.text_.text = var_417_1

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_3 = 28 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_1) / 28)

				if (28 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_1) / 28)) > 0 and var_417_0 < var_417_3 then
					arg_414_1.talkMaxDuration = var_417_3

					if var_417_3 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_3 + 0
					end
				end

				arg_414_1.text_.text = var_417_1
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_4 = math.max(var_417_0, arg_414_1.talkMaxDuration)

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_4 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - 0) / var_417_4

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= 0 + var_417_4 and arg_414_1.time_ < 0 + var_417_4 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play324161097 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 324161097
		arg_418_1.duration_ = 4.27

		local var_418_0 = {
			zh = 3.1,
			ja = 4.266
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play324161098(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1.var_.moveOldPos6148ui_story = arg_418_1.actors_["6148ui_story"].transform.localPosition

				local var_421_0 = GameObjectTools.GetOrAddComponent(arg_418_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_421_0 then
					var_421_0:EnableDynamicBone(false)
				end
			end

			local var_421_1 = 0.001

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_1 then
				arg_418_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_418_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_418_1.time_ - 0) / var_421_1)
				arg_418_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_418_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_418_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_418_1.actors_["6148ui_story"].transform.position).z)
				arg_418_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_418_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_418_1.actors_["6148ui_story"].transform.localEulerAngles = arg_418_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_418_1.time_ >= 0 + var_421_1 and arg_418_1.time_ < 0 + var_421_1 + arg_421_0 then
				arg_418_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_418_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_418_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_418_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_418_1.actors_["6148ui_story"].transform.position).z)
				arg_418_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_418_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_418_1.actors_["6148ui_story"].transform.localEulerAngles = arg_418_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_421_2 = GameObjectTools.GetOrAddComponent(arg_418_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_421_2 then
					var_421_2:EnableDynamicBone(true)
				end
			end

			local var_421_3 = arg_418_1.actors_["6148ui_story"]

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(var_421_3) and arg_418_1.var_.characterEffect6148ui_story == nil then
				arg_418_1.var_.characterEffect6148ui_story = var_421_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_4 = 0.200000002980232

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_4 and not isNil(var_421_3) then
				if arg_418_1.var_.characterEffect6148ui_story and not isNil(var_421_3) then
					arg_418_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_418_1.time_ >= 0 + var_421_4 and arg_418_1.time_ < 0 + var_421_4 + arg_421_0 and not isNil(var_421_3) and arg_418_1.var_.characterEffect6148ui_story then
				arg_418_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_421_6 = 0
			local var_421_7 = 0.3

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_6 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_8 = arg_418_1:GetWordFromCfg(324161097)
				local var_421_9 = arg_418_1:FormatText(var_421_8.content)

				arg_418_1.text_.text = var_421_9

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_11 = 12 <= 0 and var_421_7 or var_421_7 * (utf8.len(var_421_9) / 12)

				if (12 <= 0 and var_421_7 or var_421_7 * (utf8.len(var_421_9) / 12)) > 0 and var_421_7 < var_421_11 then
					arg_418_1.talkMaxDuration = var_421_11

					if var_421_11 + var_421_6 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_11 + var_421_6
					end
				end

				arg_418_1.text_.text = var_421_9
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161097", "story_v_out_324161.awb") ~= 0 then
					local var_421_12 = manager.audio:GetVoiceLength("story_v_out_324161", "324161097", "story_v_out_324161.awb") / 1000

					if var_421_12 + var_421_6 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_12 + var_421_6
					end

					if var_421_8.prefab_name ~= "" and arg_418_1.actors_[var_421_8.prefab_name] ~= nil then
						local var_421_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_8.prefab_name].transform, "story_v_out_324161", "324161097", "story_v_out_324161.awb")

						arg_418_1:RecordAudio("324161097", var_421_13)
						arg_418_1:RecordAudio("324161097", var_421_13)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_324161", "324161097", "story_v_out_324161.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_324161", "324161097", "story_v_out_324161.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_14 = math.max(var_421_7, arg_418_1.talkMaxDuration)

			if var_421_6 <= arg_418_1.time_ and arg_418_1.time_ < var_421_6 + var_421_14 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_6) / var_421_14

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_6 + var_421_14 and arg_418_1.time_ < var_421_6 + var_421_14 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_418_1:InitPlayNodeList()
	end,
	Play324161098 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 324161098
		arg_422_1.duration_ = 4.47

		local var_422_0 = {
			zh = 4.466,
			ja = 3.933
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
			arg_422_1.auto_ = false
		end

		function arg_422_1.playNext_(arg_424_0)
			arg_422_1.onStoryFinished_()
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1.var_.moveOldPos1054ui_story = arg_422_1.actors_["1054ui_story"].transform.localPosition

				local var_425_0 = GameObjectTools.GetOrAddComponent(arg_422_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_425_0 then
					var_425_0:EnableDynamicBone(false)
				end
			end

			local var_425_1 = 0.001

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_1 then
				arg_422_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_422_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_422_1.time_ - 0) / var_425_1)
				arg_422_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_422_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_422_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_422_1.actors_["1054ui_story"].transform.position).z)
				arg_422_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_422_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_422_1.actors_["1054ui_story"].transform.localEulerAngles = arg_422_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_422_1.time_ >= 0 + var_425_1 and arg_422_1.time_ < 0 + var_425_1 + arg_425_0 then
				arg_422_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_422_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_422_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_422_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_422_1.actors_["1054ui_story"].transform.position).z)
				arg_422_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_422_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_422_1.actors_["1054ui_story"].transform.localEulerAngles = arg_422_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_425_2 = GameObjectTools.GetOrAddComponent(arg_422_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_425_2 then
					var_425_2:EnableDynamicBone(true)
				end
			end

			local var_425_3 = arg_422_1.actors_["1054ui_story"]

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 and not isNil(var_425_3) and arg_422_1.var_.characterEffect1054ui_story == nil then
				arg_422_1.var_.characterEffect1054ui_story = var_425_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_4 = 0.200000002980232

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_4 and not isNil(var_425_3) then
				if arg_422_1.var_.characterEffect1054ui_story and not isNil(var_425_3) then
					arg_422_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_422_1.time_ >= 0 + var_425_4 and arg_422_1.time_ < 0 + var_425_4 + arg_425_0 and not isNil(var_425_3) and arg_422_1.var_.characterEffect1054ui_story then
				arg_422_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_425_6 = arg_422_1.actors_["6148ui_story"]

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 and not isNil(var_425_6) and arg_422_1.var_.characterEffect6148ui_story == nil then
				arg_422_1.var_.characterEffect6148ui_story = var_425_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_7 = 0.200000002980232

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_7 and not isNil(var_425_6) then
				if arg_422_1.var_.characterEffect6148ui_story and not isNil(var_425_6) then
					arg_422_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_422_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_422_1.time_ - 0) / var_425_7)
				end
			end

			if arg_422_1.time_ >= 0 + var_425_7 and arg_422_1.time_ < 0 + var_425_7 + arg_425_0 and not isNil(var_425_6) and arg_422_1.var_.characterEffect6148ui_story then
				arg_422_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_422_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_425_8 = 0
			local var_425_9 = 0.275

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_8 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_10 = arg_422_1:GetWordFromCfg(324161098)
				local var_425_11 = arg_422_1:FormatText(var_425_10.content)

				arg_422_1.text_.text = var_425_11

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_13 = 11 <= 0 and var_425_9 or var_425_9 * (utf8.len(var_425_11) / 11)

				if (11 <= 0 and var_425_9 or var_425_9 * (utf8.len(var_425_11) / 11)) > 0 and var_425_9 < var_425_13 then
					arg_422_1.talkMaxDuration = var_425_13

					if var_425_13 + var_425_8 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_13 + var_425_8
					end
				end

				arg_422_1.text_.text = var_425_11
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161098", "story_v_out_324161.awb") ~= 0 then
					local var_425_14 = manager.audio:GetVoiceLength("story_v_out_324161", "324161098", "story_v_out_324161.awb") / 1000

					if var_425_14 + var_425_8 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_14 + var_425_8
					end

					if var_425_10.prefab_name ~= "" and arg_422_1.actors_[var_425_10.prefab_name] ~= nil then
						local var_425_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_10.prefab_name].transform, "story_v_out_324161", "324161098", "story_v_out_324161.awb")

						arg_422_1:RecordAudio("324161098", var_425_15)
						arg_422_1:RecordAudio("324161098", var_425_15)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_324161", "324161098", "story_v_out_324161.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_324161", "324161098", "story_v_out_324161.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_16 = math.max(var_425_9, arg_422_1.talkMaxDuration)

			if var_425_8 <= arg_422_1.time_ and arg_422_1.time_ < var_425_8 + var_425_16 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_8) / var_425_16

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_8 + var_425_16 and arg_422_1.time_ < var_425_8 + var_425_16 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_422_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2008",
		"TextureConfig/Background/J27i",
		"TextureConfig/Background/J27g",
		"TextureConfig/Background/MS2404",
		"TextureConfig/Background/ST2007"
	},
	voices = {
		"story_v_out_324161.awb"
	}
}
