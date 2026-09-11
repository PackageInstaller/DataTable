return {
	Play420132001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 420132001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play420132002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST61 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST61")
				var_4_0.name = "ST61"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST61 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST61

				arg_1_1.bgs_.ST61.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST61" then
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

			if 0.333333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.333333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			local var_4_15 = 2
			local var_4_16 = 0.375

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(420132001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 15 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 15)

				if (15 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 15)) > 0 and var_4_16 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_15 = var_4_15 + 0.3

					if var_4_20 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_15 + 0.3
			local var_4_22 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_21) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play420132002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 420132002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play420132003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0.05 < arg_9_1.time_ and arg_9_1.time_ <= 0.05 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_11", "se_story_11_foot", "")
			end

			local var_12_1 = 0
			local var_12_2 = 1

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(420132002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 40 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 40)

				if (40 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 40)) > 0 and var_12_2 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5

					if var_12_5 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_6 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_6 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_6

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_6 and arg_9_1.time_ < var_12_1 + var_12_6 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play420132003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 420132003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play420132004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.175

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(420132003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 7 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 7)

				if (7 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 7)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play420132004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 420132004
		arg_17_1.duration_ = 3.9

		local var_17_0 = {
			zh = 3.8,
			ja = 3.9
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play420132005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["404001ui_story"] == nil and not isNil((Asset.Load("Char/" .. "404001ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "404001ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["404001ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["404001ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["404001ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["404001ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["404001ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos404001ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0, -1.55, -5.5)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			local var_20_5 = arg_17_1.actors_["404001ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect404001ui_story == nil then
				arg_17_1.var_.characterEffect404001ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect404001ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect404001ui_story then
				arg_17_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_20_8 = 0
			local var_20_9 = 0.525

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:GetWordFromCfg(420132004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 21 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 21)

				if (21 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 21)) > 0 and var_20_9 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132004", "story_v_out_420132.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_out_420132", "420132004", "story_v_out_420132.awb") / 1000

					if var_20_14 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_8
					end

					if var_20_10.prefab_name ~= "" and arg_17_1.actors_[var_20_10.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_10.prefab_name].transform, "story_v_out_420132", "420132004", "story_v_out_420132.awb")

						arg_17_1:RecordAudio("420132004", var_20_15)
						arg_17_1:RecordAudio("420132004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_420132", "420132004", "story_v_out_420132.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_420132", "420132004", "story_v_out_420132.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_16 and arg_17_1.time_ < var_20_8 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play420132005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 420132005
		arg_21_1.duration_ = 4.87

		local var_21_0 = {
			zh = 2.3,
			ja = 4.866
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
				arg_21_0:Play420132006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.325

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:GetWordFromCfg(420132005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 13 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 13)

				if (13 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 13)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132005", "story_v_out_420132.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_420132", "420132005", "story_v_out_420132.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_420132", "420132005", "story_v_out_420132.awb")

						arg_21_1:RecordAudio("420132005", var_24_6)
						arg_21_1:RecordAudio("420132005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_420132", "420132005", "story_v_out_420132.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_420132", "420132005", "story_v_out_420132.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play420132006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 420132006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play420132007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos404001ui_story = arg_25_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["404001ui_story"].transform.position).z)
				arg_25_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["404001ui_story"].transform.localEulerAngles = arg_25_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["404001ui_story"].transform.position).z)
				arg_25_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["404001ui_story"].transform.localEulerAngles = arg_25_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_28_1 = 0
			local var_28_2 = 0.475

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(420132006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 19 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 19)

				if (19 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 19)) > 0 and var_28_2 < var_28_5 then
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

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play420132007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 420132007
		arg_29_1.duration_ = 2

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play420132008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["1089ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1089ui_story"))) then
				local var_32_0 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_29_1.stage_.transform)

				var_32_0.name = "1089ui_story"
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["1089ui_story"] = var_32_0

				local var_32_1 = var_32_0:GetComponentInChildren(typeof(CharacterEffect))

				var_32_1.enabled = true

				local var_32_2 = GameObjectTools.GetOrAddComponent(var_32_0, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(false)
				end

				arg_29_1:ShowWeapon(var_32_1.transform, false)

				arg_29_1.var_["1089ui_story" .. "Animator"] = var_32_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_29_1.var_["1089ui_story" .. "Animator"].applyRootMotion = true
				arg_29_1.var_["1089ui_story" .. "LipSync"] = var_32_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_32_3 = arg_29_1.actors_["1089ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1089ui_story = var_32_3.localPosition
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_3.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_29_1.time_ - 0) / var_32_4)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_3.localPosition = Vector3.New(0, -1.1, -6.17)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			local var_32_5 = arg_29_1.actors_["1089ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect1089ui_story == nil then
				arg_29_1.var_.characterEffect1089ui_story = var_32_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_6 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 and not isNil(var_32_5) then
				if arg_29_1.var_.characterEffect1089ui_story and not isNil(var_32_5) then
					arg_29_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect1089ui_story then
				arg_29_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_32_8 = 0
			local var_32_9 = 0.075

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_10 = arg_29_1:GetWordFromCfg(420132007)
				local var_32_11 = arg_29_1:FormatText(var_32_10.content)

				arg_29_1.text_.text = var_32_11

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 3 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 3)

				if (3 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 3)) > 0 and var_32_9 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_11
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132007", "story_v_out_420132.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_420132", "420132007", "story_v_out_420132.awb") / 1000

					if var_32_14 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_8
					end

					if var_32_10.prefab_name ~= "" and arg_29_1.actors_[var_32_10.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_10.prefab_name].transform, "story_v_out_420132", "420132007", "story_v_out_420132.awb")

						arg_29_1:RecordAudio("420132007", var_32_15)
						arg_29_1:RecordAudio("420132007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_420132", "420132007", "story_v_out_420132.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_420132", "420132007", "story_v_out_420132.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_9, arg_29_1.talkMaxDuration)

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_8) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_8 + var_32_16 and arg_29_1.time_ < var_32_8 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play420132008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 420132008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play420132009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1089ui_story = arg_33_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1089ui_story"].transform.position).z)
				arg_33_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1089ui_story"].transform.localEulerAngles = arg_33_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1089ui_story"].transform.position).z)
				arg_33_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1089ui_story"].transform.localEulerAngles = arg_33_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_36_1 = 0
			local var_36_2 = 1.475

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(420132008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 59 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 59)

				if (59 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 59)) > 0 and var_36_2 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_6 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_6 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_6

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_6 and arg_33_1.time_ < var_36_1 + var_36_6 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play420132009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 420132009
		arg_37_1.duration_ = 5.77

		local var_37_0 = {
			zh = 4.666,
			ja = 5.766
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
				arg_37_0:Play420132010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.7

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_1 = arg_37_1:GetWordFromCfg(420132009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 28 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 28)

				if (28 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 28)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132009", "story_v_out_420132.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_420132", "420132009", "story_v_out_420132.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_420132", "420132009", "story_v_out_420132.awb")

						arg_37_1:RecordAudio("420132009", var_40_6)
						arg_37_1:RecordAudio("420132009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_420132", "420132009", "story_v_out_420132.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_420132", "420132009", "story_v_out_420132.awb")
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
	Play420132010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 420132010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play420132011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 1.175

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

				local var_44_1 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(420132010).content)

				arg_41_1.text_.text = var_44_1

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_3 = 47 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 47)

				if (47 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 47)) > 0 and var_44_0 < var_44_3 then
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
	Play420132011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 420132011
		arg_45_1.duration_ = 3.83

		local var_45_0 = {
			zh = 3.833,
			ja = 3.5
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
				arg_45_0:Play420132012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1089ui_story = arg_45_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1089ui_story"].transform.position).z)
				arg_45_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1089ui_story"].transform.localEulerAngles = arg_45_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.17)
				arg_45_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1089ui_story"].transform.position).z)
				arg_45_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1089ui_story"].transform.localEulerAngles = arg_45_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["1089ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1089ui_story == nil then
				arg_45_1.var_.characterEffect1089ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect1089ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1089ui_story then
				arg_45_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_48_4 = 0
			local var_48_5 = 0.375

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:GetWordFromCfg(420132011)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 15 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 15)

				if (15 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 15)) > 0 and var_48_5 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132011", "story_v_out_420132.awb") ~= 0 then
					local var_48_10 = manager.audio:GetVoiceLength("story_v_out_420132", "420132011", "story_v_out_420132.awb") / 1000

					if var_48_10 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_4
					end

					if var_48_6.prefab_name ~= "" and arg_45_1.actors_[var_48_6.prefab_name] ~= nil then
						local var_48_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_6.prefab_name].transform, "story_v_out_420132", "420132011", "story_v_out_420132.awb")

						arg_45_1:RecordAudio("420132011", var_48_11)
						arg_45_1:RecordAudio("420132011", var_48_11)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_420132", "420132011", "story_v_out_420132.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_420132", "420132011", "story_v_out_420132.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_12 = math.max(var_48_5, arg_45_1.talkMaxDuration)

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_12 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_4) / var_48_12

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_4 + var_48_12 and arg_45_1.time_ < var_48_4 + var_48_12 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play420132012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 420132012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play420132013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1089ui_story"]) and arg_49_1.var_.characterEffect1089ui_story == nil then
				arg_49_1.var_.characterEffect1089ui_story = arg_49_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1089ui_story"]) then
				if arg_49_1.var_.characterEffect1089ui_story and not isNil(arg_49_1.actors_["1089ui_story"]) then
					arg_49_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1089ui_story"]) and arg_49_1.var_.characterEffect1089ui_story then
				arg_49_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_52_1 = 0
			local var_52_2 = 0.225

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

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(420132012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 9 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 9)

				if (9 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 9)) > 0 and var_52_2 < var_52_5 then
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
	Play420132013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 420132013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play420132014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1089ui_story = arg_53_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1089ui_story"].transform.position).z)
				arg_53_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1089ui_story"].transform.localEulerAngles = arg_53_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1089ui_story"].transform.position).z)
				arg_53_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1089ui_story"].transform.localEulerAngles = arg_53_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_56_3 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_53_1.bgmTxt_.text ~= var_56_3 and arg_53_1.bgmTxt_.text ~= "" then
						if arg_53_1.bgmTxt2_.text ~= "" then
							arg_53_1.bgmTxt_.text = arg_53_1.bgmTxt2_.text
						end

						arg_53_1.bgmTxt2_.text = var_56_3

						arg_53_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_53_1.bgmTxt_.text = var_56_3
						arg_53_1.bgmTxt2_.text = var_56_3
					end

					if arg_53_1.bgmTimer then
						arg_53_1.bgmTimer:Stop()

						arg_53_1.bgmTimer = nil
					end

					if arg_53_1.settingData.show_music_name == 1 then
						arg_53_1.musicController:SetSelectedState("show")
						arg_53_1.musicAnimator_:Play("open", 0, 0)

						if arg_53_1.settingData.music_time ~= 0 then
							arg_53_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_53_1.settingData.music_time), function()
								if arg_53_1 == nil or isNil(arg_53_1.bgmTxt_) then
									return
								end

								arg_53_1.musicController:SetSelectedState("hide")
								arg_53_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_56_4 = 0
			local var_56_5 = 0.875

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(420132013).content)

				arg_53_1.text_.text = var_56_6

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_8 = 35 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_6) / 35)

				if (35 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_6) / 35)) > 0 and var_56_5 < var_56_8 then
					arg_53_1.talkMaxDuration = var_56_8

					if var_56_8 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_6
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_9 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_9 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_9

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_9 and arg_53_1.time_ < var_56_4 + var_56_9 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play420132014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 420132014
		arg_58_1.duration_ = 5.9

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play420132015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if arg_58_1.bgs_.STblack == nil then
				local var_61_0 = Object.Instantiate(arg_58_1.paintGo_)

				var_61_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_61_0.name = "STblack"
				var_61_0.transform.parent = arg_58_1.stage_.transform
				var_61_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_58_1.bgs_.STblack = var_61_0
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				local var_61_1 = arg_58_1.bgs_.STblack

				arg_58_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_61_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_61_2 = var_61_1:GetComponent("SpriteRenderer")

				if var_61_2 and var_61_2.sprite then
					local var_61_3 = 2 * (var_61_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_61_1.transform.localScale = Vector3.New(var_61_3 / var_61_2.sprite.bounds.size.y < var_61_3 * manager.ui.mainCameraCom_.aspect / var_61_2.sprite.bounds.size.x and var_61_3 * manager.ui.mainCameraCom_.aspect / var_61_2.sprite.bounds.size.x or var_61_3 / var_61_2.sprite.bounds.size.y, var_61_3 / var_61_2.sprite.bounds.size.y < var_61_3 * manager.ui.mainCameraCom_.aspect / var_61_2.sprite.bounds.size.x and var_61_3 * manager.ui.mainCameraCom_.aspect / var_61_2.sprite.bounds.size.x or var_61_3 / var_61_2.sprite.bounds.size.y, 0)
				end

				for iter_61_0, iter_61_1 in pairs(arg_58_1.bgs_) do
					if iter_61_0 ~= "STblack" then
						iter_61_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_61_4 = 2

			if 2 < arg_58_1.time_ and arg_58_1.time_ <= var_61_4 + arg_61_0 then
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

				var_61_7.a = Mathf.Lerp(1, 0, (arg_58_1.time_ - var_61_5) / var_61_6)
				arg_58_1.mask_.color = var_61_7
			end

			if arg_58_1.time_ >= var_61_5 + var_61_6 and arg_58_1.time_ < var_61_5 + var_61_6 + arg_61_0 then
				local var_61_8 = Color.New(0, 0, 0)

				arg_58_1.mask_.enabled = false
				var_61_8.a = 0
				arg_58_1.mask_.color = var_61_8
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.cswbg_:SetActive(true)

				local var_61_9 = arg_58_1.cswt_:GetComponent("RectTransform")

				arg_58_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_61_9.offsetMin = Vector2.New(0, 0)
				var_61_9.offsetMax = Vector2.New(0, 130)
				arg_58_1.cswt_.text = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(419150).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.cswt_)

				arg_58_1.cswt_.fontSize = 120
				arg_58_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_58_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_58_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.fswbg_:SetActive(true)
				arg_58_1.dialog_:SetActive(false)

				arg_58_1.fswtw_.percent = 0
				arg_58_1.fswt_.text = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(420132014).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.fswt_)

				arg_58_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_58_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_58_1.fswtw_:SetDirty()

				arg_58_1.typewritterCharCountI18N = 0

				SetActive(arg_58_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_58_1:ShowNextGo(false)
			end

			local var_61_10 = 1.3

			if 1.3 < arg_58_1.time_ and arg_58_1.time_ <= var_61_10 + arg_61_0 then
				arg_58_1.var_.oldValueTypewriter = arg_58_1.fswtw_.percent

				SetActive(arg_58_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_58_1:ShowNextGo(false)
			end

			local var_61_11 = 21
			local var_61_12 = 1.4
			local var_61_13, var_61_14 = arg_58_1:GetPercentByPara(arg_58_1:FormatText(arg_58_1:GetWordFromCfg(420132014).content), 1)

			if var_61_10 < arg_58_1.time_ and arg_58_1.time_ <= var_61_10 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0

				local var_61_15 = var_61_11 <= 0 and var_61_12 or var_61_12 * ((var_61_14 - arg_58_1.typewritterCharCountI18N) / var_61_11)

				if (var_61_11 <= 0 and var_61_12 or var_61_12 * ((var_61_14 - arg_58_1.typewritterCharCountI18N) / var_61_11)) > 0 and var_61_12 < var_61_15 then
					arg_58_1.talkMaxDuration = var_61_15

					if var_61_15 + var_61_10 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_15 + var_61_10
					end
				end
			end

			local var_61_16 = math.max(1.4, arg_58_1.talkMaxDuration)

			if var_61_10 <= arg_58_1.time_ and arg_58_1.time_ < var_61_10 + var_61_16 then
				arg_58_1.fswtw_.percent = Mathf.Lerp(arg_58_1.var_.oldValueTypewriter, var_61_13, (arg_58_1.time_ - var_61_10) / var_61_16)
				arg_58_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_58_1.fswtw_:SetDirty()
			end

			if arg_58_1.time_ >= var_61_10 + var_61_16 and arg_58_1.time_ < var_61_10 + var_61_16 + arg_61_0 then
				arg_58_1.fswtw_.percent = var_61_13

				arg_58_1.fswtw_:SetDirty()
				arg_58_1:ShowNextGo(true)

				arg_58_1.typewritterCharCountI18N = var_61_14
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				local var_61_17 = arg_58_1.fswbg_.transform:Find("textbox/adapt/content") or arg_58_1.fswbg_.transform:Find("textbox/content")
				local var_61_18 = arg_58_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_61_19 = var_61_17:GetComponent("RectTransform")

				var_61_17:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_61_19.offsetMin = Vector2.New(0, -70)
				var_61_19.offsetMax = Vector2.New(0, 0)
			end

			local var_61_20 = 1.3
			local var_61_21 = manager.audio:GetVoiceLength("story_v_out_420132", "420132014", "story_v_out_420132.awb") / 1000

			if var_61_21 > 0 and 4.6 < var_61_21 and var_61_21 + var_61_20 > arg_58_1.duration_ then
				arg_58_1.duration_ = var_61_21 + var_61_20
			end

			if var_61_20 < arg_58_1.time_ and arg_58_1.time_ <= var_61_20 + arg_61_0 then
				arg_58_1:AudioAction("play", "voice", "story_v_out_420132", "420132014", "story_v_out_420132.awb")
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play420132015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 420132015
		arg_62_1.duration_ = 2.6

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play420132016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.fswbg_:SetActive(true)
				arg_62_1.dialog_:SetActive(false)

				arg_62_1.fswtw_.percent = 0
				arg_62_1.fswt_.text = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(420132015).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.fswt_)

				arg_62_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_62_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_62_1.fswtw_:SetDirty()

				arg_62_1.typewritterCharCountI18N = 0

				SetActive(arg_62_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_62_1:ShowNextGo(false)
			end

			local var_65_0 = 0.0666666666666669

			if 0.0666666666666669 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.var_.oldValueTypewriter = arg_62_1.fswtw_.percent

				SetActive(arg_62_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_62_1:ShowNextGo(false)
			end

			local var_65_1 = 38
			local var_65_2 = 2.53333333333333
			local var_65_3, var_65_4 = arg_62_1:GetPercentByPara(arg_62_1:FormatText(arg_62_1:GetWordFromCfg(420132015).content), 1)

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0

				local var_65_5 = var_65_1 <= 0 and var_65_2 or var_65_2 * ((var_65_4 - arg_62_1.typewritterCharCountI18N) / var_65_1)

				if (var_65_1 <= 0 and var_65_2 or var_65_2 * ((var_65_4 - arg_62_1.typewritterCharCountI18N) / var_65_1)) > 0 and var_65_2 < var_65_5 then
					arg_62_1.talkMaxDuration = var_65_5

					if var_65_5 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + var_65_0
					end
				end
			end

			local var_65_6 = math.max(2.53333333333333, arg_62_1.talkMaxDuration)

			if var_65_0 <= arg_62_1.time_ and arg_62_1.time_ < var_65_0 + var_65_6 then
				arg_62_1.fswtw_.percent = Mathf.Lerp(arg_62_1.var_.oldValueTypewriter, var_65_3, (arg_62_1.time_ - var_65_0) / var_65_6)
				arg_62_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_62_1.fswtw_:SetDirty()
			end

			if arg_62_1.time_ >= var_65_0 + var_65_6 and arg_62_1.time_ < var_65_0 + var_65_6 + arg_65_0 then
				arg_62_1.fswtw_.percent = var_65_3

				arg_62_1.fswtw_:SetDirty()
				arg_62_1:ShowNextGo(true)

				arg_62_1.typewritterCharCountI18N = var_65_4
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play420132016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 420132016
		arg_66_1.duration_ = 8.37

		local var_66_0 = {
			zh = 7.6,
			ja = 8.366
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play420132017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if arg_66_1.bgs_.ST67 == nil then
				local var_69_0 = Object.Instantiate(arg_66_1.paintGo_)

				var_69_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST67")
				var_69_0.name = "ST67"
				var_69_0.transform.parent = arg_66_1.stage_.transform
				var_69_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_66_1.bgs_.ST67 = var_69_0
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				local var_69_1 = arg_66_1.bgs_.ST67

				arg_66_1.bgs_.ST67.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_69_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_69_2 = var_69_1:GetComponent("SpriteRenderer")

				if var_69_2 and var_69_2.sprite then
					local var_69_3 = 2 * (var_69_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_69_1.transform.localScale = Vector3.New(var_69_3 / var_69_2.sprite.bounds.size.y < var_69_3 * manager.ui.mainCameraCom_.aspect / var_69_2.sprite.bounds.size.x and var_69_3 * manager.ui.mainCameraCom_.aspect / var_69_2.sprite.bounds.size.x or var_69_3 / var_69_2.sprite.bounds.size.y, var_69_3 / var_69_2.sprite.bounds.size.y < var_69_3 * manager.ui.mainCameraCom_.aspect / var_69_2.sprite.bounds.size.x and var_69_3 * manager.ui.mainCameraCom_.aspect / var_69_2.sprite.bounds.size.x or var_69_3 / var_69_2.sprite.bounds.size.y, 0)
				end

				for iter_69_0, iter_69_1 in pairs(arg_66_1.bgs_) do
					if iter_69_0 ~= "ST67" then
						iter_69_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_69_4 = 2

			if 2 < arg_66_1.time_ and arg_66_1.time_ <= var_69_4 + arg_69_0 then
				arg_66_1.allBtn_.enabled = false
			end

			if arg_66_1.time_ >= var_69_4 + 0.3 and arg_66_1.time_ < var_69_4 + 0.3 + arg_69_0 then
				arg_66_1.allBtn_.enabled = true
			end

			local var_69_5 = 0

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 then
				arg_66_1.mask_.enabled = true
				arg_66_1.mask_.raycastTarget = true

				arg_66_1:SetGaussion(false)
			end

			local var_69_6 = 2

			if var_69_5 <= arg_66_1.time_ and arg_66_1.time_ < var_69_5 + var_69_6 then
				local var_69_7 = Color.New(0, 0, 0)

				var_69_7.a = Mathf.Lerp(1, 0, (arg_66_1.time_ - var_69_5) / var_69_6)
				arg_66_1.mask_.color = var_69_7
			end

			if arg_66_1.time_ >= var_69_5 + var_69_6 and arg_66_1.time_ < var_69_5 + var_69_6 + arg_69_0 then
				local var_69_8 = Color.New(0, 0, 0)

				arg_66_1.mask_.enabled = false
				var_69_8.a = 0
				arg_66_1.mask_.color = var_69_8
			end

			local var_69_9 = "1061ui_story"

			if arg_66_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_69_10 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_66_1.stage_.transform)

				var_69_10.name = var_69_9
				var_69_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_66_1.actors_[var_69_9] = var_69_10

				local var_69_11 = var_69_10:GetComponentInChildren(typeof(CharacterEffect))

				var_69_11.enabled = true

				local var_69_12 = GameObjectTools.GetOrAddComponent(var_69_10, typeof(DynamicBoneHelper))

				if var_69_12 then
					var_69_12:EnableDynamicBone(false)
				end

				arg_66_1:ShowWeapon(var_69_11.transform, false)

				arg_66_1.var_[var_69_9 .. "Animator"] = var_69_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_66_1.var_[var_69_9 .. "Animator"].applyRootMotion = true
				arg_66_1.var_[var_69_9 .. "LipSync"] = var_69_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_69_13 = arg_66_1.actors_["1061ui_story"].transform

			if 1.86666666666667 < arg_66_1.time_ and arg_66_1.time_ <= 1.86666666666667 + arg_69_0 then
				arg_66_1.var_.moveOldPos1061ui_story = var_69_13.localPosition
			end

			local var_69_14 = 0.001

			if 1.86666666666667 <= arg_66_1.time_ and arg_66_1.time_ < 1.86666666666667 + var_69_14 then
				var_69_13.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_66_1.time_ - 1.86666666666667) / var_69_14)
				var_69_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_13.position).x, (manager.ui.mainCamera.transform.position - var_69_13.position).y, (manager.ui.mainCamera.transform.position - var_69_13.position).z)
				var_69_13.localEulerAngles.z = 0
				var_69_13.localEulerAngles.x = 0
				var_69_13.localEulerAngles = var_69_13.localEulerAngles
			end

			if arg_66_1.time_ >= 1.86666666666667 + var_69_14 and arg_66_1.time_ < 1.86666666666667 + var_69_14 + arg_69_0 then
				var_69_13.localPosition = Vector3.New(0, -1.18, -6.15)
				var_69_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_13.position).x, (manager.ui.mainCamera.transform.position - var_69_13.position).y, (manager.ui.mainCamera.transform.position - var_69_13.position).z)
				var_69_13.localEulerAngles.z = 0
				var_69_13.localEulerAngles.x = 0
				var_69_13.localEulerAngles = var_69_13.localEulerAngles
			end

			local var_69_15 = arg_66_1.actors_["1061ui_story"]

			if 1.86666666666667 < arg_66_1.time_ and arg_66_1.time_ <= 1.86666666666667 + arg_69_0 and not isNil(var_69_15) and arg_66_1.var_.characterEffect1061ui_story == nil then
				arg_66_1.var_.characterEffect1061ui_story = var_69_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_16 = 0.200000002980232

			if 1.86666666666667 <= arg_66_1.time_ and arg_66_1.time_ < 1.86666666666667 + var_69_16 and not isNil(var_69_15) then
				if arg_66_1.var_.characterEffect1061ui_story and not isNil(var_69_15) then
					arg_66_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 1.86666666666667 + var_69_16 and arg_66_1.time_ < 1.86666666666667 + var_69_16 + arg_69_0 and not isNil(var_69_15) and arg_66_1.var_.characterEffect1061ui_story then
				arg_66_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 1.86666666666667 < arg_66_1.time_ and arg_66_1.time_ <= 1.86666666666667 + arg_69_0 then
				arg_66_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 1.86666666666667 < arg_66_1.time_ and arg_66_1.time_ <= 1.86666666666667 + arg_69_0 then
				arg_66_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.fswbg_:SetActive(false)
				arg_66_1.dialog_:SetActive(false)
				SetActive(arg_66_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_66_1:ShowNextGo(false)
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.cswbg_:SetActive(false)
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_69_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_66_1.bgmTxt_.text ~= var_69_20 and arg_66_1.bgmTxt_.text ~= "" then
						if arg_66_1.bgmTxt2_.text ~= "" then
							arg_66_1.bgmTxt_.text = arg_66_1.bgmTxt2_.text
						end

						arg_66_1.bgmTxt2_.text = var_69_20

						arg_66_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_66_1.bgmTxt_.text = var_69_20
						arg_66_1.bgmTxt2_.text = var_69_20
					end

					if arg_66_1.bgmTimer then
						arg_66_1.bgmTimer:Stop()

						arg_66_1.bgmTimer = nil
					end

					if arg_66_1.settingData.show_music_name == 1 then
						arg_66_1.musicController:SetSelectedState("show")
						arg_66_1.musicAnimator_:Play("open", 0, 0)

						if arg_66_1.settingData.music_time ~= 0 then
							arg_66_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_66_1.settingData.music_time), function()
								if arg_66_1 == nil or isNil(arg_66_1.bgmTxt_) then
									return
								end

								arg_66_1.musicController:SetSelectedState("hide")
								arg_66_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.333333333333333 < arg_66_1.time_ and arg_66_1.time_ <= 0.333333333333333 + arg_69_0 then
				arg_66_1:AudioAction("play", "music", "bgm_activity_4_0_story_lab", "bgm_activity_4_0_story_lab", "bgm_activity_4_0_story_lab.awb")

				local var_69_23 = manager.audio:GetAudioName("bgm_activity_4_0_story_lab", "bgm_activity_4_0_story_lab")

				if "" ~= "" then
					if arg_66_1.bgmTxt_.text ~= var_69_23 and arg_66_1.bgmTxt_.text ~= "" then
						if arg_66_1.bgmTxt2_.text ~= "" then
							arg_66_1.bgmTxt_.text = arg_66_1.bgmTxt2_.text
						end

						arg_66_1.bgmTxt2_.text = var_69_23

						arg_66_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_66_1.bgmTxt_.text = var_69_23
						arg_66_1.bgmTxt2_.text = var_69_23
					end

					if arg_66_1.bgmTimer then
						arg_66_1.bgmTimer:Stop()

						arg_66_1.bgmTimer = nil
					end

					if arg_66_1.settingData.show_music_name == 1 then
						arg_66_1.musicController:SetSelectedState("show")
						arg_66_1.musicAnimator_:Play("open", 0, 0)

						if arg_66_1.settingData.music_time ~= 0 then
							arg_66_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_66_1.settingData.music_time), function()
								if arg_66_1 == nil or isNil(arg_66_1.bgmTxt_) then
									return
								end

								arg_66_1.musicController:SetSelectedState("hide")
								arg_66_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.3 < arg_66_1.time_ and arg_66_1.time_ <= 0.3 + arg_69_0 then
				arg_66_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if arg_66_1.frameCnt_ <= 1 then
				arg_66_1.dialog_:SetActive(false)
			end

			local var_69_25 = 2
			local var_69_26 = 0.4

			if 2 < arg_66_1.time_ and arg_66_1.time_ <= var_69_25 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0

				arg_66_1.dialog_:SetActive(true)

				arg_66_1.dialogCg_.alpha = 0

				local var_69_27 = LeanTween.value(arg_66_1.dialog_, 0, 1, 0.3)

				var_69_27:setOnUpdate(LuaHelper.FloatAction(function(arg_72_0)
					arg_66_1.dialogCg_.alpha = arg_72_0
				end))
				var_69_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_66_1.dialog_)
					var_69_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_66_1.duration_ = arg_66_1.duration_ + 0.3

				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_28 = arg_66_1:GetWordFromCfg(420132016)
				local var_69_29 = arg_66_1:FormatText(var_69_28.content)

				arg_66_1.text_.text = var_69_29

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_31 = 16 <= 0 and var_69_26 or var_69_26 * (utf8.len(var_69_29) / 16)

				if (16 <= 0 and var_69_26 or var_69_26 * (utf8.len(var_69_29) / 16)) > 0 and var_69_26 < var_69_31 then
					arg_66_1.talkMaxDuration = var_69_31
					var_69_25 = var_69_25 + 0.3

					if var_69_31 + var_69_25 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_31 + var_69_25
					end
				end

				arg_66_1.text_.text = var_69_29
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132016", "story_v_out_420132.awb") ~= 0 then
					local var_69_32 = manager.audio:GetVoiceLength("story_v_out_420132", "420132016", "story_v_out_420132.awb") / 1000

					if var_69_32 + var_69_25 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_32 + var_69_25
					end

					if var_69_28.prefab_name ~= "" and arg_66_1.actors_[var_69_28.prefab_name] ~= nil then
						local var_69_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_28.prefab_name].transform, "story_v_out_420132", "420132016", "story_v_out_420132.awb")

						arg_66_1:RecordAudio("420132016", var_69_33)
						arg_66_1:RecordAudio("420132016", var_69_33)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_420132", "420132016", "story_v_out_420132.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_420132", "420132016", "story_v_out_420132.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_34 = var_69_25 + 0.3
			local var_69_35 = math.max(var_69_26, arg_66_1.talkMaxDuration)

			if var_69_25 + 0.3 <= arg_66_1.time_ and arg_66_1.time_ < var_69_34 + var_69_35 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_34) / var_69_35

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_34 + var_69_35 and arg_66_1.time_ < var_69_34 + var_69_35 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play420132017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 420132017
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play420132018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos1061ui_story = arg_74_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_77_0 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 then
				arg_74_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_74_1.time_ - 0) / var_77_0)
				arg_74_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_74_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["1061ui_story"].transform.position).z)
				arg_74_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_74_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_74_1.actors_["1061ui_story"].transform.localEulerAngles = arg_74_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 then
				arg_74_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_74_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_74_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["1061ui_story"].transform.position).z)
				arg_74_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_74_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_74_1.actors_["1061ui_story"].transform.localEulerAngles = arg_74_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_77_1 = 0
			local var_77_2 = 1.225

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_3 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(420132017).content)

				arg_74_1.text_.text = var_77_3

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 49 <= 0 and var_77_2 or var_77_2 * (utf8.len(var_77_3) / 49)

				if (49 <= 0 and var_77_2 or var_77_2 * (utf8.len(var_77_3) / 49)) > 0 and var_77_2 < var_77_5 then
					arg_74_1.talkMaxDuration = var_77_5

					if var_77_5 + var_77_1 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_5 + var_77_1
					end
				end

				arg_74_1.text_.text = var_77_3
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_6 = math.max(var_77_2, arg_74_1.talkMaxDuration)

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_6 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_1) / var_77_6

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_1 + var_77_6 and arg_74_1.time_ < var_77_1 + var_77_6 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play420132018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 420132018
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play420132019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 1.075

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_1 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(420132018).content)

				arg_78_1.text_.text = var_81_1

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_3 = 43 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_1) / 43)

				if (43 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_1) / 43)) > 0 and var_81_0 < var_81_3 then
					arg_78_1.talkMaxDuration = var_81_3

					if var_81_3 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_3 + 0
					end
				end

				arg_78_1.text_.text = var_81_1
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_4 = math.max(var_81_0, arg_78_1.talkMaxDuration)

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_4 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - 0) / var_81_4

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= 0 + var_81_4 and arg_78_1.time_ < 0 + var_81_4 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play420132019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 420132019
		arg_82_1.duration_ = 3.27

		local var_82_0 = {
			zh = 2.366,
			ja = 3.266
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play420132020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos1061ui_story = arg_82_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_85_0 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 then
				arg_82_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_82_1.time_ - 0) / var_85_0)
				arg_82_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1061ui_story"].transform.position).z)
				arg_82_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["1061ui_story"].transform.localEulerAngles = arg_82_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 then
				arg_82_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_82_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1061ui_story"].transform.position).z)
				arg_82_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["1061ui_story"].transform.localEulerAngles = arg_82_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_85_1 = arg_82_1.actors_["1061ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_1) and arg_82_1.var_.characterEffect1061ui_story == nil then
				arg_82_1.var_.characterEffect1061ui_story = var_85_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.200000002980232

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_2 and not isNil(var_85_1) then
				if arg_82_1.var_.characterEffect1061ui_story and not isNil(var_85_1) then
					arg_82_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= 0 + var_85_2 and arg_82_1.time_ < 0 + var_85_2 + arg_85_0 and not isNil(var_85_1) and arg_82_1.var_.characterEffect1061ui_story then
				arg_82_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva", "EmotionTimelineAnimator")
			end

			local var_85_4 = 0
			local var_85_5 = 0.3

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_4 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_6 = arg_82_1:GetWordFromCfg(420132019)
				local var_85_7 = arg_82_1:FormatText(var_85_6.content)

				arg_82_1.text_.text = var_85_7

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_9 = 12 <= 0 and var_85_5 or var_85_5 * (utf8.len(var_85_7) / 12)

				if (12 <= 0 and var_85_5 or var_85_5 * (utf8.len(var_85_7) / 12)) > 0 and var_85_5 < var_85_9 then
					arg_82_1.talkMaxDuration = var_85_9

					if var_85_9 + var_85_4 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_9 + var_85_4
					end
				end

				arg_82_1.text_.text = var_85_7
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132019", "story_v_out_420132.awb") ~= 0 then
					local var_85_10 = manager.audio:GetVoiceLength("story_v_out_420132", "420132019", "story_v_out_420132.awb") / 1000

					if var_85_10 + var_85_4 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_10 + var_85_4
					end

					if var_85_6.prefab_name ~= "" and arg_82_1.actors_[var_85_6.prefab_name] ~= nil then
						local var_85_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_6.prefab_name].transform, "story_v_out_420132", "420132019", "story_v_out_420132.awb")

						arg_82_1:RecordAudio("420132019", var_85_11)
						arg_82_1:RecordAudio("420132019", var_85_11)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_420132", "420132019", "story_v_out_420132.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_420132", "420132019", "story_v_out_420132.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_12 = math.max(var_85_5, arg_82_1.talkMaxDuration)

			if var_85_4 <= arg_82_1.time_ and arg_82_1.time_ < var_85_4 + var_85_12 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_4) / var_85_12

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_4 + var_85_12 and arg_82_1.time_ < var_85_4 + var_85_12 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play420132020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 420132020
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play420132021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["1061ui_story"]) and arg_86_1.var_.characterEffect1061ui_story == nil then
				arg_86_1.var_.characterEffect1061ui_story = arg_86_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_0 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["1061ui_story"]) then
				if arg_86_1.var_.characterEffect1061ui_story and not isNil(arg_86_1.actors_["1061ui_story"]) then
					arg_86_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_86_1.time_ - 0) / var_89_0)
				end
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["1061ui_story"]) and arg_86_1.var_.characterEffect1061ui_story then
				arg_86_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_89_1 = 0
			local var_89_2 = 1.025

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_3 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(420132020).content)

				arg_86_1.text_.text = var_89_3

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_5 = 41 <= 0 and var_89_2 or var_89_2 * (utf8.len(var_89_3) / 41)

				if (41 <= 0 and var_89_2 or var_89_2 * (utf8.len(var_89_3) / 41)) > 0 and var_89_2 < var_89_5 then
					arg_86_1.talkMaxDuration = var_89_5

					if var_89_5 + var_89_1 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + var_89_1
					end
				end

				arg_86_1.text_.text = var_89_3
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_6 = math.max(var_89_2, arg_86_1.talkMaxDuration)

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_6 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_1) / var_89_6

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_1 + var_89_6 and arg_86_1.time_ < var_89_1 + var_89_6 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play420132021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 420132021
		arg_90_1.duration_ = 4.87

		local var_90_0 = {
			zh = 3.8,
			ja = 4.866
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
				arg_90_0:Play420132022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["1061ui_story"]) and arg_90_1.var_.characterEffect1061ui_story == nil then
				arg_90_1.var_.characterEffect1061ui_story = arg_90_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["1061ui_story"]) then
				if arg_90_1.var_.characterEffect1061ui_story and not isNil(arg_90_1.actors_["1061ui_story"]) then
					arg_90_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["1061ui_story"]) and arg_90_1.var_.characterEffect1061ui_story then
				arg_90_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_93_2 = 0
			local var_93_3 = 0.45

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_2 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_4 = arg_90_1:GetWordFromCfg(420132021)
				local var_93_5 = arg_90_1:FormatText(var_93_4.content)

				arg_90_1.text_.text = var_93_5

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_7 = 17 <= 0 and var_93_3 or var_93_3 * (utf8.len(var_93_5) / 17)

				if (17 <= 0 and var_93_3 or var_93_3 * (utf8.len(var_93_5) / 17)) > 0 and var_93_3 < var_93_7 then
					arg_90_1.talkMaxDuration = var_93_7

					if var_93_7 + var_93_2 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_2
					end
				end

				arg_90_1.text_.text = var_93_5
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132021", "story_v_out_420132.awb") ~= 0 then
					local var_93_8 = manager.audio:GetVoiceLength("story_v_out_420132", "420132021", "story_v_out_420132.awb") / 1000

					if var_93_8 + var_93_2 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_8 + var_93_2
					end

					if var_93_4.prefab_name ~= "" and arg_90_1.actors_[var_93_4.prefab_name] ~= nil then
						local var_93_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_4.prefab_name].transform, "story_v_out_420132", "420132021", "story_v_out_420132.awb")

						arg_90_1:RecordAudio("420132021", var_93_9)
						arg_90_1:RecordAudio("420132021", var_93_9)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_420132", "420132021", "story_v_out_420132.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_420132", "420132021", "story_v_out_420132.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_10 = math.max(var_93_3, arg_90_1.talkMaxDuration)

			if var_93_2 <= arg_90_1.time_ and arg_90_1.time_ < var_93_2 + var_93_10 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_2) / var_93_10

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_2 + var_93_10 and arg_90_1.time_ < var_93_2 + var_93_10 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play420132022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 420132022
		arg_94_1.duration_ = 13.17

		local var_94_0 = {
			zh = 7.7,
			ja = 13.166
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
				arg_94_0:Play420132023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			local var_97_0 = 0
			local var_97_1 = 0.925

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_2 = arg_94_1:GetWordFromCfg(420132022)
				local var_97_3 = arg_94_1:FormatText(var_97_2.content)

				arg_94_1.text_.text = var_97_3

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 37 <= 0 and var_97_1 or var_97_1 * (utf8.len(var_97_3) / 37)

				if (37 <= 0 and var_97_1 or var_97_1 * (utf8.len(var_97_3) / 37)) > 0 and var_97_1 < var_97_5 then
					arg_94_1.talkMaxDuration = var_97_5

					if var_97_5 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_5 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_3
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132022", "story_v_out_420132.awb") ~= 0 then
					local var_97_6 = manager.audio:GetVoiceLength("story_v_out_420132", "420132022", "story_v_out_420132.awb") / 1000

					if var_97_6 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_6 + var_97_0
					end

					if var_97_2.prefab_name ~= "" and arg_94_1.actors_[var_97_2.prefab_name] ~= nil then
						local var_97_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_2.prefab_name].transform, "story_v_out_420132", "420132022", "story_v_out_420132.awb")

						arg_94_1:RecordAudio("420132022", var_97_7)
						arg_94_1:RecordAudio("420132022", var_97_7)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_420132", "420132022", "story_v_out_420132.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_420132", "420132022", "story_v_out_420132.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_8 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_8 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_8

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_8 and arg_94_1.time_ < var_97_0 + var_97_8 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play420132023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 420132023
		arg_98_1.duration_ = 13.77

		local var_98_0 = {
			zh = 11.733,
			ja = 13.766
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play420132024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 1.275

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_1 = arg_98_1:GetWordFromCfg(420132023)
				local var_101_2 = arg_98_1:FormatText(var_101_1.content)

				arg_98_1.text_.text = var_101_2

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_4 = 51 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 51)

				if (51 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 51)) > 0 and var_101_0 < var_101_4 then
					arg_98_1.talkMaxDuration = var_101_4

					if var_101_4 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_4 + 0
					end
				end

				arg_98_1.text_.text = var_101_2
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132023", "story_v_out_420132.awb") ~= 0 then
					local var_101_5 = manager.audio:GetVoiceLength("story_v_out_420132", "420132023", "story_v_out_420132.awb") / 1000

					if var_101_5 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + 0
					end

					if var_101_1.prefab_name ~= "" and arg_98_1.actors_[var_101_1.prefab_name] ~= nil then
						local var_101_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_1.prefab_name].transform, "story_v_out_420132", "420132023", "story_v_out_420132.awb")

						arg_98_1:RecordAudio("420132023", var_101_6)
						arg_98_1:RecordAudio("420132023", var_101_6)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_420132", "420132023", "story_v_out_420132.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_420132", "420132023", "story_v_out_420132.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_7 = math.max(var_101_0, arg_98_1.talkMaxDuration)

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_7 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - 0) / var_101_7

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= 0 + var_101_7 and arg_98_1.time_ < 0 + var_101_7 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play420132024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 420132024
		arg_102_1.duration_ = 9.8

		local var_102_0 = {
			zh = 5.8,
			ja = 9.8
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
				arg_102_0:Play420132025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0.75

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_1 = arg_102_1:GetWordFromCfg(420132024)
				local var_105_2 = arg_102_1:FormatText(var_105_1.content)

				arg_102_1.text_.text = var_105_2

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 30 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 30)

				if (30 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 30)) > 0 and var_105_0 < var_105_4 then
					arg_102_1.talkMaxDuration = var_105_4

					if var_105_4 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_4 + 0
					end
				end

				arg_102_1.text_.text = var_105_2
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132024", "story_v_out_420132.awb") ~= 0 then
					local var_105_5 = manager.audio:GetVoiceLength("story_v_out_420132", "420132024", "story_v_out_420132.awb") / 1000

					if var_105_5 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + 0
					end

					if var_105_1.prefab_name ~= "" and arg_102_1.actors_[var_105_1.prefab_name] ~= nil then
						local var_105_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_1.prefab_name].transform, "story_v_out_420132", "420132024", "story_v_out_420132.awb")

						arg_102_1:RecordAudio("420132024", var_105_6)
						arg_102_1:RecordAudio("420132024", var_105_6)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_420132", "420132024", "story_v_out_420132.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_420132", "420132024", "story_v_out_420132.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_7 = math.max(var_105_0, arg_102_1.talkMaxDuration)

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_7 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - 0) / var_105_7

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= 0 + var_105_7 and arg_102_1.time_ < 0 + var_105_7 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play420132025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 420132025
		arg_106_1.duration_ = 7.63

		local var_106_0 = {
			zh = 5.233,
			ja = 7.633
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
				arg_106_0:Play420132026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_109_0 = 0
			local var_109_1 = 0.65

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_2 = arg_106_1:GetWordFromCfg(420132025)
				local var_109_3 = arg_106_1:FormatText(var_109_2.content)

				arg_106_1.text_.text = var_109_3

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 26 <= 0 and var_109_1 or var_109_1 * (utf8.len(var_109_3) / 26)

				if (26 <= 0 and var_109_1 or var_109_1 * (utf8.len(var_109_3) / 26)) > 0 and var_109_1 < var_109_5 then
					arg_106_1.talkMaxDuration = var_109_5

					if var_109_5 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + var_109_0
					end
				end

				arg_106_1.text_.text = var_109_3
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132025", "story_v_out_420132.awb") ~= 0 then
					local var_109_6 = manager.audio:GetVoiceLength("story_v_out_420132", "420132025", "story_v_out_420132.awb") / 1000

					if var_109_6 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_6 + var_109_0
					end

					if var_109_2.prefab_name ~= "" and arg_106_1.actors_[var_109_2.prefab_name] ~= nil then
						local var_109_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_2.prefab_name].transform, "story_v_out_420132", "420132025", "story_v_out_420132.awb")

						arg_106_1:RecordAudio("420132025", var_109_7)
						arg_106_1:RecordAudio("420132025", var_109_7)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_420132", "420132025", "story_v_out_420132.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_420132", "420132025", "story_v_out_420132.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_8 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_8 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_8

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_8 and arg_106_1.time_ < var_109_0 + var_109_8 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play420132026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 420132026
		arg_110_1.duration_ = 9.7

		local var_110_0 = {
			zh = 6.033,
			ja = 9.7
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
				arg_110_0:Play420132027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos1061ui_story = arg_110_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_113_0 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 then
				arg_110_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_110_1.time_ - 0) / var_113_0)
				arg_110_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1061ui_story"].transform.position).z)
				arg_110_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["1061ui_story"].transform.localEulerAngles = arg_110_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 then
				arg_110_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				arg_110_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1061ui_story"].transform.position).z)
				arg_110_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["1061ui_story"].transform.localEulerAngles = arg_110_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_113_1 = "1085ui_story"

			if arg_110_1.actors_["1085ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1085ui_story"))) then
				local var_113_2 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_110_1.stage_.transform)

				var_113_2.name = var_113_1
				var_113_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_110_1.actors_[var_113_1] = var_113_2

				local var_113_3 = var_113_2:GetComponentInChildren(typeof(CharacterEffect))

				var_113_3.enabled = true

				local var_113_4 = GameObjectTools.GetOrAddComponent(var_113_2, typeof(DynamicBoneHelper))

				if var_113_4 then
					var_113_4:EnableDynamicBone(false)
				end

				arg_110_1:ShowWeapon(var_113_3.transform, false)

				arg_110_1.var_[var_113_1 .. "Animator"] = var_113_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_110_1.var_[var_113_1 .. "Animator"].applyRootMotion = true
				arg_110_1.var_[var_113_1 .. "LipSync"] = var_113_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_113_5 = arg_110_1.actors_["1085ui_story"].transform

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos1085ui_story = var_113_5.localPosition
			end

			local var_113_6 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_6 then
				var_113_5.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_110_1.time_ - 0) / var_113_6)
				var_113_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_5.position).x, (manager.ui.mainCamera.transform.position - var_113_5.position).y, (manager.ui.mainCamera.transform.position - var_113_5.position).z)
				var_113_5.localEulerAngles.z = 0
				var_113_5.localEulerAngles.x = 0
				var_113_5.localEulerAngles = var_113_5.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_6 and arg_110_1.time_ < 0 + var_113_6 + arg_113_0 then
				var_113_5.localPosition = Vector3.New(0.75, -1.01, -5.83)
				var_113_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_5.position).x, (manager.ui.mainCamera.transform.position - var_113_5.position).y, (manager.ui.mainCamera.transform.position - var_113_5.position).z)
				var_113_5.localEulerAngles.z = 0
				var_113_5.localEulerAngles.x = 0
				var_113_5.localEulerAngles = var_113_5.localEulerAngles
			end

			local var_113_7 = arg_110_1.actors_["1085ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_7) and arg_110_1.var_.characterEffect1085ui_story == nil then
				arg_110_1.var_.characterEffect1085ui_story = var_113_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_8 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_8 and not isNil(var_113_7) then
				if arg_110_1.var_.characterEffect1085ui_story and not isNil(var_113_7) then
					arg_110_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_8 and arg_110_1.time_ < 0 + var_113_8 + arg_113_0 and not isNil(var_113_7) and arg_110_1.var_.characterEffect1085ui_story then
				arg_110_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_113_10 = arg_110_1.actors_["1061ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_10) and arg_110_1.var_.characterEffect1061ui_story == nil then
				arg_110_1.var_.characterEffect1061ui_story = var_113_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_11 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_11 and not isNil(var_113_10) then
				if arg_110_1.var_.characterEffect1061ui_story and not isNil(var_113_10) then
					arg_110_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_11)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_11 and arg_110_1.time_ < 0 + var_113_11 + arg_113_0 and not isNil(var_113_10) and arg_110_1.var_.characterEffect1061ui_story then
				arg_110_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_113_12 = 0
			local var_113_13 = 0.65

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_12 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_14 = arg_110_1:GetWordFromCfg(420132026)
				local var_113_15 = arg_110_1:FormatText(var_113_14.content)

				arg_110_1.text_.text = var_113_15

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_17 = 26 <= 0 and var_113_13 or var_113_13 * (utf8.len(var_113_15) / 26)

				if (26 <= 0 and var_113_13 or var_113_13 * (utf8.len(var_113_15) / 26)) > 0 and var_113_13 < var_113_17 then
					arg_110_1.talkMaxDuration = var_113_17

					if var_113_17 + var_113_12 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_17 + var_113_12
					end
				end

				arg_110_1.text_.text = var_113_15
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132026", "story_v_out_420132.awb") ~= 0 then
					local var_113_18 = manager.audio:GetVoiceLength("story_v_out_420132", "420132026", "story_v_out_420132.awb") / 1000

					if var_113_18 + var_113_12 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_18 + var_113_12
					end

					if var_113_14.prefab_name ~= "" and arg_110_1.actors_[var_113_14.prefab_name] ~= nil then
						local var_113_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_14.prefab_name].transform, "story_v_out_420132", "420132026", "story_v_out_420132.awb")

						arg_110_1:RecordAudio("420132026", var_113_19)
						arg_110_1:RecordAudio("420132026", var_113_19)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_420132", "420132026", "story_v_out_420132.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_420132", "420132026", "story_v_out_420132.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_20 = math.max(var_113_13, arg_110_1.talkMaxDuration)

			if var_113_12 <= arg_110_1.time_ and arg_110_1.time_ < var_113_12 + var_113_20 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_12) / var_113_20

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_12 + var_113_20 and arg_110_1.time_ < var_113_12 + var_113_20 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play420132027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 420132027
		arg_114_1.duration_ = 7.4

		local var_114_0 = {
			zh = 2.766,
			ja = 7.4
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play420132028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["1061ui_story"]) and arg_114_1.var_.characterEffect1061ui_story == nil then
				arg_114_1.var_.characterEffect1061ui_story = arg_114_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_0 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["1061ui_story"]) then
				if arg_114_1.var_.characterEffect1061ui_story and not isNil(arg_114_1.actors_["1061ui_story"]) then
					arg_114_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["1061ui_story"]) and arg_114_1.var_.characterEffect1061ui_story then
				arg_114_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_117_2 = arg_114_1.actors_["1085ui_story"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_2) and arg_114_1.var_.characterEffect1085ui_story == nil then
				arg_114_1.var_.characterEffect1085ui_story = var_117_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_3 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_3 and not isNil(var_117_2) then
				if arg_114_1.var_.characterEffect1085ui_story and not isNil(var_117_2) then
					arg_114_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_114_1.time_ - 0) / var_117_3)
				end
			end

			if arg_114_1.time_ >= 0 + var_117_3 and arg_114_1.time_ < 0 + var_117_3 + arg_117_0 and not isNil(var_117_2) and arg_114_1.var_.characterEffect1085ui_story then
				arg_114_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_117_4 = 0
			local var_117_5 = 0.35

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_6 = arg_114_1:GetWordFromCfg(420132027)
				local var_117_7 = arg_114_1:FormatText(var_117_6.content)

				arg_114_1.text_.text = var_117_7

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_9 = 14 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 14)

				if (14 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 14)) > 0 and var_117_5 < var_117_9 then
					arg_114_1.talkMaxDuration = var_117_9

					if var_117_9 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_9 + var_117_4
					end
				end

				arg_114_1.text_.text = var_117_7
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132027", "story_v_out_420132.awb") ~= 0 then
					local var_117_10 = manager.audio:GetVoiceLength("story_v_out_420132", "420132027", "story_v_out_420132.awb") / 1000

					if var_117_10 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_10 + var_117_4
					end

					if var_117_6.prefab_name ~= "" and arg_114_1.actors_[var_117_6.prefab_name] ~= nil then
						local var_117_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_6.prefab_name].transform, "story_v_out_420132", "420132027", "story_v_out_420132.awb")

						arg_114_1:RecordAudio("420132027", var_117_11)
						arg_114_1:RecordAudio("420132027", var_117_11)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_420132", "420132027", "story_v_out_420132.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_420132", "420132027", "story_v_out_420132.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_12 = math.max(var_117_5, arg_114_1.talkMaxDuration)

			if var_117_4 <= arg_114_1.time_ and arg_114_1.time_ < var_117_4 + var_117_12 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_4) / var_117_12

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_4 + var_117_12 and arg_114_1.time_ < var_117_4 + var_117_12 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play420132028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 420132028
		arg_118_1.duration_ = 14.33

		local var_118_0 = {
			zh = 7.966,
			ja = 14.333
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play420132029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["1085ui_story"]) and arg_118_1.var_.characterEffect1085ui_story == nil then
				arg_118_1.var_.characterEffect1085ui_story = arg_118_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_0 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["1085ui_story"]) then
				if arg_118_1.var_.characterEffect1085ui_story and not isNil(arg_118_1.actors_["1085ui_story"]) then
					arg_118_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["1085ui_story"]) and arg_118_1.var_.characterEffect1085ui_story then
				arg_118_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_121_2 = arg_118_1.actors_["1061ui_story"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_2) and arg_118_1.var_.characterEffect1061ui_story == nil then
				arg_118_1.var_.characterEffect1061ui_story = var_121_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_3 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_3 and not isNil(var_121_2) then
				if arg_118_1.var_.characterEffect1061ui_story and not isNil(var_121_2) then
					arg_118_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_118_1.time_ - 0) / var_121_3)
				end
			end

			if arg_118_1.time_ >= 0 + var_121_3 and arg_118_1.time_ < 0 + var_121_3 + arg_121_0 and not isNil(var_121_2) and arg_118_1.var_.characterEffect1061ui_story then
				arg_118_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_121_4 = 0
			local var_121_5 = 0.75

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_4 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_6 = arg_118_1:GetWordFromCfg(420132028)
				local var_121_7 = arg_118_1:FormatText(var_121_6.content)

				arg_118_1.text_.text = var_121_7

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_9 = 30 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 30)

				if (30 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 30)) > 0 and var_121_5 < var_121_9 then
					arg_118_1.talkMaxDuration = var_121_9

					if var_121_9 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_9 + var_121_4
					end
				end

				arg_118_1.text_.text = var_121_7
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132028", "story_v_out_420132.awb") ~= 0 then
					local var_121_10 = manager.audio:GetVoiceLength("story_v_out_420132", "420132028", "story_v_out_420132.awb") / 1000

					if var_121_10 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_10 + var_121_4
					end

					if var_121_6.prefab_name ~= "" and arg_118_1.actors_[var_121_6.prefab_name] ~= nil then
						local var_121_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_6.prefab_name].transform, "story_v_out_420132", "420132028", "story_v_out_420132.awb")

						arg_118_1:RecordAudio("420132028", var_121_11)
						arg_118_1:RecordAudio("420132028", var_121_11)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_420132", "420132028", "story_v_out_420132.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_420132", "420132028", "story_v_out_420132.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_12 = math.max(var_121_5, arg_118_1.talkMaxDuration)

			if var_121_4 <= arg_118_1.time_ and arg_118_1.time_ < var_121_4 + var_121_12 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_4) / var_121_12

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_4 + var_121_12 and arg_118_1.time_ < var_121_4 + var_121_12 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play420132029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 420132029
		arg_122_1.duration_ = 13.83

		local var_122_0 = {
			zh = 9.066,
			ja = 13.833
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play420132030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["1061ui_story"]) and arg_122_1.var_.characterEffect1061ui_story == nil then
				arg_122_1.var_.characterEffect1061ui_story = arg_122_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_0 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["1061ui_story"]) then
				if arg_122_1.var_.characterEffect1061ui_story and not isNil(arg_122_1.actors_["1061ui_story"]) then
					arg_122_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["1061ui_story"]) and arg_122_1.var_.characterEffect1061ui_story then
				arg_122_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_125_2 = arg_122_1.actors_["1085ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.characterEffect1085ui_story == nil then
				arg_122_1.var_.characterEffect1085ui_story = var_125_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_3 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_3 and not isNil(var_125_2) then
				if arg_122_1.var_.characterEffect1085ui_story and not isNil(var_125_2) then
					arg_122_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 0) / var_125_3)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_3 and arg_122_1.time_ < 0 + var_125_3 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.characterEffect1085ui_story then
				arg_122_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_125_4 = 0
			local var_125_5 = 1.025

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_6 = arg_122_1:GetWordFromCfg(420132029)
				local var_125_7 = arg_122_1:FormatText(var_125_6.content)

				arg_122_1.text_.text = var_125_7

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_9 = 41 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_7) / 41)

				if (41 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_7) / 41)) > 0 and var_125_5 < var_125_9 then
					arg_122_1.talkMaxDuration = var_125_9

					if var_125_9 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_9 + var_125_4
					end
				end

				arg_122_1.text_.text = var_125_7
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132029", "story_v_out_420132.awb") ~= 0 then
					local var_125_10 = manager.audio:GetVoiceLength("story_v_out_420132", "420132029", "story_v_out_420132.awb") / 1000

					if var_125_10 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_10 + var_125_4
					end

					if var_125_6.prefab_name ~= "" and arg_122_1.actors_[var_125_6.prefab_name] ~= nil then
						local var_125_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_6.prefab_name].transform, "story_v_out_420132", "420132029", "story_v_out_420132.awb")

						arg_122_1:RecordAudio("420132029", var_125_11)
						arg_122_1:RecordAudio("420132029", var_125_11)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_420132", "420132029", "story_v_out_420132.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_420132", "420132029", "story_v_out_420132.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_12 = math.max(var_125_5, arg_122_1.talkMaxDuration)

			if var_125_4 <= arg_122_1.time_ and arg_122_1.time_ < var_125_4 + var_125_12 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_4) / var_125_12

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_4 + var_125_12 and arg_122_1.time_ < var_125_4 + var_125_12 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play420132030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 420132030
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play420132031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["1061ui_story"]) and arg_126_1.var_.characterEffect1061ui_story == nil then
				arg_126_1.var_.characterEffect1061ui_story = arg_126_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_0 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["1061ui_story"]) then
				if arg_126_1.var_.characterEffect1061ui_story and not isNil(arg_126_1.actors_["1061ui_story"]) then
					arg_126_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_0)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["1061ui_story"]) and arg_126_1.var_.characterEffect1061ui_story then
				arg_126_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_129_1 = 0
			local var_129_2 = 0.2

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_3 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(420132030).content)

				arg_126_1.text_.text = var_129_3

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_5 = 8 <= 0 and var_129_2 or var_129_2 * (utf8.len(var_129_3) / 8)

				if (8 <= 0 and var_129_2 or var_129_2 * (utf8.len(var_129_3) / 8)) > 0 and var_129_2 < var_129_5 then
					arg_126_1.talkMaxDuration = var_129_5

					if var_129_5 + var_129_1 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_5 + var_129_1
					end
				end

				arg_126_1.text_.text = var_129_3
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_6 = math.max(var_129_2, arg_126_1.talkMaxDuration)

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_6 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_1) / var_129_6

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_1 + var_129_6 and arg_126_1.time_ < var_129_1 + var_129_6 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play420132031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 420132031
		arg_130_1.duration_ = 2

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play420132032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(arg_130_1.actors_["1085ui_story"]) and arg_130_1.var_.characterEffect1085ui_story == nil then
				arg_130_1.var_.characterEffect1085ui_story = arg_130_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_0 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 and not isNil(arg_130_1.actors_["1085ui_story"]) then
				if arg_130_1.var_.characterEffect1085ui_story and not isNil(arg_130_1.actors_["1085ui_story"]) then
					arg_130_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 and not isNil(arg_130_1.actors_["1085ui_story"]) and arg_130_1.var_.characterEffect1085ui_story then
				arg_130_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_133_2 = 0
			local var_133_3 = 0.05

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_2 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_4 = arg_130_1:GetWordFromCfg(420132031)
				local var_133_5 = arg_130_1:FormatText(var_133_4.content)

				arg_130_1.text_.text = var_133_5

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_7 = 2 <= 0 and var_133_3 or var_133_3 * (utf8.len(var_133_5) / 2)

				if (2 <= 0 and var_133_3 or var_133_3 * (utf8.len(var_133_5) / 2)) > 0 and var_133_3 < var_133_7 then
					arg_130_1.talkMaxDuration = var_133_7

					if var_133_7 + var_133_2 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_7 + var_133_2
					end
				end

				arg_130_1.text_.text = var_133_5
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132031", "story_v_out_420132.awb") ~= 0 then
					local var_133_8 = manager.audio:GetVoiceLength("story_v_out_420132", "420132031", "story_v_out_420132.awb") / 1000

					if var_133_8 + var_133_2 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_8 + var_133_2
					end

					if var_133_4.prefab_name ~= "" and arg_130_1.actors_[var_133_4.prefab_name] ~= nil then
						local var_133_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_4.prefab_name].transform, "story_v_out_420132", "420132031", "story_v_out_420132.awb")

						arg_130_1:RecordAudio("420132031", var_133_9)
						arg_130_1:RecordAudio("420132031", var_133_9)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_420132", "420132031", "story_v_out_420132.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_420132", "420132031", "story_v_out_420132.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_10 = math.max(var_133_3, arg_130_1.talkMaxDuration)

			if var_133_2 <= arg_130_1.time_ and arg_130_1.time_ < var_133_2 + var_133_10 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_2) / var_133_10

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_2 + var_133_10 and arg_130_1.time_ < var_133_2 + var_133_10 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play420132032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 420132032
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play420132033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["1085ui_story"]) and arg_134_1.var_.characterEffect1085ui_story == nil then
				arg_134_1.var_.characterEffect1085ui_story = arg_134_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_0 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["1085ui_story"]) then
				if arg_134_1.var_.characterEffect1085ui_story and not isNil(arg_134_1.actors_["1085ui_story"]) then
					arg_134_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_0)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["1085ui_story"]) and arg_134_1.var_.characterEffect1085ui_story then
				arg_134_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_137_1 = 0
			local var_137_2 = 0.25

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_3 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(420132032).content)

				arg_134_1.text_.text = var_137_3

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_5 = 10 <= 0 and var_137_2 or var_137_2 * (utf8.len(var_137_3) / 10)

				if (10 <= 0 and var_137_2 or var_137_2 * (utf8.len(var_137_3) / 10)) > 0 and var_137_2 < var_137_5 then
					arg_134_1.talkMaxDuration = var_137_5

					if var_137_5 + var_137_1 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_5 + var_137_1
					end
				end

				arg_134_1.text_.text = var_137_3
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_6 = math.max(var_137_2, arg_134_1.talkMaxDuration)

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_6 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_1) / var_137_6

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_1 + var_137_6 and arg_134_1.time_ < var_137_1 + var_137_6 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play420132033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 420132033
		arg_138_1.duration_ = 7.57

		local var_138_0 = {
			zh = 5.066,
			ja = 7.566
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play420132034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["1085ui_story"]) and arg_138_1.var_.characterEffect1085ui_story == nil then
				arg_138_1.var_.characterEffect1085ui_story = arg_138_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_0 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["1085ui_story"]) then
				if arg_138_1.var_.characterEffect1085ui_story and not isNil(arg_138_1.actors_["1085ui_story"]) then
					arg_138_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["1085ui_story"]) and arg_138_1.var_.characterEffect1085ui_story then
				arg_138_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			local var_141_2 = 0
			local var_141_3 = 0.4

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_2 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_4 = arg_138_1:GetWordFromCfg(420132033)
				local var_141_5 = arg_138_1:FormatText(var_141_4.content)

				arg_138_1.text_.text = var_141_5

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_7 = 16 <= 0 and var_141_3 or var_141_3 * (utf8.len(var_141_5) / 16)

				if (16 <= 0 and var_141_3 or var_141_3 * (utf8.len(var_141_5) / 16)) > 0 and var_141_3 < var_141_7 then
					arg_138_1.talkMaxDuration = var_141_7

					if var_141_7 + var_141_2 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_7 + var_141_2
					end
				end

				arg_138_1.text_.text = var_141_5
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132033", "story_v_out_420132.awb") ~= 0 then
					local var_141_8 = manager.audio:GetVoiceLength("story_v_out_420132", "420132033", "story_v_out_420132.awb") / 1000

					if var_141_8 + var_141_2 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_8 + var_141_2
					end

					if var_141_4.prefab_name ~= "" and arg_138_1.actors_[var_141_4.prefab_name] ~= nil then
						local var_141_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_4.prefab_name].transform, "story_v_out_420132", "420132033", "story_v_out_420132.awb")

						arg_138_1:RecordAudio("420132033", var_141_9)
						arg_138_1:RecordAudio("420132033", var_141_9)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_420132", "420132033", "story_v_out_420132.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_420132", "420132033", "story_v_out_420132.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_10 = math.max(var_141_3, arg_138_1.talkMaxDuration)

			if var_141_2 <= arg_138_1.time_ and arg_138_1.time_ < var_141_2 + var_141_10 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_2) / var_141_10

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_2 + var_141_10 and arg_138_1.time_ < var_141_2 + var_141_10 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play420132034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 420132034
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play420132035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["1085ui_story"]) and arg_142_1.var_.characterEffect1085ui_story == nil then
				arg_142_1.var_.characterEffect1085ui_story = arg_142_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_0 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["1085ui_story"]) then
				if arg_142_1.var_.characterEffect1085ui_story and not isNil(arg_142_1.actors_["1085ui_story"]) then
					arg_142_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_142_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_142_1.time_ - 0) / var_145_0)
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["1085ui_story"]) and arg_142_1.var_.characterEffect1085ui_story then
				arg_142_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_142_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_145_1 = 0
			local var_145_2 = 0.125

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_3 = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(420132034).content)

				arg_142_1.text_.text = var_145_3

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 5 <= 0 and var_145_2 or var_145_2 * (utf8.len(var_145_3) / 5)

				if (5 <= 0 and var_145_2 or var_145_2 * (utf8.len(var_145_3) / 5)) > 0 and var_145_2 < var_145_5 then
					arg_142_1.talkMaxDuration = var_145_5

					if var_145_5 + var_145_1 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_5 + var_145_1
					end
				end

				arg_142_1.text_.text = var_145_3
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_6 = math.max(var_145_2, arg_142_1.talkMaxDuration)

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_6 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_1) / var_145_6

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_1 + var_145_6 and arg_142_1.time_ < var_145_1 + var_145_6 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play420132035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 420132035
		arg_146_1.duration_ = 6.43

		local var_146_0 = {
			zh = 5.233,
			ja = 6.433
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play420132036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(arg_146_1.actors_["1061ui_story"]) and arg_146_1.var_.characterEffect1061ui_story == nil then
				arg_146_1.var_.characterEffect1061ui_story = arg_146_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_0 = 0.200000002980232

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 and not isNil(arg_146_1.actors_["1061ui_story"]) then
				if arg_146_1.var_.characterEffect1061ui_story and not isNil(arg_146_1.actors_["1061ui_story"]) then
					arg_146_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 and not isNil(arg_146_1.actors_["1061ui_story"]) and arg_146_1.var_.characterEffect1061ui_story then
				arg_146_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_2")
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_149_2 = 0
			local var_149_3 = 0.6

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_2 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_4 = arg_146_1:GetWordFromCfg(420132035)
				local var_149_5 = arg_146_1:FormatText(var_149_4.content)

				arg_146_1.text_.text = var_149_5

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_7 = 24 <= 0 and var_149_3 or var_149_3 * (utf8.len(var_149_5) / 24)

				if (24 <= 0 and var_149_3 or var_149_3 * (utf8.len(var_149_5) / 24)) > 0 and var_149_3 < var_149_7 then
					arg_146_1.talkMaxDuration = var_149_7

					if var_149_7 + var_149_2 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_7 + var_149_2
					end
				end

				arg_146_1.text_.text = var_149_5
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132035", "story_v_out_420132.awb") ~= 0 then
					local var_149_8 = manager.audio:GetVoiceLength("story_v_out_420132", "420132035", "story_v_out_420132.awb") / 1000

					if var_149_8 + var_149_2 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_8 + var_149_2
					end

					if var_149_4.prefab_name ~= "" and arg_146_1.actors_[var_149_4.prefab_name] ~= nil then
						local var_149_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_4.prefab_name].transform, "story_v_out_420132", "420132035", "story_v_out_420132.awb")

						arg_146_1:RecordAudio("420132035", var_149_9)
						arg_146_1:RecordAudio("420132035", var_149_9)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_420132", "420132035", "story_v_out_420132.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_420132", "420132035", "story_v_out_420132.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_10 = math.max(var_149_3, arg_146_1.talkMaxDuration)

			if var_149_2 <= arg_146_1.time_ and arg_146_1.time_ < var_149_2 + var_149_10 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_2) / var_149_10

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_2 + var_149_10 and arg_146_1.time_ < var_149_2 + var_149_10 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play420132036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 420132036
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play420132037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos1061ui_story = arg_150_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_153_0 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 then
				arg_150_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_150_1.time_ - 0) / var_153_0)
				arg_150_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_150_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1061ui_story"].transform.position).z)
				arg_150_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_150_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_150_1.actors_["1061ui_story"].transform.localEulerAngles = arg_150_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 then
				arg_150_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_150_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_150_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1061ui_story"].transform.position).z)
				arg_150_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_150_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_150_1.actors_["1061ui_story"].transform.localEulerAngles = arg_150_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_153_1 = arg_150_1.actors_["1085ui_story"].transform

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos1085ui_story = var_153_1.localPosition
			end

			local var_153_2 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_2 then
				var_153_1.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_150_1.time_ - 0) / var_153_2)
				var_153_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_1.position).x, (manager.ui.mainCamera.transform.position - var_153_1.position).y, (manager.ui.mainCamera.transform.position - var_153_1.position).z)
				var_153_1.localEulerAngles.z = 0
				var_153_1.localEulerAngles.x = 0
				var_153_1.localEulerAngles = var_153_1.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_2 and arg_150_1.time_ < 0 + var_153_2 + arg_153_0 then
				var_153_1.localPosition = Vector3.New(0, 100, 0)
				var_153_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_1.position).x, (manager.ui.mainCamera.transform.position - var_153_1.position).y, (manager.ui.mainCamera.transform.position - var_153_1.position).z)
				var_153_1.localEulerAngles.z = 0
				var_153_1.localEulerAngles.x = 0
				var_153_1.localEulerAngles = var_153_1.localEulerAngles
			end

			local var_153_3 = 0
			local var_153_4 = 0.7

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_3 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_5 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(420132036).content)

				arg_150_1.text_.text = var_153_5

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_7 = 28 <= 0 and var_153_4 or var_153_4 * (utf8.len(var_153_5) / 28)

				if (28 <= 0 and var_153_4 or var_153_4 * (utf8.len(var_153_5) / 28)) > 0 and var_153_4 < var_153_7 then
					arg_150_1.talkMaxDuration = var_153_7

					if var_153_7 + var_153_3 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_7 + var_153_3
					end
				end

				arg_150_1.text_.text = var_153_5
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_8 = math.max(var_153_4, arg_150_1.talkMaxDuration)

			if var_153_3 <= arg_150_1.time_ and arg_150_1.time_ < var_153_3 + var_153_8 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_3) / var_153_8

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_3 + var_153_8 and arg_150_1.time_ < var_153_3 + var_153_8 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play420132037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 420132037
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play420132038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0.725

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_1 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(420132037).content)

				arg_154_1.text_.text = var_157_1

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_3 = 29 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 29)

				if (29 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 29)) > 0 and var_157_0 < var_157_3 then
					arg_154_1.talkMaxDuration = var_157_3

					if var_157_3 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_3 + 0
					end
				end

				arg_154_1.text_.text = var_157_1
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_4 = math.max(var_157_0, arg_154_1.talkMaxDuration)

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_4 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - 0) / var_157_4

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= 0 + var_157_4 and arg_154_1.time_ < 0 + var_157_4 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play420132038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 420132038
		arg_158_1.duration_ = 10.47

		local var_158_0 = {
			zh = 7.1,
			ja = 10.466
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play420132039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.var_.moveOldPos1061ui_story = arg_158_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_161_0 = 0.001

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 then
				arg_158_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_158_1.time_ - 0) / var_161_0)
				arg_158_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_158_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1061ui_story"].transform.position).z)
				arg_158_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_158_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_158_1.actors_["1061ui_story"].transform.localEulerAngles = arg_158_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 then
				arg_158_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_158_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_158_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1061ui_story"].transform.position).z)
				arg_158_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_158_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_158_1.actors_["1061ui_story"].transform.localEulerAngles = arg_158_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_161_1 = arg_158_1.actors_["1061ui_story"]

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(var_161_1) and arg_158_1.var_.characterEffect1061ui_story == nil then
				arg_158_1.var_.characterEffect1061ui_story = var_161_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_2 = 0.200000002980232

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_2 and not isNil(var_161_1) then
				if arg_158_1.var_.characterEffect1061ui_story and not isNil(var_161_1) then
					arg_158_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= 0 + var_161_2 and arg_158_1.time_ < 0 + var_161_2 + arg_161_0 and not isNil(var_161_1) and arg_158_1.var_.characterEffect1061ui_story then
				arg_158_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_161_4 = 0
			local var_161_5 = 0.825

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_4 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_6 = arg_158_1:GetWordFromCfg(420132038)
				local var_161_7 = arg_158_1:FormatText(var_161_6.content)

				arg_158_1.text_.text = var_161_7

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_9 = 33 <= 0 and var_161_5 or var_161_5 * (utf8.len(var_161_7) / 33)

				if (33 <= 0 and var_161_5 or var_161_5 * (utf8.len(var_161_7) / 33)) > 0 and var_161_5 < var_161_9 then
					arg_158_1.talkMaxDuration = var_161_9

					if var_161_9 + var_161_4 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_9 + var_161_4
					end
				end

				arg_158_1.text_.text = var_161_7
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132038", "story_v_out_420132.awb") ~= 0 then
					local var_161_10 = manager.audio:GetVoiceLength("story_v_out_420132", "420132038", "story_v_out_420132.awb") / 1000

					if var_161_10 + var_161_4 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_10 + var_161_4
					end

					if var_161_6.prefab_name ~= "" and arg_158_1.actors_[var_161_6.prefab_name] ~= nil then
						local var_161_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_6.prefab_name].transform, "story_v_out_420132", "420132038", "story_v_out_420132.awb")

						arg_158_1:RecordAudio("420132038", var_161_11)
						arg_158_1:RecordAudio("420132038", var_161_11)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_420132", "420132038", "story_v_out_420132.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_420132", "420132038", "story_v_out_420132.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_12 = math.max(var_161_5, arg_158_1.talkMaxDuration)

			if var_161_4 <= arg_158_1.time_ and arg_158_1.time_ < var_161_4 + var_161_12 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_4) / var_161_12

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_4 + var_161_12 and arg_158_1.time_ < var_161_4 + var_161_12 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play420132039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 420132039
		arg_162_1.duration_ = 8.5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play420132040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos1061ui_story = arg_162_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_165_0 = 0.001

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 then
				arg_162_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_162_1.time_ - 0) / var_165_0)
				arg_162_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_162_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1061ui_story"].transform.position).z)
				arg_162_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_162_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_162_1.actors_["1061ui_story"].transform.localEulerAngles = arg_162_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 then
				arg_162_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				arg_162_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_162_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1061ui_story"].transform.position).z)
				arg_162_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_162_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_162_1.actors_["1061ui_story"].transform.localEulerAngles = arg_162_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_165_1 = arg_162_1.actors_["1085ui_story"].transform

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos1085ui_story = var_165_1.localPosition
			end

			local var_165_2 = 0.001

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_2 then
				var_165_1.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_162_1.time_ - 0) / var_165_2)
				var_165_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_1.position).x, (manager.ui.mainCamera.transform.position - var_165_1.position).y, (manager.ui.mainCamera.transform.position - var_165_1.position).z)
				var_165_1.localEulerAngles.z = 0
				var_165_1.localEulerAngles.x = 0
				var_165_1.localEulerAngles = var_165_1.localEulerAngles
			end

			if arg_162_1.time_ >= 0 + var_165_2 and arg_162_1.time_ < 0 + var_165_2 + arg_165_0 then
				var_165_1.localPosition = Vector3.New(0.75, -1.01, -5.83)
				var_165_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_1.position).x, (manager.ui.mainCamera.transform.position - var_165_1.position).y, (manager.ui.mainCamera.transform.position - var_165_1.position).z)
				var_165_1.localEulerAngles.z = 0
				var_165_1.localEulerAngles.x = 0
				var_165_1.localEulerAngles = var_165_1.localEulerAngles
			end

			local var_165_3 = arg_162_1.actors_["1085ui_story"]

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(var_165_3) and arg_162_1.var_.characterEffect1085ui_story == nil then
				arg_162_1.var_.characterEffect1085ui_story = var_165_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_4 = 0.200000002980232

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_4 and not isNil(var_165_3) then
				if arg_162_1.var_.characterEffect1085ui_story and not isNil(var_165_3) then
					arg_162_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= 0 + var_165_4 and arg_162_1.time_ < 0 + var_165_4 + arg_165_0 and not isNil(var_165_3) and arg_162_1.var_.characterEffect1085ui_story then
				arg_162_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_165_6 = arg_162_1.actors_["1061ui_story"]

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(var_165_6) and arg_162_1.var_.characterEffect1061ui_story == nil then
				arg_162_1.var_.characterEffect1061ui_story = var_165_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_7 = 0.200000002980232

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_7 and not isNil(var_165_6) then
				if arg_162_1.var_.characterEffect1061ui_story and not isNil(var_165_6) then
					arg_162_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_162_1.time_ - 0) / var_165_7)
				end
			end

			if arg_162_1.time_ >= 0 + var_165_7 and arg_162_1.time_ < 0 + var_165_7 + arg_165_0 and not isNil(var_165_6) and arg_162_1.var_.characterEffect1061ui_story then
				arg_162_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			local var_165_8 = 0
			local var_165_9 = 0.625

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_8 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_10 = arg_162_1:GetWordFromCfg(420132039)
				local var_165_11 = arg_162_1:FormatText(var_165_10.content)

				arg_162_1.text_.text = var_165_11

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_13 = 25 <= 0 and var_165_9 or var_165_9 * (utf8.len(var_165_11) / 25)

				if (25 <= 0 and var_165_9 or var_165_9 * (utf8.len(var_165_11) / 25)) > 0 and var_165_9 < var_165_13 then
					arg_162_1.talkMaxDuration = var_165_13

					if var_165_13 + var_165_8 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_13 + var_165_8
					end
				end

				arg_162_1.text_.text = var_165_11
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132039", "story_v_out_420132.awb") ~= 0 then
					local var_165_14 = manager.audio:GetVoiceLength("story_v_out_420132", "420132039", "story_v_out_420132.awb") / 1000

					if var_165_14 + var_165_8 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_14 + var_165_8
					end

					if var_165_10.prefab_name ~= "" and arg_162_1.actors_[var_165_10.prefab_name] ~= nil then
						local var_165_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_10.prefab_name].transform, "story_v_out_420132", "420132039", "story_v_out_420132.awb")

						arg_162_1:RecordAudio("420132039", var_165_15)
						arg_162_1:RecordAudio("420132039", var_165_15)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_420132", "420132039", "story_v_out_420132.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_420132", "420132039", "story_v_out_420132.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_16 = math.max(var_165_9, arg_162_1.talkMaxDuration)

			if var_165_8 <= arg_162_1.time_ and arg_162_1.time_ < var_165_8 + var_165_16 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_8) / var_165_16

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_8 + var_165_16 and arg_162_1.time_ < var_165_8 + var_165_16 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play420132040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 420132040
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play420132041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos1061ui_story = arg_166_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_169_0 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 then
				arg_166_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_166_1.time_ - 0) / var_169_0)
				arg_166_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_166_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1061ui_story"].transform.position).z)
				arg_166_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_166_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_166_1.actors_["1061ui_story"].transform.localEulerAngles = arg_166_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 then
				arg_166_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_166_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_166_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1061ui_story"].transform.position).z)
				arg_166_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_166_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_166_1.actors_["1061ui_story"].transform.localEulerAngles = arg_166_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_169_1 = arg_166_1.actors_["1085ui_story"].transform

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos1085ui_story = var_169_1.localPosition
			end

			local var_169_2 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_2 then
				var_169_1.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_166_1.time_ - 0) / var_169_2)
				var_169_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_1.position).x, (manager.ui.mainCamera.transform.position - var_169_1.position).y, (manager.ui.mainCamera.transform.position - var_169_1.position).z)
				var_169_1.localEulerAngles.z = 0
				var_169_1.localEulerAngles.x = 0
				var_169_1.localEulerAngles = var_169_1.localEulerAngles
			end

			if arg_166_1.time_ >= 0 + var_169_2 and arg_166_1.time_ < 0 + var_169_2 + arg_169_0 then
				var_169_1.localPosition = Vector3.New(0, 100, 0)
				var_169_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_1.position).x, (manager.ui.mainCamera.transform.position - var_169_1.position).y, (manager.ui.mainCamera.transform.position - var_169_1.position).z)
				var_169_1.localEulerAngles.z = 0
				var_169_1.localEulerAngles.x = 0
				var_169_1.localEulerAngles = var_169_1.localEulerAngles
			end

			local var_169_3 = 0
			local var_169_4 = 0.45

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_3 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_5 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(420132040).content)

				arg_166_1.text_.text = var_169_5

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_7 = 18 <= 0 and var_169_4 or var_169_4 * (utf8.len(var_169_5) / 18)

				if (18 <= 0 and var_169_4 or var_169_4 * (utf8.len(var_169_5) / 18)) > 0 and var_169_4 < var_169_7 then
					arg_166_1.talkMaxDuration = var_169_7

					if var_169_7 + var_169_3 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_7 + var_169_3
					end
				end

				arg_166_1.text_.text = var_169_5
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_8 = math.max(var_169_4, arg_166_1.talkMaxDuration)

			if var_169_3 <= arg_166_1.time_ and arg_166_1.time_ < var_169_3 + var_169_8 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_3) / var_169_8

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_3 + var_169_8 and arg_166_1.time_ < var_169_3 + var_169_8 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play420132041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 420132041
		arg_170_1.duration_ = 3.47

		local var_170_0 = {
			zh = 2.4,
			ja = 3.466
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play420132042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos1061ui_story = arg_170_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_173_0 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 then
				arg_170_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_170_1.time_ - 0) / var_173_0)
				arg_170_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1061ui_story"].transform.position).z)
				arg_170_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["1061ui_story"].transform.localEulerAngles = arg_170_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 then
				arg_170_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_170_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1061ui_story"].transform.position).z)
				arg_170_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["1061ui_story"].transform.localEulerAngles = arg_170_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_173_1 = arg_170_1.actors_["1061ui_story"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_1) and arg_170_1.var_.characterEffect1061ui_story == nil then
				arg_170_1.var_.characterEffect1061ui_story = var_173_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_2 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_2 and not isNil(var_173_1) then
				if arg_170_1.var_.characterEffect1061ui_story and not isNil(var_173_1) then
					arg_170_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= 0 + var_173_2 and arg_170_1.time_ < 0 + var_173_2 + arg_173_0 and not isNil(var_173_1) and arg_170_1.var_.characterEffect1061ui_story then
				arg_170_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_173_4 = 0
			local var_173_5 = 0.3

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_4 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_6 = arg_170_1:GetWordFromCfg(420132041)
				local var_173_7 = arg_170_1:FormatText(var_173_6.content)

				arg_170_1.text_.text = var_173_7

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_9 = 12 <= 0 and var_173_5 or var_173_5 * (utf8.len(var_173_7) / 12)

				if (12 <= 0 and var_173_5 or var_173_5 * (utf8.len(var_173_7) / 12)) > 0 and var_173_5 < var_173_9 then
					arg_170_1.talkMaxDuration = var_173_9

					if var_173_9 + var_173_4 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_9 + var_173_4
					end
				end

				arg_170_1.text_.text = var_173_7
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132041", "story_v_out_420132.awb") ~= 0 then
					local var_173_10 = manager.audio:GetVoiceLength("story_v_out_420132", "420132041", "story_v_out_420132.awb") / 1000

					if var_173_10 + var_173_4 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_10 + var_173_4
					end

					if var_173_6.prefab_name ~= "" and arg_170_1.actors_[var_173_6.prefab_name] ~= nil then
						local var_173_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_6.prefab_name].transform, "story_v_out_420132", "420132041", "story_v_out_420132.awb")

						arg_170_1:RecordAudio("420132041", var_173_11)
						arg_170_1:RecordAudio("420132041", var_173_11)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_420132", "420132041", "story_v_out_420132.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_420132", "420132041", "story_v_out_420132.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_12 = math.max(var_173_5, arg_170_1.talkMaxDuration)

			if var_173_4 <= arg_170_1.time_ and arg_170_1.time_ < var_173_4 + var_173_12 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_4) / var_173_12

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_4 + var_173_12 and arg_170_1.time_ < var_173_4 + var_173_12 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play420132042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 420132042
		arg_174_1.duration_ = 18.83

		local var_174_0 = {
			zh = 12.133,
			ja = 18.833
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play420132043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 1.55

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_1 = arg_174_1:GetWordFromCfg(420132042)
				local var_177_2 = arg_174_1:FormatText(var_177_1.content)

				arg_174_1.text_.text = var_177_2

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_4 = 62 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_2) / 62)

				if (62 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_2) / 62)) > 0 and var_177_0 < var_177_4 then
					arg_174_1.talkMaxDuration = var_177_4

					if var_177_4 + 0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_4 + 0
					end
				end

				arg_174_1.text_.text = var_177_2
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132042", "story_v_out_420132.awb") ~= 0 then
					local var_177_5 = manager.audio:GetVoiceLength("story_v_out_420132", "420132042", "story_v_out_420132.awb") / 1000

					if var_177_5 + 0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_5 + 0
					end

					if var_177_1.prefab_name ~= "" and arg_174_1.actors_[var_177_1.prefab_name] ~= nil then
						local var_177_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_1.prefab_name].transform, "story_v_out_420132", "420132042", "story_v_out_420132.awb")

						arg_174_1:RecordAudio("420132042", var_177_6)
						arg_174_1:RecordAudio("420132042", var_177_6)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_420132", "420132042", "story_v_out_420132.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_420132", "420132042", "story_v_out_420132.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_7 = math.max(var_177_0, arg_174_1.talkMaxDuration)

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_7 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - 0) / var_177_7

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= 0 + var_177_7 and arg_174_1.time_ < 0 + var_177_7 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play420132043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 420132043
		arg_178_1.duration_ = 9.4

		local var_178_0 = {
			zh = 6.933,
			ja = 9.4
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
				arg_178_0:Play420132044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0.65

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_1 = arg_178_1:GetWordFromCfg(420132043)
				local var_181_2 = arg_178_1:FormatText(var_181_1.content)

				arg_178_1.text_.text = var_181_2

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_4 = 26 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_2) / 26)

				if (26 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_2) / 26)) > 0 and var_181_0 < var_181_4 then
					arg_178_1.talkMaxDuration = var_181_4

					if var_181_4 + 0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_4 + 0
					end
				end

				arg_178_1.text_.text = var_181_2
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132043", "story_v_out_420132.awb") ~= 0 then
					local var_181_5 = manager.audio:GetVoiceLength("story_v_out_420132", "420132043", "story_v_out_420132.awb") / 1000

					if var_181_5 + 0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_5 + 0
					end

					if var_181_1.prefab_name ~= "" and arg_178_1.actors_[var_181_1.prefab_name] ~= nil then
						local var_181_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_1.prefab_name].transform, "story_v_out_420132", "420132043", "story_v_out_420132.awb")

						arg_178_1:RecordAudio("420132043", var_181_6)
						arg_178_1:RecordAudio("420132043", var_181_6)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_420132", "420132043", "story_v_out_420132.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_420132", "420132043", "story_v_out_420132.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_7 = math.max(var_181_0, arg_178_1.talkMaxDuration)

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_7 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - 0) / var_181_7

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= 0 + var_181_7 and arg_178_1.time_ < 0 + var_181_7 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play420132044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 420132044
		arg_182_1.duration_ = 8.8

		local var_182_0 = {
			zh = 8.433,
			ja = 8.8
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play420132045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0.925

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_1 = arg_182_1:GetWordFromCfg(420132044)
				local var_185_2 = arg_182_1:FormatText(var_185_1.content)

				arg_182_1.text_.text = var_185_2

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_4 = 37 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_2) / 37)

				if (37 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_2) / 37)) > 0 and var_185_0 < var_185_4 then
					arg_182_1.talkMaxDuration = var_185_4

					if var_185_4 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_4 + 0
					end
				end

				arg_182_1.text_.text = var_185_2
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132044", "story_v_out_420132.awb") ~= 0 then
					local var_185_5 = manager.audio:GetVoiceLength("story_v_out_420132", "420132044", "story_v_out_420132.awb") / 1000

					if var_185_5 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_5 + 0
					end

					if var_185_1.prefab_name ~= "" and arg_182_1.actors_[var_185_1.prefab_name] ~= nil then
						local var_185_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_1.prefab_name].transform, "story_v_out_420132", "420132044", "story_v_out_420132.awb")

						arg_182_1:RecordAudio("420132044", var_185_6)
						arg_182_1:RecordAudio("420132044", var_185_6)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_420132", "420132044", "story_v_out_420132.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_420132", "420132044", "story_v_out_420132.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_7 = math.max(var_185_0, arg_182_1.talkMaxDuration)

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_7 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - 0) / var_185_7

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= 0 + var_185_7 and arg_182_1.time_ < 0 + var_185_7 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play420132045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 420132045
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play420132046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos1061ui_story = arg_186_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_189_0 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 then
				arg_186_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_186_1.time_ - 0) / var_189_0)
				arg_186_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1061ui_story"].transform.position).z)
				arg_186_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["1061ui_story"].transform.localEulerAngles = arg_186_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 then
				arg_186_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_186_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1061ui_story"].transform.position).z)
				arg_186_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["1061ui_story"].transform.localEulerAngles = arg_186_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_189_1 = 0
			local var_189_2 = 1.1

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_3 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(420132045).content)

				arg_186_1.text_.text = var_189_3

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_5 = 44 <= 0 and var_189_2 or var_189_2 * (utf8.len(var_189_3) / 44)

				if (44 <= 0 and var_189_2 or var_189_2 * (utf8.len(var_189_3) / 44)) > 0 and var_189_2 < var_189_5 then
					arg_186_1.talkMaxDuration = var_189_5

					if var_189_5 + var_189_1 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_5 + var_189_1
					end
				end

				arg_186_1.text_.text = var_189_3
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_6 = math.max(var_189_2, arg_186_1.talkMaxDuration)

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_6 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_1) / var_189_6

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_1 + var_189_6 and arg_186_1.time_ < var_189_1 + var_189_6 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play420132046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 420132046
		arg_190_1.duration_ = 5.47

		local var_190_0 = {
			zh = 3.866,
			ja = 5.466
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
				arg_190_0:Play420132047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos1085ui_story = arg_190_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_193_0 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 then
				arg_190_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_190_1.time_ - 0) / var_193_0)
				arg_190_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1085ui_story"].transform.position).z)
				arg_190_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1085ui_story"].transform.localEulerAngles = arg_190_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 then
				arg_190_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_190_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1085ui_story"].transform.position).z)
				arg_190_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1085ui_story"].transform.localEulerAngles = arg_190_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_193_1 = arg_190_1.actors_["1085ui_story"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1085ui_story == nil then
				arg_190_1.var_.characterEffect1085ui_story = var_193_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_2 and not isNil(var_193_1) then
				if arg_190_1.var_.characterEffect1085ui_story and not isNil(var_193_1) then
					arg_190_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= 0 + var_193_2 and arg_190_1.time_ < 0 + var_193_2 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1085ui_story then
				arg_190_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_193_4 = 0
			local var_193_5 = 0.25

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_4 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_6 = arg_190_1:GetWordFromCfg(420132046)
				local var_193_7 = arg_190_1:FormatText(var_193_6.content)

				arg_190_1.text_.text = var_193_7

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_9 = 10 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 10)

				if (10 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 10)) > 0 and var_193_5 < var_193_9 then
					arg_190_1.talkMaxDuration = var_193_9

					if var_193_9 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_9 + var_193_4
					end
				end

				arg_190_1.text_.text = var_193_7
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132046", "story_v_out_420132.awb") ~= 0 then
					local var_193_10 = manager.audio:GetVoiceLength("story_v_out_420132", "420132046", "story_v_out_420132.awb") / 1000

					if var_193_10 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_10 + var_193_4
					end

					if var_193_6.prefab_name ~= "" and arg_190_1.actors_[var_193_6.prefab_name] ~= nil then
						local var_193_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_6.prefab_name].transform, "story_v_out_420132", "420132046", "story_v_out_420132.awb")

						arg_190_1:RecordAudio("420132046", var_193_11)
						arg_190_1:RecordAudio("420132046", var_193_11)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_420132", "420132046", "story_v_out_420132.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_420132", "420132046", "story_v_out_420132.awb")
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
				actorName = "1085ui_story",
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
	Play420132047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 420132047
		arg_194_1.duration_ = 8.67

		local var_194_0 = {
			zh = 5.1,
			ja = 8.666
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
				arg_194_0:Play420132048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos1085ui_story = arg_194_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_197_0 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 then
				arg_194_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_194_1.time_ - 0) / var_197_0)
				arg_194_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_194_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["1085ui_story"].transform.position).z)
				arg_194_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_194_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_194_1.actors_["1085ui_story"].transform.localEulerAngles = arg_194_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 then
				arg_194_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_194_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_194_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["1085ui_story"].transform.position).z)
				arg_194_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_194_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_194_1.actors_["1085ui_story"].transform.localEulerAngles = arg_194_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_197_1 = arg_194_1.actors_["1061ui_story"].transform

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos1061ui_story = var_197_1.localPosition
			end

			local var_197_2 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_2 then
				var_197_1.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_194_1.time_ - 0) / var_197_2)
				var_197_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_1.position).x, (manager.ui.mainCamera.transform.position - var_197_1.position).y, (manager.ui.mainCamera.transform.position - var_197_1.position).z)
				var_197_1.localEulerAngles.z = 0
				var_197_1.localEulerAngles.x = 0
				var_197_1.localEulerAngles = var_197_1.localEulerAngles
			end

			if arg_194_1.time_ >= 0 + var_197_2 and arg_194_1.time_ < 0 + var_197_2 + arg_197_0 then
				var_197_1.localPosition = Vector3.New(0, -1.18, -6.15)
				var_197_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_1.position).x, (manager.ui.mainCamera.transform.position - var_197_1.position).y, (manager.ui.mainCamera.transform.position - var_197_1.position).z)
				var_197_1.localEulerAngles.z = 0
				var_197_1.localEulerAngles.x = 0
				var_197_1.localEulerAngles = var_197_1.localEulerAngles
			end

			local var_197_3 = arg_194_1.actors_["1061ui_story"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_3) and arg_194_1.var_.characterEffect1061ui_story == nil then
				arg_194_1.var_.characterEffect1061ui_story = var_197_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_4 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_4 and not isNil(var_197_3) then
				if arg_194_1.var_.characterEffect1061ui_story and not isNil(var_197_3) then
					arg_194_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= 0 + var_197_4 and arg_194_1.time_ < 0 + var_197_4 + arg_197_0 and not isNil(var_197_3) and arg_194_1.var_.characterEffect1061ui_story then
				arg_194_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_197_6 = arg_194_1.actors_["1085ui_story"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_6) and arg_194_1.var_.characterEffect1085ui_story == nil then
				arg_194_1.var_.characterEffect1085ui_story = var_197_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_7 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_7 and not isNil(var_197_6) then
				if arg_194_1.var_.characterEffect1085ui_story and not isNil(var_197_6) then
					arg_194_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_194_1.time_ - 0) / var_197_7)
				end
			end

			if arg_194_1.time_ >= 0 + var_197_7 and arg_194_1.time_ < 0 + var_197_7 + arg_197_0 and not isNil(var_197_6) and arg_194_1.var_.characterEffect1085ui_story then
				arg_194_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_197_8 = 0
			local var_197_9 = 0.475

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_8 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_10 = arg_194_1:GetWordFromCfg(420132047)
				local var_197_11 = arg_194_1:FormatText(var_197_10.content)

				arg_194_1.text_.text = var_197_11

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_13 = 19 <= 0 and var_197_9 or var_197_9 * (utf8.len(var_197_11) / 19)

				if (19 <= 0 and var_197_9 or var_197_9 * (utf8.len(var_197_11) / 19)) > 0 and var_197_9 < var_197_13 then
					arg_194_1.talkMaxDuration = var_197_13

					if var_197_13 + var_197_8 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_13 + var_197_8
					end
				end

				arg_194_1.text_.text = var_197_11
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132047", "story_v_out_420132.awb") ~= 0 then
					local var_197_14 = manager.audio:GetVoiceLength("story_v_out_420132", "420132047", "story_v_out_420132.awb") / 1000

					if var_197_14 + var_197_8 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_14 + var_197_8
					end

					if var_197_10.prefab_name ~= "" and arg_194_1.actors_[var_197_10.prefab_name] ~= nil then
						local var_197_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_10.prefab_name].transform, "story_v_out_420132", "420132047", "story_v_out_420132.awb")

						arg_194_1:RecordAudio("420132047", var_197_15)
						arg_194_1:RecordAudio("420132047", var_197_15)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_420132", "420132047", "story_v_out_420132.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_420132", "420132047", "story_v_out_420132.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_16 = math.max(var_197_9, arg_194_1.talkMaxDuration)

			if var_197_8 <= arg_194_1.time_ and arg_194_1.time_ < var_197_8 + var_197_16 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_8) / var_197_16

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_8 + var_197_16 and arg_194_1.time_ < var_197_8 + var_197_16 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play420132048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 420132048
		arg_198_1.duration_ = 12.27

		local var_198_0 = {
			zh = 9.5,
			ja = 12.266
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play420132049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos1061ui_story = arg_198_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_201_0 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 then
				arg_198_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_198_1.time_ - 0) / var_201_0)
				arg_198_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1061ui_story"].transform.position).z)
				arg_198_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1061ui_story"].transform.localEulerAngles = arg_198_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 then
				arg_198_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				arg_198_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1061ui_story"].transform.position).z)
				arg_198_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1061ui_story"].transform.localEulerAngles = arg_198_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_201_1 = arg_198_1.actors_["1085ui_story"].transform

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos1085ui_story = var_201_1.localPosition
			end

			local var_201_2 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_2 then
				var_201_1.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_198_1.time_ - 0) / var_201_2)
				var_201_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_201_1.position).x, (manager.ui.mainCamera.transform.position - var_201_1.position).y, (manager.ui.mainCamera.transform.position - var_201_1.position).z)
				var_201_1.localEulerAngles.z = 0
				var_201_1.localEulerAngles.x = 0
				var_201_1.localEulerAngles = var_201_1.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_2 and arg_198_1.time_ < 0 + var_201_2 + arg_201_0 then
				var_201_1.localPosition = Vector3.New(0.75, -1.01, -5.83)
				var_201_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_201_1.position).x, (manager.ui.mainCamera.transform.position - var_201_1.position).y, (manager.ui.mainCamera.transform.position - var_201_1.position).z)
				var_201_1.localEulerAngles.z = 0
				var_201_1.localEulerAngles.x = 0
				var_201_1.localEulerAngles = var_201_1.localEulerAngles
			end

			local var_201_3 = arg_198_1.actors_["1085ui_story"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_3) and arg_198_1.var_.characterEffect1085ui_story == nil then
				arg_198_1.var_.characterEffect1085ui_story = var_201_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_4 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_4 and not isNil(var_201_3) then
				if arg_198_1.var_.characterEffect1085ui_story and not isNil(var_201_3) then
					arg_198_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= 0 + var_201_4 and arg_198_1.time_ < 0 + var_201_4 + arg_201_0 and not isNil(var_201_3) and arg_198_1.var_.characterEffect1085ui_story then
				arg_198_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_201_6 = arg_198_1.actors_["1061ui_story"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_6) and arg_198_1.var_.characterEffect1061ui_story == nil then
				arg_198_1.var_.characterEffect1061ui_story = var_201_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_7 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_7 and not isNil(var_201_6) then
				if arg_198_1.var_.characterEffect1061ui_story and not isNil(var_201_6) then
					arg_198_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_198_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_198_1.time_ - 0) / var_201_7)
				end
			end

			if arg_198_1.time_ >= 0 + var_201_7 and arg_198_1.time_ < 0 + var_201_7 + arg_201_0 and not isNil(var_201_6) and arg_198_1.var_.characterEffect1061ui_story then
				arg_198_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_198_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_201_8 = 0
			local var_201_9 = 0.775

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_8 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_10 = arg_198_1:GetWordFromCfg(420132048)
				local var_201_11 = arg_198_1:FormatText(var_201_10.content)

				arg_198_1.text_.text = var_201_11

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_13 = 31 <= 0 and var_201_9 or var_201_9 * (utf8.len(var_201_11) / 31)

				if (31 <= 0 and var_201_9 or var_201_9 * (utf8.len(var_201_11) / 31)) > 0 and var_201_9 < var_201_13 then
					arg_198_1.talkMaxDuration = var_201_13

					if var_201_13 + var_201_8 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_13 + var_201_8
					end
				end

				arg_198_1.text_.text = var_201_11
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132048", "story_v_out_420132.awb") ~= 0 then
					local var_201_14 = manager.audio:GetVoiceLength("story_v_out_420132", "420132048", "story_v_out_420132.awb") / 1000

					if var_201_14 + var_201_8 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_14 + var_201_8
					end

					if var_201_10.prefab_name ~= "" and arg_198_1.actors_[var_201_10.prefab_name] ~= nil then
						local var_201_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_10.prefab_name].transform, "story_v_out_420132", "420132048", "story_v_out_420132.awb")

						arg_198_1:RecordAudio("420132048", var_201_15)
						arg_198_1:RecordAudio("420132048", var_201_15)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_420132", "420132048", "story_v_out_420132.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_420132", "420132048", "story_v_out_420132.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_16 = math.max(var_201_9, arg_198_1.talkMaxDuration)

			if var_201_8 <= arg_198_1.time_ and arg_198_1.time_ < var_201_8 + var_201_16 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_8) / var_201_16

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_8 + var_201_16 and arg_198_1.time_ < var_201_8 + var_201_16 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420132049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 420132049
		arg_202_1.duration_ = 12.83

		local var_202_0 = {
			zh = 7.133,
			ja = 12.833
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
				arg_202_0:Play420132050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["1061ui_story"]) and arg_202_1.var_.characterEffect1061ui_story == nil then
				arg_202_1.var_.characterEffect1061ui_story = arg_202_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_0 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["1061ui_story"]) then
				if arg_202_1.var_.characterEffect1061ui_story and not isNil(arg_202_1.actors_["1061ui_story"]) then
					arg_202_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["1061ui_story"]) and arg_202_1.var_.characterEffect1061ui_story then
				arg_202_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_205_2 = arg_202_1.actors_["1085ui_story"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_2) and arg_202_1.var_.characterEffect1085ui_story == nil then
				arg_202_1.var_.characterEffect1085ui_story = var_205_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_3 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_3 and not isNil(var_205_2) then
				if arg_202_1.var_.characterEffect1085ui_story and not isNil(var_205_2) then
					arg_202_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_3)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_3 and arg_202_1.time_ < 0 + var_205_3 + arg_205_0 and not isNil(var_205_2) and arg_202_1.var_.characterEffect1085ui_story then
				arg_202_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_205_4 = 0
			local var_205_5 = 0.775

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_4 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_6 = arg_202_1:GetWordFromCfg(420132049)
				local var_205_7 = arg_202_1:FormatText(var_205_6.content)

				arg_202_1.text_.text = var_205_7

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_9 = 31 <= 0 and var_205_5 or var_205_5 * (utf8.len(var_205_7) / 31)

				if (31 <= 0 and var_205_5 or var_205_5 * (utf8.len(var_205_7) / 31)) > 0 and var_205_5 < var_205_9 then
					arg_202_1.talkMaxDuration = var_205_9

					if var_205_9 + var_205_4 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_9 + var_205_4
					end
				end

				arg_202_1.text_.text = var_205_7
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132049", "story_v_out_420132.awb") ~= 0 then
					local var_205_10 = manager.audio:GetVoiceLength("story_v_out_420132", "420132049", "story_v_out_420132.awb") / 1000

					if var_205_10 + var_205_4 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_10 + var_205_4
					end

					if var_205_6.prefab_name ~= "" and arg_202_1.actors_[var_205_6.prefab_name] ~= nil then
						local var_205_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_6.prefab_name].transform, "story_v_out_420132", "420132049", "story_v_out_420132.awb")

						arg_202_1:RecordAudio("420132049", var_205_11)
						arg_202_1:RecordAudio("420132049", var_205_11)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_420132", "420132049", "story_v_out_420132.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_420132", "420132049", "story_v_out_420132.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_12 = math.max(var_205_5, arg_202_1.talkMaxDuration)

			if var_205_4 <= arg_202_1.time_ and arg_202_1.time_ < var_205_4 + var_205_12 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_4) / var_205_12

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_4 + var_205_12 and arg_202_1.time_ < var_205_4 + var_205_12 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play420132050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 420132050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play420132051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1061ui_story = arg_206_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_209_0 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 then
				arg_206_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_206_1.time_ - 0) / var_209_0)
				arg_206_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1061ui_story"].transform.position).z)
				arg_206_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["1061ui_story"].transform.localEulerAngles = arg_206_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 then
				arg_206_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_206_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1061ui_story"].transform.position).z)
				arg_206_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["1061ui_story"].transform.localEulerAngles = arg_206_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_209_1 = arg_206_1.actors_["1085ui_story"].transform

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1085ui_story = var_209_1.localPosition
			end

			local var_209_2 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_2 then
				var_209_1.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_206_1.time_ - 0) / var_209_2)
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

			local var_209_3 = 0
			local var_209_4 = 1.9

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_3 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_5 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(420132050).content)

				arg_206_1.text_.text = var_209_5

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_7 = 76 <= 0 and var_209_4 or var_209_4 * (utf8.len(var_209_5) / 76)

				if (76 <= 0 and var_209_4 or var_209_4 * (utf8.len(var_209_5) / 76)) > 0 and var_209_4 < var_209_7 then
					arg_206_1.talkMaxDuration = var_209_7

					if var_209_7 + var_209_3 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_7 + var_209_3
					end
				end

				arg_206_1.text_.text = var_209_5
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_8 = math.max(var_209_4, arg_206_1.talkMaxDuration)

			if var_209_3 <= arg_206_1.time_ and arg_206_1.time_ < var_209_3 + var_209_8 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_3) / var_209_8

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_3 + var_209_8 and arg_206_1.time_ < var_209_3 + var_209_8 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420132051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 420132051
		arg_210_1.duration_ = 6.77

		local var_210_0 = {
			zh = 4,
			ja = 6.766
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play420132052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos1061ui_story = arg_210_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_213_0 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 then
				arg_210_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_210_1.time_ - 0) / var_213_0)
				arg_210_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1061ui_story"].transform.position).z)
				arg_210_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["1061ui_story"].transform.localEulerAngles = arg_210_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 then
				arg_210_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_210_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1061ui_story"].transform.position).z)
				arg_210_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["1061ui_story"].transform.localEulerAngles = arg_210_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_213_1 = arg_210_1.actors_["1061ui_story"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_1) and arg_210_1.var_.characterEffect1061ui_story == nil then
				arg_210_1.var_.characterEffect1061ui_story = var_213_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_2 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_2 and not isNil(var_213_1) then
				if arg_210_1.var_.characterEffect1061ui_story and not isNil(var_213_1) then
					arg_210_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= 0 + var_213_2 and arg_210_1.time_ < 0 + var_213_2 + arg_213_0 and not isNil(var_213_1) and arg_210_1.var_.characterEffect1061ui_story then
				arg_210_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			local var_213_4 = 0
			local var_213_5 = 0.425

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_4 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_6 = arg_210_1:GetWordFromCfg(420132051)
				local var_213_7 = arg_210_1:FormatText(var_213_6.content)

				arg_210_1.text_.text = var_213_7

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_9 = 17 <= 0 and var_213_5 or var_213_5 * (utf8.len(var_213_7) / 17)

				if (17 <= 0 and var_213_5 or var_213_5 * (utf8.len(var_213_7) / 17)) > 0 and var_213_5 < var_213_9 then
					arg_210_1.talkMaxDuration = var_213_9

					if var_213_9 + var_213_4 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_9 + var_213_4
					end
				end

				arg_210_1.text_.text = var_213_7
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132051", "story_v_out_420132.awb") ~= 0 then
					local var_213_10 = manager.audio:GetVoiceLength("story_v_out_420132", "420132051", "story_v_out_420132.awb") / 1000

					if var_213_10 + var_213_4 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_10 + var_213_4
					end

					if var_213_6.prefab_name ~= "" and arg_210_1.actors_[var_213_6.prefab_name] ~= nil then
						local var_213_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_6.prefab_name].transform, "story_v_out_420132", "420132051", "story_v_out_420132.awb")

						arg_210_1:RecordAudio("420132051", var_213_11)
						arg_210_1:RecordAudio("420132051", var_213_11)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_420132", "420132051", "story_v_out_420132.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_420132", "420132051", "story_v_out_420132.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_12 = math.max(var_213_5, arg_210_1.talkMaxDuration)

			if var_213_4 <= arg_210_1.time_ and arg_210_1.time_ < var_213_4 + var_213_12 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_4) / var_213_12

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_4 + var_213_12 and arg_210_1.time_ < var_213_4 + var_213_12 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play420132052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 420132052
		arg_214_1.duration_ = 2.37

		local var_214_0 = {
			zh = 1.999999999999,
			ja = 2.366
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
				arg_214_0:Play420132053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos1061ui_story = arg_214_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_217_0 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 then
				arg_214_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_214_1.time_ - 0) / var_217_0)
				arg_214_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1061ui_story"].transform.position).z)
				arg_214_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["1061ui_story"].transform.localEulerAngles = arg_214_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 then
				arg_214_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				arg_214_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1061ui_story"].transform.position).z)
				arg_214_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["1061ui_story"].transform.localEulerAngles = arg_214_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_217_1 = arg_214_1.actors_["1061ui_story"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_1) and arg_214_1.var_.characterEffect1061ui_story == nil then
				arg_214_1.var_.characterEffect1061ui_story = var_217_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_2 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_2 and not isNil(var_217_1) then
				if arg_214_1.var_.characterEffect1061ui_story and not isNil(var_217_1) then
					arg_214_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_214_1.time_ - 0) / var_217_2)
				end
			end

			if arg_214_1.time_ >= 0 + var_217_2 and arg_214_1.time_ < 0 + var_217_2 + arg_217_0 and not isNil(var_217_1) and arg_214_1.var_.characterEffect1061ui_story then
				arg_214_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_217_3 = arg_214_1.actors_["1085ui_story"].transform

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos1085ui_story = var_217_3.localPosition
			end

			local var_217_4 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_4 then
				var_217_3.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_214_1.time_ - 0) / var_217_4)
				var_217_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_217_3.position).x, (manager.ui.mainCamera.transform.position - var_217_3.position).y, (manager.ui.mainCamera.transform.position - var_217_3.position).z)
				var_217_3.localEulerAngles.z = 0
				var_217_3.localEulerAngles.x = 0
				var_217_3.localEulerAngles = var_217_3.localEulerAngles
			end

			if arg_214_1.time_ >= 0 + var_217_4 and arg_214_1.time_ < 0 + var_217_4 + arg_217_0 then
				var_217_3.localPosition = Vector3.New(0.75, -1.01, -5.83)
				var_217_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_217_3.position).x, (manager.ui.mainCamera.transform.position - var_217_3.position).y, (manager.ui.mainCamera.transform.position - var_217_3.position).z)
				var_217_3.localEulerAngles.z = 0
				var_217_3.localEulerAngles.x = 0
				var_217_3.localEulerAngles = var_217_3.localEulerAngles
			end

			local var_217_5 = arg_214_1.actors_["1085ui_story"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_5) and arg_214_1.var_.characterEffect1085ui_story == nil then
				arg_214_1.var_.characterEffect1085ui_story = var_217_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_6 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_6 and not isNil(var_217_5) then
				if arg_214_1.var_.characterEffect1085ui_story and not isNil(var_217_5) then
					arg_214_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= 0 + var_217_6 and arg_214_1.time_ < 0 + var_217_6 + arg_217_0 and not isNil(var_217_5) and arg_214_1.var_.characterEffect1085ui_story then
				arg_214_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_217_8 = 0
			local var_217_9 = 0.15

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_8 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_10 = arg_214_1:GetWordFromCfg(420132052)
				local var_217_11 = arg_214_1:FormatText(var_217_10.content)

				arg_214_1.text_.text = var_217_11

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_13 = 6 <= 0 and var_217_9 or var_217_9 * (utf8.len(var_217_11) / 6)

				if (6 <= 0 and var_217_9 or var_217_9 * (utf8.len(var_217_11) / 6)) > 0 and var_217_9 < var_217_13 then
					arg_214_1.talkMaxDuration = var_217_13

					if var_217_13 + var_217_8 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_13 + var_217_8
					end
				end

				arg_214_1.text_.text = var_217_11
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132052", "story_v_out_420132.awb") ~= 0 then
					local var_217_14 = manager.audio:GetVoiceLength("story_v_out_420132", "420132052", "story_v_out_420132.awb") / 1000

					if var_217_14 + var_217_8 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_14 + var_217_8
					end

					if var_217_10.prefab_name ~= "" and arg_214_1.actors_[var_217_10.prefab_name] ~= nil then
						local var_217_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_10.prefab_name].transform, "story_v_out_420132", "420132052", "story_v_out_420132.awb")

						arg_214_1:RecordAudio("420132052", var_217_15)
						arg_214_1:RecordAudio("420132052", var_217_15)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_420132", "420132052", "story_v_out_420132.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_420132", "420132052", "story_v_out_420132.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_16 = math.max(var_217_9, arg_214_1.talkMaxDuration)

			if var_217_8 <= arg_214_1.time_ and arg_214_1.time_ < var_217_8 + var_217_16 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_8) / var_217_16

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_8 + var_217_16 and arg_214_1.time_ < var_217_8 + var_217_16 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play420132053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 420132053
		arg_218_1.duration_ = 11.2

		local var_218_0 = {
			zh = 8.866,
			ja = 11.2
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
				arg_218_0:Play420132054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["1061ui_story"]) and arg_218_1.var_.characterEffect1061ui_story == nil then
				arg_218_1.var_.characterEffect1061ui_story = arg_218_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_0 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["1061ui_story"]) then
				if arg_218_1.var_.characterEffect1061ui_story and not isNil(arg_218_1.actors_["1061ui_story"]) then
					arg_218_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["1061ui_story"]) and arg_218_1.var_.characterEffect1061ui_story then
				arg_218_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_221_2 = arg_218_1.actors_["1061ui_story"].transform

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos1061ui_story = var_221_2.localPosition
			end

			local var_221_3 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_3 then
				var_221_2.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_218_1.time_ - 0) / var_221_3)
				var_221_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_2.position).x, (manager.ui.mainCamera.transform.position - var_221_2.position).y, (manager.ui.mainCamera.transform.position - var_221_2.position).z)
				var_221_2.localEulerAngles.z = 0
				var_221_2.localEulerAngles.x = 0
				var_221_2.localEulerAngles = var_221_2.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_3 and arg_218_1.time_ < 0 + var_221_3 + arg_221_0 then
				var_221_2.localPosition = Vector3.New(0, -1.18, -6.15)
				var_221_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_2.position).x, (manager.ui.mainCamera.transform.position - var_221_2.position).y, (manager.ui.mainCamera.transform.position - var_221_2.position).z)
				var_221_2.localEulerAngles.z = 0
				var_221_2.localEulerAngles.x = 0
				var_221_2.localEulerAngles = var_221_2.localEulerAngles
			end

			local var_221_4 = arg_218_1.actors_["1085ui_story"].transform

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos1085ui_story = var_221_4.localPosition
			end

			local var_221_5 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_5 then
				var_221_4.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_218_1.time_ - 0) / var_221_5)
				var_221_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_4.position).x, (manager.ui.mainCamera.transform.position - var_221_4.position).y, (manager.ui.mainCamera.transform.position - var_221_4.position).z)
				var_221_4.localEulerAngles.z = 0
				var_221_4.localEulerAngles.x = 0
				var_221_4.localEulerAngles = var_221_4.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_5 and arg_218_1.time_ < 0 + var_221_5 + arg_221_0 then
				var_221_4.localPosition = Vector3.New(0, 100, 0)
				var_221_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_4.position).x, (manager.ui.mainCamera.transform.position - var_221_4.position).y, (manager.ui.mainCamera.transform.position - var_221_4.position).z)
				var_221_4.localEulerAngles.z = 0
				var_221_4.localEulerAngles.x = 0
				var_221_4.localEulerAngles = var_221_4.localEulerAngles
			end

			local var_221_6 = 0
			local var_221_7 = 0.9

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_6 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_8 = arg_218_1:GetWordFromCfg(420132053)
				local var_221_9 = arg_218_1:FormatText(var_221_8.content)

				arg_218_1.text_.text = var_221_9

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_11 = 36 <= 0 and var_221_7 or var_221_7 * (utf8.len(var_221_9) / 36)

				if (36 <= 0 and var_221_7 or var_221_7 * (utf8.len(var_221_9) / 36)) > 0 and var_221_7 < var_221_11 then
					arg_218_1.talkMaxDuration = var_221_11

					if var_221_11 + var_221_6 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_11 + var_221_6
					end
				end

				arg_218_1.text_.text = var_221_9
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132053", "story_v_out_420132.awb") ~= 0 then
					local var_221_12 = manager.audio:GetVoiceLength("story_v_out_420132", "420132053", "story_v_out_420132.awb") / 1000

					if var_221_12 + var_221_6 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_12 + var_221_6
					end

					if var_221_8.prefab_name ~= "" and arg_218_1.actors_[var_221_8.prefab_name] ~= nil then
						local var_221_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_8.prefab_name].transform, "story_v_out_420132", "420132053", "story_v_out_420132.awb")

						arg_218_1:RecordAudio("420132053", var_221_13)
						arg_218_1:RecordAudio("420132053", var_221_13)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_420132", "420132053", "story_v_out_420132.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_420132", "420132053", "story_v_out_420132.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_14 = math.max(var_221_7, arg_218_1.talkMaxDuration)

			if var_221_6 <= arg_218_1.time_ and arg_218_1.time_ < var_221_6 + var_221_14 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_6) / var_221_14

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_6 + var_221_14 and arg_218_1.time_ < var_221_6 + var_221_14 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play420132054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 420132054
		arg_222_1.duration_ = 13.8

		local var_222_0 = {
			zh = 9.2,
			ja = 13.8
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play420132055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 1.25

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_1 = arg_222_1:GetWordFromCfg(420132054)
				local var_225_2 = arg_222_1:FormatText(var_225_1.content)

				arg_222_1.text_.text = var_225_2

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_4 = 50 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_2) / 50)

				if (50 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_2) / 50)) > 0 and var_225_0 < var_225_4 then
					arg_222_1.talkMaxDuration = var_225_4

					if var_225_4 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_4 + 0
					end
				end

				arg_222_1.text_.text = var_225_2
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132054", "story_v_out_420132.awb") ~= 0 then
					local var_225_5 = manager.audio:GetVoiceLength("story_v_out_420132", "420132054", "story_v_out_420132.awb") / 1000

					if var_225_5 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_5 + 0
					end

					if var_225_1.prefab_name ~= "" and arg_222_1.actors_[var_225_1.prefab_name] ~= nil then
						local var_225_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_1.prefab_name].transform, "story_v_out_420132", "420132054", "story_v_out_420132.awb")

						arg_222_1:RecordAudio("420132054", var_225_6)
						arg_222_1:RecordAudio("420132054", var_225_6)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_420132", "420132054", "story_v_out_420132.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_420132", "420132054", "story_v_out_420132.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_7 = math.max(var_225_0, arg_222_1.talkMaxDuration)

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_7 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - 0) / var_225_7

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= 0 + var_225_7 and arg_222_1.time_ < 0 + var_225_7 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play420132055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 420132055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play420132056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["1061ui_story"]) and arg_226_1.var_.characterEffect1061ui_story == nil then
				arg_226_1.var_.characterEffect1061ui_story = arg_226_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_0 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["1061ui_story"]) then
				if arg_226_1.var_.characterEffect1061ui_story and not isNil(arg_226_1.actors_["1061ui_story"]) then
					arg_226_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_226_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_226_1.time_ - 0) / var_229_0)
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["1061ui_story"]) and arg_226_1.var_.characterEffect1061ui_story then
				arg_226_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_226_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_229_1 = 0
			local var_229_2 = 0.25

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_3 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(420132055).content)

				arg_226_1.text_.text = var_229_3

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 10 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_3) / 10)

				if (10 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_3) / 10)) > 0 and var_229_2 < var_229_5 then
					arg_226_1.talkMaxDuration = var_229_5

					if var_229_5 + var_229_1 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_5 + var_229_1
					end
				end

				arg_226_1.text_.text = var_229_3
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_6 = math.max(var_229_2, arg_226_1.talkMaxDuration)

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_6 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_1) / var_229_6

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_1 + var_229_6 and arg_226_1.time_ < var_229_1 + var_229_6 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play420132056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 420132056
		arg_230_1.duration_ = 13.07

		local var_230_0 = {
			zh = 9.8,
			ja = 13.066
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
				arg_230_0:Play420132057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["1061ui_story"]) and arg_230_1.var_.characterEffect1061ui_story == nil then
				arg_230_1.var_.characterEffect1061ui_story = arg_230_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_0 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["1061ui_story"]) then
				if arg_230_1.var_.characterEffect1061ui_story and not isNil(arg_230_1.actors_["1061ui_story"]) then
					arg_230_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["1061ui_story"]) and arg_230_1.var_.characterEffect1061ui_story then
				arg_230_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_233_2 = 0
			local var_233_3 = 1.075

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_2 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_4 = arg_230_1:GetWordFromCfg(420132056)
				local var_233_5 = arg_230_1:FormatText(var_233_4.content)

				arg_230_1.text_.text = var_233_5

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_7 = 43 <= 0 and var_233_3 or var_233_3 * (utf8.len(var_233_5) / 43)

				if (43 <= 0 and var_233_3 or var_233_3 * (utf8.len(var_233_5) / 43)) > 0 and var_233_3 < var_233_7 then
					arg_230_1.talkMaxDuration = var_233_7

					if var_233_7 + var_233_2 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_7 + var_233_2
					end
				end

				arg_230_1.text_.text = var_233_5
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132056", "story_v_out_420132.awb") ~= 0 then
					local var_233_8 = manager.audio:GetVoiceLength("story_v_out_420132", "420132056", "story_v_out_420132.awb") / 1000

					if var_233_8 + var_233_2 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_8 + var_233_2
					end

					if var_233_4.prefab_name ~= "" and arg_230_1.actors_[var_233_4.prefab_name] ~= nil then
						local var_233_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_4.prefab_name].transform, "story_v_out_420132", "420132056", "story_v_out_420132.awb")

						arg_230_1:RecordAudio("420132056", var_233_9)
						arg_230_1:RecordAudio("420132056", var_233_9)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_420132", "420132056", "story_v_out_420132.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_420132", "420132056", "story_v_out_420132.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_10 = math.max(var_233_3, arg_230_1.talkMaxDuration)

			if var_233_2 <= arg_230_1.time_ and arg_230_1.time_ < var_233_2 + var_233_10 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_2) / var_233_10

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_2 + var_233_10 and arg_230_1.time_ < var_233_2 + var_233_10 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play420132057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 420132057
		arg_234_1.duration_ = 9.27

		local var_234_0 = {
			zh = 5.433,
			ja = 9.266
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
				arg_234_0:Play420132058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0.65

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_1 = arg_234_1:GetWordFromCfg(420132057)
				local var_237_2 = arg_234_1:FormatText(var_237_1.content)

				arg_234_1.text_.text = var_237_2

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_4 = 26 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_2) / 26)

				if (26 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_2) / 26)) > 0 and var_237_0 < var_237_4 then
					arg_234_1.talkMaxDuration = var_237_4

					if var_237_4 + 0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_4 + 0
					end
				end

				arg_234_1.text_.text = var_237_2
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132057", "story_v_out_420132.awb") ~= 0 then
					local var_237_5 = manager.audio:GetVoiceLength("story_v_out_420132", "420132057", "story_v_out_420132.awb") / 1000

					if var_237_5 + 0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_5 + 0
					end

					if var_237_1.prefab_name ~= "" and arg_234_1.actors_[var_237_1.prefab_name] ~= nil then
						local var_237_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_1.prefab_name].transform, "story_v_out_420132", "420132057", "story_v_out_420132.awb")

						arg_234_1:RecordAudio("420132057", var_237_6)
						arg_234_1:RecordAudio("420132057", var_237_6)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_420132", "420132057", "story_v_out_420132.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_420132", "420132057", "story_v_out_420132.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_7 = math.max(var_237_0, arg_234_1.talkMaxDuration)

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_7 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - 0) / var_237_7

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= 0 + var_237_7 and arg_234_1.time_ < 0 + var_237_7 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play420132058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 420132058
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play420132059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos1061ui_story = arg_238_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_241_0 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 then
				arg_238_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_238_1.time_ - 0) / var_241_0)
				arg_238_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1061ui_story"].transform.position).z)
				arg_238_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["1061ui_story"].transform.localEulerAngles = arg_238_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 then
				arg_238_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_238_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1061ui_story"].transform.position).z)
				arg_238_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["1061ui_story"].transform.localEulerAngles = arg_238_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if 0.05 < arg_238_1.time_ and arg_238_1.time_ <= 0.05 + arg_241_0 then
				arg_238_1:AudioAction("play", "effect", "se_story_140", "se_story_140_arrow", "")
			end

			local var_241_2 = 0
			local var_241_3 = 1.15

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_2 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_4 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(420132058).content)

				arg_238_1.text_.text = var_241_4

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_6 = 46 <= 0 and var_241_3 or var_241_3 * (utf8.len(var_241_4) / 46)

				if (46 <= 0 and var_241_3 or var_241_3 * (utf8.len(var_241_4) / 46)) > 0 and var_241_3 < var_241_6 then
					arg_238_1.talkMaxDuration = var_241_6

					if var_241_6 + var_241_2 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_6 + var_241_2
					end
				end

				arg_238_1.text_.text = var_241_4
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_7 = math.max(var_241_3, arg_238_1.talkMaxDuration)

			if var_241_2 <= arg_238_1.time_ and arg_238_1.time_ < var_241_2 + var_241_7 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_2) / var_241_7

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_2 + var_241_7 and arg_238_1.time_ < var_241_2 + var_241_7 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play420132059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 420132059
		arg_242_1.duration_ = 17.4

		local var_242_0 = {
			zh = 11.933,
			ja = 17.4
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play420132060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(arg_242_1.actors_["1061ui_story"]) and arg_242_1.var_.characterEffect1061ui_story == nil then
				arg_242_1.var_.characterEffect1061ui_story = arg_242_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_0 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 and not isNil(arg_242_1.actors_["1061ui_story"]) then
				if arg_242_1.var_.characterEffect1061ui_story and not isNil(arg_242_1.actors_["1061ui_story"]) then
					arg_242_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 and not isNil(arg_242_1.actors_["1061ui_story"]) and arg_242_1.var_.characterEffect1061ui_story then
				arg_242_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_245_2 = arg_242_1.actors_["1061ui_story"].transform

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos1061ui_story = var_245_2.localPosition
			end

			local var_245_3 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_3 then
				var_245_2.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_242_1.time_ - 0) / var_245_3)
				var_245_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_245_2.position).x, (manager.ui.mainCamera.transform.position - var_245_2.position).y, (manager.ui.mainCamera.transform.position - var_245_2.position).z)
				var_245_2.localEulerAngles.z = 0
				var_245_2.localEulerAngles.x = 0
				var_245_2.localEulerAngles = var_245_2.localEulerAngles
			end

			if arg_242_1.time_ >= 0 + var_245_3 and arg_242_1.time_ < 0 + var_245_3 + arg_245_0 then
				var_245_2.localPosition = Vector3.New(0, -1.18, -6.15)
				var_245_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_245_2.position).x, (manager.ui.mainCamera.transform.position - var_245_2.position).y, (manager.ui.mainCamera.transform.position - var_245_2.position).z)
				var_245_2.localEulerAngles.z = 0
				var_245_2.localEulerAngles.x = 0
				var_245_2.localEulerAngles = var_245_2.localEulerAngles
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_245_4 = 0
			local var_245_5 = 1.35

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_4 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_6 = arg_242_1:GetWordFromCfg(420132059)
				local var_245_7 = arg_242_1:FormatText(var_245_6.content)

				arg_242_1.text_.text = var_245_7

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_9 = 54 <= 0 and var_245_5 or var_245_5 * (utf8.len(var_245_7) / 54)

				if (54 <= 0 and var_245_5 or var_245_5 * (utf8.len(var_245_7) / 54)) > 0 and var_245_5 < var_245_9 then
					arg_242_1.talkMaxDuration = var_245_9

					if var_245_9 + var_245_4 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_9 + var_245_4
					end
				end

				arg_242_1.text_.text = var_245_7
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132059", "story_v_out_420132.awb") ~= 0 then
					local var_245_10 = manager.audio:GetVoiceLength("story_v_out_420132", "420132059", "story_v_out_420132.awb") / 1000

					if var_245_10 + var_245_4 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_10 + var_245_4
					end

					if var_245_6.prefab_name ~= "" and arg_242_1.actors_[var_245_6.prefab_name] ~= nil then
						local var_245_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_6.prefab_name].transform, "story_v_out_420132", "420132059", "story_v_out_420132.awb")

						arg_242_1:RecordAudio("420132059", var_245_11)
						arg_242_1:RecordAudio("420132059", var_245_11)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_420132", "420132059", "story_v_out_420132.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_420132", "420132059", "story_v_out_420132.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_12 = math.max(var_245_5, arg_242_1.talkMaxDuration)

			if var_245_4 <= arg_242_1.time_ and arg_242_1.time_ < var_245_4 + var_245_12 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_4) / var_245_12

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_4 + var_245_12 and arg_242_1.time_ < var_245_4 + var_245_12 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play420132060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 420132060
		arg_246_1.duration_ = 20.1

		local var_246_0 = {
			zh = 13.966,
			ja = 20.1
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play420132061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 1.75

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_1 = arg_246_1:GetWordFromCfg(420132060)
				local var_249_2 = arg_246_1:FormatText(var_249_1.content)

				arg_246_1.text_.text = var_249_2

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_4 = 70 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_2) / 70)

				if (70 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_2) / 70)) > 0 and var_249_0 < var_249_4 then
					arg_246_1.talkMaxDuration = var_249_4

					if var_249_4 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_4 + 0
					end
				end

				arg_246_1.text_.text = var_249_2
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132060", "story_v_out_420132.awb") ~= 0 then
					local var_249_5 = manager.audio:GetVoiceLength("story_v_out_420132", "420132060", "story_v_out_420132.awb") / 1000

					if var_249_5 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_5 + 0
					end

					if var_249_1.prefab_name ~= "" and arg_246_1.actors_[var_249_1.prefab_name] ~= nil then
						local var_249_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_1.prefab_name].transform, "story_v_out_420132", "420132060", "story_v_out_420132.awb")

						arg_246_1:RecordAudio("420132060", var_249_6)
						arg_246_1:RecordAudio("420132060", var_249_6)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_420132", "420132060", "story_v_out_420132.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_420132", "420132060", "story_v_out_420132.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_7 = math.max(var_249_0, arg_246_1.talkMaxDuration)

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_7 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - 0) / var_249_7

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= 0 + var_249_7 and arg_246_1.time_ < 0 + var_249_7 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play420132061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 420132061
		arg_250_1.duration_ = 10.93

		local var_250_0 = {
			zh = 9.333,
			ja = 10.933
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play420132062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0.875

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_1 = arg_250_1:GetWordFromCfg(420132061)
				local var_253_2 = arg_250_1:FormatText(var_253_1.content)

				arg_250_1.text_.text = var_253_2

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_4 = 35 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_2) / 35)

				if (35 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_2) / 35)) > 0 and var_253_0 < var_253_4 then
					arg_250_1.talkMaxDuration = var_253_4

					if var_253_4 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_4 + 0
					end
				end

				arg_250_1.text_.text = var_253_2
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132061", "story_v_out_420132.awb") ~= 0 then
					local var_253_5 = manager.audio:GetVoiceLength("story_v_out_420132", "420132061", "story_v_out_420132.awb") / 1000

					if var_253_5 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_5 + 0
					end

					if var_253_1.prefab_name ~= "" and arg_250_1.actors_[var_253_1.prefab_name] ~= nil then
						local var_253_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_1.prefab_name].transform, "story_v_out_420132", "420132061", "story_v_out_420132.awb")

						arg_250_1:RecordAudio("420132061", var_253_6)
						arg_250_1:RecordAudio("420132061", var_253_6)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_420132", "420132061", "story_v_out_420132.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_420132", "420132061", "story_v_out_420132.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_7 = math.max(var_253_0, arg_250_1.talkMaxDuration)

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_7 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - 0) / var_253_7

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= 0 + var_253_7 and arg_250_1.time_ < 0 + var_253_7 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play420132062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 420132062
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play420132063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(arg_254_1.actors_["1061ui_story"]) and arg_254_1.var_.characterEffect1061ui_story == nil then
				arg_254_1.var_.characterEffect1061ui_story = arg_254_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_0 = 0.200000002980232

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 and not isNil(arg_254_1.actors_["1061ui_story"]) then
				if arg_254_1.var_.characterEffect1061ui_story and not isNil(arg_254_1.actors_["1061ui_story"]) then
					arg_254_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_254_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_254_1.time_ - 0) / var_257_0)
				end
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 and not isNil(arg_254_1.actors_["1061ui_story"]) and arg_254_1.var_.characterEffect1061ui_story then
				arg_254_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_254_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_257_1 = 0
			local var_257_2 = 1.05

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_3 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(420132062).content)

				arg_254_1.text_.text = var_257_3

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_5 = 42 <= 0 and var_257_2 or var_257_2 * (utf8.len(var_257_3) / 42)

				if (42 <= 0 and var_257_2 or var_257_2 * (utf8.len(var_257_3) / 42)) > 0 and var_257_2 < var_257_5 then
					arg_254_1.talkMaxDuration = var_257_5

					if var_257_5 + var_257_1 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_5 + var_257_1
					end
				end

				arg_254_1.text_.text = var_257_3
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_6 = math.max(var_257_2, arg_254_1.talkMaxDuration)

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_6 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_1) / var_257_6

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_1 + var_257_6 and arg_254_1.time_ < var_257_1 + var_257_6 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play420132063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 420132063
		arg_258_1.duration_ = 15.7

		local var_258_0 = {
			zh = 13.1,
			ja = 15.7
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
				arg_258_0:Play420132064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos1061ui_story = arg_258_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_261_0 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 then
				arg_258_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_258_1.time_ - 0) / var_261_0)
				arg_258_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_258_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1061ui_story"].transform.position).z)
				arg_258_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_258_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_258_1.actors_["1061ui_story"].transform.localEulerAngles = arg_258_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 then
				arg_258_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_258_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_258_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1061ui_story"].transform.position).z)
				arg_258_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_258_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_258_1.actors_["1061ui_story"].transform.localEulerAngles = arg_258_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_261_1 = arg_258_1.actors_["1061ui_story"]

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(var_261_1) and arg_258_1.var_.characterEffect1061ui_story == nil then
				arg_258_1.var_.characterEffect1061ui_story = var_261_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_2 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_2 and not isNil(var_261_1) then
				if arg_258_1.var_.characterEffect1061ui_story and not isNil(var_261_1) then
					arg_258_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= 0 + var_261_2 and arg_258_1.time_ < 0 + var_261_2 + arg_261_0 and not isNil(var_261_1) and arg_258_1.var_.characterEffect1061ui_story then
				arg_258_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_261_4 = 0
			local var_261_5 = 1.55

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_4 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_6 = arg_258_1:GetWordFromCfg(420132063)
				local var_261_7 = arg_258_1:FormatText(var_261_6.content)

				arg_258_1.text_.text = var_261_7

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_9 = 62 <= 0 and var_261_5 or var_261_5 * (utf8.len(var_261_7) / 62)

				if (62 <= 0 and var_261_5 or var_261_5 * (utf8.len(var_261_7) / 62)) > 0 and var_261_5 < var_261_9 then
					arg_258_1.talkMaxDuration = var_261_9

					if var_261_9 + var_261_4 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_9 + var_261_4
					end
				end

				arg_258_1.text_.text = var_261_7
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132063", "story_v_out_420132.awb") ~= 0 then
					local var_261_10 = manager.audio:GetVoiceLength("story_v_out_420132", "420132063", "story_v_out_420132.awb") / 1000

					if var_261_10 + var_261_4 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_10 + var_261_4
					end

					if var_261_6.prefab_name ~= "" and arg_258_1.actors_[var_261_6.prefab_name] ~= nil then
						local var_261_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_6.prefab_name].transform, "story_v_out_420132", "420132063", "story_v_out_420132.awb")

						arg_258_1:RecordAudio("420132063", var_261_11)
						arg_258_1:RecordAudio("420132063", var_261_11)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_420132", "420132063", "story_v_out_420132.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_420132", "420132063", "story_v_out_420132.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_12 = math.max(var_261_5, arg_258_1.talkMaxDuration)

			if var_261_4 <= arg_258_1.time_ and arg_258_1.time_ < var_261_4 + var_261_12 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_4) / var_261_12

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_4 + var_261_12 and arg_258_1.time_ < var_261_4 + var_261_12 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play420132064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 420132064
		arg_262_1.duration_ = 6.67

		local var_262_0 = {
			zh = 6.666,
			ja = 6.566
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
				arg_262_0:Play420132065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(arg_262_1.actors_["1061ui_story"]) and arg_262_1.var_.characterEffect1061ui_story == nil then
				arg_262_1.var_.characterEffect1061ui_story = arg_262_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_0 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 and not isNil(arg_262_1.actors_["1061ui_story"]) then
				if arg_262_1.var_.characterEffect1061ui_story and not isNil(arg_262_1.actors_["1061ui_story"]) then
					arg_262_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_262_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_262_1.time_ - 0) / var_265_0)
				end
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 and not isNil(arg_262_1.actors_["1061ui_story"]) and arg_262_1.var_.characterEffect1061ui_story then
				arg_262_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_262_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_265_1 = arg_262_1.actors_["1085ui_story"].transform

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos1085ui_story = var_265_1.localPosition
			end

			local var_265_2 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_2 then
				var_265_1.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_262_1.time_ - 0) / var_265_2)
				var_265_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_265_1.position).x, (manager.ui.mainCamera.transform.position - var_265_1.position).y, (manager.ui.mainCamera.transform.position - var_265_1.position).z)
				var_265_1.localEulerAngles.z = 0
				var_265_1.localEulerAngles.x = 0
				var_265_1.localEulerAngles = var_265_1.localEulerAngles
			end

			if arg_262_1.time_ >= 0 + var_265_2 and arg_262_1.time_ < 0 + var_265_2 + arg_265_0 then
				var_265_1.localPosition = Vector3.New(0.75, -1.01, -5.83)
				var_265_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_265_1.position).x, (manager.ui.mainCamera.transform.position - var_265_1.position).y, (manager.ui.mainCamera.transform.position - var_265_1.position).z)
				var_265_1.localEulerAngles.z = 0
				var_265_1.localEulerAngles.x = 0
				var_265_1.localEulerAngles = var_265_1.localEulerAngles
			end

			local var_265_3 = arg_262_1.actors_["1085ui_story"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_3) and arg_262_1.var_.characterEffect1085ui_story == nil then
				arg_262_1.var_.characterEffect1085ui_story = var_265_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_4 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_4 and not isNil(var_265_3) then
				if arg_262_1.var_.characterEffect1085ui_story and not isNil(var_265_3) then
					arg_262_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= 0 + var_265_4 and arg_262_1.time_ < 0 + var_265_4 + arg_265_0 and not isNil(var_265_3) and arg_262_1.var_.characterEffect1085ui_story then
				arg_262_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_265_6 = arg_262_1.actors_["1061ui_story"].transform

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos1061ui_story = var_265_6.localPosition
			end

			local var_265_7 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_7 then
				var_265_6.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_262_1.time_ - 0) / var_265_7)
				var_265_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_265_6.position).x, (manager.ui.mainCamera.transform.position - var_265_6.position).y, (manager.ui.mainCamera.transform.position - var_265_6.position).z)
				var_265_6.localEulerAngles.z = 0
				var_265_6.localEulerAngles.x = 0
				var_265_6.localEulerAngles = var_265_6.localEulerAngles
			end

			if arg_262_1.time_ >= 0 + var_265_7 and arg_262_1.time_ < 0 + var_265_7 + arg_265_0 then
				var_265_6.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				var_265_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_265_6.position).x, (manager.ui.mainCamera.transform.position - var_265_6.position).y, (manager.ui.mainCamera.transform.position - var_265_6.position).z)
				var_265_6.localEulerAngles.z = 0
				var_265_6.localEulerAngles.x = 0
				var_265_6.localEulerAngles = var_265_6.localEulerAngles
			end

			local var_265_8 = 0
			local var_265_9 = 0.4

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_8 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_10 = arg_262_1:GetWordFromCfg(420132064)
				local var_265_11 = arg_262_1:FormatText(var_265_10.content)

				arg_262_1.text_.text = var_265_11

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_13 = 16 <= 0 and var_265_9 or var_265_9 * (utf8.len(var_265_11) / 16)

				if (16 <= 0 and var_265_9 or var_265_9 * (utf8.len(var_265_11) / 16)) > 0 and var_265_9 < var_265_13 then
					arg_262_1.talkMaxDuration = var_265_13

					if var_265_13 + var_265_8 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_13 + var_265_8
					end
				end

				arg_262_1.text_.text = var_265_11
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132064", "story_v_out_420132.awb") ~= 0 then
					local var_265_14 = manager.audio:GetVoiceLength("story_v_out_420132", "420132064", "story_v_out_420132.awb") / 1000

					if var_265_14 + var_265_8 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_14 + var_265_8
					end

					if var_265_10.prefab_name ~= "" and arg_262_1.actors_[var_265_10.prefab_name] ~= nil then
						local var_265_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_10.prefab_name].transform, "story_v_out_420132", "420132064", "story_v_out_420132.awb")

						arg_262_1:RecordAudio("420132064", var_265_15)
						arg_262_1:RecordAudio("420132064", var_265_15)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_420132", "420132064", "story_v_out_420132.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_420132", "420132064", "story_v_out_420132.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_16 = math.max(var_265_9, arg_262_1.talkMaxDuration)

			if var_265_8 <= arg_262_1.time_ and arg_262_1.time_ < var_265_8 + var_265_16 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_8) / var_265_16

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_8 + var_265_16 and arg_262_1.time_ < var_265_8 + var_265_16 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play420132065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 420132065
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play420132066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos1061ui_story = arg_266_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_269_0 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 then
				arg_266_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_266_1.time_ - 0) / var_269_0)
				arg_266_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1061ui_story"].transform.position).z)
				arg_266_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["1061ui_story"].transform.localEulerAngles = arg_266_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 then
				arg_266_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_266_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1061ui_story"].transform.position).z)
				arg_266_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["1061ui_story"].transform.localEulerAngles = arg_266_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_269_1 = arg_266_1.actors_["1085ui_story"].transform

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos1085ui_story = var_269_1.localPosition
			end

			local var_269_2 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_2 then
				var_269_1.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_266_1.time_ - 0) / var_269_2)
				var_269_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_269_1.position).x, (manager.ui.mainCamera.transform.position - var_269_1.position).y, (manager.ui.mainCamera.transform.position - var_269_1.position).z)
				var_269_1.localEulerAngles.z = 0
				var_269_1.localEulerAngles.x = 0
				var_269_1.localEulerAngles = var_269_1.localEulerAngles
			end

			if arg_266_1.time_ >= 0 + var_269_2 and arg_266_1.time_ < 0 + var_269_2 + arg_269_0 then
				var_269_1.localPosition = Vector3.New(0, 100, 0)
				var_269_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_269_1.position).x, (manager.ui.mainCamera.transform.position - var_269_1.position).y, (manager.ui.mainCamera.transform.position - var_269_1.position).z)
				var_269_1.localEulerAngles.z = 0
				var_269_1.localEulerAngles.x = 0
				var_269_1.localEulerAngles = var_269_1.localEulerAngles
			end

			local var_269_3 = 0
			local var_269_4 = 1.35

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_3 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_5 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(420132065).content)

				arg_266_1.text_.text = var_269_5

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_7 = 54 <= 0 and var_269_4 or var_269_4 * (utf8.len(var_269_5) / 54)

				if (54 <= 0 and var_269_4 or var_269_4 * (utf8.len(var_269_5) / 54)) > 0 and var_269_4 < var_269_7 then
					arg_266_1.talkMaxDuration = var_269_7

					if var_269_7 + var_269_3 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_7 + var_269_3
					end
				end

				arg_266_1.text_.text = var_269_5
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_8 = math.max(var_269_4, arg_266_1.talkMaxDuration)

			if var_269_3 <= arg_266_1.time_ and arg_266_1.time_ < var_269_3 + var_269_8 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_3) / var_269_8

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_3 + var_269_8 and arg_266_1.time_ < var_269_3 + var_269_8 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play420132066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 420132066
		arg_270_1.duration_ = 2

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play420132067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(arg_270_1.actors_["1085ui_story"]) and arg_270_1.var_.characterEffect1085ui_story == nil then
				arg_270_1.var_.characterEffect1085ui_story = arg_270_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_0 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 and not isNil(arg_270_1.actors_["1085ui_story"]) then
				if arg_270_1.var_.characterEffect1085ui_story and not isNil(arg_270_1.actors_["1085ui_story"]) then
					arg_270_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 and not isNil(arg_270_1.actors_["1085ui_story"]) and arg_270_1.var_.characterEffect1085ui_story then
				arg_270_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_273_2 = arg_270_1.actors_["1085ui_story"].transform

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos1085ui_story = var_273_2.localPosition
			end

			local var_273_3 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_3 then
				var_273_2.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_270_1.time_ - 0) / var_273_3)
				var_273_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_2.position).x, (manager.ui.mainCamera.transform.position - var_273_2.position).y, (manager.ui.mainCamera.transform.position - var_273_2.position).z)
				var_273_2.localEulerAngles.z = 0
				var_273_2.localEulerAngles.x = 0
				var_273_2.localEulerAngles = var_273_2.localEulerAngles
			end

			if arg_270_1.time_ >= 0 + var_273_3 and arg_270_1.time_ < 0 + var_273_3 + arg_273_0 then
				var_273_2.localPosition = Vector3.New(0, -1.01, -5.83)
				var_273_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_2.position).x, (manager.ui.mainCamera.transform.position - var_273_2.position).y, (manager.ui.mainCamera.transform.position - var_273_2.position).z)
				var_273_2.localEulerAngles.z = 0
				var_273_2.localEulerAngles.x = 0
				var_273_2.localEulerAngles = var_273_2.localEulerAngles
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_2")
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_273_4 = 0
			local var_273_5 = 0.075

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_4 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_6 = arg_270_1:GetWordFromCfg(420132066)
				local var_273_7 = arg_270_1:FormatText(var_273_6.content)

				arg_270_1.text_.text = var_273_7

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_9 = 3 <= 0 and var_273_5 or var_273_5 * (utf8.len(var_273_7) / 3)

				if (3 <= 0 and var_273_5 or var_273_5 * (utf8.len(var_273_7) / 3)) > 0 and var_273_5 < var_273_9 then
					arg_270_1.talkMaxDuration = var_273_9

					if var_273_9 + var_273_4 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_9 + var_273_4
					end
				end

				arg_270_1.text_.text = var_273_7
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132066", "story_v_out_420132.awb") ~= 0 then
					local var_273_10 = manager.audio:GetVoiceLength("story_v_out_420132", "420132066", "story_v_out_420132.awb") / 1000

					if var_273_10 + var_273_4 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_10 + var_273_4
					end

					if var_273_6.prefab_name ~= "" and arg_270_1.actors_[var_273_6.prefab_name] ~= nil then
						local var_273_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_6.prefab_name].transform, "story_v_out_420132", "420132066", "story_v_out_420132.awb")

						arg_270_1:RecordAudio("420132066", var_273_11)
						arg_270_1:RecordAudio("420132066", var_273_11)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_420132", "420132066", "story_v_out_420132.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_420132", "420132066", "story_v_out_420132.awb")
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

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play420132067 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 420132067
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play420132068(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(arg_274_1.actors_["1085ui_story"]) and arg_274_1.var_.characterEffect1085ui_story == nil then
				arg_274_1.var_.characterEffect1085ui_story = arg_274_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_0 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 and not isNil(arg_274_1.actors_["1085ui_story"]) then
				if arg_274_1.var_.characterEffect1085ui_story and not isNil(arg_274_1.actors_["1085ui_story"]) then
					arg_274_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_274_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_274_1.time_ - 0) / var_277_0)
				end
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 and not isNil(arg_274_1.actors_["1085ui_story"]) and arg_274_1.var_.characterEffect1085ui_story then
				arg_274_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_274_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_277_1 = 0
			local var_277_2 = 0.25

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
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

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_3 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(420132067).content)

				arg_274_1.text_.text = var_277_3

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_5 = 10 <= 0 and var_277_2 or var_277_2 * (utf8.len(var_277_3) / 10)

				if (10 <= 0 and var_277_2 or var_277_2 * (utf8.len(var_277_3) / 10)) > 0 and var_277_2 < var_277_5 then
					arg_274_1.talkMaxDuration = var_277_5

					if var_277_5 + var_277_1 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_5 + var_277_1
					end
				end

				arg_274_1.text_.text = var_277_3
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_6 = math.max(var_277_2, arg_274_1.talkMaxDuration)

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_6 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_1) / var_277_6

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_1 + var_277_6 and arg_274_1.time_ < var_277_1 + var_277_6 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play420132068 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 420132068
		arg_278_1.duration_ = 18.17

		local var_278_0 = {
			zh = 13.233,
			ja = 18.166
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
				arg_278_0:Play420132069(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(arg_278_1.actors_["1085ui_story"]) and arg_278_1.var_.characterEffect1085ui_story == nil then
				arg_278_1.var_.characterEffect1085ui_story = arg_278_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_0 = 0.200000002980232

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_0 and not isNil(arg_278_1.actors_["1085ui_story"]) then
				if arg_278_1.var_.characterEffect1085ui_story and not isNil(arg_278_1.actors_["1085ui_story"]) then
					arg_278_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_278_1.time_ >= 0 + var_281_0 and arg_278_1.time_ < 0 + var_281_0 + arg_281_0 and not isNil(arg_278_1.actors_["1085ui_story"]) and arg_278_1.var_.characterEffect1085ui_story then
				arg_278_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_281_2 = arg_278_1.actors_["1085ui_story"].transform

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.moveOldPos1085ui_story = var_281_2.localPosition
			end

			local var_281_3 = 0.001

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_3 then
				var_281_2.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_278_1.time_ - 0) / var_281_3)
				var_281_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_2.position).x, (manager.ui.mainCamera.transform.position - var_281_2.position).y, (manager.ui.mainCamera.transform.position - var_281_2.position).z)
				var_281_2.localEulerAngles.z = 0
				var_281_2.localEulerAngles.x = 0
				var_281_2.localEulerAngles = var_281_2.localEulerAngles
			end

			if arg_278_1.time_ >= 0 + var_281_3 and arg_278_1.time_ < 0 + var_281_3 + arg_281_0 then
				var_281_2.localPosition = Vector3.New(0, -1.01, -5.83)
				var_281_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_2.position).x, (manager.ui.mainCamera.transform.position - var_281_2.position).y, (manager.ui.mainCamera.transform.position - var_281_2.position).z)
				var_281_2.localEulerAngles.z = 0
				var_281_2.localEulerAngles.x = 0
				var_281_2.localEulerAngles = var_281_2.localEulerAngles
			end

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_281_4 = 0
			local var_281_5 = 1.325

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_4 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_6 = arg_278_1:GetWordFromCfg(420132068)
				local var_281_7 = arg_278_1:FormatText(var_281_6.content)

				arg_278_1.text_.text = var_281_7

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_9 = 53 <= 0 and var_281_5 or var_281_5 * (utf8.len(var_281_7) / 53)

				if (53 <= 0 and var_281_5 or var_281_5 * (utf8.len(var_281_7) / 53)) > 0 and var_281_5 < var_281_9 then
					arg_278_1.talkMaxDuration = var_281_9

					if var_281_9 + var_281_4 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_9 + var_281_4
					end
				end

				arg_278_1.text_.text = var_281_7
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132068", "story_v_out_420132.awb") ~= 0 then
					local var_281_10 = manager.audio:GetVoiceLength("story_v_out_420132", "420132068", "story_v_out_420132.awb") / 1000

					if var_281_10 + var_281_4 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_10 + var_281_4
					end

					if var_281_6.prefab_name ~= "" and arg_278_1.actors_[var_281_6.prefab_name] ~= nil then
						local var_281_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_6.prefab_name].transform, "story_v_out_420132", "420132068", "story_v_out_420132.awb")

						arg_278_1:RecordAudio("420132068", var_281_11)
						arg_278_1:RecordAudio("420132068", var_281_11)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_420132", "420132068", "story_v_out_420132.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_420132", "420132068", "story_v_out_420132.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_12 = math.max(var_281_5, arg_278_1.talkMaxDuration)

			if var_281_4 <= arg_278_1.time_ and arg_278_1.time_ < var_281_4 + var_281_12 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_4) / var_281_12

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_4 + var_281_12 and arg_278_1.time_ < var_281_4 + var_281_12 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play420132069 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 420132069
		arg_282_1.duration_ = 5.67

		local var_282_0 = {
			zh = 3.5,
			ja = 5.666
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play420132070(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0.3

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_1 = arg_282_1:GetWordFromCfg(420132069)
				local var_285_2 = arg_282_1:FormatText(var_285_1.content)

				arg_282_1.text_.text = var_285_2

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_4 = 12 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_2) / 12)

				if (12 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_2) / 12)) > 0 and var_285_0 < var_285_4 then
					arg_282_1.talkMaxDuration = var_285_4

					if var_285_4 + 0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_4 + 0
					end
				end

				arg_282_1.text_.text = var_285_2
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132069", "story_v_out_420132.awb") ~= 0 then
					local var_285_5 = manager.audio:GetVoiceLength("story_v_out_420132", "420132069", "story_v_out_420132.awb") / 1000

					if var_285_5 + 0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_5 + 0
					end

					if var_285_1.prefab_name ~= "" and arg_282_1.actors_[var_285_1.prefab_name] ~= nil then
						local var_285_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_1.prefab_name].transform, "story_v_out_420132", "420132069", "story_v_out_420132.awb")

						arg_282_1:RecordAudio("420132069", var_285_6)
						arg_282_1:RecordAudio("420132069", var_285_6)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_420132", "420132069", "story_v_out_420132.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_420132", "420132069", "story_v_out_420132.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_7 = math.max(var_285_0, arg_282_1.talkMaxDuration)

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_7 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - 0) / var_285_7

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= 0 + var_285_7 and arg_282_1.time_ < 0 + var_285_7 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play420132070 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 420132070
		arg_286_1.duration_ = 11.33

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play420132071(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				local var_289_0 = arg_286_1.bgs_.STblack

				arg_286_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_289_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_289_1 = var_289_0:GetComponent("SpriteRenderer")

				if var_289_1 and var_289_1.sprite then
					local var_289_2 = 2 * (var_289_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_289_0.transform.localScale = Vector3.New(var_289_2 / var_289_1.sprite.bounds.size.y < var_289_2 * manager.ui.mainCameraCom_.aspect / var_289_1.sprite.bounds.size.x and var_289_2 * manager.ui.mainCameraCom_.aspect / var_289_1.sprite.bounds.size.x or var_289_2 / var_289_1.sprite.bounds.size.y, var_289_2 / var_289_1.sprite.bounds.size.y < var_289_2 * manager.ui.mainCameraCom_.aspect / var_289_1.sprite.bounds.size.x and var_289_2 * manager.ui.mainCameraCom_.aspect / var_289_1.sprite.bounds.size.x or var_289_2 / var_289_1.sprite.bounds.size.y, 0)
				end

				for iter_289_0, iter_289_1 in pairs(arg_286_1.bgs_) do
					if iter_289_0 ~= "STblack" then
						iter_289_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_289_3 = 0

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_3 + arg_289_0 then
				arg_286_1.mask_.enabled = true
				arg_286_1.mask_.raycastTarget = true

				arg_286_1:SetGaussion(false)
			end

			local var_289_4 = 2

			if var_289_3 <= arg_286_1.time_ and arg_286_1.time_ < var_289_3 + var_289_4 then
				local var_289_5 = Color.New(0, 0, 0)

				var_289_5.a = Mathf.Lerp(1, 0, (arg_286_1.time_ - var_289_3) / var_289_4)
				arg_286_1.mask_.color = var_289_5
			end

			if arg_286_1.time_ >= var_289_3 + var_289_4 and arg_286_1.time_ < var_289_3 + var_289_4 + arg_289_0 then
				local var_289_6 = Color.New(0, 0, 0)

				arg_286_1.mask_.enabled = false
				var_289_6.a = 0
				arg_286_1.mask_.color = var_289_6
			end

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.cswbg_:SetActive(true)

				local var_289_7 = arg_286_1.cswt_:GetComponent("RectTransform")

				arg_286_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_289_7.offsetMin = Vector2.New(0, 0)
				var_289_7.offsetMax = Vector2.New(0, 130)
				arg_286_1.cswt_.text = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(419151).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.cswt_)

				arg_286_1.cswt_.fontSize = 120
				arg_286_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_286_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_286_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.fswbg_:SetActive(true)
				arg_286_1.dialog_:SetActive(false)

				arg_286_1.fswtw_.percent = 0
				arg_286_1.fswt_.text = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(420132070).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.fswt_)

				arg_286_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_286_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_286_1.fswtw_:SetDirty()

				arg_286_1.typewritterCharCountI18N = 0

				SetActive(arg_286_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_286_1:ShowNextGo(false)
			end

			local var_289_9 = 1.66666666666667

			if 1.66666666666667 < arg_286_1.time_ and arg_286_1.time_ <= var_289_9 + arg_289_0 then
				arg_286_1.var_.oldValueTypewriter = arg_286_1.fswtw_.percent

				SetActive(arg_286_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_286_1:ShowNextGo(false)
			end

			local var_289_10 = 27
			local var_289_11 = 1.8
			local var_289_12, var_289_13 = arg_286_1:GetPercentByPara(arg_286_1:FormatText(arg_286_1:GetWordFromCfg(420132070).content), 1)

			if var_289_9 < arg_286_1.time_ and arg_286_1.time_ <= var_289_9 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0

				local var_289_14 = var_289_10 <= 0 and var_289_11 or var_289_11 * ((var_289_13 - arg_286_1.typewritterCharCountI18N) / var_289_10)

				if (var_289_10 <= 0 and var_289_11 or var_289_11 * ((var_289_13 - arg_286_1.typewritterCharCountI18N) / var_289_10)) > 0 and var_289_11 < var_289_14 then
					arg_286_1.talkMaxDuration = var_289_14

					if var_289_14 + var_289_9 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_14 + var_289_9
					end
				end
			end

			local var_289_15 = math.max(1.8, arg_286_1.talkMaxDuration)

			if var_289_9 <= arg_286_1.time_ and arg_286_1.time_ < var_289_9 + var_289_15 then
				arg_286_1.fswtw_.percent = Mathf.Lerp(arg_286_1.var_.oldValueTypewriter, var_289_12, (arg_286_1.time_ - var_289_9) / var_289_15)
				arg_286_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_286_1.fswtw_:SetDirty()
			end

			if arg_286_1.time_ >= var_289_9 + var_289_15 and arg_286_1.time_ < var_289_9 + var_289_15 + arg_289_0 then
				arg_286_1.fswtw_.percent = var_289_12

				arg_286_1.fswtw_:SetDirty()
				arg_286_1:ShowNextGo(true)

				arg_286_1.typewritterCharCountI18N = var_289_13
			end

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				local var_289_16 = arg_286_1.fswbg_.transform:Find("textbox/adapt/content") or arg_286_1.fswbg_.transform:Find("textbox/content")
				local var_289_17 = arg_286_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_289_18 = var_289_16:GetComponent("RectTransform")

				var_289_16:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_289_18.offsetMin = Vector2.New(0, -70)
				var_289_18.offsetMax = Vector2.New(0, 0)
			end

			local var_289_19 = arg_286_1.actors_["1085ui_story"].transform

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos1085ui_story = var_289_19.localPosition
			end

			local var_289_20 = 0.001

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_20 then
				var_289_19.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_286_1.time_ - 0) / var_289_20)
				var_289_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_289_19.position).x, (manager.ui.mainCamera.transform.position - var_289_19.position).y, (manager.ui.mainCamera.transform.position - var_289_19.position).z)
				var_289_19.localEulerAngles.z = 0
				var_289_19.localEulerAngles.x = 0
				var_289_19.localEulerAngles = var_289_19.localEulerAngles
			end

			if arg_286_1.time_ >= 0 + var_289_20 and arg_286_1.time_ < 0 + var_289_20 + arg_289_0 then
				var_289_19.localPosition = Vector3.New(0, 100, 0)
				var_289_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_289_19.position).x, (manager.ui.mainCamera.transform.position - var_289_19.position).y, (manager.ui.mainCamera.transform.position - var_289_19.position).z)
				var_289_19.localEulerAngles.z = 0
				var_289_19.localEulerAngles.x = 0
				var_289_19.localEulerAngles = var_289_19.localEulerAngles
			end

			local var_289_21 = 1.66666666666667
			local var_289_22 = manager.audio:GetVoiceLength("story_v_out_420132", "420132070", "story_v_out_420132.awb") / 1000

			if var_289_22 > 0 and 9.666 < var_289_22 and var_289_22 + var_289_21 > arg_286_1.duration_ then
				arg_286_1.duration_ = var_289_22 + var_289_21
			end

			if var_289_21 < arg_286_1.time_ and arg_286_1.time_ <= var_289_21 + arg_289_0 then
				arg_286_1:AudioAction("play", "voice", "story_v_out_420132", "420132070", "story_v_out_420132.awb")
			end
		end

		arg_286_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_286_1:InitPlayNodeList()
	end,
	Play420132071 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 420132071
		arg_290_1.duration_ = 11.23

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play420132072(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.fswbg_:SetActive(true)
				arg_290_1.dialog_:SetActive(false)

				arg_290_1.fswtw_.percent = 0
				arg_290_1.fswt_.text = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(420132071).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.fswt_)

				arg_290_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_290_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_290_1.fswtw_:SetDirty()

				arg_290_1.typewritterCharCountI18N = 0

				SetActive(arg_290_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_290_1:ShowNextGo(false)
			end

			local var_293_0 = 0.0666666666666669

			if 0.0666666666666669 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.var_.oldValueTypewriter = arg_290_1.fswtw_.percent

				SetActive(arg_290_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_290_1:ShowNextGo(false)
			end

			local var_293_1 = 31
			local var_293_2 = 2.06666666666667
			local var_293_3, var_293_4 = arg_290_1:GetPercentByPara(arg_290_1:FormatText(arg_290_1:GetWordFromCfg(420132071).content), 1)

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0

				local var_293_5 = var_293_1 <= 0 and var_293_2 or var_293_2 * ((var_293_4 - arg_290_1.typewritterCharCountI18N) / var_293_1)

				if (var_293_1 <= 0 and var_293_2 or var_293_2 * ((var_293_4 - arg_290_1.typewritterCharCountI18N) / var_293_1)) > 0 and var_293_2 < var_293_5 then
					arg_290_1.talkMaxDuration = var_293_5

					if var_293_5 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_5 + var_293_0
					end
				end
			end

			local var_293_6 = math.max(2.06666666666667, arg_290_1.talkMaxDuration)

			if var_293_0 <= arg_290_1.time_ and arg_290_1.time_ < var_293_0 + var_293_6 then
				arg_290_1.fswtw_.percent = Mathf.Lerp(arg_290_1.var_.oldValueTypewriter, var_293_3, (arg_290_1.time_ - var_293_0) / var_293_6)
				arg_290_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_290_1.fswtw_:SetDirty()
			end

			if arg_290_1.time_ >= var_293_0 + var_293_6 and arg_290_1.time_ < var_293_0 + var_293_6 + arg_293_0 then
				arg_290_1.fswtw_.percent = var_293_3

				arg_290_1.fswtw_:SetDirty()
				arg_290_1:ShowNextGo(true)

				arg_290_1.typewritterCharCountI18N = var_293_4
			end

			local var_293_7 = 0
			local var_293_8 = manager.audio:GetVoiceLength("story_v_out_420132", "420132071", "story_v_out_420132.awb") / 1000

			if var_293_8 > 0 and 11.233 < var_293_8 and var_293_8 + var_293_7 > arg_290_1.duration_ then
				arg_290_1.duration_ = var_293_8 + var_293_7
			end

			if var_293_7 < arg_290_1.time_ and arg_290_1.time_ <= var_293_7 + arg_293_0 then
				arg_290_1:AudioAction("play", "voice", "story_v_out_420132", "420132071", "story_v_out_420132.awb")
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play420132072 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 420132072
		arg_294_1.duration_ = 11.27

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play420132073(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.fswbg_:SetActive(true)
				arg_294_1.dialog_:SetActive(false)

				arg_294_1.fswtw_.percent = 0
				arg_294_1.fswt_.text = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(420132072).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.fswt_)

				arg_294_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_294_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_294_1.fswtw_:SetDirty()

				arg_294_1.typewritterCharCountI18N = 0

				SetActive(arg_294_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_294_1:ShowNextGo(false)
			end

			local var_297_0 = 0.0666666666666669

			if 0.0666666666666669 < arg_294_1.time_ and arg_294_1.time_ <= var_297_0 + arg_297_0 then
				arg_294_1.var_.oldValueTypewriter = arg_294_1.fswtw_.percent

				SetActive(arg_294_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_294_1:ShowNextGo(false)
			end

			local var_297_1 = 38
			local var_297_2 = 2.53333333333333
			local var_297_3, var_297_4 = arg_294_1:GetPercentByPara(arg_294_1:FormatText(arg_294_1:GetWordFromCfg(420132072).content), 1)

			if var_297_0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0

				local var_297_5 = var_297_1 <= 0 and var_297_2 or var_297_2 * ((var_297_4 - arg_294_1.typewritterCharCountI18N) / var_297_1)

				if (var_297_1 <= 0 and var_297_2 or var_297_2 * ((var_297_4 - arg_294_1.typewritterCharCountI18N) / var_297_1)) > 0 and var_297_2 < var_297_5 then
					arg_294_1.talkMaxDuration = var_297_5

					if var_297_5 + var_297_0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_5 + var_297_0
					end
				end
			end

			local var_297_6 = math.max(2.53333333333333, arg_294_1.talkMaxDuration)

			if var_297_0 <= arg_294_1.time_ and arg_294_1.time_ < var_297_0 + var_297_6 then
				arg_294_1.fswtw_.percent = Mathf.Lerp(arg_294_1.var_.oldValueTypewriter, var_297_3, (arg_294_1.time_ - var_297_0) / var_297_6)
				arg_294_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_294_1.fswtw_:SetDirty()
			end

			if arg_294_1.time_ >= var_297_0 + var_297_6 and arg_294_1.time_ < var_297_0 + var_297_6 + arg_297_0 then
				arg_294_1.fswtw_.percent = var_297_3

				arg_294_1.fswtw_:SetDirty()
				arg_294_1:ShowNextGo(true)

				arg_294_1.typewritterCharCountI18N = var_297_4
			end

			local var_297_7 = 0
			local var_297_8 = manager.audio:GetVoiceLength("story_v_out_420132", "420132072", "story_v_out_420132.awb") / 1000

			if var_297_8 > 0 and 11.266 < var_297_8 and var_297_8 + var_297_7 > arg_294_1.duration_ then
				arg_294_1.duration_ = var_297_8 + var_297_7
			end

			if var_297_7 < arg_294_1.time_ and arg_294_1.time_ <= var_297_7 + arg_297_0 then
				arg_294_1:AudioAction("play", "voice", "story_v_out_420132", "420132072", "story_v_out_420132.awb")
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play420132073 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 420132073
		arg_298_1.duration_ = 4.63

		local var_298_0 = {
			zh = 4.1,
			ja = 4.633
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play420132074(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				local var_301_0 = arg_298_1.bgs_.ST67

				arg_298_1.bgs_.ST67.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_301_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_301_1 = var_301_0:GetComponent("SpriteRenderer")

				if var_301_1 and var_301_1.sprite then
					local var_301_2 = 2 * (var_301_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_301_0.transform.localScale = Vector3.New(var_301_2 / var_301_1.sprite.bounds.size.y < var_301_2 * manager.ui.mainCameraCom_.aspect / var_301_1.sprite.bounds.size.x and var_301_2 * manager.ui.mainCameraCom_.aspect / var_301_1.sprite.bounds.size.x or var_301_2 / var_301_1.sprite.bounds.size.y, var_301_2 / var_301_1.sprite.bounds.size.y < var_301_2 * manager.ui.mainCameraCom_.aspect / var_301_1.sprite.bounds.size.x and var_301_2 * manager.ui.mainCameraCom_.aspect / var_301_1.sprite.bounds.size.x or var_301_2 / var_301_1.sprite.bounds.size.y, 0)
				end

				for iter_301_0, iter_301_1 in pairs(arg_298_1.bgs_) do
					if iter_301_0 ~= "ST67" then
						iter_301_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_301_3 = 0

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_3 + arg_301_0 then
				arg_298_1.mask_.enabled = true
				arg_298_1.mask_.raycastTarget = true

				arg_298_1:SetGaussion(false)
			end

			local var_301_4 = 2

			if var_301_3 <= arg_298_1.time_ and arg_298_1.time_ < var_301_3 + var_301_4 then
				local var_301_5 = Color.New(0, 0, 0)

				var_301_5.a = Mathf.Lerp(1, 0, (arg_298_1.time_ - var_301_3) / var_301_4)
				arg_298_1.mask_.color = var_301_5
			end

			if arg_298_1.time_ >= var_301_3 + var_301_4 and arg_298_1.time_ < var_301_3 + var_301_4 + arg_301_0 then
				local var_301_6 = Color.New(0, 0, 0)

				arg_298_1.mask_.enabled = false
				var_301_6.a = 0
				arg_298_1.mask_.color = var_301_6
			end

			local var_301_7 = arg_298_1.actors_["1061ui_story"].transform

			if 1.86666666666667 < arg_298_1.time_ and arg_298_1.time_ <= 1.86666666666667 + arg_301_0 then
				arg_298_1.var_.moveOldPos1061ui_story = var_301_7.localPosition
			end

			local var_301_8 = 0.001

			if 1.86666666666667 <= arg_298_1.time_ and arg_298_1.time_ < 1.86666666666667 + var_301_8 then
				var_301_7.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_298_1.time_ - 1.86666666666667) / var_301_8)
				var_301_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_301_7.position).x, (manager.ui.mainCamera.transform.position - var_301_7.position).y, (manager.ui.mainCamera.transform.position - var_301_7.position).z)
				var_301_7.localEulerAngles.z = 0
				var_301_7.localEulerAngles.x = 0
				var_301_7.localEulerAngles = var_301_7.localEulerAngles
			end

			if arg_298_1.time_ >= 1.86666666666667 + var_301_8 and arg_298_1.time_ < 1.86666666666667 + var_301_8 + arg_301_0 then
				var_301_7.localPosition = Vector3.New(0, -1.18, -6.15)
				var_301_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_301_7.position).x, (manager.ui.mainCamera.transform.position - var_301_7.position).y, (manager.ui.mainCamera.transform.position - var_301_7.position).z)
				var_301_7.localEulerAngles.z = 0
				var_301_7.localEulerAngles.x = 0
				var_301_7.localEulerAngles = var_301_7.localEulerAngles
			end

			local var_301_9 = arg_298_1.actors_["1061ui_story"]

			if 1.86666666666667 < arg_298_1.time_ and arg_298_1.time_ <= 1.86666666666667 + arg_301_0 and not isNil(var_301_9) and arg_298_1.var_.characterEffect1061ui_story == nil then
				arg_298_1.var_.characterEffect1061ui_story = var_301_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_10 = 0.200000002980232

			if 1.86666666666667 <= arg_298_1.time_ and arg_298_1.time_ < 1.86666666666667 + var_301_10 and not isNil(var_301_9) then
				if arg_298_1.var_.characterEffect1061ui_story and not isNil(var_301_9) then
					arg_298_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_298_1.time_ >= 1.86666666666667 + var_301_10 and arg_298_1.time_ < 1.86666666666667 + var_301_10 + arg_301_0 and not isNil(var_301_9) and arg_298_1.var_.characterEffect1061ui_story then
				arg_298_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 1.86666666666667 < arg_298_1.time_ and arg_298_1.time_ <= 1.86666666666667 + arg_301_0 then
				arg_298_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 1.86666666666667 < arg_298_1.time_ and arg_298_1.time_ <= 1.86666666666667 + arg_301_0 then
				arg_298_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.cswbg_:SetActive(false)
			end

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.fswbg_:SetActive(false)
				arg_298_1.dialog_:SetActive(false)
				SetActive(arg_298_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_298_1:ShowNextGo(false)
			end

			if 0.05 < arg_298_1.time_ and arg_298_1.time_ <= 0.05 + arg_301_0 then
				arg_298_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if arg_298_1.frameCnt_ <= 1 then
				arg_298_1.dialog_:SetActive(false)
			end

			local var_301_13 = 2
			local var_301_14 = 0.225

			if 2 < arg_298_1.time_ and arg_298_1.time_ <= var_301_13 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0

				arg_298_1.dialog_:SetActive(true)

				arg_298_1.dialogCg_.alpha = 0

				local var_301_15 = LeanTween.value(arg_298_1.dialog_, 0, 1, 0.3)

				var_301_15:setOnUpdate(LuaHelper.FloatAction(function(arg_302_0)
					arg_298_1.dialogCg_.alpha = arg_302_0
				end))
				var_301_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_298_1.dialog_)
					var_301_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_298_1.duration_ = arg_298_1.duration_ + 0.3

				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_16 = arg_298_1:GetWordFromCfg(420132073)
				local var_301_17 = arg_298_1:FormatText(var_301_16.content)

				arg_298_1.text_.text = var_301_17

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_19 = 9 <= 0 and var_301_14 or var_301_14 * (utf8.len(var_301_17) / 9)

				if (9 <= 0 and var_301_14 or var_301_14 * (utf8.len(var_301_17) / 9)) > 0 and var_301_14 < var_301_19 then
					arg_298_1.talkMaxDuration = var_301_19
					var_301_13 = var_301_13 + 0.3

					if var_301_19 + var_301_13 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_19 + var_301_13
					end
				end

				arg_298_1.text_.text = var_301_17
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132073", "story_v_out_420132.awb") ~= 0 then
					local var_301_20 = manager.audio:GetVoiceLength("story_v_out_420132", "420132073", "story_v_out_420132.awb") / 1000

					if var_301_20 + var_301_13 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_20 + var_301_13
					end

					if var_301_16.prefab_name ~= "" and arg_298_1.actors_[var_301_16.prefab_name] ~= nil then
						local var_301_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_16.prefab_name].transform, "story_v_out_420132", "420132073", "story_v_out_420132.awb")

						arg_298_1:RecordAudio("420132073", var_301_21)
						arg_298_1:RecordAudio("420132073", var_301_21)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_420132", "420132073", "story_v_out_420132.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_420132", "420132073", "story_v_out_420132.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_22 = var_301_13 + 0.3
			local var_301_23 = math.max(var_301_14, arg_298_1.talkMaxDuration)

			if var_301_13 + 0.3 <= arg_298_1.time_ and arg_298_1.time_ < var_301_22 + var_301_23 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_22) / var_301_23

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_22 + var_301_23 and arg_298_1.time_ < var_301_22 + var_301_23 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play420132074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 420132074
		arg_304_1.duration_ = 7.27

		local var_304_0 = {
			zh = 5.9,
			ja = 7.266
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
				arg_304_0:Play420132075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.var_.moveOldPos1061ui_story = arg_304_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_307_0 = 0.001

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_0 then
				arg_304_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_304_1.time_ - 0) / var_307_0)
				arg_304_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_304_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1061ui_story"].transform.position).z)
				arg_304_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_304_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_304_1.actors_["1061ui_story"].transform.localEulerAngles = arg_304_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_304_1.time_ >= 0 + var_307_0 and arg_304_1.time_ < 0 + var_307_0 + arg_307_0 then
				arg_304_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_304_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_304_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1061ui_story"].transform.position).z)
				arg_304_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_304_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_304_1.actors_["1061ui_story"].transform.localEulerAngles = arg_304_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_307_1 = arg_304_1.actors_["1085ui_story"].transform

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.var_.moveOldPos1085ui_story = var_307_1.localPosition
			end

			local var_307_2 = 0.001

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_2 then
				var_307_1.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_304_1.time_ - 0) / var_307_2)
				var_307_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_307_1.position).x, (manager.ui.mainCamera.transform.position - var_307_1.position).y, (manager.ui.mainCamera.transform.position - var_307_1.position).z)
				var_307_1.localEulerAngles.z = 0
				var_307_1.localEulerAngles.x = 0
				var_307_1.localEulerAngles = var_307_1.localEulerAngles
			end

			if arg_304_1.time_ >= 0 + var_307_2 and arg_304_1.time_ < 0 + var_307_2 + arg_307_0 then
				var_307_1.localPosition = Vector3.New(0, -1.01, -5.83)
				var_307_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_307_1.position).x, (manager.ui.mainCamera.transform.position - var_307_1.position).y, (manager.ui.mainCamera.transform.position - var_307_1.position).z)
				var_307_1.localEulerAngles.z = 0
				var_307_1.localEulerAngles.x = 0
				var_307_1.localEulerAngles = var_307_1.localEulerAngles
			end

			local var_307_3 = arg_304_1.actors_["1085ui_story"]

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(var_307_3) and arg_304_1.var_.characterEffect1085ui_story == nil then
				arg_304_1.var_.characterEffect1085ui_story = var_307_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_4 = 0.200000002980232

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_4 and not isNil(var_307_3) then
				if arg_304_1.var_.characterEffect1085ui_story and not isNil(var_307_3) then
					arg_304_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_304_1.time_ >= 0 + var_307_4 and arg_304_1.time_ < 0 + var_307_4 + arg_307_0 and not isNil(var_307_3) and arg_304_1.var_.characterEffect1085ui_story then
				arg_304_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_307_6 = 0
			local var_307_7 = 0.475

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_6 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_8 = arg_304_1:GetWordFromCfg(420132074)
				local var_307_9 = arg_304_1:FormatText(var_307_8.content)

				arg_304_1.text_.text = var_307_9

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_11 = 19 <= 0 and var_307_7 or var_307_7 * (utf8.len(var_307_9) / 19)

				if (19 <= 0 and var_307_7 or var_307_7 * (utf8.len(var_307_9) / 19)) > 0 and var_307_7 < var_307_11 then
					arg_304_1.talkMaxDuration = var_307_11

					if var_307_11 + var_307_6 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_11 + var_307_6
					end
				end

				arg_304_1.text_.text = var_307_9
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132074", "story_v_out_420132.awb") ~= 0 then
					local var_307_12 = manager.audio:GetVoiceLength("story_v_out_420132", "420132074", "story_v_out_420132.awb") / 1000

					if var_307_12 + var_307_6 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_12 + var_307_6
					end

					if var_307_8.prefab_name ~= "" and arg_304_1.actors_[var_307_8.prefab_name] ~= nil then
						local var_307_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_8.prefab_name].transform, "story_v_out_420132", "420132074", "story_v_out_420132.awb")

						arg_304_1:RecordAudio("420132074", var_307_13)
						arg_304_1:RecordAudio("420132074", var_307_13)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_420132", "420132074", "story_v_out_420132.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_420132", "420132074", "story_v_out_420132.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_14 = math.max(var_307_7, arg_304_1.talkMaxDuration)

			if var_307_6 <= arg_304_1.time_ and arg_304_1.time_ < var_307_6 + var_307_14 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_6) / var_307_14

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_6 + var_307_14 and arg_304_1.time_ < var_307_6 + var_307_14 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420132075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 420132075
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play420132076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos1085ui_story = arg_308_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_311_0 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 then
				arg_308_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_308_1.time_ - 0) / var_311_0)
				arg_308_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_308_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1085ui_story"].transform.position).z)
				arg_308_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_308_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_308_1.actors_["1085ui_story"].transform.localEulerAngles = arg_308_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 then
				arg_308_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_308_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_308_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1085ui_story"].transform.position).z)
				arg_308_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_308_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_308_1.actors_["1085ui_story"].transform.localEulerAngles = arg_308_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_311_1 = 0
			local var_311_2 = 1.2

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_3 = arg_308_1:FormatText(arg_308_1:GetWordFromCfg(420132075).content)

				arg_308_1.text_.text = var_311_3

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_5 = 48 <= 0 and var_311_2 or var_311_2 * (utf8.len(var_311_3) / 48)

				if (48 <= 0 and var_311_2 or var_311_2 * (utf8.len(var_311_3) / 48)) > 0 and var_311_2 < var_311_5 then
					arg_308_1.talkMaxDuration = var_311_5

					if var_311_5 + var_311_1 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_5 + var_311_1
					end
				end

				arg_308_1.text_.text = var_311_3
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_6 = math.max(var_311_2, arg_308_1.talkMaxDuration)

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_6 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_1) / var_311_6

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_1 + var_311_6 and arg_308_1.time_ < var_311_1 + var_311_6 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420132076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 420132076
		arg_312_1.duration_ = 5.2

		local var_312_0 = {
			zh = 4.466,
			ja = 5.2
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play420132077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos1061ui_story = arg_312_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_315_0 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_0 then
				arg_312_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_312_1.time_ - 0) / var_315_0)
				arg_312_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_312_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1061ui_story"].transform.position).z)
				arg_312_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_312_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_312_1.actors_["1061ui_story"].transform.localEulerAngles = arg_312_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_312_1.time_ >= 0 + var_315_0 and arg_312_1.time_ < 0 + var_315_0 + arg_315_0 then
				arg_312_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_312_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_312_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1061ui_story"].transform.position).z)
				arg_312_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_312_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_312_1.actors_["1061ui_story"].transform.localEulerAngles = arg_312_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_315_1 = arg_312_1.actors_["1061ui_story"]

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(var_315_1) and arg_312_1.var_.characterEffect1061ui_story == nil then
				arg_312_1.var_.characterEffect1061ui_story = var_315_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_2 = 0.200000002980232

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_2 and not isNil(var_315_1) then
				if arg_312_1.var_.characterEffect1061ui_story and not isNil(var_315_1) then
					arg_312_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_312_1.time_ >= 0 + var_315_2 and arg_312_1.time_ < 0 + var_315_2 + arg_315_0 and not isNil(var_315_1) and arg_312_1.var_.characterEffect1061ui_story then
				arg_312_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_315_4 = 0
			local var_315_5 = 0.45

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_4 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_6 = arg_312_1:GetWordFromCfg(420132076)
				local var_315_7 = arg_312_1:FormatText(var_315_6.content)

				arg_312_1.text_.text = var_315_7

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_9 = 18 <= 0 and var_315_5 or var_315_5 * (utf8.len(var_315_7) / 18)

				if (18 <= 0 and var_315_5 or var_315_5 * (utf8.len(var_315_7) / 18)) > 0 and var_315_5 < var_315_9 then
					arg_312_1.talkMaxDuration = var_315_9

					if var_315_9 + var_315_4 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_9 + var_315_4
					end
				end

				arg_312_1.text_.text = var_315_7
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132076", "story_v_out_420132.awb") ~= 0 then
					local var_315_10 = manager.audio:GetVoiceLength("story_v_out_420132", "420132076", "story_v_out_420132.awb") / 1000

					if var_315_10 + var_315_4 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_10 + var_315_4
					end

					if var_315_6.prefab_name ~= "" and arg_312_1.actors_[var_315_6.prefab_name] ~= nil then
						local var_315_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_6.prefab_name].transform, "story_v_out_420132", "420132076", "story_v_out_420132.awb")

						arg_312_1:RecordAudio("420132076", var_315_11)
						arg_312_1:RecordAudio("420132076", var_315_11)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_420132", "420132076", "story_v_out_420132.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_420132", "420132076", "story_v_out_420132.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_12 = math.max(var_315_5, arg_312_1.talkMaxDuration)

			if var_315_4 <= arg_312_1.time_ and arg_312_1.time_ < var_315_4 + var_315_12 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_4) / var_315_12

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_4 + var_315_12 and arg_312_1.time_ < var_315_4 + var_315_12 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play420132077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 420132077
		arg_316_1.duration_ = 5.13

		local var_316_0 = {
			zh = 3.3,
			ja = 5.133
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play420132078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(arg_316_1.actors_["1085ui_story"]) and arg_316_1.var_.characterEffect1085ui_story == nil then
				arg_316_1.var_.characterEffect1085ui_story = arg_316_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_0 = 0.200000002980232

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_0 and not isNil(arg_316_1.actors_["1085ui_story"]) then
				if arg_316_1.var_.characterEffect1085ui_story and not isNil(arg_316_1.actors_["1085ui_story"]) then
					arg_316_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_316_1.time_ >= 0 + var_319_0 and arg_316_1.time_ < 0 + var_319_0 + arg_319_0 and not isNil(arg_316_1.actors_["1085ui_story"]) and arg_316_1.var_.characterEffect1085ui_story then
				arg_316_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_319_2 = arg_316_1.actors_["1061ui_story"]

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(var_319_2) and arg_316_1.var_.characterEffect1061ui_story == nil then
				arg_316_1.var_.characterEffect1061ui_story = var_319_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_3 = 0.200000002980232

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_3 and not isNil(var_319_2) then
				if arg_316_1.var_.characterEffect1061ui_story and not isNil(var_319_2) then
					arg_316_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_316_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_316_1.time_ - 0) / var_319_3)
				end
			end

			if arg_316_1.time_ >= 0 + var_319_3 and arg_316_1.time_ < 0 + var_319_3 + arg_319_0 and not isNil(var_319_2) and arg_316_1.var_.characterEffect1061ui_story then
				arg_316_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_316_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_319_4 = arg_316_1.actors_["1061ui_story"].transform

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.var_.moveOldPos1061ui_story = var_319_4.localPosition
			end

			local var_319_5 = 0.001

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_5 then
				var_319_4.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_316_1.time_ - 0) / var_319_5)
				var_319_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_319_4.position).x, (manager.ui.mainCamera.transform.position - var_319_4.position).y, (manager.ui.mainCamera.transform.position - var_319_4.position).z)
				var_319_4.localEulerAngles.z = 0
				var_319_4.localEulerAngles.x = 0
				var_319_4.localEulerAngles = var_319_4.localEulerAngles
			end

			if arg_316_1.time_ >= 0 + var_319_5 and arg_316_1.time_ < 0 + var_319_5 + arg_319_0 then
				var_319_4.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				var_319_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_319_4.position).x, (manager.ui.mainCamera.transform.position - var_319_4.position).y, (manager.ui.mainCamera.transform.position - var_319_4.position).z)
				var_319_4.localEulerAngles.z = 0
				var_319_4.localEulerAngles.x = 0
				var_319_4.localEulerAngles = var_319_4.localEulerAngles
			end

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			local var_319_6 = arg_316_1.actors_["1085ui_story"].transform

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.var_.moveOldPos1085ui_story = var_319_6.localPosition
			end

			local var_319_7 = 0.001

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_7 then
				var_319_6.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_316_1.time_ - 0) / var_319_7)
				var_319_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_319_6.position).x, (manager.ui.mainCamera.transform.position - var_319_6.position).y, (manager.ui.mainCamera.transform.position - var_319_6.position).z)
				var_319_6.localEulerAngles.z = 0
				var_319_6.localEulerAngles.x = 0
				var_319_6.localEulerAngles = var_319_6.localEulerAngles
			end

			if arg_316_1.time_ >= 0 + var_319_7 and arg_316_1.time_ < 0 + var_319_7 + arg_319_0 then
				var_319_6.localPosition = Vector3.New(0.75, -1.01, -5.83)
				var_319_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_319_6.position).x, (manager.ui.mainCamera.transform.position - var_319_6.position).y, (manager.ui.mainCamera.transform.position - var_319_6.position).z)
				var_319_6.localEulerAngles.z = 0
				var_319_6.localEulerAngles.x = 0
				var_319_6.localEulerAngles = var_319_6.localEulerAngles
			end

			local var_319_8 = 0
			local var_319_9 = 0.275

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_8 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_10 = arg_316_1:GetWordFromCfg(420132077)
				local var_319_11 = arg_316_1:FormatText(var_319_10.content)

				arg_316_1.text_.text = var_319_11

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_13 = 11 <= 0 and var_319_9 or var_319_9 * (utf8.len(var_319_11) / 11)

				if (11 <= 0 and var_319_9 or var_319_9 * (utf8.len(var_319_11) / 11)) > 0 and var_319_9 < var_319_13 then
					arg_316_1.talkMaxDuration = var_319_13

					if var_319_13 + var_319_8 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_13 + var_319_8
					end
				end

				arg_316_1.text_.text = var_319_11
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132077", "story_v_out_420132.awb") ~= 0 then
					local var_319_14 = manager.audio:GetVoiceLength("story_v_out_420132", "420132077", "story_v_out_420132.awb") / 1000

					if var_319_14 + var_319_8 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_14 + var_319_8
					end

					if var_319_10.prefab_name ~= "" and arg_316_1.actors_[var_319_10.prefab_name] ~= nil then
						local var_319_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_10.prefab_name].transform, "story_v_out_420132", "420132077", "story_v_out_420132.awb")

						arg_316_1:RecordAudio("420132077", var_319_15)
						arg_316_1:RecordAudio("420132077", var_319_15)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_420132", "420132077", "story_v_out_420132.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_420132", "420132077", "story_v_out_420132.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_16 = math.max(var_319_9, arg_316_1.talkMaxDuration)

			if var_319_8 <= arg_316_1.time_ and arg_316_1.time_ < var_319_8 + var_319_16 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_8) / var_319_16

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_8 + var_319_16 and arg_316_1.time_ < var_319_8 + var_319_16 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play420132078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 420132078
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play420132079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 and not isNil(arg_320_1.actors_["1085ui_story"]) and arg_320_1.var_.characterEffect1085ui_story == nil then
				arg_320_1.var_.characterEffect1085ui_story = arg_320_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_0 = 0.200000002980232

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_0 and not isNil(arg_320_1.actors_["1085ui_story"]) then
				if arg_320_1.var_.characterEffect1085ui_story and not isNil(arg_320_1.actors_["1085ui_story"]) then
					arg_320_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_320_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_320_1.time_ - 0) / var_323_0)
				end
			end

			if arg_320_1.time_ >= 0 + var_323_0 and arg_320_1.time_ < 0 + var_323_0 + arg_323_0 and not isNil(arg_320_1.actors_["1085ui_story"]) and arg_320_1.var_.characterEffect1085ui_story then
				arg_320_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_320_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_323_1 = 0
			local var_323_2 = 0.925

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_3 = arg_320_1:FormatText(arg_320_1:GetWordFromCfg(420132078).content)

				arg_320_1.text_.text = var_323_3

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_5 = 37 <= 0 and var_323_2 or var_323_2 * (utf8.len(var_323_3) / 37)

				if (37 <= 0 and var_323_2 or var_323_2 * (utf8.len(var_323_3) / 37)) > 0 and var_323_2 < var_323_5 then
					arg_320_1.talkMaxDuration = var_323_5

					if var_323_5 + var_323_1 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_5 + var_323_1
					end
				end

				arg_320_1.text_.text = var_323_3
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_6 = math.max(var_323_2, arg_320_1.talkMaxDuration)

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_6 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_1) / var_323_6

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_1 + var_323_6 and arg_320_1.time_ < var_323_1 + var_323_6 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play420132079 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 420132079
		arg_324_1.duration_ = 21.37

		local var_324_0 = {
			zh = 10.2,
			ja = 21.366
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play420132080(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(arg_324_1.actors_["1085ui_story"]) and arg_324_1.var_.characterEffect1085ui_story == nil then
				arg_324_1.var_.characterEffect1085ui_story = arg_324_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_0 = 0.200000002980232

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_0 and not isNil(arg_324_1.actors_["1085ui_story"]) then
				if arg_324_1.var_.characterEffect1085ui_story and not isNil(arg_324_1.actors_["1085ui_story"]) then
					arg_324_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_324_1.time_ >= 0 + var_327_0 and arg_324_1.time_ < 0 + var_327_0 + arg_327_0 and not isNil(arg_324_1.actors_["1085ui_story"]) and arg_324_1.var_.characterEffect1085ui_story then
				arg_324_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_327_2 = 0
			local var_327_3 = 0.95

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_2 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_4 = arg_324_1:GetWordFromCfg(420132079)
				local var_327_5 = arg_324_1:FormatText(var_327_4.content)

				arg_324_1.text_.text = var_327_5

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_7 = 38 <= 0 and var_327_3 or var_327_3 * (utf8.len(var_327_5) / 38)

				if (38 <= 0 and var_327_3 or var_327_3 * (utf8.len(var_327_5) / 38)) > 0 and var_327_3 < var_327_7 then
					arg_324_1.talkMaxDuration = var_327_7

					if var_327_7 + var_327_2 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_7 + var_327_2
					end
				end

				arg_324_1.text_.text = var_327_5
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132079", "story_v_out_420132.awb") ~= 0 then
					local var_327_8 = manager.audio:GetVoiceLength("story_v_out_420132", "420132079", "story_v_out_420132.awb") / 1000

					if var_327_8 + var_327_2 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_8 + var_327_2
					end

					if var_327_4.prefab_name ~= "" and arg_324_1.actors_[var_327_4.prefab_name] ~= nil then
						local var_327_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_4.prefab_name].transform, "story_v_out_420132", "420132079", "story_v_out_420132.awb")

						arg_324_1:RecordAudio("420132079", var_327_9)
						arg_324_1:RecordAudio("420132079", var_327_9)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_420132", "420132079", "story_v_out_420132.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_420132", "420132079", "story_v_out_420132.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_10 = math.max(var_327_3, arg_324_1.talkMaxDuration)

			if var_327_2 <= arg_324_1.time_ and arg_324_1.time_ < var_327_2 + var_327_10 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_2) / var_327_10

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_2 + var_327_10 and arg_324_1.time_ < var_327_2 + var_327_10 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play420132080 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 420132080
		arg_328_1.duration_ = 15.63

		local var_328_0 = {
			zh = 9.2,
			ja = 15.633
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play420132081(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_2")
			end

			local var_331_0 = 0
			local var_331_1 = 0.875

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_2 = arg_328_1:GetWordFromCfg(420132080)
				local var_331_3 = arg_328_1:FormatText(var_331_2.content)

				arg_328_1.text_.text = var_331_3

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_5 = 35 <= 0 and var_331_1 or var_331_1 * (utf8.len(var_331_3) / 35)

				if (35 <= 0 and var_331_1 or var_331_1 * (utf8.len(var_331_3) / 35)) > 0 and var_331_1 < var_331_5 then
					arg_328_1.talkMaxDuration = var_331_5

					if var_331_5 + var_331_0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_5 + var_331_0
					end
				end

				arg_328_1.text_.text = var_331_3
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132080", "story_v_out_420132.awb") ~= 0 then
					local var_331_6 = manager.audio:GetVoiceLength("story_v_out_420132", "420132080", "story_v_out_420132.awb") / 1000

					if var_331_6 + var_331_0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_6 + var_331_0
					end

					if var_331_2.prefab_name ~= "" and arg_328_1.actors_[var_331_2.prefab_name] ~= nil then
						local var_331_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_2.prefab_name].transform, "story_v_out_420132", "420132080", "story_v_out_420132.awb")

						arg_328_1:RecordAudio("420132080", var_331_7)
						arg_328_1:RecordAudio("420132080", var_331_7)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_420132", "420132080", "story_v_out_420132.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_420132", "420132080", "story_v_out_420132.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_8 = math.max(var_331_1, arg_328_1.talkMaxDuration)

			if var_331_0 <= arg_328_1.time_ and arg_328_1.time_ < var_331_0 + var_331_8 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_0) / var_331_8

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_0 + var_331_8 and arg_328_1.time_ < var_331_0 + var_331_8 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play420132081 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 420132081
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play420132082(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.var_.moveOldPos1085ui_story = arg_332_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_335_0 = 0.001

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_0 then
				arg_332_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_332_1.time_ - 0) / var_335_0)
				arg_332_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_332_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["1085ui_story"].transform.position).z)
				arg_332_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_332_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_332_1.actors_["1085ui_story"].transform.localEulerAngles = arg_332_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_332_1.time_ >= 0 + var_335_0 and arg_332_1.time_ < 0 + var_335_0 + arg_335_0 then
				arg_332_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_332_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_332_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["1085ui_story"].transform.position).z)
				arg_332_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_332_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_332_1.actors_["1085ui_story"].transform.localEulerAngles = arg_332_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_335_1 = arg_332_1.actors_["1061ui_story"].transform

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.var_.moveOldPos1061ui_story = var_335_1.localPosition
			end

			local var_335_2 = 0.001

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_2 then
				var_335_1.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_332_1.time_ - 0) / var_335_2)
				var_335_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_335_1.position).x, (manager.ui.mainCamera.transform.position - var_335_1.position).y, (manager.ui.mainCamera.transform.position - var_335_1.position).z)
				var_335_1.localEulerAngles.z = 0
				var_335_1.localEulerAngles.x = 0
				var_335_1.localEulerAngles = var_335_1.localEulerAngles
			end

			if arg_332_1.time_ >= 0 + var_335_2 and arg_332_1.time_ < 0 + var_335_2 + arg_335_0 then
				var_335_1.localPosition = Vector3.New(0, 100, 0)
				var_335_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_335_1.position).x, (manager.ui.mainCamera.transform.position - var_335_1.position).y, (manager.ui.mainCamera.transform.position - var_335_1.position).z)
				var_335_1.localEulerAngles.z = 0
				var_335_1.localEulerAngles.x = 0
				var_335_1.localEulerAngles = var_335_1.localEulerAngles
			end

			local var_335_3 = 0
			local var_335_4 = 0.5

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_3 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, false)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_5 = arg_332_1:FormatText(arg_332_1:GetWordFromCfg(420132081).content)

				arg_332_1.text_.text = var_335_5

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_7 = 20 <= 0 and var_335_4 or var_335_4 * (utf8.len(var_335_5) / 20)

				if (20 <= 0 and var_335_4 or var_335_4 * (utf8.len(var_335_5) / 20)) > 0 and var_335_4 < var_335_7 then
					arg_332_1.talkMaxDuration = var_335_7

					if var_335_7 + var_335_3 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_7 + var_335_3
					end
				end

				arg_332_1.text_.text = var_335_5
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_8 = math.max(var_335_4, arg_332_1.talkMaxDuration)

			if var_335_3 <= arg_332_1.time_ and arg_332_1.time_ < var_335_3 + var_335_8 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_3) / var_335_8

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_3 + var_335_8 and arg_332_1.time_ < var_335_3 + var_335_8 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_332_1:InitPlayNodeList()
	end,
	Play420132082 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 420132082
		arg_336_1.duration_ = 7.97

		local var_336_0 = {
			zh = 5.033,
			ja = 7.966
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
				arg_336_0:Play420132083(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				local var_339_0 = arg_336_1.bgs_.ST67

				arg_336_1.bgs_.ST67.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_339_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_339_1 = var_339_0:GetComponent("SpriteRenderer")

				if var_339_1 and var_339_1.sprite then
					local var_339_2 = 2 * (var_339_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_339_0.transform.localScale = Vector3.New(var_339_2 / var_339_1.sprite.bounds.size.y < var_339_2 * manager.ui.mainCameraCom_.aspect / var_339_1.sprite.bounds.size.x and var_339_2 * manager.ui.mainCameraCom_.aspect / var_339_1.sprite.bounds.size.x or var_339_2 / var_339_1.sprite.bounds.size.y, var_339_2 / var_339_1.sprite.bounds.size.y < var_339_2 * manager.ui.mainCameraCom_.aspect / var_339_1.sprite.bounds.size.x and var_339_2 * manager.ui.mainCameraCom_.aspect / var_339_1.sprite.bounds.size.x or var_339_2 / var_339_1.sprite.bounds.size.y, 0)
				end

				for iter_339_0, iter_339_1 in pairs(arg_336_1.bgs_) do
					if iter_339_0 ~= "ST67" then
						iter_339_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_339_3 = 2

			if 2 < arg_336_1.time_ and arg_336_1.time_ <= var_339_3 + arg_339_0 then
				arg_336_1.allBtn_.enabled = false
			end

			if arg_336_1.time_ >= var_339_3 + 0.3 and arg_336_1.time_ < var_339_3 + 0.3 + arg_339_0 then
				arg_336_1.allBtn_.enabled = true
			end

			local var_339_4 = 0

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_4 + arg_339_0 then
				arg_336_1.mask_.enabled = true
				arg_336_1.mask_.raycastTarget = true

				arg_336_1:SetGaussion(false)
			end

			local var_339_5 = 1

			if var_339_4 <= arg_336_1.time_ and arg_336_1.time_ < var_339_4 + var_339_5 then
				local var_339_6 = Color.New(0, 0, 0)

				var_339_6.a = Mathf.Lerp(0, 1, (arg_336_1.time_ - var_339_4) / var_339_5)
				arg_336_1.mask_.color = var_339_6
			end

			if arg_336_1.time_ >= var_339_4 + var_339_5 and arg_336_1.time_ < var_339_4 + var_339_5 + arg_339_0 then
				local var_339_7 = Color.New(0, 0, 0)

				var_339_7.a = 1
				arg_336_1.mask_.color = var_339_7
			end

			local var_339_8 = 1

			if 1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_8 + arg_339_0 then
				arg_336_1.mask_.enabled = true
				arg_336_1.mask_.raycastTarget = true

				arg_336_1:SetGaussion(false)
			end

			local var_339_9 = 1

			if var_339_8 <= arg_336_1.time_ and arg_336_1.time_ < var_339_8 + var_339_9 then
				local var_339_10 = Color.New(0, 0, 0)

				var_339_10.a = Mathf.Lerp(1, 0, (arg_336_1.time_ - var_339_8) / var_339_9)
				arg_336_1.mask_.color = var_339_10
			end

			if arg_336_1.time_ >= var_339_8 + var_339_9 and arg_336_1.time_ < var_339_8 + var_339_9 + arg_339_0 then
				local var_339_11 = Color.New(0, 0, 0)

				arg_336_1.mask_.enabled = false
				var_339_11.a = 0
				arg_336_1.mask_.color = var_339_11
			end

			local var_339_12 = arg_336_1.actors_["1061ui_story"]

			if 1.79999999701977 < arg_336_1.time_ and arg_336_1.time_ <= 1.79999999701977 + arg_339_0 and not isNil(var_339_12) and arg_336_1.var_.characterEffect1061ui_story == nil then
				arg_336_1.var_.characterEffect1061ui_story = var_339_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_13 = 0.200000002980232

			if 1.79999999701977 <= arg_336_1.time_ and arg_336_1.time_ < 1.79999999701977 + var_339_13 and not isNil(var_339_12) then
				if arg_336_1.var_.characterEffect1061ui_story and not isNil(var_339_12) then
					arg_336_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_336_1.time_ >= 1.79999999701977 + var_339_13 and arg_336_1.time_ < 1.79999999701977 + var_339_13 + arg_339_0 and not isNil(var_339_12) and arg_336_1.var_.characterEffect1061ui_story then
				arg_336_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_339_15 = arg_336_1.actors_["1061ui_story"].transform

			if 1.79999999701977 < arg_336_1.time_ and arg_336_1.time_ <= 1.79999999701977 + arg_339_0 then
				arg_336_1.var_.moveOldPos1061ui_story = var_339_15.localPosition
			end

			local var_339_16 = 0.001

			if 1.79999999701977 <= arg_336_1.time_ and arg_336_1.time_ < 1.79999999701977 + var_339_16 then
				var_339_15.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_336_1.time_ - 1.79999999701977) / var_339_16)
				var_339_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_339_15.position).x, (manager.ui.mainCamera.transform.position - var_339_15.position).y, (manager.ui.mainCamera.transform.position - var_339_15.position).z)
				var_339_15.localEulerAngles.z = 0
				var_339_15.localEulerAngles.x = 0
				var_339_15.localEulerAngles = var_339_15.localEulerAngles
			end

			if arg_336_1.time_ >= 1.79999999701977 + var_339_16 and arg_336_1.time_ < 1.79999999701977 + var_339_16 + arg_339_0 then
				var_339_15.localPosition = Vector3.New(0, -1.18, -6.15)
				var_339_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_339_15.position).x, (manager.ui.mainCamera.transform.position - var_339_15.position).y, (manager.ui.mainCamera.transform.position - var_339_15.position).z)
				var_339_15.localEulerAngles.z = 0
				var_339_15.localEulerAngles.x = 0
				var_339_15.localEulerAngles = var_339_15.localEulerAngles
			end

			if 1.79999999701977 < arg_336_1.time_ and arg_336_1.time_ <= 1.79999999701977 + arg_339_0 then
				arg_336_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 1.79999999701977 < arg_336_1.time_ and arg_336_1.time_ <= 1.79999999701977 + arg_339_0 then
				arg_336_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_339_17 = 1

			arg_336_1.isInRecall_ = false

			if var_339_17 < arg_336_1.time_ and arg_336_1.time_ <= var_339_17 + arg_339_0 then
				arg_336_1.screenFilterGo_:SetActive(true)

				arg_336_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_339_2, iter_339_3 in pairs(arg_336_1.actors_) do
					for iter_339_4, iter_339_5 in ipairs((iter_339_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_339_5.color = iter_339_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_339_18 = 0.2

			if var_339_17 <= arg_336_1.time_ and arg_336_1.time_ < var_339_17 + var_339_18 then
				arg_336_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_336_1.time_ - var_339_17) / var_339_18)
			end

			if arg_336_1.time_ >= var_339_17 + var_339_18 and arg_336_1.time_ < var_339_17 + var_339_18 + arg_339_0 then
				arg_336_1.screenFilterEffect_.weight = 1
			end

			if arg_336_1.frameCnt_ <= 1 then
				arg_336_1.dialog_:SetActive(false)
			end

			local var_339_19 = 2
			local var_339_20 = 0.375

			if 2 < arg_336_1.time_ and arg_336_1.time_ <= var_339_19 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0

				arg_336_1.dialog_:SetActive(true)

				arg_336_1.dialogCg_.alpha = 0

				local var_339_21 = LeanTween.value(arg_336_1.dialog_, 0, 1, 0.3)

				var_339_21:setOnUpdate(LuaHelper.FloatAction(function(arg_340_0)
					arg_336_1.dialogCg_.alpha = arg_340_0
				end))
				var_339_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_336_1.dialog_)
					var_339_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_336_1.duration_ = arg_336_1.duration_ + 0.3

				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_22 = arg_336_1:GetWordFromCfg(420132082)
				local var_339_23 = arg_336_1:FormatText(var_339_22.content)

				arg_336_1.text_.text = var_339_23

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_25 = 15 <= 0 and var_339_20 or var_339_20 * (utf8.len(var_339_23) / 15)

				if (15 <= 0 and var_339_20 or var_339_20 * (utf8.len(var_339_23) / 15)) > 0 and var_339_20 < var_339_25 then
					arg_336_1.talkMaxDuration = var_339_25
					var_339_19 = var_339_19 + 0.3

					if var_339_25 + var_339_19 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_25 + var_339_19
					end
				end

				arg_336_1.text_.text = var_339_23
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132082", "story_v_out_420132.awb") ~= 0 then
					local var_339_26 = manager.audio:GetVoiceLength("story_v_out_420132", "420132082", "story_v_out_420132.awb") / 1000

					if var_339_26 + var_339_19 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_26 + var_339_19
					end

					if var_339_22.prefab_name ~= "" and arg_336_1.actors_[var_339_22.prefab_name] ~= nil then
						local var_339_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_22.prefab_name].transform, "story_v_out_420132", "420132082", "story_v_out_420132.awb")

						arg_336_1:RecordAudio("420132082", var_339_27)
						arg_336_1:RecordAudio("420132082", var_339_27)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_420132", "420132082", "story_v_out_420132.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_420132", "420132082", "story_v_out_420132.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_28 = var_339_19 + 0.3
			local var_339_29 = math.max(var_339_20, arg_336_1.talkMaxDuration)

			if var_339_19 + 0.3 <= arg_336_1.time_ and arg_336_1.time_ < var_339_28 + var_339_29 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_28) / var_339_29

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_28 + var_339_29 and arg_336_1.time_ < var_339_28 + var_339_29 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.79999999701977,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_336_1:InitPlayNodeList()
	end,
	Play420132083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 420132083
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play420132084(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.var_.moveOldPos1061ui_story = arg_342_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_345_0 = 0.001

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 then
				arg_342_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_342_1.time_ - 0) / var_345_0)
				arg_342_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_342_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["1061ui_story"].transform.position).z)
				arg_342_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_342_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_342_1.actors_["1061ui_story"].transform.localEulerAngles = arg_342_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 then
				arg_342_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_342_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_342_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["1061ui_story"].transform.position).z)
				arg_342_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_342_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_342_1.actors_["1061ui_story"].transform.localEulerAngles = arg_342_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_345_1 = 0
			local var_345_2 = 1.15

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_3 = arg_342_1:FormatText(arg_342_1:GetWordFromCfg(420132083).content)

				arg_342_1.text_.text = var_345_3

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_5 = 46 <= 0 and var_345_2 or var_345_2 * (utf8.len(var_345_3) / 46)

				if (46 <= 0 and var_345_2 or var_345_2 * (utf8.len(var_345_3) / 46)) > 0 and var_345_2 < var_345_5 then
					arg_342_1.talkMaxDuration = var_345_5

					if var_345_5 + var_345_1 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_5 + var_345_1
					end
				end

				arg_342_1.text_.text = var_345_3
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_6 = math.max(var_345_2, arg_342_1.talkMaxDuration)

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_6 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_1) / var_345_6

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_1 + var_345_6 and arg_342_1.time_ < var_345_1 + var_345_6 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_342_1:InitPlayNodeList()
	end,
	Play420132084 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 420132084
		arg_346_1.duration_ = 7

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play420132085(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 2 < arg_346_1.time_ and arg_346_1.time_ <= 2 + arg_349_0 then
				arg_346_1.allBtn_.enabled = false
			end

			if arg_346_1.time_ >= 2 + 0.3 and arg_346_1.time_ < 2 + 0.3 + arg_349_0 then
				arg_346_1.allBtn_.enabled = true
			end

			if 1 < arg_346_1.time_ and arg_346_1.time_ <= 1 + arg_349_0 then
				local var_349_0 = arg_346_1.bgs_.ST67

				arg_346_1.bgs_.ST67.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_349_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_349_1 = var_349_0:GetComponent("SpriteRenderer")

				if var_349_1 and var_349_1.sprite then
					local var_349_2 = 2 * (var_349_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_349_0.transform.localScale = Vector3.New(var_349_2 / var_349_1.sprite.bounds.size.y < var_349_2 * manager.ui.mainCameraCom_.aspect / var_349_1.sprite.bounds.size.x and var_349_2 * manager.ui.mainCameraCom_.aspect / var_349_1.sprite.bounds.size.x or var_349_2 / var_349_1.sprite.bounds.size.y, var_349_2 / var_349_1.sprite.bounds.size.y < var_349_2 * manager.ui.mainCameraCom_.aspect / var_349_1.sprite.bounds.size.x and var_349_2 * manager.ui.mainCameraCom_.aspect / var_349_1.sprite.bounds.size.x or var_349_2 / var_349_1.sprite.bounds.size.y, 0)
				end

				for iter_349_0, iter_349_1 in pairs(arg_346_1.bgs_) do
					if iter_349_0 ~= "ST67" then
						iter_349_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_349_3 = 0

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_3 + arg_349_0 then
				arg_346_1.mask_.enabled = true
				arg_346_1.mask_.raycastTarget = true

				arg_346_1:SetGaussion(false)
			end

			local var_349_4 = 1

			if var_349_3 <= arg_346_1.time_ and arg_346_1.time_ < var_349_3 + var_349_4 then
				local var_349_5 = Color.New(0, 0, 0)

				var_349_5.a = Mathf.Lerp(0, 1, (arg_346_1.time_ - var_349_3) / var_349_4)
				arg_346_1.mask_.color = var_349_5
			end

			if arg_346_1.time_ >= var_349_3 + var_349_4 and arg_346_1.time_ < var_349_3 + var_349_4 + arg_349_0 then
				local var_349_6 = Color.New(0, 0, 0)

				var_349_6.a = 1
				arg_346_1.mask_.color = var_349_6
			end

			local var_349_7 = 1

			if 1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_7 + arg_349_0 then
				arg_346_1.mask_.enabled = true
				arg_346_1.mask_.raycastTarget = true

				arg_346_1:SetGaussion(false)
			end

			local var_349_8 = 1

			if var_349_7 <= arg_346_1.time_ and arg_346_1.time_ < var_349_7 + var_349_8 then
				local var_349_9 = Color.New(0, 0, 0)

				var_349_9.a = Mathf.Lerp(1, 0, (arg_346_1.time_ - var_349_7) / var_349_8)
				arg_346_1.mask_.color = var_349_9
			end

			if arg_346_1.time_ >= var_349_7 + var_349_8 and arg_346_1.time_ < var_349_7 + var_349_8 + arg_349_0 then
				local var_349_10 = Color.New(0, 0, 0)

				arg_346_1.mask_.enabled = false
				var_349_10.a = 0
				arg_346_1.mask_.color = var_349_10
			end

			local var_349_11 = 0.9

			arg_346_1.isInRecall_ = false

			if var_349_11 < arg_346_1.time_ and arg_346_1.time_ <= var_349_11 + arg_349_0 then
				arg_346_1.screenFilterGo_:SetActive(false)

				for iter_349_2, iter_349_3 in pairs(arg_346_1.actors_) do
					for iter_349_4, iter_349_5 in ipairs((iter_349_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_349_5.color = iter_349_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_349_12 = 0.1

			if var_349_11 <= arg_346_1.time_ and arg_346_1.time_ < var_349_11 + var_349_12 then
				arg_346_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_346_1.time_ - var_349_11) / var_349_12)
			end

			if arg_346_1.time_ >= var_349_11 + var_349_12 and arg_346_1.time_ < var_349_11 + var_349_12 + arg_349_0 then
				arg_346_1.screenFilterEffect_.weight = 0
			end

			if arg_346_1.frameCnt_ <= 1 then
				arg_346_1.dialog_:SetActive(false)
			end

			local var_349_13 = 2
			local var_349_14 = 0.375

			if 2 < arg_346_1.time_ and arg_346_1.time_ <= var_349_13 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0

				arg_346_1.dialog_:SetActive(true)

				arg_346_1.dialogCg_.alpha = 0

				local var_349_15 = LeanTween.value(arg_346_1.dialog_, 0, 1, 0.3)

				var_349_15:setOnUpdate(LuaHelper.FloatAction(function(arg_350_0)
					arg_346_1.dialogCg_.alpha = arg_350_0
				end))
				var_349_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_346_1.dialog_)
					var_349_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_346_1.duration_ = arg_346_1.duration_ + 0.3

				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_16 = arg_346_1:FormatText(arg_346_1:GetWordFromCfg(420132084).content)

				arg_346_1.text_.text = var_349_16

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_18 = 15 <= 0 and var_349_14 or var_349_14 * (utf8.len(var_349_16) / 15)

				if (15 <= 0 and var_349_14 or var_349_14 * (utf8.len(var_349_16) / 15)) > 0 and var_349_14 < var_349_18 then
					arg_346_1.talkMaxDuration = var_349_18
					var_349_13 = var_349_13 + 0.3

					if var_349_18 + var_349_13 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_18 + var_349_13
					end
				end

				arg_346_1.text_.text = var_349_16
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_19 = var_349_13 + 0.3
			local var_349_20 = math.max(var_349_14, arg_346_1.talkMaxDuration)

			if var_349_13 + 0.3 <= arg_346_1.time_ and arg_346_1.time_ < var_349_19 + var_349_20 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_19) / var_349_20

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_19 + var_349_20 and arg_346_1.time_ < var_349_19 + var_349_20 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play420132085 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 420132085
		arg_352_1.duration_ = 9.17

		local var_352_0 = {
			zh = 7.1,
			ja = 9.166
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play420132086(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(arg_352_1.actors_["1061ui_story"]) and arg_352_1.var_.characterEffect1061ui_story == nil then
				arg_352_1.var_.characterEffect1061ui_story = arg_352_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_0 = 0.200000002980232

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_0 and not isNil(arg_352_1.actors_["1061ui_story"]) then
				if arg_352_1.var_.characterEffect1061ui_story and not isNil(arg_352_1.actors_["1061ui_story"]) then
					arg_352_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_352_1.time_ >= 0 + var_355_0 and arg_352_1.time_ < 0 + var_355_0 + arg_355_0 and not isNil(arg_352_1.actors_["1061ui_story"]) and arg_352_1.var_.characterEffect1061ui_story then
				arg_352_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_355_2 = arg_352_1.actors_["1061ui_story"].transform

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.var_.moveOldPos1061ui_story = var_355_2.localPosition
			end

			local var_355_3 = 0.001

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_3 then
				var_355_2.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_352_1.time_ - 0) / var_355_3)
				var_355_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_355_2.position).x, (manager.ui.mainCamera.transform.position - var_355_2.position).y, (manager.ui.mainCamera.transform.position - var_355_2.position).z)
				var_355_2.localEulerAngles.z = 0
				var_355_2.localEulerAngles.x = 0
				var_355_2.localEulerAngles = var_355_2.localEulerAngles
			end

			if arg_352_1.time_ >= 0 + var_355_3 and arg_352_1.time_ < 0 + var_355_3 + arg_355_0 then
				var_355_2.localPosition = Vector3.New(0, -1.18, -6.15)
				var_355_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_355_2.position).x, (manager.ui.mainCamera.transform.position - var_355_2.position).y, (manager.ui.mainCamera.transform.position - var_355_2.position).z)
				var_355_2.localEulerAngles.z = 0
				var_355_2.localEulerAngles.x = 0
				var_355_2.localEulerAngles = var_355_2.localEulerAngles
			end

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_355_4 = 0
			local var_355_5 = 0.5

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_4 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_6 = arg_352_1:GetWordFromCfg(420132085)
				local var_355_7 = arg_352_1:FormatText(var_355_6.content)

				arg_352_1.text_.text = var_355_7

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_9 = 20 <= 0 and var_355_5 or var_355_5 * (utf8.len(var_355_7) / 20)

				if (20 <= 0 and var_355_5 or var_355_5 * (utf8.len(var_355_7) / 20)) > 0 and var_355_5 < var_355_9 then
					arg_352_1.talkMaxDuration = var_355_9

					if var_355_9 + var_355_4 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_9 + var_355_4
					end
				end

				arg_352_1.text_.text = var_355_7
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132085", "story_v_out_420132.awb") ~= 0 then
					local var_355_10 = manager.audio:GetVoiceLength("story_v_out_420132", "420132085", "story_v_out_420132.awb") / 1000

					if var_355_10 + var_355_4 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_10 + var_355_4
					end

					if var_355_6.prefab_name ~= "" and arg_352_1.actors_[var_355_6.prefab_name] ~= nil then
						local var_355_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_6.prefab_name].transform, "story_v_out_420132", "420132085", "story_v_out_420132.awb")

						arg_352_1:RecordAudio("420132085", var_355_11)
						arg_352_1:RecordAudio("420132085", var_355_11)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_420132", "420132085", "story_v_out_420132.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_420132", "420132085", "story_v_out_420132.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_12 = math.max(var_355_5, arg_352_1.talkMaxDuration)

			if var_355_4 <= arg_352_1.time_ and arg_352_1.time_ < var_355_4 + var_355_12 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_4) / var_355_12

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_4 + var_355_12 and arg_352_1.time_ < var_355_4 + var_355_12 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_352_1:InitPlayNodeList()
	end,
	Play420132086 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 420132086
		arg_356_1.duration_ = 5

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play420132087(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 and not isNil(arg_356_1.actors_["1061ui_story"]) and arg_356_1.var_.characterEffect1061ui_story == nil then
				arg_356_1.var_.characterEffect1061ui_story = arg_356_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_0 = 0.200000002980232

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_0 and not isNil(arg_356_1.actors_["1061ui_story"]) then
				if arg_356_1.var_.characterEffect1061ui_story and not isNil(arg_356_1.actors_["1061ui_story"]) then
					arg_356_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_356_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_356_1.time_ - 0) / var_359_0)
				end
			end

			if arg_356_1.time_ >= 0 + var_359_0 and arg_356_1.time_ < 0 + var_359_0 + arg_359_0 and not isNil(arg_356_1.actors_["1061ui_story"]) and arg_356_1.var_.characterEffect1061ui_story then
				arg_356_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_356_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_359_1 = 0
			local var_359_2 = 1.025

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, false)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_3 = arg_356_1:FormatText(arg_356_1:GetWordFromCfg(420132086).content)

				arg_356_1.text_.text = var_359_3

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_5 = 41 <= 0 and var_359_2 or var_359_2 * (utf8.len(var_359_3) / 41)

				if (41 <= 0 and var_359_2 or var_359_2 * (utf8.len(var_359_3) / 41)) > 0 and var_359_2 < var_359_5 then
					arg_356_1.talkMaxDuration = var_359_5

					if var_359_5 + var_359_1 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_5 + var_359_1
					end
				end

				arg_356_1.text_.text = var_359_3
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_6 = math.max(var_359_2, arg_356_1.talkMaxDuration)

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_6 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_1) / var_359_6

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_1 + var_359_6 and arg_356_1.time_ < var_359_1 + var_359_6 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play420132087 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 420132087
		arg_360_1.duration_ = 10.2

		local var_360_0 = {
			zh = 6.266,
			ja = 10.2
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play420132088(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 and not isNil(arg_360_1.actors_["1061ui_story"]) and arg_360_1.var_.characterEffect1061ui_story == nil then
				arg_360_1.var_.characterEffect1061ui_story = arg_360_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_0 = 0.200000002980232

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_0 and not isNil(arg_360_1.actors_["1061ui_story"]) then
				if arg_360_1.var_.characterEffect1061ui_story and not isNil(arg_360_1.actors_["1061ui_story"]) then
					arg_360_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_360_1.time_ >= 0 + var_363_0 and arg_360_1.time_ < 0 + var_363_0 + arg_363_0 and not isNil(arg_360_1.actors_["1061ui_story"]) and arg_360_1.var_.characterEffect1061ui_story then
				arg_360_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_363_2 = 0
			local var_363_3 = 0.9

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_2 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_4 = arg_360_1:GetWordFromCfg(420132087)
				local var_363_5 = arg_360_1:FormatText(var_363_4.content)

				arg_360_1.text_.text = var_363_5

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_7 = 36 <= 0 and var_363_3 or var_363_3 * (utf8.len(var_363_5) / 36)

				if (36 <= 0 and var_363_3 or var_363_3 * (utf8.len(var_363_5) / 36)) > 0 and var_363_3 < var_363_7 then
					arg_360_1.talkMaxDuration = var_363_7

					if var_363_7 + var_363_2 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_7 + var_363_2
					end
				end

				arg_360_1.text_.text = var_363_5
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132087", "story_v_out_420132.awb") ~= 0 then
					local var_363_8 = manager.audio:GetVoiceLength("story_v_out_420132", "420132087", "story_v_out_420132.awb") / 1000

					if var_363_8 + var_363_2 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_8 + var_363_2
					end

					if var_363_4.prefab_name ~= "" and arg_360_1.actors_[var_363_4.prefab_name] ~= nil then
						local var_363_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_4.prefab_name].transform, "story_v_out_420132", "420132087", "story_v_out_420132.awb")

						arg_360_1:RecordAudio("420132087", var_363_9)
						arg_360_1:RecordAudio("420132087", var_363_9)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_420132", "420132087", "story_v_out_420132.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_420132", "420132087", "story_v_out_420132.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_10 = math.max(var_363_3, arg_360_1.talkMaxDuration)

			if var_363_2 <= arg_360_1.time_ and arg_360_1.time_ < var_363_2 + var_363_10 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_2) / var_363_10

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_2 + var_363_10 and arg_360_1.time_ < var_363_2 + var_363_10 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play420132088 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 420132088
		arg_364_1.duration_ = 5

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play420132089(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.var_.moveOldPos1061ui_story = arg_364_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_367_0 = 0.001

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_0 then
				arg_364_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_364_1.time_ - 0) / var_367_0)
				arg_364_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_364_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_364_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_364_1.actors_["1061ui_story"].transform.position).z)
				arg_364_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_364_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_364_1.actors_["1061ui_story"].transform.localEulerAngles = arg_364_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_364_1.time_ >= 0 + var_367_0 and arg_364_1.time_ < 0 + var_367_0 + arg_367_0 then
				arg_364_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_364_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_364_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_364_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_364_1.actors_["1061ui_story"].transform.position).z)
				arg_364_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_364_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_364_1.actors_["1061ui_story"].transform.localEulerAngles = arg_364_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_367_1 = 0
			local var_367_2 = 0.6

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_3 = arg_364_1:FormatText(arg_364_1:GetWordFromCfg(420132088).content)

				arg_364_1.text_.text = var_367_3

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_5 = 24 <= 0 and var_367_2 or var_367_2 * (utf8.len(var_367_3) / 24)

				if (24 <= 0 and var_367_2 or var_367_2 * (utf8.len(var_367_3) / 24)) > 0 and var_367_2 < var_367_5 then
					arg_364_1.talkMaxDuration = var_367_5

					if var_367_5 + var_367_1 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_5 + var_367_1
					end
				end

				arg_364_1.text_.text = var_367_3
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)
				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_6 = math.max(var_367_2, arg_364_1.talkMaxDuration)

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_6 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_1) / var_367_6

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_1 + var_367_6 and arg_364_1.time_ < var_367_1 + var_367_6 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_364_1:InitPlayNodeList()
	end,
	Play420132089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 420132089
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play420132090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0.325

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, true)
				arg_368_1.iconController_:SetSelectedState("hero")

				arg_368_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_368_1.callingController_:SetSelectedState("normal")

				arg_368_1.keyicon_.color = Color.New(1, 1, 1)
				arg_368_1.icon_.color = Color.New(1, 1, 1)

				local var_371_1 = arg_368_1:FormatText(arg_368_1:GetWordFromCfg(420132089).content)

				arg_368_1.text_.text = var_371_1

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_3 = 13 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_1) / 13)

				if (13 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_1) / 13)) > 0 and var_371_0 < var_371_3 then
					arg_368_1.talkMaxDuration = var_371_3

					if var_371_3 + 0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_3 + 0
					end
				end

				arg_368_1.text_.text = var_371_1
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_4 = math.max(var_371_0, arg_368_1.talkMaxDuration)

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_4 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - 0) / var_371_4

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= 0 + var_371_4 and arg_368_1.time_ < 0 + var_371_4 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play420132090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 420132090
		arg_372_1.duration_ = 5.2

		local var_372_0 = {
			zh = 3.966,
			ja = 5.2
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play420132091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 and not isNil(arg_372_1.actors_["1061ui_story"]) and arg_372_1.var_.characterEffect1061ui_story == nil then
				arg_372_1.var_.characterEffect1061ui_story = arg_372_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_0 = 0.200000002980232

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_0 and not isNil(arg_372_1.actors_["1061ui_story"]) then
				if arg_372_1.var_.characterEffect1061ui_story and not isNil(arg_372_1.actors_["1061ui_story"]) then
					arg_372_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_372_1.time_ >= 0 + var_375_0 and arg_372_1.time_ < 0 + var_375_0 + arg_375_0 and not isNil(arg_372_1.actors_["1061ui_story"]) and arg_372_1.var_.characterEffect1061ui_story then
				arg_372_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_375_2 = arg_372_1.actors_["1061ui_story"].transform

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1.var_.moveOldPos1061ui_story = var_375_2.localPosition
			end

			local var_375_3 = 0.001

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_3 then
				var_375_2.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_372_1.time_ - 0) / var_375_3)
				var_375_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_375_2.position).x, (manager.ui.mainCamera.transform.position - var_375_2.position).y, (manager.ui.mainCamera.transform.position - var_375_2.position).z)
				var_375_2.localEulerAngles.z = 0
				var_375_2.localEulerAngles.x = 0
				var_375_2.localEulerAngles = var_375_2.localEulerAngles
			end

			if arg_372_1.time_ >= 0 + var_375_3 and arg_372_1.time_ < 0 + var_375_3 + arg_375_0 then
				var_375_2.localPosition = Vector3.New(0, -1.18, -6.15)
				var_375_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_375_2.position).x, (manager.ui.mainCamera.transform.position - var_375_2.position).y, (manager.ui.mainCamera.transform.position - var_375_2.position).z)
				var_375_2.localEulerAngles.z = 0
				var_375_2.localEulerAngles.x = 0
				var_375_2.localEulerAngles = var_375_2.localEulerAngles
			end

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_375_4 = 0
			local var_375_5 = 0.5

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_4 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_6 = arg_372_1:GetWordFromCfg(420132090)
				local var_375_7 = arg_372_1:FormatText(var_375_6.content)

				arg_372_1.text_.text = var_375_7

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_9 = 20 <= 0 and var_375_5 or var_375_5 * (utf8.len(var_375_7) / 20)

				if (20 <= 0 and var_375_5 or var_375_5 * (utf8.len(var_375_7) / 20)) > 0 and var_375_5 < var_375_9 then
					arg_372_1.talkMaxDuration = var_375_9

					if var_375_9 + var_375_4 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_9 + var_375_4
					end
				end

				arg_372_1.text_.text = var_375_7
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132090", "story_v_out_420132.awb") ~= 0 then
					local var_375_10 = manager.audio:GetVoiceLength("story_v_out_420132", "420132090", "story_v_out_420132.awb") / 1000

					if var_375_10 + var_375_4 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_10 + var_375_4
					end

					if var_375_6.prefab_name ~= "" and arg_372_1.actors_[var_375_6.prefab_name] ~= nil then
						local var_375_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_6.prefab_name].transform, "story_v_out_420132", "420132090", "story_v_out_420132.awb")

						arg_372_1:RecordAudio("420132090", var_375_11)
						arg_372_1:RecordAudio("420132090", var_375_11)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_420132", "420132090", "story_v_out_420132.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_420132", "420132090", "story_v_out_420132.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_12 = math.max(var_375_5, arg_372_1.talkMaxDuration)

			if var_375_4 <= arg_372_1.time_ and arg_372_1.time_ < var_375_4 + var_375_12 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_4) / var_375_12

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_4 + var_375_12 and arg_372_1.time_ < var_375_4 + var_375_12 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_372_1:InitPlayNodeList()
	end,
	Play420132091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 420132091
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play420132092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 and not isNil(arg_376_1.actors_["1061ui_story"]) and arg_376_1.var_.characterEffect1061ui_story == nil then
				arg_376_1.var_.characterEffect1061ui_story = arg_376_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_0 = 0.200000002980232

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_0 and not isNil(arg_376_1.actors_["1061ui_story"]) then
				if arg_376_1.var_.characterEffect1061ui_story and not isNil(arg_376_1.actors_["1061ui_story"]) then
					arg_376_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_376_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_376_1.time_ - 0) / var_379_0)
				end
			end

			if arg_376_1.time_ >= 0 + var_379_0 and arg_376_1.time_ < 0 + var_379_0 + arg_379_0 and not isNil(arg_376_1.actors_["1061ui_story"]) and arg_376_1.var_.characterEffect1061ui_story then
				arg_376_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_376_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_379_1 = 0
			local var_379_2 = 1.3

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, false)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_3 = arg_376_1:FormatText(arg_376_1:GetWordFromCfg(420132091).content)

				arg_376_1.text_.text = var_379_3

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_5 = 52 <= 0 and var_379_2 or var_379_2 * (utf8.len(var_379_3) / 52)

				if (52 <= 0 and var_379_2 or var_379_2 * (utf8.len(var_379_3) / 52)) > 0 and var_379_2 < var_379_5 then
					arg_376_1.talkMaxDuration = var_379_5

					if var_379_5 + var_379_1 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_5 + var_379_1
					end
				end

				arg_376_1.text_.text = var_379_3
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_6 = math.max(var_379_2, arg_376_1.talkMaxDuration)

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_6 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_1) / var_379_6

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_1 + var_379_6 and arg_376_1.time_ < var_379_1 + var_379_6 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play420132092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 420132092
		arg_380_1.duration_ = 9.03

		local var_380_0 = {
			zh = 9.033,
			ja = 8.933
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play420132093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(arg_380_1.actors_["1061ui_story"]) and arg_380_1.var_.characterEffect1061ui_story == nil then
				arg_380_1.var_.characterEffect1061ui_story = arg_380_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_0 = 0.200000002980232

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_0 and not isNil(arg_380_1.actors_["1061ui_story"]) then
				if arg_380_1.var_.characterEffect1061ui_story and not isNil(arg_380_1.actors_["1061ui_story"]) then
					arg_380_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_380_1.time_ >= 0 + var_383_0 and arg_380_1.time_ < 0 + var_383_0 + arg_383_0 and not isNil(arg_380_1.actors_["1061ui_story"]) and arg_380_1.var_.characterEffect1061ui_story then
				arg_380_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_383_2 = 0
			local var_383_3 = 0.925

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_2 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_4 = arg_380_1:GetWordFromCfg(420132092)
				local var_383_5 = arg_380_1:FormatText(var_383_4.content)

				arg_380_1.text_.text = var_383_5

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_7 = 37 <= 0 and var_383_3 or var_383_3 * (utf8.len(var_383_5) / 37)

				if (37 <= 0 and var_383_3 or var_383_3 * (utf8.len(var_383_5) / 37)) > 0 and var_383_3 < var_383_7 then
					arg_380_1.talkMaxDuration = var_383_7

					if var_383_7 + var_383_2 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_7 + var_383_2
					end
				end

				arg_380_1.text_.text = var_383_5
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132092", "story_v_out_420132.awb") ~= 0 then
					local var_383_8 = manager.audio:GetVoiceLength("story_v_out_420132", "420132092", "story_v_out_420132.awb") / 1000

					if var_383_8 + var_383_2 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_8 + var_383_2
					end

					if var_383_4.prefab_name ~= "" and arg_380_1.actors_[var_383_4.prefab_name] ~= nil then
						local var_383_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_4.prefab_name].transform, "story_v_out_420132", "420132092", "story_v_out_420132.awb")

						arg_380_1:RecordAudio("420132092", var_383_9)
						arg_380_1:RecordAudio("420132092", var_383_9)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_420132", "420132092", "story_v_out_420132.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_420132", "420132092", "story_v_out_420132.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_10 = math.max(var_383_3, arg_380_1.talkMaxDuration)

			if var_383_2 <= arg_380_1.time_ and arg_380_1.time_ < var_383_2 + var_383_10 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_2) / var_383_10

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_2 + var_383_10 and arg_380_1.time_ < var_383_2 + var_383_10 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play420132093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 420132093
		arg_384_1.duration_ = 10.03

		local var_384_0 = {
			zh = 7.033,
			ja = 10.033
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play420132094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0.7

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_1 = arg_384_1:GetWordFromCfg(420132093)
				local var_387_2 = arg_384_1:FormatText(var_387_1.content)

				arg_384_1.text_.text = var_387_2

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_4 = 28 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_2) / 28)

				if (28 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_2) / 28)) > 0 and var_387_0 < var_387_4 then
					arg_384_1.talkMaxDuration = var_387_4

					if var_387_4 + 0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_4 + 0
					end
				end

				arg_384_1.text_.text = var_387_2
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132093", "story_v_out_420132.awb") ~= 0 then
					local var_387_5 = manager.audio:GetVoiceLength("story_v_out_420132", "420132093", "story_v_out_420132.awb") / 1000

					if var_387_5 + 0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_5 + 0
					end

					if var_387_1.prefab_name ~= "" and arg_384_1.actors_[var_387_1.prefab_name] ~= nil then
						local var_387_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_1.prefab_name].transform, "story_v_out_420132", "420132093", "story_v_out_420132.awb")

						arg_384_1:RecordAudio("420132093", var_387_6)
						arg_384_1:RecordAudio("420132093", var_387_6)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_420132", "420132093", "story_v_out_420132.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_420132", "420132093", "story_v_out_420132.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_7 = math.max(var_387_0, arg_384_1.talkMaxDuration)

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_7 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - 0) / var_387_7

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= 0 + var_387_7 and arg_384_1.time_ < 0 + var_387_7 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play420132094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 420132094
		arg_388_1.duration_ = 7.43

		local var_388_0 = {
			zh = 7,
			ja = 7.433
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play420132095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(arg_388_1.actors_["1085ui_story"]) and arg_388_1.var_.characterEffect1085ui_story == nil then
				arg_388_1.var_.characterEffect1085ui_story = arg_388_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_0 = 0.200000002980232

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_0 and not isNil(arg_388_1.actors_["1085ui_story"]) then
				if arg_388_1.var_.characterEffect1085ui_story and not isNil(arg_388_1.actors_["1085ui_story"]) then
					arg_388_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_388_1.time_ >= 0 + var_391_0 and arg_388_1.time_ < 0 + var_391_0 + arg_391_0 and not isNil(arg_388_1.actors_["1085ui_story"]) and arg_388_1.var_.characterEffect1085ui_story then
				arg_388_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_391_2 = arg_388_1.actors_["1061ui_story"]

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(var_391_2) and arg_388_1.var_.characterEffect1061ui_story == nil then
				arg_388_1.var_.characterEffect1061ui_story = var_391_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_3 = 0.200000002980232

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_3 and not isNil(var_391_2) then
				if arg_388_1.var_.characterEffect1061ui_story and not isNil(var_391_2) then
					arg_388_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_388_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_388_1.time_ - 0) / var_391_3)
				end
			end

			if arg_388_1.time_ >= 0 + var_391_3 and arg_388_1.time_ < 0 + var_391_3 + arg_391_0 and not isNil(var_391_2) and arg_388_1.var_.characterEffect1061ui_story then
				arg_388_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_388_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_391_4 = arg_388_1.actors_["1061ui_story"].transform

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.var_.moveOldPos1061ui_story = var_391_4.localPosition
			end

			local var_391_5 = 0.001

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_5 then
				var_391_4.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_388_1.time_ - 0) / var_391_5)
				var_391_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_391_4.position).x, (manager.ui.mainCamera.transform.position - var_391_4.position).y, (manager.ui.mainCamera.transform.position - var_391_4.position).z)
				var_391_4.localEulerAngles.z = 0
				var_391_4.localEulerAngles.x = 0
				var_391_4.localEulerAngles = var_391_4.localEulerAngles
			end

			if arg_388_1.time_ >= 0 + var_391_5 and arg_388_1.time_ < 0 + var_391_5 + arg_391_0 then
				var_391_4.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				var_391_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_391_4.position).x, (manager.ui.mainCamera.transform.position - var_391_4.position).y, (manager.ui.mainCamera.transform.position - var_391_4.position).z)
				var_391_4.localEulerAngles.z = 0
				var_391_4.localEulerAngles.x = 0
				var_391_4.localEulerAngles = var_391_4.localEulerAngles
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_391_6 = arg_388_1.actors_["1085ui_story"].transform

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.var_.moveOldPos1085ui_story = var_391_6.localPosition
			end

			local var_391_7 = 0.001

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_7 then
				var_391_6.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_388_1.time_ - 0) / var_391_7)
				var_391_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_391_6.position).x, (manager.ui.mainCamera.transform.position - var_391_6.position).y, (manager.ui.mainCamera.transform.position - var_391_6.position).z)
				var_391_6.localEulerAngles.z = 0
				var_391_6.localEulerAngles.x = 0
				var_391_6.localEulerAngles = var_391_6.localEulerAngles
			end

			if arg_388_1.time_ >= 0 + var_391_7 and arg_388_1.time_ < 0 + var_391_7 + arg_391_0 then
				var_391_6.localPosition = Vector3.New(0.75, -1.01, -5.83)
				var_391_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_391_6.position).x, (manager.ui.mainCamera.transform.position - var_391_6.position).y, (manager.ui.mainCamera.transform.position - var_391_6.position).z)
				var_391_6.localEulerAngles.z = 0
				var_391_6.localEulerAngles.x = 0
				var_391_6.localEulerAngles = var_391_6.localEulerAngles
			end

			local var_391_8 = 0
			local var_391_9 = 0.525

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_8 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_10 = arg_388_1:GetWordFromCfg(420132094)
				local var_391_11 = arg_388_1:FormatText(var_391_10.content)

				arg_388_1.text_.text = var_391_11

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_13 = 21 <= 0 and var_391_9 or var_391_9 * (utf8.len(var_391_11) / 21)

				if (21 <= 0 and var_391_9 or var_391_9 * (utf8.len(var_391_11) / 21)) > 0 and var_391_9 < var_391_13 then
					arg_388_1.talkMaxDuration = var_391_13

					if var_391_13 + var_391_8 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_13 + var_391_8
					end
				end

				arg_388_1.text_.text = var_391_11
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132094", "story_v_out_420132.awb") ~= 0 then
					local var_391_14 = manager.audio:GetVoiceLength("story_v_out_420132", "420132094", "story_v_out_420132.awb") / 1000

					if var_391_14 + var_391_8 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_14 + var_391_8
					end

					if var_391_10.prefab_name ~= "" and arg_388_1.actors_[var_391_10.prefab_name] ~= nil then
						local var_391_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_10.prefab_name].transform, "story_v_out_420132", "420132094", "story_v_out_420132.awb")

						arg_388_1:RecordAudio("420132094", var_391_15)
						arg_388_1:RecordAudio("420132094", var_391_15)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_420132", "420132094", "story_v_out_420132.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_420132", "420132094", "story_v_out_420132.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_16 = math.max(var_391_9, arg_388_1.talkMaxDuration)

			if var_391_8 <= arg_388_1.time_ and arg_388_1.time_ < var_391_8 + var_391_16 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_8) / var_391_16

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_8 + var_391_16 and arg_388_1.time_ < var_391_8 + var_391_16 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	Play420132095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 420132095
		arg_392_1.duration_ = 6.87

		local var_392_0 = {
			zh = 4.7,
			ja = 6.866
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play420132096(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(arg_392_1.actors_["1061ui_story"]) and arg_392_1.var_.characterEffect1061ui_story == nil then
				arg_392_1.var_.characterEffect1061ui_story = arg_392_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_0 = 0.200000002980232

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_0 and not isNil(arg_392_1.actors_["1061ui_story"]) then
				if arg_392_1.var_.characterEffect1061ui_story and not isNil(arg_392_1.actors_["1061ui_story"]) then
					arg_392_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_392_1.time_ >= 0 + var_395_0 and arg_392_1.time_ < 0 + var_395_0 + arg_395_0 and not isNil(arg_392_1.actors_["1061ui_story"]) and arg_392_1.var_.characterEffect1061ui_story then
				arg_392_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_395_2 = arg_392_1.actors_["1085ui_story"]

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(var_395_2) and arg_392_1.var_.characterEffect1085ui_story == nil then
				arg_392_1.var_.characterEffect1085ui_story = var_395_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_3 = 0.200000002980232

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_3 and not isNil(var_395_2) then
				if arg_392_1.var_.characterEffect1085ui_story and not isNil(var_395_2) then
					arg_392_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_392_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_392_1.time_ - 0) / var_395_3)
				end
			end

			if arg_392_1.time_ >= 0 + var_395_3 and arg_392_1.time_ < 0 + var_395_3 + arg_395_0 and not isNil(var_395_2) and arg_392_1.var_.characterEffect1085ui_story then
				arg_392_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_392_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_395_4 = 0
			local var_395_5 = 0.5

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_4 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_6 = arg_392_1:GetWordFromCfg(420132095)
				local var_395_7 = arg_392_1:FormatText(var_395_6.content)

				arg_392_1.text_.text = var_395_7

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_9 = 20 <= 0 and var_395_5 or var_395_5 * (utf8.len(var_395_7) / 20)

				if (20 <= 0 and var_395_5 or var_395_5 * (utf8.len(var_395_7) / 20)) > 0 and var_395_5 < var_395_9 then
					arg_392_1.talkMaxDuration = var_395_9

					if var_395_9 + var_395_4 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_9 + var_395_4
					end
				end

				arg_392_1.text_.text = var_395_7
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132095", "story_v_out_420132.awb") ~= 0 then
					local var_395_10 = manager.audio:GetVoiceLength("story_v_out_420132", "420132095", "story_v_out_420132.awb") / 1000

					if var_395_10 + var_395_4 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_10 + var_395_4
					end

					if var_395_6.prefab_name ~= "" and arg_392_1.actors_[var_395_6.prefab_name] ~= nil then
						local var_395_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_6.prefab_name].transform, "story_v_out_420132", "420132095", "story_v_out_420132.awb")

						arg_392_1:RecordAudio("420132095", var_395_11)
						arg_392_1:RecordAudio("420132095", var_395_11)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_420132", "420132095", "story_v_out_420132.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_420132", "420132095", "story_v_out_420132.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_12 = math.max(var_395_5, arg_392_1.talkMaxDuration)

			if var_395_4 <= arg_392_1.time_ and arg_392_1.time_ < var_395_4 + var_395_12 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_4) / var_395_12

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_4 + var_395_12 and arg_392_1.time_ < var_395_4 + var_395_12 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play420132096 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 420132096
		arg_396_1.duration_ = 3.8

		local var_396_0 = {
			zh = 2.166,
			ja = 3.8
		}
		local var_396_1 = manager.audio:GetLocalizationFlag()

		if var_396_0[var_396_1] ~= nil then
			arg_396_1.duration_ = var_396_0[var_396_1]
		end

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play420132097(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 and not isNil(arg_396_1.actors_["1085ui_story"]) and arg_396_1.var_.characterEffect1085ui_story == nil then
				arg_396_1.var_.characterEffect1085ui_story = arg_396_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_0 = 0.200000002980232

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_0 and not isNil(arg_396_1.actors_["1085ui_story"]) then
				if arg_396_1.var_.characterEffect1085ui_story and not isNil(arg_396_1.actors_["1085ui_story"]) then
					arg_396_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_396_1.time_ >= 0 + var_399_0 and arg_396_1.time_ < 0 + var_399_0 + arg_399_0 and not isNil(arg_396_1.actors_["1085ui_story"]) and arg_396_1.var_.characterEffect1085ui_story then
				arg_396_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_399_2 = arg_396_1.actors_["1061ui_story"]

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 and not isNil(var_399_2) and arg_396_1.var_.characterEffect1061ui_story == nil then
				arg_396_1.var_.characterEffect1061ui_story = var_399_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_3 = 0.200000002980232

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_3 and not isNil(var_399_2) then
				if arg_396_1.var_.characterEffect1061ui_story and not isNil(var_399_2) then
					arg_396_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_396_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_396_1.time_ - 0) / var_399_3)
				end
			end

			if arg_396_1.time_ >= 0 + var_399_3 and arg_396_1.time_ < 0 + var_399_3 + arg_399_0 and not isNil(var_399_2) and arg_396_1.var_.characterEffect1061ui_story then
				arg_396_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_396_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_399_4 = 0
			local var_399_5 = 0.2

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_4 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				arg_396_1.leftNameTxt_.text = arg_396_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_6 = arg_396_1:GetWordFromCfg(420132096)
				local var_399_7 = arg_396_1:FormatText(var_399_6.content)

				arg_396_1.text_.text = var_399_7

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_9 = 8 <= 0 and var_399_5 or var_399_5 * (utf8.len(var_399_7) / 8)

				if (8 <= 0 and var_399_5 or var_399_5 * (utf8.len(var_399_7) / 8)) > 0 and var_399_5 < var_399_9 then
					arg_396_1.talkMaxDuration = var_399_9

					if var_399_9 + var_399_4 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_9 + var_399_4
					end
				end

				arg_396_1.text_.text = var_399_7
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132096", "story_v_out_420132.awb") ~= 0 then
					local var_399_10 = manager.audio:GetVoiceLength("story_v_out_420132", "420132096", "story_v_out_420132.awb") / 1000

					if var_399_10 + var_399_4 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_10 + var_399_4
					end

					if var_399_6.prefab_name ~= "" and arg_396_1.actors_[var_399_6.prefab_name] ~= nil then
						local var_399_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_6.prefab_name].transform, "story_v_out_420132", "420132096", "story_v_out_420132.awb")

						arg_396_1:RecordAudio("420132096", var_399_11)
						arg_396_1:RecordAudio("420132096", var_399_11)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_420132", "420132096", "story_v_out_420132.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_420132", "420132096", "story_v_out_420132.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_12 = math.max(var_399_5, arg_396_1.talkMaxDuration)

			if var_399_4 <= arg_396_1.time_ and arg_396_1.time_ < var_399_4 + var_399_12 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_4) / var_399_12

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_4 + var_399_12 and arg_396_1.time_ < var_399_4 + var_399_12 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play420132097 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 420132097
		arg_400_1.duration_ = 9.23

		local var_400_0 = {
			zh = 8.4,
			ja = 9.233
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
				arg_400_0:Play420132098(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(arg_400_1.actors_["1061ui_story"]) and arg_400_1.var_.characterEffect1061ui_story == nil then
				arg_400_1.var_.characterEffect1061ui_story = arg_400_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_0 = 0.200000002980232

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_0 and not isNil(arg_400_1.actors_["1061ui_story"]) then
				if arg_400_1.var_.characterEffect1061ui_story and not isNil(arg_400_1.actors_["1061ui_story"]) then
					arg_400_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_400_1.time_ >= 0 + var_403_0 and arg_400_1.time_ < 0 + var_403_0 + arg_403_0 and not isNil(arg_400_1.actors_["1061ui_story"]) and arg_400_1.var_.characterEffect1061ui_story then
				arg_400_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_403_2 = arg_400_1.actors_["1085ui_story"]

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(var_403_2) and arg_400_1.var_.characterEffect1085ui_story == nil then
				arg_400_1.var_.characterEffect1085ui_story = var_403_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_3 = 0.200000002980232

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_3 and not isNil(var_403_2) then
				if arg_400_1.var_.characterEffect1085ui_story and not isNil(var_403_2) then
					arg_400_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_400_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_400_1.time_ - 0) / var_403_3)
				end
			end

			if arg_400_1.time_ >= 0 + var_403_3 and arg_400_1.time_ < 0 + var_403_3 + arg_403_0 and not isNil(var_403_2) and arg_400_1.var_.characterEffect1085ui_story then
				arg_400_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_400_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_1")
			end

			local var_403_4 = 0
			local var_403_5 = 0.75

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_4 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_6 = arg_400_1:GetWordFromCfg(420132097)
				local var_403_7 = arg_400_1:FormatText(var_403_6.content)

				arg_400_1.text_.text = var_403_7

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_9 = 30 <= 0 and var_403_5 or var_403_5 * (utf8.len(var_403_7) / 30)

				if (30 <= 0 and var_403_5 or var_403_5 * (utf8.len(var_403_7) / 30)) > 0 and var_403_5 < var_403_9 then
					arg_400_1.talkMaxDuration = var_403_9

					if var_403_9 + var_403_4 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_9 + var_403_4
					end
				end

				arg_400_1.text_.text = var_403_7
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132097", "story_v_out_420132.awb") ~= 0 then
					local var_403_10 = manager.audio:GetVoiceLength("story_v_out_420132", "420132097", "story_v_out_420132.awb") / 1000

					if var_403_10 + var_403_4 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_10 + var_403_4
					end

					if var_403_6.prefab_name ~= "" and arg_400_1.actors_[var_403_6.prefab_name] ~= nil then
						local var_403_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_6.prefab_name].transform, "story_v_out_420132", "420132097", "story_v_out_420132.awb")

						arg_400_1:RecordAudio("420132097", var_403_11)
						arg_400_1:RecordAudio("420132097", var_403_11)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_420132", "420132097", "story_v_out_420132.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_420132", "420132097", "story_v_out_420132.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_12 = math.max(var_403_5, arg_400_1.talkMaxDuration)

			if var_403_4 <= arg_400_1.time_ and arg_400_1.time_ < var_403_4 + var_403_12 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_4) / var_403_12

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_4 + var_403_12 and arg_400_1.time_ < var_403_4 + var_403_12 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play420132098 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 420132098
		arg_404_1.duration_ = 2

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play420132099(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(arg_404_1.actors_["1085ui_story"]) and arg_404_1.var_.characterEffect1085ui_story == nil then
				arg_404_1.var_.characterEffect1085ui_story = arg_404_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_0 = 0.200000002980232

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_0 and not isNil(arg_404_1.actors_["1085ui_story"]) then
				if arg_404_1.var_.characterEffect1085ui_story and not isNil(arg_404_1.actors_["1085ui_story"]) then
					arg_404_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_404_1.time_ >= 0 + var_407_0 and arg_404_1.time_ < 0 + var_407_0 + arg_407_0 and not isNil(arg_404_1.actors_["1085ui_story"]) and arg_404_1.var_.characterEffect1085ui_story then
				arg_404_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_407_2 = arg_404_1.actors_["1061ui_story"]

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(var_407_2) and arg_404_1.var_.characterEffect1061ui_story == nil then
				arg_404_1.var_.characterEffect1061ui_story = var_407_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_3 = 0.200000002980232

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_3 and not isNil(var_407_2) then
				if arg_404_1.var_.characterEffect1061ui_story and not isNil(var_407_2) then
					arg_404_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_404_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_404_1.time_ - 0) / var_407_3)
				end
			end

			if arg_404_1.time_ >= 0 + var_407_3 and arg_404_1.time_ < 0 + var_407_3 + arg_407_0 and not isNil(var_407_2) and arg_404_1.var_.characterEffect1061ui_story then
				arg_404_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_404_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_407_4 = 0
			local var_407_5 = 0.1

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_4 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_6 = arg_404_1:GetWordFromCfg(420132098)
				local var_407_7 = arg_404_1:FormatText(var_407_6.content)

				arg_404_1.text_.text = var_407_7

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_9 = 4 <= 0 and var_407_5 or var_407_5 * (utf8.len(var_407_7) / 4)

				if (4 <= 0 and var_407_5 or var_407_5 * (utf8.len(var_407_7) / 4)) > 0 and var_407_5 < var_407_9 then
					arg_404_1.talkMaxDuration = var_407_9

					if var_407_9 + var_407_4 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_9 + var_407_4
					end
				end

				arg_404_1.text_.text = var_407_7
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132098", "story_v_out_420132.awb") ~= 0 then
					local var_407_10 = manager.audio:GetVoiceLength("story_v_out_420132", "420132098", "story_v_out_420132.awb") / 1000

					if var_407_10 + var_407_4 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_10 + var_407_4
					end

					if var_407_6.prefab_name ~= "" and arg_404_1.actors_[var_407_6.prefab_name] ~= nil then
						local var_407_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_6.prefab_name].transform, "story_v_out_420132", "420132098", "story_v_out_420132.awb")

						arg_404_1:RecordAudio("420132098", var_407_11)
						arg_404_1:RecordAudio("420132098", var_407_11)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_420132", "420132098", "story_v_out_420132.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_420132", "420132098", "story_v_out_420132.awb")
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
	Play420132099 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 420132099
		arg_408_1.duration_ = 3.07

		local var_408_0 = {
			zh = 2.233,
			ja = 3.066
		}
		local var_408_1 = manager.audio:GetLocalizationFlag()

		if var_408_0[var_408_1] ~= nil then
			arg_408_1.duration_ = var_408_0[var_408_1]
		end

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play420132100(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 and not isNil(arg_408_1.actors_["1061ui_story"]) and arg_408_1.var_.characterEffect1061ui_story == nil then
				arg_408_1.var_.characterEffect1061ui_story = arg_408_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_0 = 0.200000002980232

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_0 and not isNil(arg_408_1.actors_["1061ui_story"]) then
				if arg_408_1.var_.characterEffect1061ui_story and not isNil(arg_408_1.actors_["1061ui_story"]) then
					arg_408_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_408_1.time_ >= 0 + var_411_0 and arg_408_1.time_ < 0 + var_411_0 + arg_411_0 and not isNil(arg_408_1.actors_["1061ui_story"]) and arg_408_1.var_.characterEffect1061ui_story then
				arg_408_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_411_2 = arg_408_1.actors_["1085ui_story"]

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 and not isNil(var_411_2) and arg_408_1.var_.characterEffect1085ui_story == nil then
				arg_408_1.var_.characterEffect1085ui_story = var_411_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_3 = 0.200000002980232

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_3 and not isNil(var_411_2) then
				if arg_408_1.var_.characterEffect1085ui_story and not isNil(var_411_2) then
					arg_408_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_408_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_408_1.time_ - 0) / var_411_3)
				end
			end

			if arg_408_1.time_ >= 0 + var_411_3 and arg_408_1.time_ < 0 + var_411_3 + arg_411_0 and not isNil(var_411_2) and arg_408_1.var_.characterEffect1085ui_story then
				arg_408_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_408_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_2")
			end

			local var_411_4 = 0
			local var_411_5 = 0.275

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_4 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_6 = arg_408_1:GetWordFromCfg(420132099)
				local var_411_7 = arg_408_1:FormatText(var_411_6.content)

				arg_408_1.text_.text = var_411_7

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_9 = 11 <= 0 and var_411_5 or var_411_5 * (utf8.len(var_411_7) / 11)

				if (11 <= 0 and var_411_5 or var_411_5 * (utf8.len(var_411_7) / 11)) > 0 and var_411_5 < var_411_9 then
					arg_408_1.talkMaxDuration = var_411_9

					if var_411_9 + var_411_4 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_9 + var_411_4
					end
				end

				arg_408_1.text_.text = var_411_7
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132099", "story_v_out_420132.awb") ~= 0 then
					local var_411_10 = manager.audio:GetVoiceLength("story_v_out_420132", "420132099", "story_v_out_420132.awb") / 1000

					if var_411_10 + var_411_4 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_10 + var_411_4
					end

					if var_411_6.prefab_name ~= "" and arg_408_1.actors_[var_411_6.prefab_name] ~= nil then
						local var_411_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_6.prefab_name].transform, "story_v_out_420132", "420132099", "story_v_out_420132.awb")

						arg_408_1:RecordAudio("420132099", var_411_11)
						arg_408_1:RecordAudio("420132099", var_411_11)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_420132", "420132099", "story_v_out_420132.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_420132", "420132099", "story_v_out_420132.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_12 = math.max(var_411_5, arg_408_1.talkMaxDuration)

			if var_411_4 <= arg_408_1.time_ and arg_408_1.time_ < var_411_4 + var_411_12 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_4) / var_411_12

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_4 + var_411_12 and arg_408_1.time_ < var_411_4 + var_411_12 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play420132100 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 420132100
		arg_412_1.duration_ = 12.53

		local var_412_0 = {
			zh = 8.6,
			ja = 12.533
		}
		local var_412_1 = manager.audio:GetLocalizationFlag()

		if var_412_0[var_412_1] ~= nil then
			arg_412_1.duration_ = var_412_0[var_412_1]
		end

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play420132101(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.var_.moveOldPos1061ui_story = arg_412_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_415_0 = 0.001

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_0 then
				arg_412_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_412_1.time_ - 0) / var_415_0)
				arg_412_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_412_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1061ui_story"].transform.position).z)
				arg_412_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_412_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_412_1.actors_["1061ui_story"].transform.localEulerAngles = arg_412_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_412_1.time_ >= 0 + var_415_0 and arg_412_1.time_ < 0 + var_415_0 + arg_415_0 then
				arg_412_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_412_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_412_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1061ui_story"].transform.position).z)
				arg_412_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_412_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_412_1.actors_["1061ui_story"].transform.localEulerAngles = arg_412_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_415_1 = arg_412_1.actors_["1085ui_story"].transform

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.var_.moveOldPos1085ui_story = var_415_1.localPosition
			end

			local var_415_2 = 0.001

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_2 then
				var_415_1.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_412_1.time_ - 0) / var_415_2)
				var_415_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_415_1.position).x, (manager.ui.mainCamera.transform.position - var_415_1.position).y, (manager.ui.mainCamera.transform.position - var_415_1.position).z)
				var_415_1.localEulerAngles.z = 0
				var_415_1.localEulerAngles.x = 0
				var_415_1.localEulerAngles = var_415_1.localEulerAngles
			end

			if arg_412_1.time_ >= 0 + var_415_2 and arg_412_1.time_ < 0 + var_415_2 + arg_415_0 then
				var_415_1.localPosition = Vector3.New(0, 100, 0)
				var_415_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_415_1.position).x, (manager.ui.mainCamera.transform.position - var_415_1.position).y, (manager.ui.mainCamera.transform.position - var_415_1.position).z)
				var_415_1.localEulerAngles.z = 0
				var_415_1.localEulerAngles.x = 0
				var_415_1.localEulerAngles = var_415_1.localEulerAngles
			end

			local var_415_3 = 0
			local var_415_4 = 1.325

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_3 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_5 = arg_412_1:GetWordFromCfg(420132100)
				local var_415_6 = arg_412_1:FormatText(var_415_5.content)

				arg_412_1.text_.text = var_415_6

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_8 = 53 <= 0 and var_415_4 or var_415_4 * (utf8.len(var_415_6) / 53)

				if (53 <= 0 and var_415_4 or var_415_4 * (utf8.len(var_415_6) / 53)) > 0 and var_415_4 < var_415_8 then
					arg_412_1.talkMaxDuration = var_415_8

					if var_415_8 + var_415_3 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_8 + var_415_3
					end
				end

				arg_412_1.text_.text = var_415_6
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132100", "story_v_out_420132.awb") ~= 0 then
					local var_415_9 = manager.audio:GetVoiceLength("story_v_out_420132", "420132100", "story_v_out_420132.awb") / 1000

					if var_415_9 + var_415_3 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_9 + var_415_3
					end

					if var_415_5.prefab_name ~= "" and arg_412_1.actors_[var_415_5.prefab_name] ~= nil then
						local var_415_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_5.prefab_name].transform, "story_v_out_420132", "420132100", "story_v_out_420132.awb")

						arg_412_1:RecordAudio("420132100", var_415_10)
						arg_412_1:RecordAudio("420132100", var_415_10)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_420132", "420132100", "story_v_out_420132.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_420132", "420132100", "story_v_out_420132.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_11 = math.max(var_415_4, arg_412_1.talkMaxDuration)

			if var_415_3 <= arg_412_1.time_ and arg_412_1.time_ < var_415_3 + var_415_11 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_3) / var_415_11

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_3 + var_415_11 and arg_412_1.time_ < var_415_3 + var_415_11 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_412_1:InitPlayNodeList()
	end,
	Play420132101 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 420132101
		arg_416_1.duration_ = 11

		local var_416_0 = {
			zh = 8.433,
			ja = 11
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
			arg_416_1.auto_ = false
		end

		function arg_416_1.playNext_(arg_418_0)
			arg_416_1.onStoryFinished_()
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0.975

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_1 = arg_416_1:GetWordFromCfg(420132101)
				local var_419_2 = arg_416_1:FormatText(var_419_1.content)

				arg_416_1.text_.text = var_419_2

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_4 = 39 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_2) / 39)

				if (39 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_2) / 39)) > 0 and var_419_0 < var_419_4 then
					arg_416_1.talkMaxDuration = var_419_4

					if var_419_4 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_4 + 0
					end
				end

				arg_416_1.text_.text = var_419_2
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420132", "420132101", "story_v_out_420132.awb") ~= 0 then
					local var_419_5 = manager.audio:GetVoiceLength("story_v_out_420132", "420132101", "story_v_out_420132.awb") / 1000

					if var_419_5 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_5 + 0
					end

					if var_419_1.prefab_name ~= "" and arg_416_1.actors_[var_419_1.prefab_name] ~= nil then
						local var_419_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_1.prefab_name].transform, "story_v_out_420132", "420132101", "story_v_out_420132.awb")

						arg_416_1:RecordAudio("420132101", var_419_6)
						arg_416_1:RecordAudio("420132101", var_419_6)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_420132", "420132101", "story_v_out_420132.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_420132", "420132101", "story_v_out_420132.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_7 = math.max(var_419_0, arg_416_1.talkMaxDuration)

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_7 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - 0) / var_419_7

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= 0 + var_419_7 and arg_416_1.time_ < 0 + var_419_7 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST61",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST67"
	},
	voices = {
		"story_v_out_420132.awb"
	}
}
